variable "aws_region" {
  description = "AWS region for Kubernetes"
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  default     = "prod-eks-cluster"
}

variable "subnet_ids" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
  default     = ["subnet-7aa45c37", "subnet-4140776f"]
}

variable "node_instance_type" {
  description = "The instance type for the worker nodes"
  default     = "t3.medium"
}
