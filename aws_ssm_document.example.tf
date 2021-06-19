resource "aws_ssm_document" "example" {
  name            = var.document_name
  document_type   = var.document_type
  document_format = var.document_format

  content = var.content
}

variable "document_name" {
  type    = string
  default = "test_document"
}

variable "document_type" {
  type    = string
  default = "Command"
  validation {
    condition     = can(regex("Command|Session|Automation|Package|Policy", var.document_type))
    error_message = "Can only be one of Command|Session|Automation|Package|Policy."
  }
}

variable "document_format" {
  type    = string
  default = "JSON"
  validation {
    condition     = can(regex("JSON|YAML", var.document_format))
    error_message = "Document format can be JSON or YAML."
  }
}

variable "content" {
  type    = string
  default = <<DOC
  {
    "schemaVersion": "1.2",
    "description": "Check ip configuration of a Linux instance.",
    "parameters": {

    },
    "runtimeConfig": {
      "aws:runShellScript": {
        "properties": [
          {
            "id": "0.aws:runShellScript",
            "runCommand": ["ifconfig"]
          }
        ]
      }
    }
  }
DOC
}
