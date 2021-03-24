# Container definitions are used in task definitions to describe the different containers that are launched as part of a task.
# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html


variable "cpu" {
  default     = 256
  description = "The number of cpu units reserved for the container"
  type        = number
}

variable "family" {
  description = "You must specify a family for a task definition, which allows you to track multiple versions of the same task definition"
}

variable "ipc_mode" {
  default     = null
  description = "The IPC resource namespace to use for the containers in the task"
}

variable "logConfiguration" {
  default     = {}
  description = "The log configuration specification for the container"
  type        = any
}

variable "memory" {
  default     = 512
  description = "The hard limit (in MiB) of memory to present to the container"
  type        = number
}

variable "network_mode" {
  default     = "bridge"
  description = "The Docker networking mode to use for the containers in the task"
}

variable "pid_mode" {
  default     = null
  description = "The process namespace to use for the containers in the task"
}

variable "placement_constraints" {
  default     = []
  description = "An array of placement constraint objects to use for the task"
  type = list(object({
    type       = string
    expression = string
  }))
}


variable "register_task_definition" {
  default     = true
  description = "Registers a new task definition from the supplied family and containerDefinitions"
}

variable "tags" {
  default     = {}
  description = "The metadata that you apply to the task definition to help you categorize and organize them"
  type        = map(string)
}

variable "task_role_arn" {
  default     = ""
  description = "The short name or full Amazon Resource Name (ARN) of the IAM role that containers in this task can assume"
}


variable "volumes" {
  default     = []
  description = "A list of volume definitions in JSON format that containers in your task may use"
  type        = list(any)
}

variable "task_policy_json" {
  type        = string
  description = "Optional; A JSON formated IAM policy providing the running container with permissions."
  default     = null
}
variable "desired_capacity" {
  type        = number
  description = "Optional; The desired number of containers running in the service. Default is 1."
  default     = 1
}
variable "platform_version" {
  type        = string
  description = "Optional; The ECS backend platform version; Defaults to 1.4.0 so EFS is supported."
  default     = "1.4.0"
}

variable "alb_arn" {
  type        = string
  description = "Required, alb arn"
  default     = ""
}
variable "container_port" {
  type        = number
  description = "Optional; the port the container listens on."
  default     = 80
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Optional; A set of subnet ID's that will be associated with the Farage service. By default the module will use the default vpc's public subnets."
  default     = ["subnet-02bfbf99cdabab086", "subnet-0bcd16c3e147d5c98"] //["subnet-0d5a87b1da974abda", "subnet-0e189fca847b40e55"] //["subnet-02bfbf99cdabab086", "subnet-0bcd16c3e147d5c98"]
}

variable "vpc_id" {
  type        = string
  description = "Optional; The VPC Id in which resources will be provisioned. Default is the default AWS vpc."
  default     = "vpc-0784feee283d827ab"
}

variable "alb_sg" {
  type        = string
  default     = ""
  description = "security group for alb sg"
}
variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "cluster_name" {
  type    = string
  default = ""
}

variable "container_definition" {
  type    = string
  default = ""
}

variable "create_service" {
  type  = "bool"
  value = true
}

variable "requires_compatibilities" {
  default     = []
  description = "The launch type required by the task"
  type        = list(string)
}

variable "secrets" {
  default     = []
  description = "The secrets to pass to the container"
  type        = list(map(string))
}