#!/bin/bash

pre_validate() {
  echo "bash pre validate, LOCATION_NAME: ${LOCATION_NAME}"
}

post_validate() {
  echo "bash post validate, LOCATION_NAME: ${LOCATION_NAME}"
}

pre_deploy() {
  echo "bash pre deploy, LOCATION_NAME: ${LOCATION_NAME}"
}

post_deploy() {
  echo "bash post deploy, LOCATION_NAME: ${LOCATION_NAME}"
}
