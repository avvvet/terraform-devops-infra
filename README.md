# Terraform Jenkins Deployment  

This project automates the deployment of a **Jenkins Controller and Agent** on an AWS EC2 instance using **Terraform**.

## project structure
```
terraform-jenkins/    # Project root
│── terraform/        # Terraform config directory
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── .terraform/   # Created after `terraform init`
│   ├── terraform.tfstate  # Created after `terraform apply`
│   ├── terraform.tfvars   # (optional)
│
├── .gitignore
├── README.md
```

## 🔹 Features  
 - Deploys an **Ubuntu EC2 instance**  
 - Installs **Docker** and runs **Jenkins Controller and Agent containers**  
 - Configures **security groups** for Jenkins UI and Agent communication  
 - Uses **Terraform Provisioners** to automate setup  

## Infrastructure Setup  
- EC2 Instance: Runs Jenkins using Docker  
- Security Group: Allows access on ports **22 (SSH), 8080 (Jenkins UI), 50000 (Agent)**  

## Installation & Usage  

### Clone the Repository 
```bash
git clone https://github.com/avvvet/terraform-jenkins.git
cd terraform-jenkins/terraform
```

### Deploy 
```bash
terraform apply 
```

### remove infrastructure
```bash
terraform distroy 
```