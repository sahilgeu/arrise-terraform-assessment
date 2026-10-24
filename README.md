# Arrise Terraform Assessment

This repository contains solutions for the Arrise Terraform technical assessment. Each task is organized into its respective folder and demonstrates modularity, security best practices, state management, and IAM policies.

---

## 📁 Repository Structure

* **`task-1-ec2/`**: Contains a reusable EC2 module (`modules/ec2`) and root module deployment.
* **`task-2-remote-state/`**: Demonstrates remote backend setup using S3 and DynamoDB for state locking.
* **`task-3-multi-account-iam/`**: Configures multi-account IAM roles, trust relationships, and policy attachments.
* **`task-4-least-privilege/`**: Implements fine-grained, least-privilege IAM policies tailored to specific service requirements.
* **`task-5-fix-iam-bug/`**: Highlights the identification and fix for a misconfigured IAM policy/role issue.
* **`notes.md`**: Contains architectural decisions, assumptions, and troubleshooting explanations for Task 5.

---



