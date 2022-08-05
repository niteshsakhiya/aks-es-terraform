# Elastic Gujarat Meetup August 2022
## Deploy Elasticsearch cluter on Azure Kubernetes Service using terraform
Elasticsearch is a distributed search and analytics engine. It is used for web search, log monitoring, and real-time analytics. Ideal for Big Data applications.

## Prerequisites
- Azure subscription
- Cloudflare (optional)


## Installation
The terraform code creates the following resources.

- Azure resource group
- Azure managed K8S(v1.23.8) cluster and nodepools
- Azure storage account and required file shares
- Elasticsearch cluster (8.3.3)
- Nginx ingress (4.2.0)
- Load balancer
- Prometheus (14.0.1)
- FluentD (0.3.9)

You can clone this git repository and use following steps to deploy the resources. Make sure you have terraform installed in your machine.
Define the following envrionment variables. These details will be used for Azure and Cloudflare authentication and authorization. If your DNS is not hosted on Cloudflare, you can skip the cloudflare part.

>ARM_SUBSCRIPTION_ID="Azure-subscription-id"
>ARM_TENANT_ID="Azure-tenant-id"
>ARM_CLIENT_ID="Azure-client-id"
>ARM_CLIENT_SECRET="Azure-client-secret"
>TF_VAR_service_principal_client_id="Azure-service-principal-client-id"
>TF_VAR_service_principal_client_secret="Azure-service-principal-client-secret"
>CLOUDFLARE_API_TOKEN="cloudflare-api-token"
>TF_VAR_cloudflare_zone_id="cloudflare-dns-zone-id"


Initialize and apply the terraform code using the following commands.
```sh
cd core_cluster/
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

The above commands will load the terraform modules and deploy the Elasticsearch cluster with 3 master-eligible nodes, 3 data-only nodes, and 2 coordinating-only nodes distributed in different availability zones.


## Terraform variables

| Variable | Description |
| -------- | ----------- |
| environment_name | Name of the work environment (For ex. dev, qa, production) |
|resource_group_location | Geographic location of the resource group |
|resource_group_name | Azure resource group name |
|service_principal_client_id|USE TF_VAR_service_principal_client_id! The client ID of the service principal that will be used to create the AKS cluster.|
|service_principal_client_secret|USE TF_VAR_service_principal_client_secret! The secret of the service principal that will be used to create the AKS cluster.|
|default_tags| Tags for the resources|
|k8s_vm_size|Azure VM size for default nodepool|
|k8s_cluster_node_count|The number of kubernetes nodes to create for the k8s cluster default pool|
|elasticsearch_data_pool_vm_size|The Azure VM Size for elasticsearch data nodepool|
|elasticsearch_master_pool_vm_size|The Azure VM Size for elasticsearch master nodepool|
|elasticsearch_coordinating_pool_vm_size|The Azure VM Size for elasticsearch coordinating nodepool|
|storage_account_name|Name of the Azure storage account|
|cloudflare_zone_id|USE TF_VAR_cloudflare_zone_id! The cloudflare DNS zone id|



>Note: Security hasn't been taken care of in this set up because it is out of scope for this demo. If you intend to use this, Please take care of security by enabling authentication, authorization, tls, etc.
