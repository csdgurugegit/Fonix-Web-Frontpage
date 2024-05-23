# Deploy Containerized Web App Using Azure App Service

Use Terraform to deploy a containerized web application on Azure App Service, ensuring a streamlined and efficient deployment process. Leverage the `values.config` file to input configuration variables separately, allowing for easy customization and management of deployment parameters. This approach enhances flexibility and maintains organized infrastructure as code, simplifying updates and scalability.

### Initialize the Terraform working directory

```bash
terraform init
```

### Plan the deployment and specify the variable file

```
terraform plan -var-file=values.config
```

##### Save the execution plan to a file

```
terraform plan -out webapp.tfplan -var-file=values.config
```

### Apply the execution plan with the specified variable file

```
terraform apply -var-file=values.config
```

##### Or, apply the saved execution plan

```
terraform apply webapp.tfplan
```

### Destroy the resources managed by Terraform with the specified variable file

```
terraform destroy -var-file=values.config
```

For more information, please refer the link.

Basic CLI Features | Terraform | HashiCorp https://developer.hashicorp.com/terraform/cli/commands


