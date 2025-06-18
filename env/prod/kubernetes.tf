locals {
  cluster_name                 = "k8s.niteshnepali.com.np"
  master_autoscaling_group_ids = [aws_autoscaling_group.control-plane-us-east-1a-masters-k8s-niteshnepali-com-np.id]
  master_security_group_ids    = [aws_security_group.masters-k8s-niteshnepali-com-np.id]
  masters_role_arn             = aws_iam_role.masters-k8s-niteshnepali-com-np.arn
  masters_role_name            = aws_iam_role.masters-k8s-niteshnepali-com-np.name
  node_autoscaling_group_ids   = [aws_autoscaling_group.nodes-us-east-1a-k8s-niteshnepali-com-np.id, aws_autoscaling_group.nodes-us-east-1b-k8s-niteshnepali-com-np.id]
  node_security_group_ids      = [aws_security_group.nodes-k8s-niteshnepali-com-np.id]
  node_subnet_ids              = [aws_subnet.us-east-1a-k8s-niteshnepali-com-np.id, aws_subnet.us-east-1b-k8s-niteshnepali-com-np.id]
  nodes_role_arn               = aws_iam_role.nodes-k8s-niteshnepali-com-np.arn
  nodes_role_name              = aws_iam_role.nodes-k8s-niteshnepali-com-np.name
  region                       = "us-east-1"
  route_table_public_id        = aws_route_table.k8s-niteshnepali-com-np.id
  subnet_us-east-1a_id         = aws_subnet.us-east-1a-k8s-niteshnepali-com-np.id
  subnet_us-east-1b_id         = aws_subnet.us-east-1b-k8s-niteshnepali-com-np.id
  vpc_cidr_block               = aws_vpc.k8s-niteshnepali-com-np.cidr_block
  vpc_id                       = aws_vpc.k8s-niteshnepali-com-np.id
  vpc_ipv6_cidr_block          = aws_vpc.k8s-niteshnepali-com-np.ipv6_cidr_block
  vpc_ipv6_cidr_length         = local.vpc_ipv6_cidr_block == "" ? null : tonumber(regex(".*/(\\d+)", local.vpc_ipv6_cidr_block)[0])
}

output "cluster_name" {
  value = "k8s.niteshnepali.com.np"
}

output "master_autoscaling_group_ids" {
  value = [aws_autoscaling_group.control-plane-us-east-1a-masters-k8s-niteshnepali-com-np.id]
}

output "master_security_group_ids" {
  value = [aws_security_group.masters-k8s-niteshnepali-com-np.id]
}

output "masters_role_arn" {
  value = aws_iam_role.masters-k8s-niteshnepali-com-np.arn
}

output "masters_role_name" {
  value = aws_iam_role.masters-k8s-niteshnepali-com-np.name
}

output "node_autoscaling_group_ids" {
  value = [aws_autoscaling_group.nodes-us-east-1a-k8s-niteshnepali-com-np.id, aws_autoscaling_group.nodes-us-east-1b-k8s-niteshnepali-com-np.id]
}

output "node_security_group_ids" {
  value = [aws_security_group.nodes-k8s-niteshnepali-com-np.id]
}

output "node_subnet_ids" {
  value = [aws_subnet.us-east-1a-k8s-niteshnepali-com-np.id, aws_subnet.us-east-1b-k8s-niteshnepali-com-np.id]
}

output "nodes_role_arn" {
  value = aws_iam_role.nodes-k8s-niteshnepali-com-np.arn
}

output "nodes_role_name" {
  value = aws_iam_role.nodes-k8s-niteshnepali-com-np.name
}

output "region" {
  value = "us-east-1"
}

output "route_table_public_id" {
  value = aws_route_table.k8s-niteshnepali-com-np.id
}

output "subnet_us-east-1a_id" {
  value = aws_subnet.us-east-1a-k8s-niteshnepali-com-np.id
}

output "subnet_us-east-1b_id" {
  value = aws_subnet.us-east-1b-k8s-niteshnepali-com-np.id
}

output "vpc_cidr_block" {
  value = aws_vpc.k8s-niteshnepali-com-np.cidr_block
}

output "vpc_id" {
  value = aws_vpc.k8s-niteshnepali-com-np.id
}

