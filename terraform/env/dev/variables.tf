variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "developer_ip_cidr" {
  type        = string
  description = "CIDR for dev machine accessing EKS endpoint"
}
