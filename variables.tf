variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to all AWS resources via provider default_tags"
  default     = {}
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

variable "log_streams" {
  type = map(object({
    name           = string
    log_group_name = string
  }))
  description = "CloudWatch log streams"
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

variable "cloudwatch_tags" {
  type        = map(string)
  description = "Tags for CloudWatch resources"
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
  description = "Public subnet CIDR blocks"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDR blocks"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Map public IP on launch for VPC public subnets"
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support in VPC"
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC"
  default     = true
}

variable "single_nat_gateway" {
  type        = bool
  description = "Use single NAT gateway"
  default     = false
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable NAT gateway"
  default     = false
}

variable "vpc_tags" {
  type        = map(string)
  description = "Tags for VPC resources"
  default     = {}
}

variable "security_group_name" {
  type        = string
  description = "Security group name"
}

variable "security_group_description" {
  type        = string
  description = "Security group description"
  default     = "Managed by Terraform"
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
  description = "Security group ingress rules"
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
  description = "Security group egress rules"
  default     = []
}

variable "revoke_rules_on_delete" {
  type        = bool
  description = "Revoke rules on security group delete"
  default     = false
}

variable "default_egress_allow_all" {
  type        = bool
  description = "Default allow-all egress rule"
  default     = true
}

variable "security_group_tags" {
  type        = map(string)
  description = "Tags for security group"
  default     = {}
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
  default     = true
}

variable "ipv6_cidr_block" {
  type        = string
  description = "Subnet IPv6 CIDR block"
  default     = null
}

variable "assign_ipv6_address_on_creation" {
  type        = bool
  description = "Assign IPv6 address on creation"
  default     = false
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
  description = "Additional subnet routes"
  default     = []
}

variable "default_route_target_type" {
  type        = string
  description = "Default route target type"
  default     = "gateway_id"
}

variable "default_route_target_id" {
  type        = string
  description = "Default route target ID"
  default     = null
}

variable "create_route_table" {
  type        = bool
  description = "Create route table for subnet"
  default     = true
}

variable "subnet_tags" {
  type        = map(string)
  description = "Tags for subnet"
  default     = {}
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
  description = "IAM role trust policy principals"
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "Managed policy ARNs to attach to IAM role"
  default     = []
}

variable "max_session_duration" {
  type        = number
  description = "IAM role max session duration"
  default     = 3600
}

variable "iam_role_description" {
  type        = string
  description = "IAM role description"
  default     = ""
}

variable "force_detach_policies" {
  type        = bool
  description = "Force detach policies on IAM role destroy"
  default     = false
}

variable "inline_policies" {
  type = map(object({
    name   = string
    policy = string
  }))
  description = "IAM role inline policies"
  default     = {}
}

variable "iam_role_path" {
  type        = string
  description = "IAM role path"
  default     = "/"
}

variable "permissions_boundary" {
  type        = string
  description = "IAM role permissions boundary ARN"
  default     = null
}

variable "iam_role_tags" {
  type        = map(string)
  description = "Tags for IAM role"
  default     = {}
}

variable "iam_instance_profile_name" {
  type        = string
  description = "IAM instance profile name"
}

variable "ec2_name" {
  type        = string
  description = "EC2 instance name"
}

variable "ami_id" {
  type        = string
  description = "EC2 AMI ID"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "EC2 key pair name"
  default     = null
}

variable "associate_public_ip" {
  type        = bool
  description = "Associate public IP with EC2 instance"
  default     = false
}

variable "ebs_delete_on_termination" {
  type        = bool
  description = "Delete EBS volume on termination"
  default     = true
}

variable "ebs_encrypted" {
  type        = bool
  description = "Encrypt EBS volume"
  default     = true
}

variable "ebs_volume_type" {
  type        = string
  description = "EBS volume type"
  default     = "gp3"
}

variable "ebs_volume_size" {
  type        = number
  description = "EBS volume size in GB"
  default     = 30
}

variable "monitoring" {
  type        = bool
  description = "Enable detailed EC2 monitoring"
  default     = false
}

variable "metadata_http_tokens" {
  type        = string
  description = "IMDSv2 metadata HTTP tokens setting"
  default     = "required"
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  description = "Metadata HTTP PUT response hop limit"
  default     = 1
}

variable "ec2_tags" {
  type        = map(string)
  description = "Tags for EC2 instance"
  default     = {}
}
