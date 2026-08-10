region = "us-east-1"

log_groups = {
  "ec2-instance" = {
    name              = "/aws/ec2/ec2-instance"
    retention_in_days = 30
  }
}

event_targets  = {}
event_rules    = {}
log_streams    = {}
dashboards     = {}
metric_alarms  = {}

cloudwatch_tags = {
  environment = "dev"
  service     = "ec2-instance"
}

vpc_name             = "ec2-instance"
vpc_cidr_block       = "10.0.0.0/16"
availability_zones   = ["us-east-1a"]
public_subnet_cidrs  = ["10.0.1.0/24"]
private_subnet_cidrs = ["10.0.2.0/24"]
map_public_ip_on_launch = true
enable_dns_support   = true
enable_dns_hostnames = true
single_nat_gateway   = false
enable_nat_gateway   = false

vpc_tags = {
  environment = "dev"
  service     = "ec2-instance"
}

security_group_name        = "ec2-instance"
security_group_description = "Security group for ec2-instance"

ingress_rules = [
  {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

revoke_rules_on_delete   = false
default_egress_allow_all = true

security_group_tags = {
  environment = "dev"
  service     = "ec2-instance"
}

subnet_name                    = "public-ec2-instance"
subnet_cidr_block              = "10.0.1.0/24"
subnet_availability_zone       = "us-east-1a"
subnet_map_public_ip_on_launch = true
ipv6_cidr_block                = null
assign_ipv6_address_on_creation = false
additional_routes              = []
default_route_target_type      = "gateway_id"
default_route_target_id        = null
create_route_table             = true

subnet_tags = {
  environment = "dev"
  service     = "ec2-instance"
}

iam_role_name = "iam-profile-ec2-instance"

assume_role_principals = [
  {
    type        = "Service"
    identifiers = ["ec2.amazonaws.com"]
  }
]

managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]

max_session_duration  = 3600
iam_role_description  = ""
force_detach_policies = false
inline_policies       = {}
iam_role_path         = "/"
permissions_boundary  = null

iam_role_tags = {
  environment = "dev"
  service     = "ec2-instance"
}

iam_instance_profile_name = "iam-profile-ec2-instance"

ec2_name      = "ec2-instance"
ami_id        = "ami-0c02fb55956c7d316"
instance_type = "t3.micro"
key_name      = "ec2-instance"

associate_public_ip                  = true
ebs_delete_on_termination            = true
ebs_encrypted                        = true
ebs_volume_type                      = "gp3"
ebs_volume_size                      = 20
monitoring                           = false
metadata_http_tokens                 = "required"
metadata_http_put_response_hop_limit = 1

ec2_tags = {
  environment = "dev"
  service     = "ec2-instance"
}

default_tags = {
  team = "dev"
  service = "ec2-instance"
  environment = "dev"
}
