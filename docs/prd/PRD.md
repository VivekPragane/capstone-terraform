# Product Requirements Document (PRD)
## Capstone Terraform Project – AWS Production-Grade Infrastructure

---

## 1. Overview

This project aims to design and implement a **production-grade AWS cloud infrastructure** using **Terraform**, following **industry best practices** for networking, security, scalability, cost optimization, and maintainability.

The project focuses on **infrastructure design, automation, and decision-making**, rather than application development.

This project was built as part of my personal capstone to deeply understand AWS and Terraform in a real-world context.

---

## 2. Problem Statement

Modern applications require:
- Secure and isolated networking
- Scalable compute resources
- Highly available architectures
- Cost-efficient cloud usage
- Infrastructure that can be reproduced reliably

Many beginner projects focus only on resource creation and ignore:
- Cost control
- Security boundaries
- Architectural decisions
- Documentation and reasoning

This project addresses those gaps by demonstrating **how a real-world DevOps / Cloud Engineer would design infrastructure**, not just deploy it.

---

## 3. Goals

### Primary Goals
- Build a **modular, reusable Terraform codebase**
- Follow **AWS best practices** for networking and security
- Demonstrate **scalability design** using ALB and ASG
- Maintain **cost awareness** using a write-only strategy for expensive services
- Provide **clear documentation** for interview and learning purposes

### Secondary Goals
- Improve Terraform structuring skills
- Practice architectural decision-making (ADRs)
- Prepare for technical interviews and real-world DevOps roles

### Personal Goals
- Prepare myself for real-world DevOps interviews and production environments.

---

## 4. Non-Goals

The following are **explicitly out of scope**:
- Application development beyond a basic EC2 web server
- Production traffic handling
- CI/CD pipeline execution (design only)
- Long-running paid AWS services

---

## 5. Target Users / Personas

### 1️⃣ Cloud / DevOps Engineer (Primary)
- Wants to understand AWS infrastructure design
- Needs hands-on Terraform experience
- Prepares for interviews and real projects

### 2️⃣ Interviewer / Reviewer
- Evaluates architectural thinking
- Reviews Terraform code quality
- Assesses cost awareness and security practices

---

## 6. Functional Requirements

### Infrastructure
- A custom VPC with a defined CIDR range
- Public, private application, and private database subnets
- Internet Gateway and routing for public access
- NAT Gateway design for private outbound traffic
- Security Groups enforcing least-privilege access
- EC2 instance for application workload
- Application Load Balancer design
- Auto Scaling Group design
- RDS database design
- Monitoring and alerting design using CloudWatch and SNS

### Terraform
- Modular structure for each infrastructure component
- Remote backend using S3 and DynamoDB
- Clear input variables and outputs
- Environment-aware configuration

---

## 7. Non-Functional Requirements

- **Security:**  
  - No public database access  
  - Strict Security Group rules  
  - Private subnets for sensitive resources  

- **Scalability:**  
  - Horizontal scaling via Auto Scaling Group  
  - Load balancing using ALB  

- **Reliability:**  
  - Multi-AZ subnet design  
  - Stateless compute design  

- **Cost Optimization:**  
  - Paid services implemented as write-only  
  - Resources destroyed immediately after validation  
  - Minimal instance sizes for demos  

- **Maintainability:**  
  - Clean module boundaries  
  - Consistent naming conventions  
  - Well-documented decisions  

---

## 8. Success Metrics

The project is considered successful if:
- Terraform `plan` and `apply` work without errors
- Infrastructure design can be clearly explained
- Repository is easy to understand and navigate
- Interviewers can review architecture without running the code
- Cost remains minimal or zero after cleanup

---

## 9. Acceptance Criteria

- All infrastructure components are defined using Terraform
- Networking and security follow AWS best practices
- Expensive services are gated or write-only
- Documentation explains **why decisions were made**
- Screenshots are available for core infrastructure phases
- Code is modular and reusable

---

## 10. Risks and Mitigations

### Risk: Unexpected AWS Costs
**Mitigation:**  
- Use `-target` applies  
- Destroy resources immediately  
- Keep RDS, ASG, and Monitoring write-only  

### Risk: Over-Engineering
**Mitigation:**  
- Keep designs simple and explainable  
- Avoid unnecessary services  

### Risk: Misconfiguration
**Mitigation:**  
- Use Terraform validation  
- Clear variable definitions  
- Phase-wise implementation  

---

## 11. Assumptions

- Project is intended for **learning and demonstration**
- AWS Free Tier or minimal paid usage is available
- Reviewer understands Terraform and AWS basics
- Infrastructure will not be used for real production traffic

---

## 12. Future Enhancements

- CI/CD pipeline using GitHub Actions
- Blue-Green or Canary deployments
- WAF integration with ALB
- Centralized logging using CloudWatch Logs
- Secrets management using AWS Secrets Manager

---

## 13. Summary

This project demonstrates **how to think like a Cloud/DevOps Engineer**, not just how to deploy resources.  
It balances **technical implementation**, **security**, **cost control**, and **documentation**, making it suitable for interviews, learning, and future extension.

This project reflects my learning journey and practical understanding of cloud infrastructure.
---