output "vpc_ipv6_cidr_block" {
  value = aws_vpc.k8s-niteshnepali-com-np.ipv6_cidr_block
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

resource "aws_autoscaling_group" "control-plane-us-east-1a-masters-k8s-niteshnepali-com-np" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.control-plane-us-east-1a-masters-k8s-niteshnepali-com-np.id
    version = aws_launch_template.control-plane-us-east-1a-masters-k8s-niteshnepali-com-np.latest_version
  }
  max_instance_lifetime = 0
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "control-plane-us-east-1a.masters.k8s.niteshnepali.com.np"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "k8s.niteshnepali.com.np"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "control-plane-us-east-1a.masters.k8s.niteshnepali.com.np"
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
    key                 = "kubernetes.io/cluster/k8s.niteshnepali.com.np"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.us-east-1a-k8s-niteshnepali-com-np.id]
}

resource "aws_autoscaling_group" "nodes-us-east-1a-k8s-niteshnepali-com-np" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.nodes-us-east-1a-k8s-niteshnepali-com-np.id
    version = aws_launch_template.nodes-us-east-1a-k8s-niteshnepali-com-np.latest_version
  }
  max_instance_lifetime = 0
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "nodes-us-east-1a.k8s.niteshnepali.com.np"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "k8s.niteshnepali.com.np"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "nodes-us-east-1a.k8s.niteshnepali.com.np"
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
    key                 = "kubernetes.io/cluster/k8s.niteshnepali.com.np"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.us-east-1a-k8s-niteshnepali-com-np.id]
}

resource "aws_autoscaling_group" "nodes-us-east-1b-k8s-niteshnepali-com-np" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.nodes-us-east-1b-k8s-niteshnepali-com-np.id
    version = aws_launch_template.nodes-us-east-1b-k8s-niteshnepali-com-np.latest_version
  }
  max_instance_lifetime = 0
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "nodes-us-east-1b.k8s.niteshnepali.com.np"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "k8s.niteshnepali.com.np"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "nodes-us-east-1b.k8s.niteshnepali.com.np"
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
    key                 = "kubernetes.io/cluster/k8s.niteshnepali.com.np"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.us-east-1b-k8s-niteshnepali-com-np.id]
}

resource "aws_autoscaling_lifecycle_hook" "control-plane-us-east-1a-NTHLifecycleHook" {
  autoscaling_group_name = aws_autoscaling_group.control-plane-us-east-1a-masters-k8s-niteshnepali-com-np.id
  default_result         = "CONTINUE"
  heartbeat_timeout      = 300
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                   = "control-plane-us-east-1a-NTHLifecycleHook"
}

resource "aws_autoscaling_lifecycle_hook" "nodes-us-east-1a-NTHLifecycleHook" {
  autoscaling_group_name = aws_autoscaling_group.nodes-us-east-1a-k8s-niteshnepali-com-np.id
  default_result         = "CONTINUE"
  heartbeat_timeout      = 300
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                   = "nodes-us-east-1a-NTHLifecycleHook"
}

resource "aws_autoscaling_lifecycle_hook" "nodes-us-east-1b-NTHLifecycleHook" {
  autoscaling_group_name = aws_autoscaling_group.nodes-us-east-1b-k8s-niteshnepali-com-np.id
  default_result         = "CONTINUE"
  heartbeat_timeout      = 300
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                   = "nodes-us-east-1b-NTHLifecycleHook"
}

resource "aws_cloudwatch_event_rule" "k8s-niteshnepali-com-np-ASGLifecycle" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_k8s.niteshnepali.com.np-ASGLifecycle_event_pattern")
  name          = "k8s.niteshnepali.com.np-ASGLifecycle"
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "k8s.niteshnepali.com.np-ASGLifecycle"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
}

resource "aws_cloudwatch_event_rule" "k8s-niteshnepali-com-np-InstanceScheduledChange" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_k8s.niteshnepali.com.np-InstanceScheduledChange_event_pattern")
  name          = "k8s.niteshnepali.com.np-InstanceScheduledChange"
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "k8s.niteshnepali.com.np-InstanceScheduledChange"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
}

