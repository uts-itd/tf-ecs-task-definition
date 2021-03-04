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
