# tf-ecs-task-definition

The purpose of this module is to generate a valid Amazon ECS Fargate Task Definition and create task service. Please not this module is not compatible with terraform version less than 0.12.x.

#Requirements

- [Terraform](https://www.terraform.io/downloads.html)

## Usage

Invoking the commands defined below creates an ECS task definition :

    $ terraform init
    $ terraform apply

## Pre-Requisite

This module is dependent of tf-ecs-container-definition repo to create containers in task definition.

## Inputs

| Name | Description | Type | Default | Required |
| cpu | The number of cpu units reserved for the container | `number` | `0` | no |
| memory | The hard limit (in MiB) of memory to present to the container | `number` | `0` | no |
| family | You must specify a family for a task definition, which allows you to track multiple versions of the same task definition | `any` | n/a | yes |
| ipc\_mode | The IPC resource namespace to use for the containers in the task | `string` | `"host"` | no |
| network\_mode | The Docker networking mode to use for the containers in the task | `string` | `"bridge"` | no |
| pid\_mode | The process namespace to use for the containers in the task | `string` | `"host"` | no |
| placement\_constraints | An array of placement constraint objects to use for the task | `list(string)` | `[]` | no |
| register\_task\_definition | Registers a new task definition from the supplied family and containerDefinitions | `bool` | `true` | no |
| tags | The metadata that you apply to the task definition to help you categorize and organize them | `map(string)` | `{}` | no |
| volumes | A list of volume definitions in JSON format that containers in your task may use | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The full Amazon Resource Name (ARN) of the task definition |
| family | The family of your task definition, used as the definition name |
| revision | The revision of the task in a particular family |