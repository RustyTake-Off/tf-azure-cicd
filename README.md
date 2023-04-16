# tf-azure-cicd

Remember to look around all the folders, files and change things to your own liking.

## [Projects](https://github.com/RustyTake-Off/projects)

[Project] - Create Azure infrastructure with Terraform and automate the validation, testing and deployment of it with GitHub Actions.

## Prerequisites

You need to have:

* Azure account

* GitHub Actions secret with `admin` and `ssh-key`

* Run one of the [prerequisites scripts](https://github.com/RustyTake-Off/tf-azure-cicd/tree/main/prerequisites). It will create a resource group, storage account and container to store in your terraform stare file.

## The infra

The Terraform creates a simple Aks infrastructure.

Variables are taken from the `infra/infra_variables/prod.tfvars` file.

In the `infra/variables.tf` file is specified a `variable "ssh"` block that takes input provided by GitHuB Actions runs.

## Setup GItHub Actions

You need to create an `ssh-key`.

```bash
ssh-keygen -t rsa -b 4096
```

And copy its contents to a `GitHub Actions secret` that needs to look something like this:

```secrets
ssh = {
  admin="myadminname"
  ssh_key="your ssh-key contents here"
}
```

## GitHub Actions

### Infra code check

The first job in `plan_workflow.yaml` checks the infrastructure code with the `validate` and `plan` flags.

Part where the `SSH secret` is injected.

```yaml
# Terraform Plan
- name: Terraform Plan
  id: plan
  run: terraform plan -input=false -var '${{ secrets.SSH }}' -var-file 'infra_variables/prod.tfvars'
```

Then there are two other jobs that scan the infra code for any misconfigurations and possible vulnerabilities with `Checkov`(commented out) and `Terrascan`.

`Terrascan` checks the infra code and uploads the results as `terrascan.sarif` file and the results are viewable in the `Security` tab.

```yaml
# Terrascan Scan
- name: Terrascan Scan
  id: terrascan
  uses: tenable/terrascan-action@main
  with:
    iac_type: terraform
    iac_version: v14
    policy_type: azure
    only_warn: true
    sarif_upload: true

# Upload Terrascan Scan
- name: Upload SARIF file
  id: terrascan-upload
  uses: github/codeql-action/upload-sarif@v2
  with:
    sarif_file: terrascan.sarif
```

The `apply_workflow.yaml` is responsible for deployment of the infra.

Though it is changed to be activated manually or with a pull request.

```yaml
# Terraform Apply
- name: Terraform Apply
  id: apply
  run: terraform apply -auto-approve -input=false -var '${{ secrets.SSH }}' -var-file 'infra_variables/prod.tfvars'
  if: ${{ github.event.inputs.apply == 'true' }}
```
