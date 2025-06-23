locals {
  cluster_name                 = "niteshnepali.com.np"
  master_autoscaling_group_ids = [aws_autoscaling_group.control-plane-us-east-1a-masters-niteshnepali-com-np.id]
  master_security_group_ids    = [aws_security_group.masters-niteshnepali-com-np.id]
  masters_role_arn             = aws_iam_role.masters-niteshnepali-com-np.arn
  masters_role_name            = aws_iam_role.masters-niteshnepali-com-np.name
  node_autoscaling_group_ids   = [aws_autoscaling_group.nodes-us-east-1a-niteshnepali-com-np.id, aws_autoscaling_group.nodes-us-east-1b-niteshnepali-com-np.id, aws_autoscaling_group.nodes-us-east-1c-niteshnepali-com-np.id]
  node_security_group_ids      = [aws_security_group.nodes-niteshnepali-com-np.id]
  node_subnet_ids              = [aws_subnet.us-east-1a-niteshnepali-com-np.id, aws_subnet.us-east-1b-niteshnepali-com-np.id, aws_subnet.us-east-1c-niteshnepali-com-np.id]
  nodes_role_arn               = aws_iam_role.nodes-niteshnepali-com-np.arn
  nodes_role_name              = aws_iam_role.nodes-niteshnepali-com-np.name
  region                       = "us-east-1"
  route_table_public_id        = aws_route_table.niteshnepali-com-np.id
  subnet_us-east-1a_id         = aws_subnet.us-east-1a-niteshnepali-com-np.id
  subnet_us-east-1b_id         = aws_subnet.us-east-1b-niteshnepali-com-np.id
  subnet_us-east-1c_id         = aws_subnet.us-east-1c-niteshnepali-com-np.id
  vpc_cidr_block               = aws_vpc.niteshnepali-com-np.cidr_block
  vpc_id                       = aws_vpc.niteshnepali-com-np.id
  vpc_ipv6_cidr_block          = aws_vpc.niteshnepali-com-np.ipv6_cidr_block
  vpc_ipv6_cidr_length         = local.vpc_ipv6_cidr_block == "" ? null : tonumber(regex(".*/(\\d+)", local.vpc_ipv6_cidr_block)[0])
}

output "cluster_name" {
  value = "niteshnepali.com.np"
}

output "master_autoscaling_group_ids" {
  value = [aws_autoscaling_group.control-plane-us-east-1a-masters-niteshnepali-com-np.id]
}

output "master_security_group_ids" {
  value = [aws_security_group.masters-niteshnepali-com-np.id]
}

output "masters_role_arn" {
  value = aws_iam_role.masters-niteshnepali-com-np.arn
}

output "masters_role_name" {
  value = aws_iam_role.masters-niteshnepali-com-np.name
}

output "node_autoscaling_group_ids" {
  value = [aws_autoscaling_group.nodes-us-east-1a-niteshnepali-com-np.id, aws_autoscaling_group.nodes-us-east-1b-niteshnepali-com-np.id, aws_autoscaling_group.nodes-us-east-1c-niteshnepali-com-np.id]
}

output "node_security_group_ids" {
  value = [aws_security_group.nodes-niteshnepali-com-np.id]
}

output "node_subnet_ids" {
  value = [aws_subnet.us-east-1a-niteshnepali-com-np.id, aws_subnet.us-east-1b-niteshnepali-com-np.id, aws_subnet.us-east-1c-niteshnepali-com-np.id]
}

output "nodes_role_arn" {
  value = aws_iam_role.nodes-niteshnepali-com-np.arn
}

output "nodes_role_name" {
  value = aws_iam_role.nodes-niteshnepali-com-np.name
}

output "region" {
  value = "us-east-1"
}

output "route_table_public_id" {
  value = aws_route_table.niteshnepali-com-np.id
}

output "subnet_us-east-1a_id" {
  value = aws_subnet.us-east-1a-niteshnepali-com-np.id
}

output "subnet_us-east-1b_id" {
  value = aws_subnet.us-east-1b-niteshnepali-com-np.id
}

output "subnet_us-east-1c_id" {
  value = aws_subnet.us-east-1c-niteshnepali-com-np.id
}

output "vpc_cidr_block" {
  value = aws_vpc.niteshnepali-com-np.cidr_block
}

output "vpc_id" {
  value = aws_vpc.niteshnepali-com-np.id
}

output "vpc_ipv6_cidr_block" {
  value = aws_vpc.niteshnepali-com-np.ipv6_cidr_block
}

