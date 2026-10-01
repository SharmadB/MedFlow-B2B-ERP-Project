# MedFlow B2B ERP

A B2B medical ERP application built using a microservices architecture. The project manages users, products, inventory, and orders through separate backend services, with a React frontend.

The project was built and deployed locally using Docker and Kubernetes, with Jenkins used to understand and automate the CI/CD workflow.

## Key Features

- User and organization management
- Role-based access for different users
- Product and inventory management
- Order creation and order tracking
- REST APIs using Spring Boot
- MongoDB Atlas for database storage
- Docker containerization
- Kubernetes deployment using Minikube
- Kubernetes Ingress for routing frontend API requests
- Jenkins-based CI/CD workflow

## Architecture Overview

The application follows a microservices architecture where the frontend communicates with the backend services through Kubernetes Ingress.

```text
                    React Frontend
                         |
                         v
                Kubernetes Ingress
                         |
          +--------------+--------------+
          |              |              |
          v              v              v
    User Service   Product Service   Order Service
      :8081            :8082            :8083
          |              |              |
          +--------------+--------------+
                         |
                         v
                    MongoDB Atlas
```
## Tech Stack

| Area                    | Technology            |
| ----------------------- | --------------------- |
| Frontend                | React, Vite           |
| Backend                 | Spring Boot, Java     |
| Database                | MongoDB Atlas         |
| API                     | REST APIs             |
| Authentication          | Spring Security / JWT |
| Containerization        | Docker                |
| Container Orchestration | Kubernetes            |
| Local Kubernetes        | Minikube              |
| Kubernetes Routing      | Ingress               |
| CI/CD                   | Jenkins               |
| Infrastructure as Code  | Terraform (planned later) |
| Version Control         | Git, GitHub           |

## Backend Services

User Service

Port: 8081

Handles:

User management
Authentication
User roles
Organization-related operations
User-related APIs
Product Service

Port: 8082

Handles:

Product management
Product catalog
Inventory management
Stock-related operations
Product APIs
Order Service

Port: 8083

Handles:

Order creation
Order management
Order status
Order history
Order-related APIs

## Docker

Docker is used to package the application components into containers so that the services can run in a consistent environment.

The project includes Docker configuration for the frontend and backend services.

Docker Flow

Application Source Code
        |
        v
    Dockerfile
        |
        v
   Docker Image
        |
        v
  Docker Container
        |
        v
 Application Service

Docker was used during local development and testing before moving the application components into Kubernetes.

Docker Concepts Used

Dockerfiles
Docker images
Docker containers
Port mapping
Docker networks
Containerized application services
Docker Compose configuration

## Kubernetes

Kubernetes is used to deploy and manage the application containers locally through Minikube.

The project contains Kubernetes manifests for the application services and networking components.

Kubernetes Flow

                     User
                      |
                      v
               React Frontend
                      |
                      v
              Kubernetes Ingress
                      |
        +-------------+-------------+
        |             |             |
        v             v             v
   User Service  Product Service  Order Service
     :8081          :8082          :8083
        |             |             |
        +-------------+-------------+
                      |
                      v
                 MongoDB Atlas

Kubernetes Components Used

Minikube
Deployments
Pods
Services
ClusterIP
Ingress
Configurations and environment variables

Kubernetes Deployment Flow

Docker Image
     |
     v
Kubernetes Deployment
     |
     v
     Pod
     |
     v
Kubernetes Service
     |
     v
Ingress
     |
     v
Application Request

## Jenkins CI/CD

Jenkins is used to automate the application build and CI/CD workflow.

The project contains separate Jenkins pipeline definitions for the backend, frontend, and infrastructure-related workflows.

### Current Jenkins Flow

```text
Developer
    |
    v
GitHub Repository
    |
    v
Jenkins Pipeline
    |
    +----> Checkout Source Code
    |
    +----> Build Application
    |
    +----> Run Tests
    |
    +----> Build Docker Image
    |
    +----> Push Image
    |
    v
```
Docker Registry / Deployment Stage

The backend pipeline is defined in:

jenkins/Jenkinsfile.backend

The project also contains:

jenkins/Jenkinsfile.frontend
jenkins/Jenkinsfile.infra
Jenkins Work Completed
Created Jenkins jobs and pipelines
Connected Jenkins with the GitHub repository
Used Jenkins to checkout project source code
Built application components through Jenkins
Used Jenkins with Docker
Built Docker images through the pipeline
Configured Docker Hub credentials
Pushed Docker images to Docker Hub
Verified successful Jenkins pipeline execution
Future CI/CD Extensions

The backend Jenkinsfile also contains stages and tooling intended for future project upgrades, such as:

Trivy
SonarQube
AWS / EKS deployment
Additional automated deployment and security stages

## Local Setup

### Prerequisites

Make sure the following tools are installed:

- Java 17+
- Maven
- Node.js and npm
- Docker
- kubectl
- Minikube
- Git
- MongoDB Atlas account

### Clone the Repository

```bash
git clone https://github.com/SharmadB/MedFlow-B2B-ERP-Project.git
cd MedFlow-B2B-ERP-Project
```

### Environment Configuration

The backend services use environment variables for configuration.

Environment files are kept outside version control and are not committed to the repository.

The project uses .env files for service-specific configuration such as database connection details and application settings.

### Run Locally

The individual Spring Boot services can be built using Maven.

Example:

cd user-service
mvn clean package

The generated application can then be run using the Spring Boot JAR.

The frontend can be installed and started using npm from the frontend directory.

### Docker Deployment

Docker can be used to build and run the application components as containers.

Refer to the Docker documentation in the docs/ directory for the detailed deployment steps.

### Kubernetes Deployment

