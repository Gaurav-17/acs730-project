# acs730-project
acs730project

# Two-Tier Web Application Automation with Terraform, Ansible, and GitHub Actions

## Contributors

- Gaurav-17 - Gaurav Jankbhai Patel - 153169222

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

## Contributors
- *Dharmik*: Security scanning with Terraform and GitHub Actions.
- *Harsh Thakkar*: Configuration and management of Terraform code for Webservers.
- *Gaurav*: Ansible playbook development and execution and overall pull flow and troubleshooting any technical errors. Also managing the github repos.
- *Lihini*: Workflow automation and Terraform launch configurations.
- *Rohan*: Terraform network infrastructure design and implementation via terraform.

## Challenges and Learnings
[Discuss the challenges each member faced, the solutions developed, and any new insights gained.]

There would inevitably be difficulties. Our first challenges were figuring out which Terraform options were specific to our multi-environment architecture and how to safely transfer photos from S3 buckets to private locations. We overcame these problems by using iterative testing and peer cooperation, and we improved our code by making frequent changes that showed our increasing skill.

The challenge that Dharmik faced was some simple syntax errors, dharmik was trying to establish an infrastructure where DevOps tools try to communicate with each other and there were times that we did not know what the problem was and finally we realised that it was not a huge hassle or a lack of knowledge problem but a small syntax error.

Harsh's task was to deploy the webserver but for some reason the server was not deploying correctly where in harsh had to dive in deep with the security groups and the correct environment to complete the task. The main issue was to install the servers into just first two AZ zones and also finding a way to bifurcate httpd installed and not installed web servers.

Rohan's initial task was to understand the whole infrastructure such as what subnets and what resources to be deployed for which the team had to meet on a zoom call and talk about the diagram and infrastructure of the project.

Lihini's major task was to get the system running by making two jobs run, one for the network infrastructure and one for the webserver respectively and there were some issues with file naming errors as we were using the same file to save workflow information for both the jobs, also we used a self-hosted runner so we also had to configure and troubleshoot on how to use it.

Gaurav's main task was to deploy the ansible via the dynamic inventory. For that me and Harsh together had to figure out a way on how to bifurcate webservers who needs to install httpd service via tags and than apply the configurations via ansible.




## Conclusion
Using Terraform, Ansible, and GitHub Actions, our team expertly negotiated the challenges of deploying a two-tier web application throughout the course of our final project for ACS730. By automating the deployment of infrastructure and application code, the project demonstrated the revolutionary power of DevOps methods and improved our operational efficiency and commitment to a DevOps culture.


Using GitHub Actions was essential to simplifying our process. An early and strong security posture was established in the development process by doing security scans on every commit. We were able to confidently and controllably swiftly spread changes across dev, staging, and prod environments by automating Terraform deployments. Ansible introduced a unique learning curve, especially when it came to playbook administration and Dynamic Inventory. Nevertheless, our persistence paid off as we were able to automate our web servers' configuration, guaranteeing dependable and consistent arrangements.

---

For additional details and support, refer to the repository's Wiki or Issues section.