resource "aws_cloudwatch_event_rule" "k8s-niteshnepali-com-np-InstanceStateChange" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_k8s.niteshnepali.com.np-InstanceStateChange_event_pattern")
  name          = "k8s.niteshnepali.com.np-InstanceStateChange"
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "k8s.niteshnepali.com.np-InstanceStateChange"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
}

resource "aws_cloudwatch_event_rule" "k8s-niteshnepali-com-np-SpotInterruption" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_k8s.niteshnepali.com.np-SpotInterruption_event_pattern")
  name          = "k8s.niteshnepali.com.np-SpotInterruption"
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "k8s.niteshnepali.com.np-SpotInterruption"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
}

resource "aws_cloudwatch_event_target" "k8s-niteshnepali-com-np-ASGLifecycle-Target" {
  arn  = aws_sqs_queue.k8s-niteshnepali-com-np-nth.arn
  rule = aws_cloudwatch_event_rule.k8s-niteshnepali-com-np-ASGLifecycle.id
}

resource "aws_cloudwatch_event_target" "k8s-niteshnepali-com-np-InstanceScheduledChange-Target" {
  arn  = aws_sqs_queue.k8s-niteshnepali-com-np-nth.arn
  rule = aws_cloudwatch_event_rule.k8s-niteshnepali-com-np-InstanceScheduledChange.id
}

resource "aws_cloudwatch_event_target" "k8s-niteshnepali-com-np-InstanceStateChange-Target" {
  arn  = aws_sqs_queue.k8s-niteshnepali-com-np-nth.arn
  rule = aws_cloudwatch_event_rule.k8s-niteshnepali-com-np-InstanceStateChange.id
}

resource "aws_cloudwatch_event_target" "k8s-niteshnepali-com-np-SpotInterruption-Target" {
  arn  = aws_sqs_queue.k8s-niteshnepali-com-np-nth.arn
  rule = aws_cloudwatch_event_rule.k8s-niteshnepali-com-np-SpotInterruption.id
}

resource "aws_ebs_volume" "a-etcd-events-k8s-niteshnepali-com-np" {
  availability_zone = "us-east-1a"
  encrypted         = true
  iops              = 3000
  size              = 20
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "a.etcd-events.k8s.niteshnepali.com.np"
    "k8s.io/etcd/events"                            = "a/a"
    "k8s.io/role/control-plane"                     = "1"
    "k8s.io/role/master"                            = "1"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
  throughput = 125
  type       = "gp3"
}

resource "aws_ebs_volume" "a-etcd-main-k8s-niteshnepali-com-np" {
  availability_zone = "us-east-1a"
  encrypted         = true
  iops              = 3000
  size              = 20
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "a.etcd-main.k8s.niteshnepali.com.np"
    "k8s.io/etcd/main"                              = "a/a"
    "k8s.io/role/control-plane"                     = "1"
    "k8s.io/role/master"                            = "1"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
  throughput = 125
  type       = "gp3"
}

resource "aws_iam_instance_profile" "masters-k8s-niteshnepali-com-np" {
  name = "masters.k8s.niteshnepali.com.np"
  role = aws_iam_role.masters-k8s-niteshnepali-com-np.name
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "masters.k8s.niteshnepali.com.np"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
}

resource "aws_iam_instance_profile" "nodes-k8s-niteshnepali-com-np" {
  name = "nodes.k8s.niteshnepali.com.np"
  role = aws_iam_role.nodes-k8s-niteshnepali-com-np.name
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "nodes.k8s.niteshnepali.com.np"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
}

resource "aws_iam_role" "masters-k8s-niteshnepali-com-np" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_masters.k8s.niteshnepali.com.np_policy")
  name               = "masters.k8s.niteshnepali.com.np"
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "masters.k8s.niteshnepali.com.np"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
}

resource "aws_iam_role" "nodes-k8s-niteshnepali-com-np" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_nodes.k8s.niteshnepali.com.np_policy")
  name               = "nodes.k8s.niteshnepali.com.np"
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "nodes.k8s.niteshnepali.com.np"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
}

resource "aws_iam_role_policy" "masters-k8s-niteshnepali-com-np" {
  name   = "masters.k8s.niteshnepali.com.np"
  policy = file("${path.module}/data/aws_iam_role_policy_masters.k8s.niteshnepali.com.np_policy")
  role   = aws_iam_role.masters-k8s-niteshnepali-com-np.name
}

