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

resource "aws_ecs_task_definition" "ecs_task_definition" {
  container_definitions = local.container_definitions
  execution_role_arn    = var.execution_role_arn
  family                = var.family
  ipc_mode              = var.ipc_mode
  network_mode          = var.network_mode
  pid_mode              = var.pid_mode

  # Fargate requires cpu and memory to be defined at the task level
  cpu    = var.cpu
  memory = var.memory

  dynamic "placement_constraints" {
    for_each = var.placement_constraints
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      expression = lookup(placement_constraints.value, "expression", null)
      type       = placement_constraints.value.type
    }
  }
  requires_compatibilities = var.requires_compatibilities
  task_role_arn            = var.task_role_arn
  dynamic "volume" {
    for_each = var.volumes
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      host_path = lookup(volume.value, "host_path", null)
      name      = volume.value.name

      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", [])
        content {
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
          scope         = lookup(docker_volume_configuration.value, "scope", null)
        }
      }
      dynamic "efs_volume_configuration" {
        for_each = lookup(volume.value, "efs_volume_configuration", [])
        content {
          file_system_id = lookup(efs_volume_configuration.value, "file_system_id", null)
          root_directory = lookup(efs_volume_configuration.value, "root_directory", null)
        }
      }
    }
  }
  tags = var.tags

  count = var.register_task_definition ? 1 : 0
}