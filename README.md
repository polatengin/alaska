# Alaska

You can find sample

- [.azuredevops/ci.yml](.azuredevops/ci.yml) Azure DevOps Pipeline
- [.github/workflows/ci.yml](.github/workflows/ci.yml) GitHub Actions Workflow
- Resource Group Bicep Module [layers/010_Infra/main.bicep](layers/010_Infra/main.bicep)
- Azure Storage Account Bicep Module [layers/020_Storage/main.bicep](layers/020_Storage/main.bicep)
- Bicep Validate helper scripts [scripts/bicep_validate.sh](scripts/bicep_validate.sh)
- Bicep Deploy helper scripts [scripts/bicep_deploy.sh](scripts/bicep_deploy.sh)
- PreValidate, PostValidate, PreDeploy, PostDeploy event functions for 010_Infra layer [layers/010_Infra/_events.sh](layers/010_Infra/_events.sh)
- PreValidate, PostValidate, PreDeploy, PostDeploy event functions for 020_Storage layer [layers/020_Storage/_events.ps1](layers/020_Storage/_events.ps1)
