# 🧪 DevOps Lab – Infrastructure & Platform Engineering Playground

Welcome to my personal DevOps lab — a modular, fully-automated, cloud-ready environment where I design, build, and test modern infrastructure using best practices in Platform Engineering and DevOps.

---

## 🚀 Purpose

This lab helps me:

- Practice **Infrastructure as Code (IaC)** using Terraform
- Automate AWS provisioning (RDS, networking, IAM, etc.)
- Explore **Kubernetes** setups and monitoring
- Test **CI/CD pipelines**, GitOps, and alerting
- Keep my DevOps tools portable on an external SSD

Everything here is structured for **reusability**, **clarity**, and **zero-cost local testing** — but can be adapted for production use.

---

## 🛠️ Tools & Tech Stack

| Category        | Stack / Tools                            |
|----------------|-------------------------------------------|
| ☁️ Cloud        | AWS (via Free Tier + SSO)                |
| 📜 IaC          | Terraform                                 |
| 🧩 K8s          | Minikube, kubectl, Helm                  |
| 📊 Monitoring   | Prometheus, Grafana, Alertmanager        |
| 🧪 Automation   | GitHub Actions, YAML Workflows            |
| 🔐 Auth         | AWS SSO, IAM Roles, Profiles              |
| 🧰 Extras       | Oh-My-Zsh, `.devopsrc`, CLI aliases       |

---

## 📦 Structure

```bash
devops-lab/
├── terraform/         # All Terraform modules and environments
├── kubernetes/        # K8s manifests and Helm charts
├── monitoring/        # Prometheus/Grafana setup
├── workflows/         # GitHub Actions, CI/CD configs
├── scripts/           # Utility & automation scripts
└── .devopsrc          # DevOps shell config (autoloaded)

⚙️ Local Setup

This lab is powered by a portable external SSD workspace. If you want to replicate the setup:

# Clone this repo
git clone https://github.com/temitayocharles/devops-lab.git

# Source the custom environment
source .devopsrc
Make sure you’ve got:

AWS CLI configured (aws configure sso)
Terraform installed (brew install terraform)
Kubernetes tools like kubectl and minikube
Helm, Git, and optionally direnv or asdf for tool versioning
🧠 Learning in Public

This project is constantly evolving — I treat it as a living, breathing platform to explore new ideas and best practices in cloud engineering.

If you're a DevOps learner too, feel free to fork, explore, and build your own lab environment.

📬 Contact

💼 LinkedIn
🧪 Profile README
☕ Buy me a coffee? (just kidding... unless?)
“If you can’t automate it, you don’t own it.”

---

### ✅ Instructions

1. Create or overwrite `README.md` in your `devops-lab` repo:

```bash
cd /Volumes/DevOpsSSD/projects/devops-lab
nano README.md  # or use your favorite editor

