###################################### 
# azurerm_resource_group variables
###################################### 
variable "resource_group_name" {
  description = "The resource group name to be imported"
  type        = string
}

variable "resource_group_location" {
  description = "Azure location"
  default = "East US"
}

###################################### 
# azurerm_kubernetes_cluster variables
###################################### 
variable "prefix" {
  description = "The prefix for the resources created in the specified Azure Resource Group. Used as the DNS prefix."
  type        = string
}

variable "kubernetes_version" {
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region"
  type        = string
  default     = null
}

variable "orchestrator_version" {
  description = "Specify which Kubernetes release to use for the orchestration layer. The default used is the latest Kubernetes version available in the region"
  type        = string
  default     = null
}

variable "agents_pool_name" {
  description = "The default Azure AKS agentpool (nodepool) name."
  type        = string
  default     = "nodepool"
}

variable "agents_count" {
  description = "The number of Agents that should exist in the Agent Pool. Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes."
  type        = number
  default     = 3 # changed from default 2
}

variable "agents_size" {
  default     = "Standard_B4ms"
  description = "The default virtual machine size for the Kubernetes agents"
  type        = string
}

variable "os_disk_size_gb" {
  description = "Disk size of nodes in GBs."
  type        = number
  default     = 30 # changed from default 50
}

variable "vnet_subnet_id" {
  description = "(Optional) The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "agents_labels" {
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created."
  type        = map(string)
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the Virtual Network resources"
  default     = {}
}

variable "agents_tags" {
  description = "(Optional) A mapping of tags to assign to the Node Pool."
  type        = map(string)
  default     = {}
}

variable "agents_type" {
  description = "(Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets."
  type        = string
  default     = "VirtualMachineScaleSets" # DOES THIS DEFAULT NEED TO BE CHANGED??
}

###################################### 
# service_principal variables 
###################################### 
variable "client_id" {
  description = "(Optional) The Client ID (appId) for the Service Principal used for the AKS deployment"
  type        = string
  default     = ""
}

variable "client_secret" {
  description = "(Optional) The Client Secret (password) for the Service Principal used for the AKS deployment"
  type        = string
  default     = ""
}

###################################### 
# role_based_access_control variables 
###################################### 
variable "enable_role_based_access_control" {
  description = "Enable Role Based Access Control."
  type        = bool
  default     = true # changed from default false
}

###################################### 
# network_profile variables 
###################################### 
variable "network_plugin" {
  description = "Network plugin to use for networking."
  type        = string
  default     = "azure" # changed from default kubenet to work with Flux
}

variable "network_policy" {
  description = "Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created."
  type        = string
  default     = "calico" # changed from default null to work with Flix
}

###################################### 
# addon_profile variables 
###################################### 
variable "enable_kube_dashboard" {
  description = "Enable Kubernetes Dashboard."
  type        = bool
  default     = true # changed from default false
}