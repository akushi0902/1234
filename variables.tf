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
  description = "Enable DNS support in VPC"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable NAT gateway"
}

variable "single_nat_gateway" {
  type        = bool
  description = "Use single NAT gateway"
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

variable "assign_ipv6_address_on_creation" {
  type        = bool
  description = "Assign IPv6 address on creation"
}

variable "ipv6_cidr_block" {
  type        = string
  description = "IPv6 CIDR block for subnet"
  default     = null
}

variable "create_route_table" {
  type        = bool
  description = "Create route table for subnet"
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

variable "additional_routes" {
  type = list(object({
    cidr_block                = string
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    transit_gateway_id        = optional(string)
    vpc_peering_connection_id = optional(string)
    network_interface_id      = optional(string)
  }))
  description = "Additional routes for subnet route table"
  default     = []
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
}

variable "default_egress_allow_all" {
  type        = bool
  description = "Default allow-all egress rule"
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
  description = "IAM role max session duration"
}

variable "force_detach_policies" {
  type        = bool
  description = "Force detach policies on IAM role destroy"
}

variable "inline_policies" {
  type = map(object({
    name   = string
    policy = string
  }))
  description = "IAM role inline policies"
  default     = {}
}

variable "permissions_boundary" {
  type        = string
  description = "IAM role permissions boundary ARN"
  default     = null
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
  description = "Associate public IP with EC2 instance"
}

variable "ebs_delete_on_termination" {
  type        = bool
  description = "Delete EBS volume on termination"
}

variable "ebs_encrypted" {
  type        = bool
  description = "Encrypt EBS volume"
}

variable "ebs_volume_type" {
  type        = string
  description = "EBS volume type"
}

variable "ebs_volume_size" {
  type        = number
  description = "EBS volume size in GB"
}

variable "monitoring" {
  type        = bool
  description = "Enable detailed CloudWatch monitoring"
}

variable "metadata_http_tokens" {
  type        = string
  description = "IMDSv2 metadata HTTP tokens setting"
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  description = "Metadata HTTP PUT response hop limit"
}

variable "user_data" {
  type        = string
  description = "EC2 user data script"
  default     = null
}

variable "user_data_base64" {
  type        = string
  description = "EC2 user data base64 encoded"
  default     = null
}
