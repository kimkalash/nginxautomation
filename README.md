As recently intended, I executed a hands-on DevOps project that automates the full lifecycle of setting up and securing an Nginx web server from manual scripts to full Infrastructure as Code (IaC) with Terraform + Ansible.

 Project Overview

This project was built in 5 phases:

VM Setup – Provision lightweight Ubuntu VMs (tested on WSL 22.04/24.04).

Security Hardening – Create non-root sudo user, configure UFW firewall, SSH hardening.

Web Server – Install and configure Nginx, deploy a static site.

Monitoring – Add tools like htop, log inspection, service checks.

Automation (IaC) – Use Terraform to orchestrate provisioning and Ansible to configure the VM automatically.

⚡ Quick Start (Manual)

Clone the repo and run all setup scripts manually:
git clone https://github.com/kimkalash/nginxautomation.git
cd nginxautomation
chmod +x setup_all.sh
./setup_all.sh

This will sequentially:

Update the system, create a non-root sudo user, set up firewall + security tools, install & configure Nginx, and add monitoring tools

Quick Start (Terraform + Ansible)

For full IaC automation:

1. Prerequisites

Terraform installed (terraform -v)

Ansible installed (ansible --version)

SSH keys set up between your control VM and target VM

Update ansible/inventory.ini with your target VM’s IP, user, and SSH port

Example:

[nginx_server]
1.1.1.1 ansible_connection=ssh ansible_user=username ansible_port=22

2. Run the pipeline
cd nginx-iac/terraform
terraform init
terraform apply


Terraform will:

Simulate provisioning (dummy resource here, replaceable with AWS EC2 later), call the Ansible playbook via local-exec, configure the VM automatically using the repo scripts.

 Lessons Learned

During Phase 5, several common errors came up (and fixes applied):

Git branch mismatch → renamed master → main

SSH port conflict → switched SSH to port 2222

Ansible sudo password issue → configured passwordless sudo for username

Git “dubious ownership” → cloned repo into /home/username instead of another user’s home

UFW profile missing → installed nginx-core to provide UFW app profiles (Nginx Full, Nginx HTTP, Nginx HTTPS)

Nginx reload failed → replaced systemctl reload nginx with systemctl restart nginx

🔮 Future Improvements

Replace dummy Terraform resource with real cloud provisioning (e.g., AWS EC2).

Add CI/CD pipeline (GitHub Actions) for automated testing & deployment.

Expand monitoring (ELK, Prometheus).


This project is primarily for learning DevOps fundamentals. Feel free to fork, clone, and adapt it to your own environment.




This project is primarily for learning DevOps fundamentals.
Feel free to fork, clone, and adapt it to your own environment.
