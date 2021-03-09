locals {
  command               = jsonencode(var.command)
  dnsSearchDomains      = jsonencode(var.dnsSearchDomains)
  dnsServers            = jsonencode(var.dnsServers)
  dockerLabels          = jsonencode(var.dockerLabels)
  dockerSecurityOptions = jsonencode(var.dockerSecurityOptions)
  entryPoint            = jsonencode(var.entryPoint)
  environment           = jsonencode(var.environment)
  extraHosts            = jsonencode(var.extraHosts)
  portMappings          = jsonencode(var.portMappings)
  repositoryCredentials = jsonencode(var.repositoryCredentials)
  resourceRequirements  = jsonencode(var.resourceRequirements)
  secrets               = jsonencode(var.secrets)
  container_definition  = var.register_task_definition ? format("[%s]", data.template_file.container_definition.rendered) : format("%s", data.template_file.container_definition.rendered)
  container_definitions = replace(local.container_definition, "/\"(null)\"/", "$1")
  healthCheck           = jsonencode(var.healthCheck)
  logConfiguration      = jsonencode(var.logConfiguration)

  mountPoints = replace(
    replace(jsonencode(var.mountPoints), "/\"1\"/", "true"),
    "/\"0\"/",
    "false",
  )
  systemControls = jsonencode(var.systemControls)
}

data "template_file" "container_definition" {
  template = file("${path.module}/templates/container-definition.json.tpl")

  vars = {
    command                = local.command == "[]" ? "null" : local.command
    cpu                    = var.cpu == 0 ? "null" : var.cpu
    disableNetworking      = var.disableNetworking ? true : false
    dnsSearchDomains       = local.dnsSearchDomains == "[]" ? "null" : local.dnsSearchDomains
    dnsServers             = local.dnsServers == "[]" ? "null" : local.dnsServers
    dockerLabels           = local.dockerLabels == "{}" ? "null" : local.dockerLabels
    dockerSecurityOptions  = local.dockerSecurityOptions == "[]" ? "null" : local.dockerSecurityOptions
    entryPoint             = local.entryPoint == "[]" ? "null" : local.entryPoint
    environment            = local.environment == "[]" ? "null" : local.environment
    essential              = var.essential ? true : false
    extraHosts             = local.extraHosts == "[]" ? "null" : local.extraHosts
    healthCheck            = local.healthCheck == "{}" ? "null" : local.healthCheck
    hostname               = var.hostname == "" ? "null" : var.hostname
    image                  = var.image == "" ? "null" : var.image
    interactive            = var.interactive ? true : false
    logConfiguration       = local.logConfiguration == "{}" ? "null" : local.logConfiguration
    memory                 = var.memory == 0 ? "null" : var.memory
    memoryReservation      = var.memoryReservation == 0 ? "null" : var.memoryReservation
    mountPoints            = local.mountPoints == "[]" ? "null" : local.mountPoints
    name                   = var.name == "" ? "null" : var.name
    portMappings           = local.portMappings == "[]" ? "null" : local.portMappings
    privileged             = var.privileged ? true : false
    pseudoTerminal         = var.pseudoTerminal ? true : false
    readonlyRootFilesystem = var.readonlyRootFilesystem ? true : false
    repositoryCredentials  = local.repositoryCredentials == "{}" ? "null" : local.repositoryCredentials
    resourceRequirements   = local.resourceRequirements == "[]" ? "null" : local.resourceRequirements
    secrets                = local.secrets == "[]" ? "null" : local.secrets
    systemControls         = local.systemControls == "[]" ? "null" : local.systemControls
    user                   = var.user == "" ? "null" : var.user
    workingDirectory       = var.workingDirectory == "" ? "null" : var.workingDirectory
  }
}