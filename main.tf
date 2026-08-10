module "cloudwatch" {
  source  = "app.terraform.io/TF01/cloudwatch/aws"
  version = "~> 1.0.1"

  log_groups     = var.log_groups
  event_targets  = var.event_targets
  event_rules    = var.event_rules
  log_streams    = var.log_streams
  dashboards     = var.dashboards
  metric_alarms  = var.metric_alarms
  tags           = var.cloudwatch_tags
}

module "vpc" {
  source  = "app.terraform.io/TF01/vpc/aws"
  version = "~> 1.0.0"

  name                  = var.vpc_name
  cidr_block            = var.vpc_cidr_block
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  map_public_ip_on_launch = var.map_public_ip_on_launch
  enable_dns_support    = var.enable_dns_support
  enable_dns_hostnames  = var.enable_dns_hostnames
  single_nat_gateway    = var.single_nat_gateway
  enable_nat_gateway    = var.enable_nat_gateway
  tags                  = var.vpc_tags
}

module "security_group" {
  source  = "app.terraform.io/TF01/security-group/aws"
  version = "~> 1.0.0"

  name                    = var.security_group_name
  vpc_id                  = module.vpc.vpc_id
  description             = var.security_group_description
  ingress_rules           = var.ingress_rules
  egress_rules            = var.egress_rules
  revoke_rules_on_delete  = var.revoke_rules_on_delete
  default_egress_allow_all = var.default_egress_allow_all
  tags                    = var.security_group_tags
}

module "subnet" {
  source  = "app.terraform.io/TF01/subnet/aws"
  version = "~> 1.0.0"

  name                          = var.subnet_name
  vpc_id                        = module.vpc.vpc_id
  cidr_block                    = var.subnet_cidr_block
  availability_zone             = module.ec2.availability_zone
  map_public_ip_on_launch       = var.subnet_map_public_ip_on_launch
  ipv6_cidr_block               = var.ipv6_cidr_block
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  additional_routes             = var.additional_routes
  default_route_target_type     = var.default_route_target_type
  default_route_target_id       = var.default_route_target_id
  create_route_table            = var.create_route_table
  tags                          = var.subnet_tags
}

module "iam_role" {
  source  = "app.terraform.io/TF01/iam-role/aws"
  version = "~> 1.0.0"

  name                   = var.iam_role_name
  assume_role_principals = var.assume_role_principals
  managed_policy_arns    = var.managed_policy_arns
  max_session_duration   = var.max_session_duration
  description            = var.iam_role_description
  force_detach_policies  = var.force_detach_policies
  inline_policies        = var.inline_policies
  path                   = var.iam_role_path
  permissions_boundary   = var.permissions_boundary
  tags                   = var.iam_role_tags
}

resource "aws_iam_instance_profile" "ec2_instance" {
  name = var.iam_instance_profile_name
  role = module.iam_role.role_name
}

module "ec2" {
  source  = "app.terraform.io/TF01/ec2/aws"
  version = "~> 1.0.0"

  name                                 = var.ec2_name
  ami_id                               = var.ami_id
  instance_type                        = var.instance_type
  subnet_id                            = module.subnet.subnet_id
  vpc_security_group_ids               = [module.security_group.security_group_id]
  iam_instance_profile                 = aws_iam_instance_profile.ec2_instance.name
  key_name                             = var.key_name
  associate_public_ip                  = var.associate_public_ip
  ebs_delete_on_termination            = var.ebs_delete_on_termination
  ebs_encrypted                        = var.ebs_encrypted
  ebs_volume_type                      = var.ebs_volume_type
  ebs_volume_size                      = var.ebs_volume_size
  monitoring                           = var.monitoring
  metadata_http_tokens                 = var.metadata_http_tokens
  metadata_http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
  tags                                 = var.ec2_tags
}
