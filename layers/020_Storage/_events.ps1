function pre_validate() {
  Write-Host "powershell pre_validate, LOCATION_NAME: ${env:LOCATION_NAME}"
}

function post_validate() {
  Write-Host "powershell post_validate, LOCATION_NAME: ${env:LOCATION_NAME}"
}

function pre_deploy() {
  Write-Host "powershell pre_deploy, LOCATION_NAME: ${env:LOCATION_NAME}"
}

function post_deploy() {
  Write-Host "powershell post_deploy, LOCATION_NAME: ${env:LOCATION_NAME}"
}