output "vpc_ipv6_cidr_length" {
  value = local.vpc_ipv6_cidr_block == "" ? null : tonumber(regex(".*/(\\d+)", local.vpc_ipv6_cidr_block)[0])
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "files"
  region = "us-east-1"
}

resource "aws_autoscaling_group" "control-plane-us-east-1a-masters-niteshnepali-com-np" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.control-plane-us-east-1a-masters-niteshnepali-com-np.id
    version = aws_launch_template.control-plane-us-east-1a-masters-niteshnepali-com-np.latest_version
  }
  max_instance_lifetime = 0
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "control-plane-us-east-1a.masters.niteshnepali.com.np"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "niteshnepali.com.np"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "control-plane-us-east-1a.masters.niteshnepali.com.np"
  }
  tag {
    key                 = "aws-node-termination-handler/managed"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/control-plane"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "k8s.io/role/master"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "control-plane-us-east-1a"
  }
  tag {
    key                 = "kubernetes.io/cluster/niteshnepali.com.np"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.us-east-1a-niteshnepali-com-np.id]
}

resource "aws_autoscaling_group" "nodes-us-east-1a-niteshnepali-com-np" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.nodes-us-east-1a-niteshnepali-com-np.id
    version = aws_launch_template.nodes-us-east-1a-niteshnepali-com-np.latest_version
  }
  max_instance_lifetime = 0
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "nodes-us-east-1a.niteshnepali.com.np"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "niteshnepali.com.np"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "nodes-us-east-1a.niteshnepali.com.np"
  }
  tag {
    key                 = "aws-node-termination-handler/managed"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/node"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "nodes-us-east-1a"
  }
  tag {
    key                 = "kubernetes.io/cluster/niteshnepali.com.np"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.us-east-1a-niteshnepali-com-np.id]
}

resource "aws_autoscaling_group" "nodes-us-east-1b-niteshnepali-com-np" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.nodes-us-east-1b-niteshnepali-com-np.id
    version = aws_launch_template.nodes-us-east-1b-niteshnepali-com-np.latest_version
  }
  max_instance_lifetime = 0
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "nodes-us-east-1b.niteshnepali.com.np"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "niteshnepali.com.np"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "nodes-us-east-1b.niteshnepali.com.np"
  }
  tag {
    key                 = "aws-node-termination-handler/managed"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/node"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "nodes-us-east-1b"
  }
  tag {
    key                 = "kubernetes.io/cluster/niteshnepali.com.np"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.us-east-1b-niteshnepali-com-np.id]
}

resource "aws_autoscaling_group" "nodes-us-east-1c-niteshnepali-com-np" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.nodes-us-east-1c-niteshnepali-com-np.id
    version = aws_launch_template.nodes-us-east-1c-niteshnepali-com-np.latest_version
  }
  max_instance_lifetime = 0
  max_size              = 0
  metrics_granularity   = "1Minute"
  min_size              = 0
  name                  = "nodes-us-east-1c.niteshnepali.com.np"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "niteshnepali.com.np"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "nodes-us-east-1c.niteshnepali.com.np"
  }
  tag {
    key                 = "aws-node-termination-handler/managed"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/node"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "nodes-us-east-1c"
  }
  tag {
    key                 = "kubernetes.io/cluster/niteshnepali.com.np"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.us-east-1c-niteshnepali-com-np.id]
}

resource "aws_autoscaling_lifecycle_hook" "control-plane-us-east-1a-NTHLifecycleHook" {
  autoscaling_group_name = aws_autoscaling_group.control-plane-us-east-1a-masters-niteshnepali-com-np.id
  default_result         = "CONTINUE"
  heartbeat_timeout      = 300
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                   = "control-plane-us-east-1a-NTHLifecycleHook"
}

resource "aws_autoscaling_lifecycle_hook" "nodes-us-east-1a-NTHLifecycleHook" {
  autoscaling_group_name = aws_autoscaling_group.nodes-us-east-1a-niteshnepali-com-np.id
  default_result         = "CONTINUE"
  heartbeat_timeout      = 300
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                   = "nodes-us-east-1a-NTHLifecycleHook"
}

resource "aws_autoscaling_lifecycle_hook" "nodes-us-east-1b-NTHLifecycleHook" {
  autoscaling_group_name = aws_autoscaling_group.nodes-us-east-1b-niteshnepali-com-np.id
  default_result         = "CONTINUE"
  heartbeat_timeout      = 300
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                   = "nodes-us-east-1b-NTHLifecycleHook"
}

