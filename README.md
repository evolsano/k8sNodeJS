# Terraform EC2 and run pods with minikube in AWS EC2

This is a practice project to use Terraform and AW EC2 and install k8s minikube to deploy docker container.
Minikube required 2 core CPU. Required to ues t2.medium which is chargable.

These are basic steps. [Work In Progress]

1. Create EC2 (t2.medium instance and 15GB storage)with security group via Terraform. [main.tf]
2. Install apache2, docker, kubectl and minikube. [installation.sh]
3. Create deployment file. [deployment.yaml]
4. Create service.yaml to expose node using LoadBalancer method. [service.yaml]
5. Create ingress.yaml to expose application to external via reserve proxy. [ingress.yaml]
6. Update apache2 configuration for reverse proxy. [reverseporxy.md]
7. Deployment with 3 pods.
   
# Commands

## Terraform

Initialize Terraform
```
terraform init
```

Plan the Terraform
```
terraform plan
```

Apply the Terraform
```
terraform apply
```

Destroy the Terraform
```
terraform destroy
```

## kubectl commands

Run the deployment file.
```
kubectl apply -f deployment.yaml
```

Run the service file.
```
kubectl apply -f service.yaml
```

### Verify the deployment

#### Check Deployments
```
kubectl get deployments
```

#### Check Pods
```
kubectl get pods
```

### Check Services
```
kubectl get services
```

## minikube commands
Start minikube
```
minikube start
```

## minikube commands

Start minikube
```
minikube start
```

Show minikube services
```
minikube services list
```

Enable minikube ingress addon
```
minikube addons enable ingress
```