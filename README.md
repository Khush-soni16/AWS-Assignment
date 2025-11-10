AWS DevSecOps Assignment — Node.js + MongoDB on EKS (Terraform + GitHub Actions)
Purpose:
End-to-end DevSecOps implementation — secure container build, image scanning, IaC provisioning (Terraform), ECR/EKS/VPC setup, and fully automated deployment via GitHub Actions.
________________________________________


________________________________________
# Project Summary
	Dockerfile — multi-stage, non-root Node.js image
	k8s/ — Kubernetes manifests:
	deployment-app.yaml,
	 service-app.yaml
	deployment-mongo.yaml, 
	service-mongo.yaml
	ingress.yaml
	terraform/ — module-based Terraform configuration:
	modules/vpc, modules/eks, modules/ecr
	root files: main.tf, variables.tf, output.tf
	.github/workflows/devsecops.yml — GitHub Actions workflow:
	Builds Docker image
	Runs Trivy and Snyk scans
	Executes Terraform (init → import → plan → apply)
	Pushes image to ECR
	Deploys to EKS via kubectl
	trivy-secure-report.txt — vulnerability report artifact
	README.md — (this file)
________________________________________
# AWS Configuration Used
Component	Name / Value
Region	us-east-1
ECR Repository Name	awsassignment-app
EKS Cluster Name	secure-eks-cluster
Terraform Version	1.9.8
Kubernetes Namespace	default
Docker Image Tag	latest
________________________________________
# GitHub Secrets Required
Go to Repo → Settings → Secrets and Variables → Actions and add these:
Secret Name	Example Value	Description
AWS_ACCESS_KEY_ID	AKIAXXXXXXX	IAM User Access Key
AWS_SECRET_ACCESS_KEY	xxxxxxxxxx	IAM Secret Key
AWS_REGION	us-east-1	AWS Region
SNYK_TOKEN	(optional)	For Snyk vulnerability scanning
## Never commit secrets — use GitHub Secrets only.
________________________________________
# Pipeline Overview
Triggers:
	On every push to main
	On every Pull Request targeting main
Workflow summary:
1.	Checkout source code
2.	Setup Docker Buildx
3.	Build Docker image
4.	Run Trivy vulnerability scan → upload report
5.	Run optional Snyk scan
6.	Configure AWS credentials
7.	Run Terraform (init → import → plan → apply)
        	Creates VPC, IAM roles, ECR repo, EKS cluster
8.	Login to ECR
9.	Push Docker image to ECR (awsassignment-app:latest)
10.	Update kubeconfig for EKS (secure-eks-cluster)
11.	Deploy manifests from k8s/ folder
12.	Verify Pods, Services, Ingress
________________________________________
# Terraform Structure
terraform/
├── main.tf          # Root Terraform entrypoint
├── variables.tf     # Variable declarations
├── output.tf        # Output values (ECR URL, cluster name, etc.)
└── modules/
    ├── vpc/         # VPC + subnets + internet gateway
    ├── ecr/         # ECR repository module
    └── eks/         # EKS cluster + IAM roles + node groups
Terraform uses modules for a clean and reusable structure.
Each module is automatically called from main.tf at root.
________________________________________
# Run Locally (Optional Validation)
1 Clone the repository
git clone <your-repo-url>
cd AWS-Assignment
2 Build and run Docker locally
docker build -t awsassignment-app:secure .
docker run -e MONGO_URL="mongodb://mongo:27017/mydb" -p 3000:3000 awsassignment-app:secure
3 Deploy with Terraform (manual)
cd terraform/
terraform init
terraform plan
terraform apply -auto-approve
4 Apply Kubernetes manifests
aws eks update-kubeconfig --region us-east-1 --name secure-eks-cluster
kubectl apply -f ../k8s/
________________________________________
# Common Troubleshooting
- ECR “repository does not exist”
	Check that Terraform successfully created the ECR repo before docker push.
The pipeline runs terraform apply first — verify it didn’t fail.
- Push error: “file too large” (100MB+)
	You committed Terraform provider binaries.
- Fix:
	rm -rf terraform/.terraform
	echo ".terraform/" >> .gitignore
	git rm -r --cached terraform/.terraform
	git commit -m "remove binaries"
	git push
# Terraform import warnings
	Expected. The pipeline runs terraform import ... || true to skip if resources don’t exist.
# Secret detected
	Remove any plaintext secret files (e.g., Secret.txt).
Regenerate and re-add them securely as GitHub Secrets.
________________________________________
# Security Practices Implemented
Control	Description
Image Scanning	Trivy & Snyk scans integrated into pipeline
Non-root containers	Dockerfile + Kubernetes manifests run as non-root
IAM least privilege	Terraform uses specific EKS/VPC policies only
Secrets protection	Uses GitHub Secrets & AWS IAM roles
Terraform Lock	State locking & provider version pinning
To make pipeline fail on vulnerabilities, change:
trivy image --exit-code 1 --severity HIGH,CRITICAL ...
________________________________________
# Validation Checklist
Checkpoint	Command
Terraform apply success	terraform output shows ECR URL & EKS details
ECR repo exists	aws ecr describe-repositories --region us-east-1
Docker image pushed	aws ecr describe-images --repository-name awsassignment-app
EKS running pods	kubectl get pods -A
App accessible	kubectl get ingress and test Ingress endpoint
________________________________________
# Repository Tree
.
├── .github/workflows/devsecops.yml        # CI/CD pipeline
├── Dockerfile
├── k8s/
│   ├── deployment-app.yaml
│   ├── service-app.yaml
│   ├── deployment-mongo.yaml
│   ├── service-mongo.yaml
│   └── ingress.yaml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── output.tf
│   └── modules/
│       ├── vpc/
│       ├── ecr/
│       └── eks/
└── README.md
________________________________________
# Best Practices & Next Steps
•	Enforce Terraform Cloud / remote state for production.
•	Add SonarCloud or Semgrep for static code analysis.
•	Integrate runtime monitoring (Falco, AWS GuardDuty).
•	Enable AWS Config + CloudTrail for audit visibility.
•	Add automated rollback logic for failed deployments.
________________________________________
# Maintainer
Author: Khushabu Soni
Role: DevOps Engineer (Terraform, AWS, CI/CD)

