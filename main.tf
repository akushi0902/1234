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
  tags                  = {}
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
  tags                    = {}
}

module "iam_role" {
  source  = "app.terraform.io/TF01/iam-role/aws"
  version = "~> 1.0.0"

  name                   = var.iam_role_name
  assume_role_principals = var.assume_role_principals
  managed_policy_arns    = var.managed_policy_arns
  description            = var.iam_role_description
  path                   = var.iam_role_path
  max_session_duration   = var.max_session_duration
  force_detach_policies  = var.force_detach_policies
  inline_policies        = var.inline_policies
  permissions_boundary   = var.permissions_boundary
  tags                   = {}
}

resource "aws_iam_instance_profile" "ec2_instance" {
  name = var.iam_role_name
  role = module.iam_role.role_name
}

module "ec2" {
  source  = "app.terraform.io/TF01/ec2/aws"
  version = "~> 1.0.0"

  name                                 = var.ec2_name
  ami_id                               = var.ami_id
  instance_type                        = var.instance_type
  subnet_id                            = module.vpc.public_subnet_ids[0]
  vpc_security_group_ids               = [module.security_group.security_group_id]
  iam_instance_profile                 = aws_iam_instance_profile.ec2_instance.name
  key_name                             = var.key_name
  associate_public_ip                  = var.associate_public_ip
  ebs_volume_size                      = var.ebs_volume_size
  ebs_volume_type                      = var.ebs_volume_type
  ebs_encrypted                        = var.ebs_encrypted
  ebs_delete_on_termination            = var.ebs_delete_on_termination
  monitoring                           = var.monitoring
  metadata_http_tokens                 = var.metadata_http_tokens
  metadata_http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
  tags                                 = {}

  depends_on = [aws_iam_instance_profile.ec2_instance]
}

module "cloudwatch" {
  source  = "app.terraform.io/TF01/cloudwatch/aws"
  version = "~> 1.0.1"

  log_groups    = var.log_groups
  log_streams   = var.log_streams
  metric_alarms = var.metric_alarms
  event_rules   = var.event_rules
  event_targets = var.event_targets
  dashboards    = var.dashboards
  tags          = {}
}