resource "aws_iam_role_policy" "nodes-k8s-niteshnepali-com-np" {
  name   = "nodes.k8s.niteshnepali.com.np"
  policy = file("${path.module}/data/aws_iam_role_policy_nodes.k8s.niteshnepali.com.np_policy")
  role   = aws_iam_role.nodes-k8s-niteshnepali-com-np.name
}

resource "aws_internet_gateway" "k8s-niteshnepali-com-np" {
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "k8s.niteshnepali.com.np"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
  vpc_id = aws_vpc.k8s-niteshnepali-com-np.id
}

resource "aws_key_pair" "kubernetes-k8s-niteshnepali-com-np-5596c8313b9f9a9f1c533dcce565e78e" {
  key_name   = "kubernetes.k8s.niteshnepali.com.np-55:96:c8:31:3b:9f:9a:9f:1c:53:3d:cc:e5:65:e7:8e"
  public_key = file("${path.module}/data/aws_key_pair_kubernetes.k8s.niteshnepali.com.np-5596c8313b9f9a9f1c533dcce565e78e_public_key")
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "k8s.niteshnepali.com.np"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
}

resource "aws_launch_template" "control-plane-us-east-1a-masters-k8s-niteshnepali-com-np" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 10
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.masters-k8s-niteshnepali-com-np.id
  }
  image_id      = "ami-054d6a336762e438e"
  instance_type = "t3.medium"
  key_name      = aws_key_pair.kubernetes-k8s-niteshnepali-com-np-5596c8313b9f9a9f1c533dcce565e78e.id
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
  name = "control-plane-us-east-1a.masters.k8s.niteshnepali.com.np"
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.masters-k8s-niteshnepali-com-np.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                                                     = "k8s.niteshnepali.com.np"
      "Name"                                                                                                  = "control-plane-us-east-1a.masters.k8s.niteshnepali.com.np"
      "aws-node-termination-handler/managed"                                                                  = ""
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
      "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
      "k8s.io/role/control-plane"                                                                             = "1"
      "k8s.io/role/master"                                                                                    = "1"
      "kops.k8s.io/instancegroup"                                                                             = "control-plane-us-east-1a"
      "kubernetes.io/cluster/k8s.niteshnepali.com.np"                                                         = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                                                     = "k8s.niteshnepali.com.np"
      "Name"                                                                                                  = "control-plane-us-east-1a.masters.k8s.niteshnepali.com.np"
      "aws-node-termination-handler/managed"                                                                  = ""
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
      "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
      "k8s.io/role/control-plane"                                                                             = "1"
      "k8s.io/role/master"                                                                                    = "1"
      "kops.k8s.io/instancegroup"                                                                             = "control-plane-us-east-1a"
      "kubernetes.io/cluster/k8s.niteshnepali.com.np"                                                         = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                                                     = "k8s.niteshnepali.com.np"
    "Name"                                                                                                  = "control-plane-us-east-1a.masters.k8s.niteshnepali.com.np"
    "aws-node-termination-handler/managed"                                                                  = ""
    "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
    "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
    "k8s.io/role/control-plane"                                                                             = "1"
    "k8s.io/role/master"                                                                                    = "1"
    "kops.k8s.io/instancegroup"                                                                             = "control-plane-us-east-1a"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np"                                                         = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_control-plane-us-east-1a.masters.k8s.niteshnepali.com.np_user_data")
}

resource "aws_launch_template" "nodes-us-east-1a-k8s-niteshnepali-com-np" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 10
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.nodes-k8s-niteshnepali-com-np.id
  }
  image_id      = "ami-054d6a336762e438e"
  instance_type = "t3.medium"
  key_name      = aws_key_pair.kubernetes-k8s-niteshnepali-com-np-5596c8313b9f9a9f1c533dcce565e78e.id
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
  name = "nodes-us-east-1a.k8s.niteshnepali.com.np"
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.nodes-k8s-niteshnepali-com-np.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                          = "k8s.niteshnepali.com.np"
      "Name"                                                                       = "nodes-us-east-1a.k8s.niteshnepali.com.np"
      "aws-node-termination-handler/managed"                                       = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1a"
      "kubernetes.io/cluster/k8s.niteshnepali.com.np"                              = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                          = "k8s.niteshnepali.com.np"
      "Name"                                                                       = "nodes-us-east-1a.k8s.niteshnepali.com.np"
      "aws-node-termination-handler/managed"                                       = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1a"
      "kubernetes.io/cluster/k8s.niteshnepali.com.np"                              = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                          = "k8s.niteshnepali.com.np"
    "Name"                                                                       = "nodes-us-east-1a.k8s.niteshnepali.com.np"
    "aws-node-termination-handler/managed"                                       = ""
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
    "k8s.io/role/node"                                                           = "1"
    "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1a"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np"                              = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_nodes-us-east-1a.k8s.niteshnepali.com.np_user_data")
}

