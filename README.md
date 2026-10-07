````markdown
# MedFlow B2B ERP

A B2B medical ERP application built using a microservices architecture for managing users, organizations, products, inventory, and orders.

The project evolved from a local Docker/Kubernetes deployment into an AWS-based V2 deployment using Amazon EKS, Kubernetes, Amazon ECR, AWS Load Balancer Controller, Application Load Balancer, Terraform, Jenkins, and MongoDB Atlas.

---

## 🚀 Project Overview

MedFlow is composed of three Spring Boot backend microservices:

- **User Service** – authentication, users, roles, and organizations
- **Product Service** – product catalog and inventory-related operations
- **Order Service** – order creation and order management

The services expose REST APIs and use JWT-based authentication for protected operations.

MongoDB Atlas is used as the persistent database.

---

## 🏗️ Architecture

### V2 AWS Architecture

```text
                         Internet
                            |
                            v
              AWS Application Load Balancer
                            |
                            v
              AWS Load Balancer Controller
                            |
                            v
                 Kubernetes Ingress
                            |
              +-------------+-------------+
              |             |             |
              v             v             v
        User Service   Product Service  Order Service
           :8081           :8082           :8083
              |             |             |
              +-------------+-------------+
                            |
                            v
                     MongoDB Atlas
````

### AWS Infrastructure

```text
                         AWS
                          |
              +-----------+-----------+
              |                       |
              v                       v
             VPC                    Amazon ECR
              |                       |
              v                       |
         Amazon EKS <-----------------+
              |
       Kubernetes Cluster
              |
      +-------+-------+
      |       |       |
      v       v       v
    User   Product   Order
   Service  Service  Service
      |
      v
 MongoDB Atlas
```

---

## ☁️ AWS / EKS Deployment

The V2 deployment runs the backend microservices on **Amazon EKS**.

### AWS components used

* Amazon EKS
* Amazon EC2 worker node
* Amazon ECR
* Amazon VPC
* AWS Load Balancer Controller
* Application Load Balancer
* IAM
* Terraform

The Kubernetes cluster runs the services inside the `med-erp` namespace.

Each backend service runs with multiple replicas for basic workload availability.

---

## 🌐 Application Routing

AWS Load Balancer Controller provisions and manages the Application Load Balancer from the Kubernetes Ingress configuration.

API routing is handled through path-based rules:

```text
/api/v1/auth          -> User Service
/api/v1/users         -> User Service
/api/v1/organizations -> User Service

/api/v1/products      -> Product Service

/api/v1/orders        -> Order Service
```

This allows a single public ALB endpoint to route requests to the appropriate Kubernetes service.

---

## 🔐 Authentication

The application uses:

* Spring Security
* JWT authentication
* Role-based authorization
* Protected REST endpoints

Typical request flow:

```text
Client
  |
  v
Login API
  |
  v
JWT Access Token
  |
  v
Protected API Request
  |
  v
JWT Validation
  |
  v
Controller
```

Authentication was verified through the deployed AWS environment using protected API requests.

---

## 🧩 Backend Microservices

### User Service

**Port:** `8081`

Responsibilities:

* User registration
* User authentication
* JWT authentication
* User management
* Role management
* Organization operations

### Product Service

**Port:** `8082`

Responsibilities:

* Product management
* Product catalog
* Inventory-related operations
* Product APIs

### Order Service

**Port:** `8083`

Responsibilities:

* Order creation
* Order management
* Order status
* Order retrieval
* Order-related APIs

---

## 🗄️ Database

The application uses **MongoDB Atlas** as the database.

The backend services connect to MongoDB Atlas from the Kubernetes environment.

Database credentials and connection details are provided through environment configuration and are not committed to the repository.

---

## 🐳 Docker & Amazon ECR

Each backend service is packaged as a Docker image.

```text
Spring Boot Application
        |
        v
     Dockerfile
        |
        v
    Docker Image
        |
        v
    Amazon ECR
        |
        v
     Amazon EKS
        |
        v
 Kubernetes Pod
```

Backend Docker images are stored in Amazon ECR repositories:

```text
med-erp/user-service
med-erp/product-service
med-erp/order-service
```

The V2 images were tagged with:

```text
eks-v2
```

---

## ☸️ Kubernetes

Kubernetes is used to deploy and manage the backend microservices on Amazon EKS.

### Kubernetes components used

* Namespace
* Deployments
* Pods
* ClusterIP Services
* Ingress
* Environment configuration
* Replica management

Current application services:

```text
user-service      :8081
product-service   :8082
order-service     :8083
```

Each service is exposed internally through a Kubernetes `ClusterIP` service and accessed externally through the ALB/Ingress layer.

---

## 🏗️ Terraform

Terraform is used as the Infrastructure as Code layer for the AWS environment.

The project contains Terraform configurations/modules for AWS infrastructure including:

* VPC
* EKS
* ECR
* Route 53
* S3 / CloudFront configuration
* Environment-specific Terraform configuration

Terraform helps define AWS infrastructure in a repeatable and version-controlled way.

---

## 🔄 Jenkins CI/CD

Jenkins is used for the project's CI/CD workflow.

The repository contains Jenkins pipeline definitions for:

```text
jenkins/
├── Jenkinsfile.backend
├── Jenkinsfile.frontend
└── Jenkinsfile.infra
```

The CI/CD workflow covers activities such as:

```text
Developer
    |
    v
