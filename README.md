# what is it?  

This repository contains Terraform configurations for provisioning DevOps infrastructure across multiple cloud providers, including AWS, DigitalOcean, and GCP. It follows a structured approach using separate subfolders per cloud provider for scalability and maintainability.

## project structure
```
terraform-devops-infra/
  ├── aws-jenkins/        # AWS EC2 + Jenkins deployment
  ├── aws-kubernetes/     # AWS EKS + Kubernetes deployment
  ├── do-kubernetes/      # DigitalOcean Kubernetes setup (future)
  ├── gcp-infra/          # GCP infrastructure setup (future)
  ├── modules/            # Reusable Terraform modules (optional)
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

# create a worker agent node in jenkins UI
```
Set Up an Agent in Jenkins UI

    Go to "Manage Jenkins" → "Nodes" 
    Click "New Node"
    Enter a name (e.g., docker-agent)
    Select "Permanent Agent" and click "Create"

Now, configure the agent:

    # of Executors: 1 (or more, based on your need)
    Remote root directory: /home/jenkins/agent
    Launch method: Select "Launch agent by connecting it to the controller"
    Labels (optional): docker (useful for targeting this agent in jobs)
    Click "Save"
```

# now install the agent node container
```
before that get the secret key by clicking the new node created in teh UI 
  
  docker run -d \
  -u root \
  --name jenkins-agent \
  --restart always \
  --env JENKINS_URL=http://<server-ip>:8080 \
  --env JENKINS_AGENT_NAME=docker-agent \
  --env JENKINS_SECRET=<node-secret> \
  --env JENKINS_TUNNEL=<server-ip>:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins/inbound-agent
```