The application can be deployed locally using Minikube and the Kubernetes manifests provided in the k8s/ directory.

The Kubernetes deployment includes the application services, Kubernetes Services, and Ingress configuration.

Refer to the Kubernetes documentation in the docs/ directory for the detailed deployment steps.

## Deployment Flow

The project was developed and tested locally using Git, Docker, Kubernetes, and Jenkins.

### Overall Flow

```text
Developer
    |
    v
Git / GitHub
    |
    v
Jenkins CI Pipeline
    |
    +----> Build & Test
    |
    +----> Docker Image
    |
    +----> Docker Hub
    |
    v
Kubernetes / Minikube
    |
    +----> Deployments
    |
    +----> Pods
    |
    +----> Services
    |
    +----> Ingress
    |
    v
React Frontend + Backend APIs
    |
    v
MongoDB Atlas
```

Application Request Flow

User
 |
 v
React Frontend
 |
 v
Kubernetes Ingress
 |
 +-------------------+-------------------+
 |                   |                   |
 v                   v                   v
User Service     Product Service     Order Service
   :8081             :8082             :8083
 |                   |                   |
 +-------------------+-------------------+
                     |
                     v
                MongoDB Atlas

CI/CD Flow

The Jenkins pipeline is used to automate the build and Docker image workflow.

Code Change
    |
    v
GitHub
    |
    v
Jenkins
    |
    v
Checkout
    |
    v
Build / Test
    |
    v
Docker Build
    |
    v
Docker Hub
    |
    v
Deployment

The current project uses Minikube for local Kubernetes deployment. Cloud deployment stages such as AWS/EKS are part of the planned future upgrade of the project.

## Testing & Verification

The application was tested locally at different stages of the deployment process.

### Backend Verification

- Built the Spring Boot microservices using Maven.
- Started and verified the individual backend services.
- Verified the configured service ports.
- Tested REST API endpoints.
- Verified MongoDB Atlas connectivity and data operations.

### Docker Verification

- Built Docker images for application components.
- Started application containers locally.
- Verified container status and application accessibility.
- Tested Docker networking and port mapping.
- Verified Docker images pushed through the Jenkins pipeline.

### Kubernetes Verification

The application was deployed on Minikube and verified using Kubernetes resources.

The following were checked during testing:

- Pods running successfully
- Deployments created successfully
- Kubernetes Services available
- ClusterIP service communication
- Ingress routing
- Frontend-to-backend API requests
- Backend service responses
- Application accessibility through the configured Ingress route

### Jenkins Verification

The Jenkins pipeline was tested to verify the CI/CD workflow.

The following were verified:

- GitHub source checkout
- Application build
- Pipeline execution
- Docker image build
- Docker Hub authentication
- Docker image push
- Successful Jenkins build completion

### Overall Result

The application was successfully built, containerized, deployed locally using Kubernetes, and tested through the frontend, backend APIs, and Kubernetes Ingress.

## Project Structure

```text
MedFlow-B2B-ERP-Project/
│
├── frontend/                  # React + Vite frontend
│
├── user-service/              # User and authentication service
│
├── product-service/           # Product and inventory service
│
├── order-service/             # Order management service
│
├── docker/                    # Docker configuration
│
├── k8s/                       # Kubernetes manifests
│
├── jenkins/                   # Jenkins pipeline definitions
│
├── terraform/                 # Terraform infrastructure configuration
│
├── docs/                      # Project and deployment documentation
│
├── .gitignore
└── README.md
```

Main Directories

| Directory          | Purpose                                        |
| ------------------ | ---------------------------------------------- |
| `frontend/`        | React frontend application                     |
| `user-service/`    | User management and authentication             |
| `product-service/` | Product and inventory management               |
| `order-service/`   | Order management                               |
| `docker/`          | Docker-related configuration                   |
| `k8s/`             | Kubernetes deployment and networking manifests |
| `jenkins/`         | Jenkins pipeline files                         |
| `terraform/`       | Infrastructure as Code configuration           |
| `docs/`            | Detailed project documentation                 |

## Documentation

Detailed project documentation is available in the `docs/` directory.

- [Architecture](docs/ARCHITECTURE.md)
- [Manual Deployment](docs/MANUAL_DEPLOYMENT.md)
- [Docker Deployment](docs/DOCKER_DEPLOYMENT.md)
- [Kubernetes Deployment](docs/KUBERNETES_DEPLOYMENT.md)
- [Jenkins Deployment](docs/JENKINS_DEPLOYMENT.md)
- [Terraform Deployment](docs/TERRAFORM_DEPLOYMENT.md)

## Future Improvements

The current version focuses on local containerization, Kubernetes deployment, and CI/CD workflow.

Planned improvements for future versions include:

- AWS infrastructure deployment using Terraform
- Kubernetes deployment on Amazon EKS
- Automated AWS infrastructure provisioning
- Trivy-based container security scanning
- SonarQube-based code quality analysis
- Extended Jenkins CI/CD automation
- Automated deployment to cloud infrastructure
- Improved monitoring and observability
- Additional security and reliability improvements

## Development Scripts

The project includes helper scripts for starting and stopping the local development environment.

### Start Development Environment

```bash
./start-dev.sh
```
This script helps start the required local application components for development and testing.

Stop Development Environment
```bash
./stop-dev.sh
```
This script is used to stop the local development environment.

These scripts are intended to simplify repeated local development and testing.

## Project Note

This repository contains the customized project work completed as part of DevOps learning and practical project development.

The current version focuses on local Docker and Kubernetes deployment, Jenkins CI/CD workflow, and integration with MongoDB Atlas.

Future versions may extend the project with cloud infrastructure, AWS EKS, Terraform-based provisioning, security scanning, code quality analysis, and additional CI/CD automation.