resource "aws_autoscaling_lifecycle_hook" "nodes-us-east-1c-NTHLifecycleHook" {
  autoscaling_group_name = aws_autoscaling_group.nodes-us-east-1c-niteshnepali-com-np.id
  default_result         = "CONTINUE"
  heartbeat_timeout      = 300
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                   = "nodes-us-east-1c-NTHLifecycleHook"
}

resource "aws_cloudwatch_event_rule" "niteshnepali-com-np-ASGLifecycle" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_niteshnepali.com.np-ASGLifecycle_event_pattern")
  name          = "niteshnepali.com.np-ASGLifecycle"
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "niteshnepali.com.np-ASGLifecycle"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
}

resource "aws_cloudwatch_event_rule" "niteshnepali-com-np-InstanceScheduledChange" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_niteshnepali.com.np-InstanceScheduledChange_event_pattern")
  name          = "niteshnepali.com.np-InstanceScheduledChange"
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "niteshnepali.com.np-InstanceScheduledChange"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
}

resource "aws_cloudwatch_event_rule" "niteshnepali-com-np-InstanceStateChange" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_niteshnepali.com.np-InstanceStateChange_event_pattern")
  name          = "niteshnepali.com.np-InstanceStateChange"
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "niteshnepali.com.np-InstanceStateChange"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
}

resource "aws_cloudwatch_event_rule" "niteshnepali-com-np-SpotInterruption" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_niteshnepali.com.np-SpotInterruption_event_pattern")
  name          = "niteshnepali.com.np-SpotInterruption"
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "niteshnepali.com.np-SpotInterruption"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
}

resource "aws_cloudwatch_event_target" "niteshnepali-com-np-ASGLifecycle-Target" {
  arn  = aws_sqs_queue.niteshnepali-com-np-nth.arn
  rule = aws_cloudwatch_event_rule.niteshnepali-com-np-ASGLifecycle.id
}

resource "aws_cloudwatch_event_target" "niteshnepali-com-np-InstanceScheduledChange-Target" {
  arn  = aws_sqs_queue.niteshnepali-com-np-nth.arn
  rule = aws_cloudwatch_event_rule.niteshnepali-com-np-InstanceScheduledChange.id
}

resource "aws_cloudwatch_event_target" "niteshnepali-com-np-InstanceStateChange-Target" {
  arn  = aws_sqs_queue.niteshnepali-com-np-nth.arn
  rule = aws_cloudwatch_event_rule.niteshnepali-com-np-InstanceStateChange.id
}

resource "aws_cloudwatch_event_target" "niteshnepali-com-np-SpotInterruption-Target" {
  arn  = aws_sqs_queue.niteshnepali-com-np-nth.arn
  rule = aws_cloudwatch_event_rule.niteshnepali-com-np-SpotInterruption.id
}

resource "aws_ebs_volume" "a-etcd-events-niteshnepali-com-np" {
  availability_zone = "us-east-1a"
  encrypted         = true
  iops              = 3000
  size              = 20
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "a.etcd-events.niteshnepali.com.np"
    "k8s.io/etcd/events"                        = "a/a"
    "k8s.io/role/control-plane"                 = "1"
    "k8s.io/role/master"                        = "1"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
  throughput = 125
  type       = "gp3"
}

resource "aws_ebs_volume" "a-etcd-main-niteshnepali-com-np" {
  availability_zone = "us-east-1a"
  encrypted         = true
  iops              = 3000
  size              = 20
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "a.etcd-main.niteshnepali.com.np"
    "k8s.io/etcd/main"                          = "a/a"
    "k8s.io/role/control-plane"                 = "1"
    "k8s.io/role/master"                        = "1"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
  throughput = 125
  type       = "gp3"
}

resource "aws_iam_instance_profile" "masters-niteshnepali-com-np" {
  name = "masters.niteshnepali.com.np"
  role = aws_iam_role.masters-niteshnepali-com-np.name
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "masters.niteshnepali.com.np"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
}

resource "aws_iam_instance_profile" "nodes-niteshnepali-com-np" {
  name = "nodes.niteshnepali.com.np"
  role = aws_iam_role.nodes-niteshnepali-com-np.name
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "nodes.niteshnepali.com.np"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
}

resource "aws_iam_role" "masters-niteshnepali-com-np" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_masters.niteshnepali.com.np_policy")
  name               = "masters.niteshnepali.com.np"
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "masters.niteshnepali.com.np"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
}

resource "aws_iam_role" "nodes-niteshnepali-com-np" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_nodes.niteshnepali.com.np_policy")
  name               = "nodes.niteshnepali.com.np"
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "nodes.niteshnepali.com.np"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
}

