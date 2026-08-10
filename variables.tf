variable "region" {
  type        = string
  description = "AWS region"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to all AWS resources via provider default_tags"
  default     = {}
}

variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDRs"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDRs"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Map public IP on launch for VPC public subnets"
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames"
}

variable "single_nat_gateway" {
  type        = bool
  description = "Single NAT gateway"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable NAT gateway"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name"
}

variable "subnet_cidr_block" {
  type        = string
  description = "Subnet CIDR block"
}

variable "subnet_map_public_ip_on_launch" {
  type        = bool
  description = "Map public IP on launch for subnet"
}

variable "subnet_ipv6_cidr_block" {
  type        = string
  description = "Subnet IPv6 CIDR block"
  default     = null
}

variable "assign_ipv6_address_on_creation" {
  type        = bool
  description = "Assign IPv6 address on creation"
}

variable "additional_routes" {
  type = list(object({
    cidr_block                = string
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    transit_gateway_id        = optional(string)
    vpc_peering_connection_id = optional(string)
    network_interface_id      = optional(string)
  }))
  description = "Additional routes"
  default     = []
}

variable "default_route_target_type" {
  type        = string
  description = "Default route target type"
}

variable "default_route_target_id" {
  type        = string
  description = "Default route target ID"
  default     = null
}

variable "create_route_table" {
  type        = bool
  description = "Create route table"
}

variable "security_group_name" {
  type        = string
  description = "Security group name"
}

variable "security_group_description" {
  type        = string
  description = "Security group description"
}

variable "ingress_rules" {
  type = list(object({
    description      = optional(string, "")
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), [])
    ipv6_cidr_blocks = optional(list(string), [])
    security_groups  = optional(list(string), [])
    self             = optional(bool, false)
  }))
  description = "Ingress rules"
  default     = []
}

variable "egress_rules" {
  type = list(object({
    description      = optional(string, "")
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), [])
    ipv6_cidr_blocks = optional(list(string), [])
    security_groups  = optional(list(string), [])
    self             = optional(bool, false)
  }))
  description = "Egress rules"
  default     = []
}

variable "revoke_rules_on_delete" {
  type        = bool
  description = "Revoke rules on delete"
}

variable "default_egress_allow_all" {
  type        = bool
  description = "Default egress allow all"
}

variable "iam_role_name" {
  type        = string
  description = "IAM role name"
}

variable "assume_role_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "Assume role principals"
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "Managed policy ARNs"
  default     = []
}

variable "iam_role_description" {
  type        = string
  description = "IAM role description"
  default     = ""
}

variable "iam_role_path" {
  type        = string
  description = "IAM role path"
}

variable "max_session_duration" {
  type        = number
  description = "Max session duration"
}

variable "force_detach_policies" {
  type        = bool
  description = "Force detach policies"
}

variable "inline_policies" {
  type = map(object({
    name   = string
    policy = string
  }))
  description = "Inline policies"
  default     = {}
}

variable "permissions_boundary" {
  type        = string
  description = "Permissions boundary ARN"
  default     = null
}

variable "ec2_name" {
  type        = string
  description = "EC2 instance name"
}

variable "ami_id" {
  type        = string
  description = "AMI ID"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  description = "EC2 key pair name"
  default     = null
}

variable "associate_public_ip" {
  type        = bool
  description = "Associate public IP"
}

variable "ebs_volume_size" {
  type        = number
  description = "EBS volume size"
}

variable "ebs_volume_type" {
  type        = string
  description = "EBS volume type"
}

variable "ebs_encrypted" {
  type        = bool
  description = "EBS encrypted"
}

variable "ebs_delete_on_termination" {
  type        = bool
  description = "EBS delete on termination"
}

variable "monitoring" {
  type        = bool
  description = "EC2 detailed monitoring"
}

variable "metadata_http_tokens" {
  type        = string
  description = "Metadata HTTP tokens"
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  description = "Metadata HTTP PUT response hop limit"
}

variable "log_groups" {
  type = map(object({
    name              = string
    retention_in_days = optional(number, 14)
    kms_key_id        = optional(string, null)
    tags              = optional(map(string), {})
  }))
  description = "CloudWatch log groups"
  default     = {}
}

variable "log_streams" {
  type = map(object({
    name           = string
    log_group_name = string
  }))
  description = "CloudWatch log streams"
  default     = {}
}

variable "metric_alarms" {
  type = map(object({
    alarm_name          = string
    comparison_operator = string
    evaluation_periods  = number
    metric_name         = string
    namespace           = string
    period              = number
    statistic           = string
    threshold           = number
    alarm_description   = optional(string, "")
    alarm_actions       = optional(list(string), [])
    ok_actions          = optional(list(string), [])
    treat_missing_data  = optional(string, "missing")
    datapoints_to_alarm = optional(number, null)
    dimensions          = optional(map(string), null)
    unit                = optional(string, null)
    tags                = optional(map(string), {})
  }))
  description = "CloudWatch metric alarms"
  default     = {}
}

variable "event_rules" {
  type = map(object({
    name                = string
    description         = optional(string, "")
    event_pattern       = optional(string, null)
    schedule_expression = optional(string, null)
    state               = optional(string, "ENABLED")
    tags                = optional(map(string), {})
  }))
  description = "CloudWatch event rules"
  default     = {}
}

variable "event_targets" {
  type = map(object({
    rule      = string
    target_id = string
    arn       = string
    role_arn  = optional(string, null)
  }))
  description = "CloudWatch event targets"
  default     = {}
}

variable "dashboards" {
  type = map(object({
    dashboard_name = string
    dashboard_body = string
  }))
  description = "CloudWatch dashboards"
  default     = {}
}
