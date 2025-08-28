**README**

# 🚀 AWS ECS Deployment with Terraform & GitHub Actions

## 📌 Overview

This project provisions and deploys a **containerized application** on **Amazon ECS (EC2 launch type)** using **Terraform** for infrastructure and **GitHub Actions** for CI/CD.

The system includes:

* **ECS (EC2 Launch Type)** → Hosts the application.
* **EC2 Instances** → Worker nodes for ECS.
* **RDS (MariaDB)** → Database backend.
* **S3 Bucket** → Stores static files.
* **EFS (Elastic File System)** → Shared storage.
* **CloudFront** → CDN and caching.

---

## 🛠️ Infrastructure Setup (Terraform)

Terraform manages all AWS resources in a modular structure:

* **`vpc.tf`** → VPC, subnets, route tables
* **`sg.tf`** → Security groups
* **`ecs.tf`** → ECS Cluster, Task Definition, Service, EC2 instance
* **`rds.tf`** → MariaDB database in private subnet
* **`s3.tf`** → S3 bucket with versioning enabled
* **`efs.tf`** → Elastic File System for shared storage
* **`cloudfront.tf`** → CloudFront distribution
* **`iam.tf`** → IAM roles and policies (ECS task execution, S3 access, etc.)
* **`variables.tf`** → Input variables
* **`dev.tfvars`** → Environment-specific values (e.g., DB username, password, instance sizes)
* **`output.tf`** → Exports useful resource info (DB endpoint, S3 bucket, ECS cluster, etc.)

### Provisioning

```bash
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

---

## ⚡ CI/CD Pipeline (GitHub Actions)

The pipeline is defined in **`.github/workflows/deploy.yml`**:

1. **Terraform Init & Plan**

   * Runs `terraform init` and `terraform plan`.
   * Pauses for **manual approval** before applying changes.

2. **Terraform Apply**

   * Provisions/updates infrastructure in AWS.

3. **Docker Build & Push**

   * Builds Docker image and pushes to **Amazon ECR**.

4. **ECS Deployment**

   * Forces a new deployment in ECS to pull the latest image.

---

## 🔑 GitHub Secrets

Add the following secrets in **GitHub → Repo → Settings → Secrets and variables → Actions**:

| Secret Name             | Description                                    |
| ----------------------- | ---------------------------------------------- |
| `AWS_ACCESS_KEY_ID`     | IAM user access key with ECS/ECR/RDS/S3 rights |
| `AWS_SECRET_ACCESS_KEY` | IAM user secret key                            |
| `AWS_REGION`            | AWS region (e.g., `us-east-1`)                 |
| `ECR_REPO`              | ECR repository name (e.g., `my-app`)           |
| `ECS_CLUSTER`           | ECS cluster name                               |
| `ECS_SERVICE`           | ECS service name                               |
| `DB_USERNAME`           | RDS admin username                             |
| `DB_PASSWORD`           | RDS admin password                             |

---

## 🌍 Using Environment Variables

* GitHub Secrets are injected as **environment variables** in the pipeline.
* Terraform can consume them using `-var="db_username=${{ secrets.DB_USERNAME }}"`.
* ECS Task Definition uses **container environment variables** to connect to DB, S3, etc.

---

## 🧪 Local Validation

To validate locally before pushing to GitHub Actions:

1. Export AWS credentials:

   ```bash
   export AWS_ACCESS_KEY_ID=xxxx
   export AWS_SECRET_ACCESS_KEY=xxxx
   export AWS_REGION=us-east-1
   ```
2. Run:

   ```bash
   terraform plan -var-file=dev.tfvars
   ```
3. Build Docker image locally:

   ```bash
   docker build -t my-app:latest .
   ```

---

## ✅ Deployment Flow

1. Developer pushes code to **main** branch.
2. GitHub Actions triggers workflow:

   * `terraform plan` → manual approval → `terraform apply`
   * Docker image build & push to ECR
   * ECS Service redeploys with new image
3. Application is live on ECS with DB (RDS), static files (S3), shared storage (EFS), and caching (CloudFront).

---

🔹 With this setup, infrastructure is fully automated via **Terraform**, while **GitHub Actions** ensures continuous delivery of application updates.