resource "aws_iam_role_policy" "masters-niteshnepali-com-np" {
  name   = "masters.niteshnepali.com.np"
  policy = file("${path.module}/data/aws_iam_role_policy_masters.niteshnepali.com.np_policy")
  role   = aws_iam_role.masters-niteshnepali-com-np.name
}

resource "aws_iam_role_policy" "nodes-niteshnepali-com-np" {
  name   = "nodes.niteshnepali.com.np"
  policy = file("${path.module}/data/aws_iam_role_policy_nodes.niteshnepali.com.np_policy")
  role   = aws_iam_role.nodes-niteshnepali-com-np.name
}

resource "aws_internet_gateway" "niteshnepali-com-np" {
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "niteshnepali.com.np"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
  vpc_id = aws_vpc.niteshnepali-com-np.id
}

resource "aws_key_pair" "kubernetes-niteshnepali-com-np-3c4f54ec948a136b75505f30227fc251" {
  key_name   = "kubernetes.niteshnepali.com.np-3c:4f:54:ec:94:8a:13:6b:75:50:5f:30:22:7f:c2:51"
  public_key = file("${path.module}/data/aws_key_pair_kubernetes.niteshnepali.com.np-3c4f54ec948a136b75505f30227fc251_public_key")
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "niteshnepali.com.np"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
}

resource "aws_launch_template" "control-plane-us-east-1a-masters-niteshnepali-com-np" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 30
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.masters-niteshnepali-com-np.id
  }
  image_id      = "ami-020cba7c55df1f615"
  instance_type = "t3.medium"
  key_name      = aws_key_pair.kubernetes-niteshnepali-com-np-3c4f54ec948a136b75505f30227fc251.id
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }
  monitoring {
    enabled = false
  }
  name = "control-plane-us-east-1a.masters.niteshnepali.com.np"
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.masters-niteshnepali-com-np.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                                                     = "niteshnepali.com.np"
      "Name"                                                                                                  = "control-plane-us-east-1a.masters.niteshnepali.com.np"
      "aws-node-termination-handler/managed"                                                                  = ""
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
      "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
      "k8s.io/role/control-plane"                                                                             = "1"
      "k8s.io/role/master"                                                                                    = "1"
      "kops.k8s.io/instancegroup"                                                                             = "control-plane-us-east-1a"
      "kubernetes.io/cluster/niteshnepali.com.np"                                                             = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                                                     = "niteshnepali.com.np"
      "Name"                                                                                                  = "control-plane-us-east-1a.masters.niteshnepali.com.np"
      "aws-node-termination-handler/managed"                                                                  = ""
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
      "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
      "k8s.io/role/control-plane"                                                                             = "1"
      "k8s.io/role/master"                                                                                    = "1"
      "kops.k8s.io/instancegroup"                                                                             = "control-plane-us-east-1a"
      "kubernetes.io/cluster/niteshnepali.com.np"                                                             = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                                                     = "niteshnepali.com.np"
    "Name"                                                                                                  = "control-plane-us-east-1a.masters.niteshnepali.com.np"
    "aws-node-termination-handler/managed"                                                                  = ""
    "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
    "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
    "k8s.io/role/control-plane"                                                                             = "1"
    "k8s.io/role/master"                                                                                    = "1"
    "kops.k8s.io/instancegroup"                                                                             = "control-plane-us-east-1a"
    "kubernetes.io/cluster/niteshnepali.com.np"                                                             = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_control-plane-us-east-1a.masters.niteshnepali.com.np_user_data")
}

resource "aws_launch_template" "nodes-us-east-1a-niteshnepali-com-np" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 30
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.nodes-niteshnepali-com-np.id
  }
  image_id      = "ami-020cba7c55df1f615"
  instance_type = "t3.medium"
  key_name      = aws_key_pair.kubernetes-niteshnepali-com-np-3c4f54ec948a136b75505f30227fc251.id
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }
  monitoring {
    enabled = false
  }
  name = "nodes-us-east-1a.niteshnepali.com.np"
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.nodes-niteshnepali-com-np.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                          = "niteshnepali.com.np"
      "Name"                                                                       = "nodes-us-east-1a.niteshnepali.com.np"
      "aws-node-termination-handler/managed"                                       = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1a"
      "kubernetes.io/cluster/niteshnepali.com.np"                                  = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                          = "niteshnepali.com.np"
      "Name"                                                                       = "nodes-us-east-1a.niteshnepali.com.np"
      "aws-node-termination-handler/managed"                                       = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1a"
      "kubernetes.io/cluster/niteshnepali.com.np"                                  = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                          = "niteshnepali.com.np"
    "Name"                                                                       = "nodes-us-east-1a.niteshnepali.com.np"
    "aws-node-termination-handler/managed"                                       = ""
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
    "k8s.io/role/node"                                                           = "1"
    "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1a"
    "kubernetes.io/cluster/niteshnepali.com.np"                                  = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_nodes-us-east-1a.niteshnepali.com.np_user_data")
}

