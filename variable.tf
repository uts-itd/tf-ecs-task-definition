# Container definitions are used in task definitions to describe the different containers that are launched as part of a task.
# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html

variable "command" {
  default     = []
  description = "The command that is passed to the container"
  type        = list(string)
}

variable "cpu" {
  default     = 256
  description = "The number of cpu units reserved for the container"
  type        = number
}

variable "disableNetworking" {
  default     = false
  description = "When this parameter is true, networking is disabled within the container"
}

variable "dnsSearchDomains" {
  default     = []
  description = "A list of DNS search domains that are presented to the container"
  type        = list(string)
}

variable "dnsServers" {
  default     = []
  description = "A list of DNS servers that are presented to the container"
  type        = list(string)
}

variable "dockerLabels" {
  default     = {}
  description = "A key/value map of labels to add to the container"
  type        = map(string)
}

variable "dockerSecurityOptions" {
  default     = []
  description = "A list of strings to provide custom labels for SELinux and AppArmor multi-level security systems"
  type        = list(string)
}

variable "entryPoint" {
  default     = []
  description = "The entry point that is passed to the container"
  type        = list(string)
}

variable "environment" {
  default     = []
  description = "The environment variables to pass to a container"
  type        = list(map(string))
}

variable "essential" {
  default     = true
  description = "If the essential parameter of a container is marked as true, and that container fails or stops for any reason, all other containers that are part of the task are stopped"
}

variable "execution_role_arn" {
  default     = ""
  description = "The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume"
}

variable "extraHosts" {
  default     = []
  description = "A list of hostnames and IP address mappings to append to the /etc/hosts file on the container"

  type = list(object({
    ipAddress = string
    hostname  = string
  }))
}

variable "family" {
  description = "You must specify a family for a task definition, which allows you to track multiple versions of the same task definition"
}

variable "healthCheck" {
  default     = {}
  description = "The health check command and associated configuration parameters for the container"
  type        = any
}

variable "hostname" {
  default     = ""
  description = "The hostname to use for your container"
}

variable "image" {
  default     = ""
  description = "The image used to start a container"
}

variable "interactive" {
  default     = false
  description = "When this parameter is true, this allows you to deploy containerized applications that require stdin or a tty to be allocated"
}

variable "ipc_mode" {
  default     = null
  description = "The IPC resource namespace to use for the containers in the task"
}


# variable "linuxParameters" {
#   default     = {}
#   description = "Linux-specific modifications that are applied to the container, such as Linux KernelCapabilities"
#   type        = any
# }

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

variable "memoryReservation" {
  default     = 0
  description = "The soft limit (in MiB) of memory to reserve for the container"
}

variable "mountPoints" {
  default     = []
  description = "The mount points for data volumes in your container"
  type        = list(any)
}

variable "name" {
  default     = ""
  description = "The name of a container"
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

variable "portMappings" {
  default     = []
  description = "The list of port mappings for the container"
  type        = list(any)
}

variable "privileged" {
  default     = false
  description = "When this parameter is true, the container is given elevated privileges on the host container instance (similar to the root user)"
}

variable "pseudoTerminal" {
  default     = false
  description = "When this parameter is true, a TTY is allocated"
}

variable "readonlyRootFilesystem" {
  default     = false
  description = "When this parameter is true, the container is given read-only access to its root file system"
}

variable "register_task_definition" {
  default     = true
  description = "Registers a new task definition from the supplied family and containerDefinitions"
}

variable "repositoryCredentials" {
  default     = {}
  description = "The private repository authentication credentials to use"
  type        = map(string)
}

variable "requires_compatibilities" {
  default     = []
  description = "The launch type required by the task"
  type        = list(string)
}

variable "resourceRequirements" {
  default     = []
  description = "The type and amount of a resource to assign to a container"
  type        = list(string)
}

variable "secrets" {
  default     = []
  description = "The secrets to pass to the container"
  type        = list(map(string))
}

variable "systemControls" {
  default     = []
  description = "A list of namespaced kernel parameters to set in the container"
  type        = list(string)
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

variable "ulimits" {
  default     = []
  description = "A list of ulimits to set in the container"
  type        = list(any)
}

variable "user" {
  default     = ""
  description = "The user name to use inside the container"
}

variable "volumes" {
  default     = []
  description = "A list of volume definitions in JSON format that containers in your task may use"
  type        = list(any)
}

variable "volumesFrom" {
  default     = []
  description = "Data volumes to mount from another container"

  type = list(object({
    readOnly        = bool
    sourceContainer = string
  }))
}

variable "workingDirectory" {
  default     = ""
  description = "The working directory in which to run commands inside the container"
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

variable "alb_arn"{
  type = string
  description = "Required, alb arn"
  default = ""
}

variable "container_port" {
  type        = number
  description = "Optional; the port the container listens on."
  default     = 80
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Optional; A set of subnet ID's that will be associated with the Farage service. By default the module will use the default vpc's public subnets."
  default     = ["subnet-02bfbf99cdabab086", "subnet-0bcd16c3e147d5c98"]//["subnet-0d5a87b1da974abda", "subnet-0e189fca847b40e55"] //["subnet-02bfbf99cdabab086", "subnet-0bcd16c3e147d5c98"]
}

variable "vpc_id" {
  type = "string"
  description = "Optional; The VPC Id in which resources will be provisioned. Default is the default AWS vpc."
  default     = "vpc-0784feee283d827ab"
}