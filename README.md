# 🚀 Terraform + Ansible Infrastructure Automation

> End-to-End DevOps Automation using Terraform, Ansible Inventory, Nginx, Docker and AWS EC2.

![Terraform](https://img.shields.io/badge/Terraform-IaC-blueviolet?style=for-the-badge\&logo=terraform)
![Ansible](https://img.shields.io/badge/Ansible-Automation-red?style=for-the-badge\&logo=ansible)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange?style=for-the-badge\&logo=amazonaws)
![Docker](https://img.shields.io/badge/Docker-Containers-blue?style=for-the-badge\&logo=docker)

---

## 📖 Project Overview

This project demonstrates how to provision and manage cloud infrastructure using Terraform and configure servers automatically using Ansible.

### Features

* Provision AWS EC2 Instances using Terraform
* Configure Infrastructure using Ansible
* Centralized Inventory Management
* Automated Nginx Installation
* Automated Docker Installation
* Execute Ad-Hoc Commands
* Manage Ubuntu and Amazon Linux Servers
* Infrastructure as Code (IaC)

---

## 🏗 Architecture

```text
Terraform
    │
    ▼
AWS EC2 Instances
    │
    ▼
Ansible Inventory
    │
 ┌──┼──┐
 ▼  ▼  ▼
S1 S2 S3
    │
    ▼
Configuration & Deployment
```

---

## 📂 Project Structure

```bash
terraform-ansible/
│
├── terraform/
│   ├── provider.tf
│   ├── variables.tf
│   ├── main.tf
│   └── outputs.tf
│
├── ansible/
│   ├── hosts.ini
│   │
│   ├── playbooks/
│   │   ├── install_nginx.yml
│   │   └── install_docker.yml
│   │
│   └── keys/
│       └── ansible_keys
│
└── README.md
```

---

# ⚙️ Prerequisites

Before starting, install:

* Terraform
* Ansible
* AWS CLI
* SSH Key Pair
* AWS Account

---

# 🔧 Install Ansible

```bash
sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
```

Verify installation:

```bash
ansible --version
```

---

# 🔑 Generate SSH Key

```bash
ssh-keygen -t rsa -b 4096
```

Example:

```bash
ansible_keys
ansible_keys.pub
```

---

# 🖥 Configure Ansible Inventory

Create a file named `hosts.ini`

```ini
[servers]

server1 ansible_host=<PUBLIC_IP_1>
server2 ansible_host=<PUBLIC_IP_2>
server3 ansible_host=<PUBLIC_IP_3>

[servers:vars]

ansible_user=ubuntu
ansible_ssh_private_key_file=~/keys/ansible_keys
```

### Mixed Environment Inventory

```ini
[amazon-linux]

server1 ansible_host=<PUBLIC_IP>
server2 ansible_host=<PUBLIC_IP>
ansible_user=ec2-user

[ubuntu]

server3 ansible_host=<PUBLIC_IP>
ansible_user=ubuntu
```

---

# ✅ Verify Connectivity

Ping all servers:

```bash
ansible -i hosts.ini servers -m ping
```

Expected Output:

```json
{
  "ping": "pong"
}
```

---

# 📊 Gather System Information

Memory Usage:

```bash
ansible server1 -a "free -h"
```

Disk Usage:

```bash
ansible server1 -a "df -h"
```

Operating System:

```bash
ansible server1 -a "cat /etc/os-release"
```

Gather Facts:

```bash
ansible -i hosts.ini servers -m setup
```

---

# 🌐 Nginx Deployment

### install_nginx.yml

```yaml
---
- name: Install Nginx
  hosts: servers
  become: true

  tasks:

    - name: Install Nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Start Nginx
      service:
        name: nginx
        state: started
        enabled: yes
```

Run Playbook:

```bash
ansible-playbook -i hosts.ini install_nginx.yml
```

---

# 🐳 Docker Deployment

### install_docker.yml

```yaml
---
- name: Install Docker
  hosts: servers
  become: true

  tasks:

    - name: Install Docker
      package:
        name: docker
        state: present

    - name: Start Docker
      service:
        name: docker
        state: started
        enabled: true
```

Run Playbook:

```bash
ansible-playbook -i hosts.ini install_docker.yml
```

Verify Docker:

```bash
ansible servers -a "docker --version"
```

```bash
ansible servers -b -a "docker ps"
```

---

# ☁️ Terraform Workflow

Initialize Terraform:

```bash
terraform init
```

Validate Configuration:

```bash
terraform validate
```

Generate Plan:

```bash
terraform plan
```

Apply Infrastructure:

```bash
terraform apply
```

Destroy Infrastructure:

```bash
terraform destroy
```

---

# 🚀 Deployment Workflow

### Step 1

Provision Infrastructure

```bash
terraform apply
```

### Step 2

Update Inventory

```ini
[servers]

server1 ansible_host=<PUBLIC_IP>
server2 ansible_host=<PUBLIC_IP>
server3 ansible_host=<PUBLIC_IP>
```

### Step 3

Verify Connectivity

```bash
ansible -i hosts.ini servers -m ping
```

### Step 4

Install Nginx

```bash
ansible-playbook -i hosts.ini install_nginx.yml
```

### Step 5

Install Docker

```bash
ansible-playbook -i hosts.ini install_docker.yml
```

---

# 🔥 Useful Commands

```bash
ansible all -m ping

ansible all -m setup

ansible server1 -a "free -h"

ansible server1 -a "df -h"

ansible server1 -a "cat /etc/os-release"

ansible server1 -b -a "docker ps"
```

---

# 📚 Skills Demonstrated

* Terraform
* Ansible
* AWS EC2
* Docker
* Nginx
* Linux Administration
* Infrastructure as Code
* Configuration Management
* SSH Automation
* DevOps Practices

---

# 🤝 Contributing

Fork this repository and submit Pull Requests.

```bash
git clone https://github.com/your-username/terraform-ansible.git
```

---

# ⭐ Support

If you found this project useful, don't forget to star the repository.

---

## 👨‍💻 Author

**Md Dilnawaz**

DevOps | AWS | Terraform | Ansible | Docker | Linux

### Connect With Me

* GitHub: https://github.com/your-username
* LinkedIn: https://linkedin.com/in/your-profile

---

### 🚀 "Automate Everything That Can Be Automated."