resource "aws_launch_template" "nodes-us-east-1b-niteshnepali-com-np" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 30
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.nodes-niteshnepali-com-np.id
  }
  image_id      = "ami-020cba7c55df1f615"
  instance_type = "t3.medium"
  key_name      = aws_key_pair.kubernetes-niteshnepali-com-np-3c4f54ec948a136b75505f30227fc251.id
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }
  monitoring {
    enabled = false
  }
  name = "nodes-us-east-1b.niteshnepali.com.np"
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.nodes-niteshnepali-com-np.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                          = "niteshnepali.com.np"
      "Name"                                                                       = "nodes-us-east-1b.niteshnepali.com.np"
      "aws-node-termination-handler/managed"                                       = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1b"
      "kubernetes.io/cluster/niteshnepali.com.np"                                  = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                          = "niteshnepali.com.np"
      "Name"                                                                       = "nodes-us-east-1b.niteshnepali.com.np"
      "aws-node-termination-handler/managed"                                       = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1b"
      "kubernetes.io/cluster/niteshnepali.com.np"                                  = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                          = "niteshnepali.com.np"
    "Name"                                                                       = "nodes-us-east-1b.niteshnepali.com.np"
    "aws-node-termination-handler/managed"                                       = ""
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
    "k8s.io/role/node"                                                           = "1"
    "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1b"
    "kubernetes.io/cluster/niteshnepali.com.np"                                  = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_nodes-us-east-1b.niteshnepali.com.np_user_data")
}

resource "aws_launch_template" "nodes-us-east-1c-niteshnepali-com-np" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 30
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.nodes-niteshnepali-com-np.id
  }
  image_id      = "ami-020cba7c55df1f615"
  instance_type = "t3.medium"
  key_name      = aws_key_pair.kubernetes-niteshnepali-com-np-3c4f54ec948a136b75505f30227fc251.id
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }
  monitoring {
    enabled = false
  }
  name = "nodes-us-east-1c.niteshnepali.com.np"
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.nodes-niteshnepali-com-np.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                          = "niteshnepali.com.np"
      "Name"                                                                       = "nodes-us-east-1c.niteshnepali.com.np"
      "aws-node-termination-handler/managed"                                       = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1c"
      "kubernetes.io/cluster/niteshnepali.com.np"                                  = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                          = "niteshnepali.com.np"
      "Name"                                                                       = "nodes-us-east-1c.niteshnepali.com.np"
      "aws-node-termination-handler/managed"                                       = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1c"
      "kubernetes.io/cluster/niteshnepali.com.np"                                  = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                          = "niteshnepali.com.np"
    "Name"                                                                       = "nodes-us-east-1c.niteshnepali.com.np"
    "aws-node-termination-handler/managed"                                       = ""
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
    "k8s.io/role/node"                                                           = "1"
    "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1c"
    "kubernetes.io/cluster/niteshnepali.com.np"                                  = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_nodes-us-east-1c.niteshnepali.com.np_user_data")
}

resource "aws_route" "route-0-0-0-0--0" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.niteshnepali-com-np.id
  route_table_id         = aws_route_table.niteshnepali-com-np.id
}

resource "aws_route" "route-__--0" {
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.niteshnepali-com-np.id
  route_table_id              = aws_route_table.niteshnepali-com-np.id
}

resource "aws_route_table" "niteshnepali-com-np" {
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "niteshnepali.com.np"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
    "kubernetes.io/kops/role"                   = "public"
  }
  vpc_id = aws_vpc.niteshnepali-com-np.id
}

resource "aws_route_table_association" "us-east-1a-niteshnepali-com-np" {
  route_table_id = aws_route_table.niteshnepali-com-np.id
  subnet_id      = aws_subnet.us-east-1a-niteshnepali-com-np.id
}

resource "aws_route_table_association" "us-east-1b-niteshnepali-com-np" {
  route_table_id = aws_route_table.niteshnepali-com-np.id
  subnet_id      = aws_subnet.us-east-1b-niteshnepali-com-np.id
}