resource "aws_launch_template" "nodes-us-east-1b-k8s-niteshnepali-com-np" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 10
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.nodes-k8s-niteshnepali-com-np.id
  }
  image_id      = "ami-054d6a336762e438e"
  instance_type = "t3.medium"
  key_name      = aws_key_pair.kubernetes-k8s-niteshnepali-com-np-5596c8313b9f9a9f1c533dcce565e78e.id
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
  name = "nodes-us-east-1b.k8s.niteshnepali.com.np"
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.nodes-k8s-niteshnepali-com-np.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                          = "k8s.niteshnepali.com.np"
      "Name"                                                                       = "nodes-us-east-1b.k8s.niteshnepali.com.np"
      "aws-node-termination-handler/managed"                                       = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1b"
      "kubernetes.io/cluster/k8s.niteshnepali.com.np"                              = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                          = "k8s.niteshnepali.com.np"
      "Name"                                                                       = "nodes-us-east-1b.k8s.niteshnepali.com.np"
      "aws-node-termination-handler/managed"                                       = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1b"
      "kubernetes.io/cluster/k8s.niteshnepali.com.np"                              = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                          = "k8s.niteshnepali.com.np"
    "Name"                                                                       = "nodes-us-east-1b.k8s.niteshnepali.com.np"
    "aws-node-termination-handler/managed"                                       = ""
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
    "k8s.io/role/node"                                                           = "1"
    "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1b"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np"                              = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_nodes-us-east-1b.k8s.niteshnepali.com.np_user_data")
}

resource "aws_route" "route-0-0-0-0--0" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.k8s-niteshnepali-com-np.id
  route_table_id         = aws_route_table.k8s-niteshnepali-com-np.id
}

resource "aws_route" "route-__--0" {
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.k8s-niteshnepali-com-np.id
  route_table_id              = aws_route_table.k8s-niteshnepali-com-np.id
}

resource "aws_route_table" "k8s-niteshnepali-com-np" {
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "k8s.niteshnepali.com.np"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
    "kubernetes.io/kops/role"                       = "public"
  }
  vpc_id = aws_vpc.k8s-niteshnepali-com-np.id
}

resource "aws_route_table_association" "us-east-1a-k8s-niteshnepali-com-np" {
  route_table_id = aws_route_table.k8s-niteshnepali-com-np.id
  subnet_id      = aws_subnet.us-east-1a-k8s-niteshnepali-com-np.id
}

resource "aws_route_table_association" "us-east-1b-k8s-niteshnepali-com-np" {
  route_table_id = aws_route_table.k8s-niteshnepali-com-np.id
  subnet_id      = aws_subnet.us-east-1b-k8s-niteshnepali-com-np.id
}

resource "aws_s3_object" "cluster-completed-spec" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_cluster-completed.spec_content")
  key      = "k8s.niteshnepali.com.np/cluster-completed.spec"
  provider = aws.files
}

resource "aws_s3_object" "etcd-cluster-spec-events" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_etcd-cluster-spec-events_content")
  key      = "k8s.niteshnepali.com.np/backups/etcd/events/control/etcd-cluster-spec"
  provider = aws.files
}

resource "aws_s3_object" "etcd-cluster-spec-main" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_etcd-cluster-spec-main_content")
  key      = "k8s.niteshnepali.com.np/backups/etcd/main/control/etcd-cluster-spec"
  provider = aws.files
}

