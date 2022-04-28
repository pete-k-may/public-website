# variables.tf

variable "application_name" {
  description = "Application name"
  default     = "public-website"
}

variable "billing_tag" {
  default = "Infrastructure"
}

variable "created_by_tag" {
  default = "Terraform"
}

variable "region" {
  default = "ap-southeast-2"
}

variable "environment" {
  description = "Deploy environment"
  default     = "DEV"
}

variable "pci_tag" {
  description = "Is this asset in PCI scope?"
  type        = number
  default     = 0
}

variable "is_customer_facing" {
  description = "This is a fixed value"
  type        = number
  default     = 1
}

variable "is_not_customer_facing" {
  description = "This is a fixed value"
  type        = number
  default     = 0
}

variable "fargate_port" {
  description = "Port exposed by the Fargate host to direct traffic to"
  type        = number
  default     = 80
}

variable "main_app_port" {
  description = "Port exposed by the main application container"
  type        = number
  default     = 80
}

variable "health_check_grace_period" {
  description = "Period in seconds to wait before applying health check"
  type        = number
  default     = 30
}

variable "read_only_filesystem" {
  description = "Should the container file system be read only or not?"
  type        = bool
  default     = false
}

variable "image_to_deploy" {
  description = "Full path to image"
  default     = "nginx:latest"
}

variable "logs_retention_in_days" {
  description = "Log retention period in days"
  type        = number
  default     = 7
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  type        = number
  default     = 256
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MB)"
  type        = number
  default     = 512
}

variable "container_count" {
  description = "Number of docker containers to run: need at least as many as az_count"
  type        = number
  default     = 3
}

variable "max_container_count" {
  description = "Maximum number of docker containers to run with autoscaling"
  type        = number
  default     = 6
}

variable "alarm_period" {
  description = "The period in seconds over which the specified statistic is applied"
  type        = number
  default     = 300
}

variable "cpu_too_high_threshhold" {
  description = "Scale up when this CPU value is reached for the specified period"
  type        = number
  default     = 80
}

variable "cpu_too_low_threshhold" {
  description = "Scale down when this CPU value is reached for the specified period"
  type        = number
  default     = 20
}

variable "vpc_name" {
  description = "Name used to find the appropriate VPC for Fargate resources"
  type        = string
  default     = "dev-ap-southeast-2"
}

variable "subnet_name" {
  description = "Name used to find the appropriate subnets for Fargate resources"
  type        = string
  default     = "dev-ap-southeast-2-APP-PRIVATE-NGW-*" 
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table used by the application in the container"
  type        = string
  default     = "public-website.generic-table"
}

variable "dynamodb_table_name2" {
  description = "Name of the second DynamoDB table used by the application in the container"
  type        = string
  default     = "public-website.generic-table2"
}

variable "force_new_deploy" {
  description = "Force new deploy of containers even if image/tag combination unchanged"
  type        = bool
  default     = true
}
