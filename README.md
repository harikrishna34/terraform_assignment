# terraform_assignments
this is terraform assignemnts for EY
# GKE Cluster and Deployment Examples

This repository contains two main tasks demonstrating the use of Google Kubernetes Engine (GKE) with Terraform and Jenkins.

## Table of Contents

1. [Overview](#overview)
2. [Task 1: GKE Cluster with Auto Scaling](#task-1-gke-cluster-with-auto-scaling)
3. [Task 2: Blue-Green Deployment with Jenkins](#task-2-blue-green-deployment-with-jenkins)
4. [Prerequisites](#prerequisites)
5. [Usage](#usage)
6. [License](#license)

## Overview

This project demonstrates the creation of a GKE cluster, deployment of a test application, and implementation of blue-green deployment strategy using Jenkins.

## Task 1: GKE Cluster with Auto Scaling

### Description

In this task, a 2-node GKE cluster was created using Terraform. A sample application was deployed on the cluster, configured to demonstrate auto-scaling based on traffic increases.

### Implementation Steps

1. **Terraform Configuration**: 
   - The Terraform scripts define the GKE cluster and associated resources.
   - The scripts can be found in the `/terraform` directory.

2. **Deploying the Application**:
   - A test application was deployed using Kubernetes manifests.
   - Horizontal Pod Autoscaler (HPA) was set up to scale the application based on CPU utilization.

3. **Testing Auto Scaling**:
   - Load testing was performed to simulate traffic increase and observe auto-scaling behavior.

### Prerequisites for Task 1

- Google Cloud SDK
- Terraform installed
- Appropriate IAM permissions

## Task 2: Blue-Green Deployment with Jenkins

### Description

This task demonstrates how to deploy an application using Jenkins on GKE, utilizing the blue-green deployment strategy.

### Implementation Steps

1. **Jenkins Setup**:
   - Jenkins is configured to build and deploy the application to the GKE cluster.
   - Pipeline scripts can be found in the `/jenkins` directory.

2. **Blue-Green Deployment**:
   - The application is deployed in two separate environments (blue and green).
   - Traffic is switched between the two environments to minimize downtime.

### Prerequisites for Task 2

- Jenkins server running
- GKE cluster with proper permissions
- Docker installed for building images

## Usage

### Task 1

1. Navigate to the `terraform` directory:
   ```bash
   cd terraform
terraform init
terraform apply
Task 2
Access Jenkins and create a new pipeline job.
Point to the Jenkinsfile in the /jenkins directory.
Run the pipeline to deploy the application using blue-green strategy.
License
This project is licensed under the MIT License - see the LICENSE file for details.

Feel free to modify any sections to better fit your project or personal style!