resource "aws_s3_object" "k8s-niteshnepali-com-np-addons-aws-cloud-controller-addons-k8s-io-k8s-1-18" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_k8s.niteshnepali.com.np-addons-aws-cloud-controller.addons.k8s.io-k8s-1.18_content")
  key      = "k8s.niteshnepali.com.np/addons/aws-cloud-controller.addons.k8s.io/k8s-1.18.yaml"
  provider = aws.files
}

resource "aws_s3_object" "k8s-niteshnepali-com-np-addons-aws-ebs-csi-driver-addons-k8s-io-k8s-1-17" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_k8s.niteshnepali.com.np-addons-aws-ebs-csi-driver.addons.k8s.io-k8s-1.17_content")
  key      = "k8s.niteshnepali.com.np/addons/aws-ebs-csi-driver.addons.k8s.io/k8s-1.17.yaml"
  provider = aws.files
}

resource "aws_s3_object" "k8s-niteshnepali-com-np-addons-bootstrap" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_k8s.niteshnepali.com.np-addons-bootstrap_content")
  key      = "k8s.niteshnepali.com.np/addons/bootstrap-channel.yaml"
  provider = aws.files
}

resource "aws_s3_object" "k8s-niteshnepali-com-np-addons-coredns-addons-k8s-io-k8s-1-12" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_k8s.niteshnepali.com.np-addons-coredns.addons.k8s.io-k8s-1.12_content")
  key      = "k8s.niteshnepali.com.np/addons/coredns.addons.k8s.io/k8s-1.12.yaml"
  provider = aws.files
}

resource "aws_s3_object" "k8s-niteshnepali-com-np-addons-dns-controller-addons-k8s-io-k8s-1-12" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_k8s.niteshnepali.com.np-addons-dns-controller.addons.k8s.io-k8s-1.12_content")
  key      = "k8s.niteshnepali.com.np/addons/dns-controller.addons.k8s.io/k8s-1.12.yaml"
  provider = aws.files
}

resource "aws_s3_object" "k8s-niteshnepali-com-np-addons-kops-controller-addons-k8s-io-k8s-1-16" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_k8s.niteshnepali.com.np-addons-kops-controller.addons.k8s.io-k8s-1.16_content")
  key      = "k8s.niteshnepali.com.np/addons/kops-controller.addons.k8s.io/k8s-1.16.yaml"
  provider = aws.files
}

resource "aws_s3_object" "k8s-niteshnepali-com-np-addons-kubelet-api-rbac-addons-k8s-io-k8s-1-9" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_k8s.niteshnepali.com.np-addons-kubelet-api.rbac.addons.k8s.io-k8s-1.9_content")
  key      = "k8s.niteshnepali.com.np/addons/kubelet-api.rbac.addons.k8s.io/k8s-1.9.yaml"
  provider = aws.files
}

resource "aws_s3_object" "k8s-niteshnepali-com-np-addons-limit-range-addons-k8s-io" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_k8s.niteshnepali.com.np-addons-limit-range.addons.k8s.io_content")
  key      = "k8s.niteshnepali.com.np/addons/limit-range.addons.k8s.io/v1.5.0.yaml"
  provider = aws.files
}

resource "aws_s3_object" "k8s-niteshnepali-com-np-addons-networking-cilium-io-k8s-1-16" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_k8s.niteshnepali.com.np-addons-networking.cilium.io-k8s-1.16_content")
  key      = "k8s.niteshnepali.com.np/addons/networking.cilium.io/k8s-1.16-v1.15.yaml"
  provider = aws.files
}

resource "aws_s3_object" "k8s-niteshnepali-com-np-addons-node-termination-handler-aws-k8s-1-11" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_k8s.niteshnepali.com.np-addons-node-termination-handler.aws-k8s-1.11_content")
  key      = "k8s.niteshnepali.com.np/addons/node-termination-handler.aws/k8s-1.11.yaml"
  provider = aws.files
}

resource "aws_s3_object" "k8s-niteshnepali-com-np-addons-storage-aws-addons-k8s-io-v1-15-0" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_k8s.niteshnepali.com.np-addons-storage-aws.addons.k8s.io-v1.15.0_content")
  key      = "k8s.niteshnepali.com.np/addons/storage-aws.addons.k8s.io/v1.15.0.yaml"
  provider = aws.files
}