resource "aws_route_table_association" "us-east-1c-niteshnepali-com-np" {
  route_table_id = aws_route_table.niteshnepali-com-np.id
  subnet_id      = aws_subnet.us-east-1c-niteshnepali-com-np.id
}

resource "aws_s3_object" "cluster-completed-spec" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_cluster-completed.spec_content")
  key      = "niteshnepali.com.np/cluster-completed.spec"
  provider = aws.files
}

resource "aws_s3_object" "etcd-cluster-spec-events" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_etcd-cluster-spec-events_content")
  key      = "niteshnepali.com.np/backups/etcd/events/control/etcd-cluster-spec"
  provider = aws.files
}

resource "aws_s3_object" "etcd-cluster-spec-main" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_etcd-cluster-spec-main_content")
  key      = "niteshnepali.com.np/backups/etcd/main/control/etcd-cluster-spec"
  provider = aws.files
}

resource "aws_s3_object" "kops-version-txt" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_kops-version.txt_content")
  key      = "niteshnepali.com.np/kops-version.txt"
  provider = aws.files
}

resource "aws_s3_object" "manifests-etcdmanager-events-control-plane-us-east-1a" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_manifests-etcdmanager-events-control-plane-us-east-1a_content")
  key      = "niteshnepali.com.np/manifests/etcd/events-control-plane-us-east-1a.yaml"
  provider = aws.files
}

resource "aws_s3_object" "manifests-etcdmanager-main-control-plane-us-east-1a" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_manifests-etcdmanager-main-control-plane-us-east-1a_content")
  key      = "niteshnepali.com.np/manifests/etcd/main-control-plane-us-east-1a.yaml"
  provider = aws.files
}

resource "aws_s3_object" "manifests-static-kube-apiserver-healthcheck" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_manifests-static-kube-apiserver-healthcheck_content")
  key      = "niteshnepali.com.np/manifests/static/kube-apiserver-healthcheck.yaml"
  provider = aws.files
}

resource "aws_s3_object" "niteshnepali-com-np-addons-aws-cloud-controller-addons-k8s-io-k8s-1-18" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_niteshnepali.com.np-addons-aws-cloud-controller.addons.k8s.io-k8s-1.18_content")
  key      = "niteshnepali.com.np/addons/aws-cloud-controller.addons.k8s.io/k8s-1.18.yaml"
  provider = aws.files
}

resource "aws_s3_object" "niteshnepali-com-np-addons-aws-ebs-csi-driver-addons-k8s-io-k8s-1-17" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_niteshnepali.com.np-addons-aws-ebs-csi-driver.addons.k8s.io-k8s-1.17_content")
  key      = "niteshnepali.com.np/addons/aws-ebs-csi-driver.addons.k8s.io/k8s-1.17.yaml"
  provider = aws.files
}

resource "aws_s3_object" "niteshnepali-com-np-addons-bootstrap" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_niteshnepali.com.np-addons-bootstrap_content")
  key      = "niteshnepali.com.np/addons/bootstrap-channel.yaml"
  provider = aws.files
}

resource "aws_s3_object" "niteshnepali-com-np-addons-coredns-addons-k8s-io-k8s-1-12" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_niteshnepali.com.np-addons-coredns.addons.k8s.io-k8s-1.12_content")
  key      = "niteshnepali.com.np/addons/coredns.addons.k8s.io/k8s-1.12.yaml"
  provider = aws.files
}

resource "aws_s3_object" "niteshnepali-com-np-addons-dns-controller-addons-k8s-io-k8s-1-12" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_niteshnepali.com.np-addons-dns-controller.addons.k8s.io-k8s-1.12_content")
  key      = "niteshnepali.com.np/addons/dns-controller.addons.k8s.io/k8s-1.12.yaml"
  provider = aws.files
}

resource "aws_s3_object" "niteshnepali-com-np-addons-kops-controller-addons-k8s-io-k8s-1-16" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_niteshnepali.com.np-addons-kops-controller.addons.k8s.io-k8s-1.16_content")
  key      = "niteshnepali.com.np/addons/kops-controller.addons.k8s.io/k8s-1.16.yaml"
  provider = aws.files
}

resource "aws_s3_object" "niteshnepali-com-np-addons-kubelet-api-rbac-addons-k8s-io-k8s-1-9" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_niteshnepali.com.np-addons-kubelet-api.rbac.addons.k8s.io-k8s-1.9_content")
  key      = "niteshnepali.com.np/addons/kubelet-api.rbac.addons.k8s.io/k8s-1.9.yaml"
  provider = aws.files
}

