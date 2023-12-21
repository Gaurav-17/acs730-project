# AWS Cloud-DevOps project

# Two-Tier Web Application Automation with Terraform, Ansible, and GitHub Actions
![image](https://github.com/Gaurav-17/aws-project/assets/64305413/306457d8-9134-4db4-90b4-69599e9a051d)


## Contributors

- Gaurav-17 - Gaurav Patel 

```

## Introduction
This repository contains Terraform configurations and Ansible Playbooks to automate the deployment of a two-tier web application in AWS. It leverages Infrastructure as Code (IaC) practices with Terraform and configuration management with Ansible. GitHub Actions are integrated for security scanning and deployment automation.

## Prerequisites
- AWS account with appropriate permissions.
- Terraform and Ansible installed on your local machine or control host.
- S3 bucket for Terraform state and webserver images bucket to configured to be non-public.
- Proper permissions set up in this GitHub repository.

## Architecture
The architecture involves multiple VMs across public and private subnets within AWS, orchestrated by Terraform and configured via Ansible.

## Setup Instructions
1. *Clone the Repository*: git clone [REPO_URL]
2. *Terraform Initialization*:
   - Navigate to the environments /prod directory and first do below steps on prod/network folder and than on prod/webserver folder.
   - Execute terraform init.
   - Execute terraform fmt.
   - Execute terraform fmt.
   - Execute terraform plan.

3. *Terraform Apply*:
   - Execute terraform apply.
4. *Ansible Configuration*:
   - Navigate to the Ansible directory.
   - Update the dynamic inventory with the created VMs.
   - Execute the Ansible Playbooks: ansible-playbook -i inventory playbook.yml

## Security
Do not commit SSH  private keys or sensitive credentials. GitHub Actions defined in .github/workflows/ will scan all commits.

## Deployment Process
Also, we used GitHub Action workflows to automate the terraform launch, that you can employ in your own infrastructure as well. The only change you would need to do is configure your own self-hosted runner and your own cloud credentials in setting>environment section.

GitHub Actions automatically scans each push to the staging branch and pull requests to the prod branch. It also automates the deployment of Terraform code.

## Cleaning Up
Run terraform destroy in the environment directory to clean up resources.


## Conclusion
Using Terraform, Ansible, and GitHub Actions, I expertly negotiated the challenges of deploying a two-tier web application throughout the course of this project for DevOps CI/CD pipeline. By automating the deployment of infrastructure and application code, the project demonstrated the revolutionary power of DevOps methods and improved our operational efficiency and commitment to a DevOps culture.


Using GitHub Actions was essential to simplifying our process. An early and strong security posture was established in the development process by doing security scans on every commit. We were able to confidently and controllably swiftly spread changes across dev, staging, and prod environments by automating Terraform deployments. Ansible introduced a unique learning curve, especially when it came to playbook administration and Dynamic Inventory. Nevertheless, our persistence paid off as we were able to automate our web servers' configuration, guaranteeing dependable and consistent arrangements.

---

For additional details and support, refer to the repository's Wiki or Issues section.