resource "aws_s3_object" "kops-version-txt" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_kops-version.txt_content")
  key      = "k8s.niteshnepali.com.np/kops-version.txt"
  provider = aws.files
}

resource "aws_s3_object" "manifests-etcdmanager-events-control-plane-us-east-1a" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_manifests-etcdmanager-events-control-plane-us-east-1a_content")
  key      = "k8s.niteshnepali.com.np/manifests/etcd/events-control-plane-us-east-1a.yaml"
  provider = aws.files
}

resource "aws_s3_object" "manifests-etcdmanager-main-control-plane-us-east-1a" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_manifests-etcdmanager-main-control-plane-us-east-1a_content")
  key      = "k8s.niteshnepali.com.np/manifests/etcd/main-control-plane-us-east-1a.yaml"
  provider = aws.files
}

resource "aws_s3_object" "manifests-static-kube-apiserver-healthcheck" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_manifests-static-kube-apiserver-healthcheck_content")
  key      = "k8s.niteshnepali.com.np/manifests/static/kube-apiserver-healthcheck.yaml"
  provider = aws.files
}

resource "aws_s3_object" "nodeupconfig-control-plane-us-east-1a" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_nodeupconfig-control-plane-us-east-1a_content")
  key      = "k8s.niteshnepali.com.np/igconfig/control-plane/control-plane-us-east-1a/nodeupconfig.yaml"
  provider = aws.files
}

resource "aws_s3_object" "nodeupconfig-nodes-us-east-1a" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_nodeupconfig-nodes-us-east-1a_content")
  key      = "k8s.niteshnepali.com.np/igconfig/node/nodes-us-east-1a/nodeupconfig.yaml"
  provider = aws.files
}

resource "aws_s3_object" "nodeupconfig-nodes-us-east-1b" {
  bucket   = "niteshnepali.com.np"
  content  = file("${path.module}/data/aws_s3_object_nodeupconfig-nodes-us-east-1b_content")
  key      = "k8s.niteshnepali.com.np/igconfig/node/nodes-us-east-1b/nodeupconfig.yaml"
  provider = aws.files
}

resource "aws_security_group" "masters-k8s-niteshnepali-com-np" {
  description = "Security group for masters"
  name        = "masters.k8s.niteshnepali.com.np"
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "masters.k8s.niteshnepali.com.np"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
  vpc_id = aws_vpc.k8s-niteshnepali-com-np.id
}

