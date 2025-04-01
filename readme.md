# Huxley Test - Provision Azure Infrastructure with Terraform

This repository demonstrates how to provision Azure infrastructure using Terraform. It includes a reusable Terraform module for deploying an Azure Virtual Network (VNET), along with additional resources and a GitHub Actions pipeline for CI/CD.

Dear Manager, I have used AI to help me with my work for not wasting too much time on something that can be done quickly, I have been doing my work for more than 5 years for big companies in Azure and I have had no problem, if you think you need to test me hire me and don't pay me if I don't deliver by doing a good job.

## Github action
The Github share is not working as it does not have an associated azure subscription. But terraform plan is working.


## Repository Structure

Huxley-test/ 
├── modules/ 
│   └── az_vnet/ 
│   ├── main.tf 
│   ├── variables.tf 
│   ├── outputs.tf 
│   └── README.md # Documentation for the module 
├── environments/ 
│ ├── dev/ 
│ │   ├── main.tf # Resource Group, module call, and additional resources 
│ │   └── providers.tf # Azure Provider configuration 
│ └── int/ 
│     ├── main.tf 
│     └── providers.tf 
│    
├── .github/ 
│     └── workflows/ 
│           └── terraform.yml # GitHub Actions pipeline 
└── README.md # This file



## Azure VNET Module (`modules/az_vnet`)

### What It Does

- **VNET Creation:**  
  The module provisions an Azure Virtual Network using configurable parameters such as the VNET name, location, resource group, and address space.

- **Subnets:**  
  It creates one or more subnets within the VNET based on a map of subnets provided as a variable. Each subnet is defined with its own address prefixes.

- **NSG Association:**  
  If a subnet has an associated Network Security Group (NSG) ID (i.e., `nsg_id` is not an empty string), a separate resource (`azurerm_subnet_network_security_group_association`) is created to associate the NSG with the subnet.  
  This ensures that NSG associations are handled using the appropriate resource, as the argument `network_security_group_id` is no longer supported directly in the `azurerm_subnet` resource.

- **Outputs:**  
  The module outputs useful values such as the VNET ID, subnet IDs, and optionally the VNET name. These outputs can be consumed by other modules or for informational purposes.

### Key Files in the Module

- **`main.tf`**  
  Contains the resource definitions for the VNET and subnets, as well as the conditional creation of NSG associations.

- **`variables.tf`**  
  Defines input variables (e.g., `vnet_name`, `address_space`, `location`, `resource_group_name`, `tags`, and a map of subnets with each subnet’s configuration).

- **`outputs.tf`**  
  Exposes outputs such as `vnet_id`, `subnet_ids`, and `vnet_name` to make it easier to reference created resources in other parts of your infrastructure.

- **`README.md` (within the module)**  
  Provides documentation specific to the module, including usage examples and variable definitions. It is recommended to use tools like `terraform-docs` to automatically generate and update this documentation.

## Environment Configuration (`environments/dev` and `environments/prod`)

Each environment contains its own Terraform configuration:
  
- **`main.tf`**  
  Creates an Azure Resource Group, invokes the Azure VNET module, and provisions additional resources (e.g., a Storage Account).

- **`providers.tf`**  
  Configures the Azure provider. Notice that the provider block uses the correct syntax:
  ```hcl
  provider "azurerm" {
    features {}
  }
