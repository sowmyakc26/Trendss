 Trend Application: Production-Ready Deployment
This project demonstrates a full DevOps lifecycle for a React application, utilizing Terraform for IaC, Jenkins for CI/CD, Docker for containerization, and Amazon EKS for orchestration.
 Architecture Overview
Frontend: React.js (running on Port 3000 via K8s Service)
CI/CD: Jenkins (Pipeline-as-code)
Infrastructure: AWS (VPC, EC2, EKS) via Terraform
Container Registry: DockerHub
Monitoring: Prometheus & Grafana
 Setup Instructions
1. Infrastructure Provisioning
Navigate to the terraform/ directory and initialize the environment:
bash
terraform init
terraform plan
terraform apply --auto-approve

This creates the VPC, IAM roles for EKS, and an EC2 instance pre-configured with Jenkins.
2. Local Docker Testing
To verify the application locally before pushing:
bash
docker build -t trend-app .
docker run -p 3000:80 trend-app

Access the app at http://3.81.200.248:3000.
3. Kubernetes Configuration
Ensure your kubectl context is set to the new EKS cluster:
bash
aws eks update-kubeconfig --region us-east-1 --name trend-cluster
   
 CI/CD Pipeline Explanation
The Jenkins Pipeline is defined in the Jenkinsfile and consists of 4 main stages:
Checkout: Pulls the latest code from the GitHub repository.
Build: Creates a Docker image using the production-ready Dockerfile.
Push: Tags and pushes the image to DockerHub using stored credentials.
Deploy: Updates the deployment.yaml with the new image tag and applies it to the EKS Cluster using kubectl.
Webhook Integration:
Any push to the main branch triggers an automatic build via the GitHub Webhook pointing to http://3.81.125.121:8080/github-webhook/.
 Monitoring
We use the Prometheus Stack for health checks:
Prometheus: Scrapes metrics from the EKS nodes and React pods.
Grafana: Visualizes cluster CPU, Memory, and Network usage.
Access: Port-forward the Grafana service to view the dashboard:
bash
kubectl port-forward svc/prometheus-grafana 8081:80
   
🔗 Deployment Details
GitHub Repository: [https://github.com/sowmyakc26/Trendss.git]
   LoadBalancer ARN/URL:aacf69246f3c6430eaac17c5d7632905-1080697447.us-east-1.elb.amazonaws.com
Run the following command to get your live URL:
kubectl get svc trend-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
📂 Project Structure
text
├── .github/            # GitHub Actions/Webhooks
├── k8s/                # Kubernetes Manifests (Deploy/Svc)
├── terraform/          # Infrastructure code (main.tf, variables.tf)
├── Dockerfile          # Container configuration
├── Jenkinsfile         # CI/CD Pipeline script
├── .dockerignore       # Files to exclude from Docker build
└── README.md           # Project documentation

screenshots

<img width="1361" height="709" alt="docker build successfull" src="https://github.com/user-attachments/assets/bdff32c7-6595-4e12-af27-1dd83cd6444f" />

<img width="1363" height="695" alt="kubectl get nodes" src="https://github.com/user-attachments/assets/f0bcd20e-9eb7-45d9-b7d4-8613357832e6" />

<img width="1104" height="619" alt="kubectl get pods running" src="https://github.com/user-attachments/assets/456359c0-9f96-4ed5-941f-fabcc3642fbf" />

<img width="1343" height="715" alt="terraform apply complete" src="https://github.com/user-attachments/assets/16a24a47-ed69-4ef2-97eb-62617e25066d" />


<img width="1350" height="718" alt="get jenkins ip" src="https://github.com/user-attachments/assets/b52589cc-fb09-4d18-9fea-65257d240fb0" />

<img width="1357" height="675" alt="loadbalancer url" src="https://github.com/user-attachments/assets/59ca3e30-340e-4db4-8f7c-a0dd573b369b" />


<img width="1290" height="722" alt="loadbalancer output" src="https://github.com/user-attachments/assets/51638f8e-3e76-46f9-8318-33adf3623a3b" />

<img width="1363" height="730" alt="build success" src="https://github.com/user-attachments/assets/5aad684c-228c-490b-91e6-7bdd197ee4c0" />

<img width="1358" height="727" alt="grafana home" src="https://github.com/user-attachments/assets/8fde5a79-a385-422c-8458-86ed25a24135" />

<img width="1334" height="663" alt="grafana running" src="https://github.com/user-attachments/assets/bb3851c8-8743-41ff-9a13-4e38708cc77a" />

<img width="1362" height="685" alt="prometheus" src="https://github.com/user-attachments/assets/8f5bd2fe-79b8-46ed-adff-d57dc31c101d" />