resource "aws_security_group" "nodes-k8s-niteshnepali-com-np" {
  description = "Security group for nodes"
  name        = "nodes.k8s.niteshnepali.com.np"
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "nodes.k8s.niteshnepali.com.np"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
  vpc_id = aws_vpc.k8s-niteshnepali-com-np.id
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-22to22-masters-k8s-niteshnepali-com-np" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.masters-k8s-niteshnepali-com-np.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-22to22-nodes-k8s-niteshnepali-com-np" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.nodes-k8s-niteshnepali-com-np.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-443to443-masters-k8s-niteshnepali-com-np" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.masters-k8s-niteshnepali-com-np.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "from-__--0-ingress-tcp-22to22-masters-k8s-niteshnepali-com-np" {
  from_port         = 22
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.masters-k8s-niteshnepali-com-np.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-__--0-ingress-tcp-22to22-nodes-k8s-niteshnepali-com-np" {
  from_port         = 22
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.nodes-k8s-niteshnepali-com-np.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-__--0-ingress-tcp-443to443-masters-k8s-niteshnepali-com-np" {
  from_port         = 443
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.masters-k8s-niteshnepali-com-np.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "from-masters-k8s-niteshnepali-com-np-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.masters-k8s-niteshnepali-com-np.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-masters-k8s-niteshnepali-com-np-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.masters-k8s-niteshnepali-com-np.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-masters-k8s-niteshnepali-com-np-ingress-all-0to0-masters-k8s-niteshnepali-com-np" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.masters-k8s-niteshnepali-com-np.id
  source_security_group_id = aws_security_group.masters-k8s-niteshnepali-com-np.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-masters-k8s-niteshnepali-com-np-ingress-all-0to0-nodes-k8s-niteshnepali-com-np" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-k8s-niteshnepali-com-np.id
  source_security_group_id = aws_security_group.masters-k8s-niteshnepali-com-np.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-k8s-niteshnepali-com-np-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.nodes-k8s-niteshnepali-com-np.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-nodes-k8s-niteshnepali-com-np-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.nodes-k8s-niteshnepali-com-np.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-nodes-k8s-niteshnepali-com-np-ingress-all-0to0-nodes-k8s-niteshnepali-com-np" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-k8s-niteshnepali-com-np.id
  source_security_group_id = aws_security_group.nodes-k8s-niteshnepali-com-np.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-k8s-niteshnepali-com-np-ingress-tcp-1to2379-masters-k8s-niteshnepali-com-np" {
  from_port                = 1
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-k8s-niteshnepali-com-np.id
  source_security_group_id = aws_security_group.nodes-k8s-niteshnepali-com-np.id
  to_port                  = 2379
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-k8s-niteshnepali-com-np-ingress-tcp-2382to4000-masters-k8s-niteshnepali-com-np" {
  from_port                = 2382
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-k8s-niteshnepali-com-np.id
  source_security_group_id = aws_security_group.nodes-k8s-niteshnepali-com-np.id
  to_port                  = 4000
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-k8s-niteshnepali-com-np-ingress-tcp-4003to65535-masters-k8s-niteshnepali-com-np" {
  from_port                = 4003
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-k8s-niteshnepali-com-np.id
  source_security_group_id = aws_security_group.nodes-k8s-niteshnepali-com-np.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-k8s-niteshnepali-com-np-ingress-udp-1to65535-masters-k8s-niteshnepali-com-np" {
  from_port                = 1
  protocol                 = "udp"
  security_group_id        = aws_security_group.masters-k8s-niteshnepali-com-np.id
  source_security_group_id = aws_security_group.nodes-k8s-niteshnepali-com-np.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_sqs_queue" "k8s-niteshnepali-com-np-nth" {
  message_retention_seconds = 300
  name                      = "k8s-niteshnepali-com-np-nth"
  policy                    = file("${path.module}/data/aws_sqs_queue_k8s-niteshnepali-com-np-nth_policy")
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "k8s-niteshnepali-com-np-nth"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
}

resource "aws_subnet" "us-east-1a-k8s-niteshnepali-com-np" {
  availability_zone                           = "us-east-1a"
  cidr_block                                  = "172.20.0.0/17"
  enable_resource_name_dns_a_record_on_launch = true
  private_dns_hostname_type_on_launch         = "resource-name"
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "us-east-1a.k8s.niteshnepali.com.np"
    "SubnetType"                                    = "Public"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
    "kubernetes.io/role/elb"                        = "1"
    "kubernetes.io/role/internal-elb"               = "1"
  }
  vpc_id = aws_vpc.k8s-niteshnepali-com-np.id
}

resource "aws_subnet" "us-east-1b-k8s-niteshnepali-com-np" {
  availability_zone                           = "us-east-1b"
  cidr_block                                  = "172.20.128.0/17"
  enable_resource_name_dns_a_record_on_launch = true
  private_dns_hostname_type_on_launch         = "resource-name"
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "us-east-1b.k8s.niteshnepali.com.np"
    "SubnetType"                                    = "Public"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
    "kubernetes.io/role/elb"                        = "1"
    "kubernetes.io/role/internal-elb"               = "1"
  }
  vpc_id = aws_vpc.k8s-niteshnepali-com-np.id
}

resource "aws_vpc" "k8s-niteshnepali-com-np" {
  assign_generated_ipv6_cidr_block = true
  cidr_block                       = "172.20.0.0/16"
  enable_dns_hostnames             = true
  enable_dns_support               = true
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "k8s.niteshnepali.com.np"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "k8s-niteshnepali-com-np" {
  domain_name         = "ec2.internal"
  domain_name_servers = ["AmazonProvidedDNS"]
  tags = {
    "KubernetesCluster"                             = "k8s.niteshnepali.com.np"
    "Name"                                          = "k8s.niteshnepali.com.np"
    "kubernetes.io/cluster/k8s.niteshnepali.com.np" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "k8s-niteshnepali-com-np" {
  dhcp_options_id = aws_vpc_dhcp_options.k8s-niteshnepali-com-np.id
  vpc_id          = aws_vpc.k8s-niteshnepali-com-np.id
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