resource "aws_s3_object" "niteshnepali-com-np-addons-limit-range-addons-k8s-io" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_niteshnepali.com.np-addons-limit-range.addons.k8s.io_content")
  key      = "niteshnepali.com.np/addons/limit-range.addons.k8s.io/v1.5.0.yaml"
  provider = aws.files
}

resource "aws_s3_object" "niteshnepali-com-np-addons-networking-projectcalico-org-k8s-1-25" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_niteshnepali.com.np-addons-networking.projectcalico.org-k8s-1.25_content")
  key      = "niteshnepali.com.np/addons/networking.projectcalico.org/k8s-1.25.yaml"
  provider = aws.files
}

resource "aws_s3_object" "niteshnepali-com-np-addons-node-termination-handler-aws-k8s-1-11" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_niteshnepali.com.np-addons-node-termination-handler.aws-k8s-1.11_content")
  key      = "niteshnepali.com.np/addons/node-termination-handler.aws/k8s-1.11.yaml"
  provider = aws.files
}

resource "aws_s3_object" "niteshnepali-com-np-addons-storage-aws-addons-k8s-io-v1-15-0" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_niteshnepali.com.np-addons-storage-aws.addons.k8s.io-v1.15.0_content")
  key      = "niteshnepali.com.np/addons/storage-aws.addons.k8s.io/v1.15.0.yaml"
  provider = aws.files
}

resource "aws_s3_object" "nodeupconfig-control-plane-us-east-1a" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_nodeupconfig-control-plane-us-east-1a_content")
  key      = "niteshnepali.com.np/igconfig/control-plane/control-plane-us-east-1a/nodeupconfig.yaml"
  provider = aws.files
}

resource "aws_s3_object" "nodeupconfig-nodes-us-east-1a" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_nodeupconfig-nodes-us-east-1a_content")
  key      = "niteshnepali.com.np/igconfig/node/nodes-us-east-1a/nodeupconfig.yaml"
  provider = aws.files
}

resource "aws_s3_object" "nodeupconfig-nodes-us-east-1b" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_nodeupconfig-nodes-us-east-1b_content")
  key      = "niteshnepali.com.np/igconfig/node/nodes-us-east-1b/nodeupconfig.yaml"
  provider = aws.files
}

resource "aws_s3_object" "nodeupconfig-nodes-us-east-1c" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_nodeupconfig-nodes-us-east-1c_content")
  key      = "niteshnepali.com.np/igconfig/node/nodes-us-east-1c/nodeupconfig.yaml"
  provider = aws.files
}

resource "aws_security_group" "masters-niteshnepali-com-np" {
  description = "Security group for masters"
  name        = "masters.niteshnepali.com.np"
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "masters.niteshnepali.com.np"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
  vpc_id = aws_vpc.niteshnepali-com-np.id
}