GitHub
    |
    v
Jenkins
    |
    +--> Checkout
    |
    +--> Build
    |
    +--> Test
    |
    +--> Docker Build
    |
    +--> Docker Image Push
    |
    v
Container Registry / Deployment Workflow
```

Jenkins was also used to build Docker images and push container images to a Docker registry during the project workflow.

The AWS EKS deployment was separately verified using the AWS, Terraform, Docker, and Kubernetes tooling.

---

## 🧪 Deployment Verification

The V2 deployment was verified using:

* Kubernetes pod status
* Kubernetes service status
* Kubernetes node status
* Ingress status
* ALB routing
* MongoDB Atlas connectivity
* Authentication/login
* Protected API requests
* Product API
* Order API
* Amazon ECR image verification

Example Kubernetes verification:

```bash
kubectl get nodes

kubectl -n med-erp get pods

kubectl -n med-erp get svc

kubectl -n med-erp get ingress
```

---

## 🛠️ Technology Stack

| Category               | Technology                    |
| ---------------------- | ----------------------------- |
| Frontend               | React, Vite                   |
| Backend                | Spring Boot                   |
| Language               | Java 17                       |
| Database               | MongoDB Atlas                 |
| Authentication         | Spring Security, JWT          |
| Containerization       | Docker                        |
| Container Registry     | Amazon ECR                    |
| Orchestration          | Kubernetes                    |
| Cloud Kubernetes       | Amazon EKS                    |
| Load Balancing         | AWS Application Load Balancer |
| Ingress                | AWS Load Balancer Controller  |
| Infrastructure as Code | Terraform                     |
| CI/CD                  | Jenkins                       |
| Version Control        | Git, GitHub                   |
| Cloud Platform         | AWS                           |

---

## 📁 Repository Structure

```text
MedFlow-B2B-ERP-Project/
│
├── frontend/
│
├── user-service/
├── product-service/
├── order-service/
│
├── k8s/
│   ├── deployments/
│   └── ingress/
│
├── terraform/
│   ├── env/
│   └── modules/
│
├── jenkins/
│   ├── Jenkinsfile.backend
│   ├── Jenkinsfile.frontend
│   └── Jenkinsfile.infra
│
├── docs/
│
├── .gitignore
└── README.md
```

---

## 💻 Local Development

The project was initially developed and tested using local Docker and Kubernetes/Minikube environments before the V2 AWS EKS deployment.

### Prerequisites

* Java 17+
* Maven
* Node.js and npm
* Docker
* kubectl
* Minikube
* Terraform
* AWS CLI
* Git
* MongoDB Atlas account

### Clone Repository

```bash
git clone https://github.com/SharmadB/MedFlow-B2B-ERP-Project.git

cd MedFlow-B2B-ERP-Project
```

---

## 📌 Project Evolution

### V1 — Local Deployment

The initial deployment focused on:

* Docker
* Kubernetes
* Minikube
* Kubernetes Ingress
* Jenkins
* MongoDB Atlas

### V2 — AWS Deployment

The project was upgraded to AWS using:

* Amazon EKS
* Amazon ECR
* AWS VPC
* Terraform
* AWS Load Balancer Controller
* Application Load Balancer
* Kubernetes Ingress
* JWT authentication
* MongoDB Atlas

The V2 deployment demonstrates how the application can move from a local containerized environment to a cloud-based Kubernetes environment.

---

## 📊 Project Status

### V2 Deployment

* [x] Microservices deployed on Amazon EKS
* [x] Docker images built
* [x] Images pushed to Amazon ECR
* [x] Kubernetes Deployments configured
* [x] Kubernetes Services configured
* [x] AWS Load Balancer Controller configured
* [x] Application Load Balancer provisioned
* [x] Ingress routing verified
* [x] MongoDB Atlas connectivity verified
* [x] JWT authentication verified
* [x] Protected APIs verified
* [x] Terraform infrastructure configured
* [x] Jenkins CI/CD workflow implemented
* [x] GitHub repository updated

---

## 🎯 Key DevOps Concepts Demonstrated

This project provides practical exposure to:

* Microservices architecture
* Docker containerization
* Container image management
* Amazon ECR
* Kubernetes Deployments and Pods
* Kubernetes Services
* Kubernetes Ingress
* Amazon EKS
* AWS Load Balancer Controller
* Application Load Balancer
* IAM
* AWS VPC
* Infrastructure as Code with Terraform
* Jenkins CI/CD
* Git and GitHub
* JWT authentication
* Cloud-based application deployment
* Application troubleshooting and verification

````
