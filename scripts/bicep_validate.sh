#!/bin/bash

pushd .

cd "../layers"

SAVEIFS=${IFS}
IFS=$'\n'
layers=($(find . -type f -name 'main.bicep' | sort -u))
IFS=${SAVEIFS}

for layer in "${layers[@]}"; do

  layerName=$(basename "$(dirname "${layer}")")
  dirname=$(dirname "${layer}")
  sanitized_dirname=${dirname//.\//}

  if [[ ${sanitized_dirname} == __* ]]; then
    echo "Skipping ${layer}"
    echo ""
    echo "------------------------"
    continue
  fi


  uniquer=$(echo $RANDOM | md5sum | head -c 6)

  target_scope=$(grep -oP 'targetScope\s*=\s*\K[^\s]+' "${layer}" | sed -e 's/[\"\`]//g')
  target_scope=${target_scope//\'/}

  echo "Validating ${layerName}..."

  if [ -f "${dirname}/_events.sh" ]; then
    source "${dirname}/_events.sh"

    if [ "$(type -t pre_validate)" == "function" ]; then
      pre_validate
    fi
  fi

  if [ -f "${dirname}/_events.ps1" ]; then
    if grep -q "function pre_validate" "${dirname}/_events.ps1"; then
      pwsh -Command "& { Import-Module \"${dirname}/_events.ps1\"; pre_validate }"
    fi
  fi

  if [[ "${target_scope}" == "managementGroup" ]]; then
    command="az deployment mg validate --management-group-id ${optional_args} --name ${uniquer} --location ${LOCATION_NAME} --template-file ${layer}"
  elif [[ "${target_scope}" == "subscription" ]]; then
    command="az deployment sub validate --name ${uniquer} --location ${LOCATION_NAME} --template-file ${layer}"
  elif [[ "${target_scope}" == "tenant" ]]; then
    command="az deployment tenant validate --name ${uniquer} --location ${LOCATION_NAME} --template-file ${layer}"
  else
    command="az deployment group validate --name ${uniquer} --resource-group sample-rg --template-file ${layer}"
  fi

  # output=$(eval "${command}")

  exit_code=$?

  if [ ${exit_code} -eq 0 ]; then
    if [ -f "${dirname}/_events.sh" ]; then
      source "${dirname}/_events.sh"

      if [ "$(type -t post_validate)" == "function" ]; then
        post_validate
      fi
    fi

    if [ -f "${dirname}/_events.ps1" ]; then
      if grep -q "function post_validate" "${dirname}/_events.ps1"; then
        pwsh -Command "Import-Module \"${dirname}/_events.ps1\" ; post_validate"
      fi
    fi
  fi

  unset -f pre_validate
  unset -f post_validate

  if [[ ${exit_code} != 0 ]]; then
    echo "Bicep validate failed - returned code ${exit_code}"
    exit ${exit_code}
  fi
done

popd