resource "aws_security_group" "nodes-niteshnepali-com-np" {
  description = "Security group for nodes"
  name        = "nodes.niteshnepali.com.np"
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "nodes.niteshnepali.com.np"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
  vpc_id = aws_vpc.niteshnepali-com-np.id
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-22to22-masters-niteshnepali-com-np" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.masters-niteshnepali-com-np.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-22to22-nodes-niteshnepali-com-np" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.nodes-niteshnepali-com-np.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-443to443-masters-niteshnepali-com-np" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.masters-niteshnepali-com-np.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "from-__--0-ingress-tcp-22to22-masters-niteshnepali-com-np" {
  from_port         = 22
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.masters-niteshnepali-com-np.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-__--0-ingress-tcp-22to22-nodes-niteshnepali-com-np" {
  from_port         = 22
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.nodes-niteshnepali-com-np.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-__--0-ingress-tcp-443to443-masters-niteshnepali-com-np" {
  from_port         = 443
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.masters-niteshnepali-com-np.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "from-masters-niteshnepali-com-np-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.masters-niteshnepali-com-np.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-masters-niteshnepali-com-np-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.masters-niteshnepali-com-np.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-masters-niteshnepali-com-np-ingress-all-0to0-masters-niteshnepali-com-np" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.masters-niteshnepali-com-np.id
  source_security_group_id = aws_security_group.masters-niteshnepali-com-np.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-masters-niteshnepali-com-np-ingress-all-0to0-nodes-niteshnepali-com-np" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-niteshnepali-com-np.id
  source_security_group_id = aws_security_group.masters-niteshnepali-com-np.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-niteshnepali-com-np-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.nodes-niteshnepali-com-np.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-nodes-niteshnepali-com-np-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.nodes-niteshnepali-com-np.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-nodes-niteshnepali-com-np-ingress-4-0to0-masters-niteshnepali-com-np" {
  from_port                = 0
  protocol                 = "4"
  security_group_id        = aws_security_group.masters-niteshnepali-com-np.id
  source_security_group_id = aws_security_group.nodes-niteshnepali-com-np.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-niteshnepali-com-np-ingress-all-0to0-nodes-niteshnepali-com-np" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-niteshnepali-com-np.id
  source_security_group_id = aws_security_group.nodes-niteshnepali-com-np.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-niteshnepali-com-np-ingress-tcp-1to2379-masters-niteshnepali-com-np" {
  from_port                = 1
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-niteshnepali-com-np.id
  source_security_group_id = aws_security_group.nodes-niteshnepali-com-np.id
  to_port                  = 2379
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-niteshnepali-com-np-ingress-tcp-2382to4000-masters-niteshnepali-com-np" {
  from_port                = 2382
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-niteshnepali-com-np.id
  source_security_group_id = aws_security_group.nodes-niteshnepali-com-np.id
  to_port                  = 4000
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-niteshnepali-com-np-ingress-tcp-4003to65535-masters-niteshnepali-com-np" {
  from_port                = 4003
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-niteshnepali-com-np.id
  source_security_group_id = aws_security_group.nodes-niteshnepali-com-np.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-niteshnepali-com-np-ingress-udp-1to65535-masters-niteshnepali-com-np" {
  from_port                = 1
  protocol                 = "udp"
  security_group_id        = aws_security_group.masters-niteshnepali-com-np.id
  source_security_group_id = aws_security_group.nodes-niteshnepali-com-np.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_sqs_queue" "niteshnepali-com-np-nth" {
  message_retention_seconds = 300
  name                      = "niteshnepali-com-np-nth"
  policy                    = file("${path.module}/data/aws_sqs_queue_niteshnepali-com-np-nth_policy")
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "niteshnepali-com-np-nth"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
}

resource "aws_subnet" "us-east-1a-niteshnepali-com-np" {
  availability_zone                           = "us-east-1a"
  cidr_block                                  = "172.20.0.0/18"
  enable_resource_name_dns_a_record_on_launch = true
  private_dns_hostname_type_on_launch         = "resource-name"
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "us-east-1a.niteshnepali.com.np"
    "SubnetType"                                = "Public"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/role/internal-elb"           = "1"
  }
  vpc_id = aws_vpc.niteshnepali-com-np.id
}

resource "aws_subnet" "us-east-1b-niteshnepali-com-np" {
  availability_zone                           = "us-east-1b"
  cidr_block                                  = "172.20.64.0/18"
  enable_resource_name_dns_a_record_on_launch = true
  private_dns_hostname_type_on_launch         = "resource-name"
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "us-east-1b.niteshnepali.com.np"
    "SubnetType"                                = "Public"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/role/internal-elb"           = "1"
  }
  vpc_id = aws_vpc.niteshnepali-com-np.id
}

resource "aws_subnet" "us-east-1c-niteshnepali-com-np" {
  availability_zone                           = "us-east-1c"
  cidr_block                                  = "172.20.128.0/18"
  enable_resource_name_dns_a_record_on_launch = true
  private_dns_hostname_type_on_launch         = "resource-name"
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "us-east-1c.niteshnepali.com.np"
    "SubnetType"                                = "Public"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/role/internal-elb"           = "1"
  }
  vpc_id = aws_vpc.niteshnepali-com-np.id
}

resource "aws_vpc" "niteshnepali-com-np" {
  assign_generated_ipv6_cidr_block = true
  cidr_block                       = "172.20.0.0/16"
  enable_dns_hostnames             = true
  enable_dns_support               = true
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "niteshnepali.com.np"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "niteshnepali-com-np" {
  domain_name         = "ec2.internal"
  domain_name_servers = ["AmazonProvidedDNS"]
  tags = {
    "KubernetesCluster"                         = "niteshnepali.com.np"
    "Name"                                      = "niteshnepali.com.np"
    "kubernetes.io/cluster/niteshnepali.com.np" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "niteshnepali-com-np" {
  dhcp_options_id = aws_vpc_dhcp_options.niteshnepali-com-np.id
  vpc_id          = aws_vpc.niteshnepali-com-np.id
}

terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = {
      "configuration_aliases" = [aws.files]
      "source"                = "hashicorp/aws"
      "version"               = ">= 5.0.0"
    }
  }
}
