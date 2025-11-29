# ADR-007: Subnet Architecture and Design

## 1. Status
Implemented

## 2. Context
The infrastructure for this capstone project must support a secure, scalable, and highly available web application architecture.  
Key AWS components include VPC, ALB, Auto Scaling Group (ASG), EC2, NAT Gateways, and RDS.  
To ensure security and reliability, the VPC network must be divided into logical subnet tiers and distributed across at least two Availability Zones (AZs) in the ap-south-1 region.

A flat single-subnet VPC would fail to meet:
- High availability requirements 
- Internet isolation for backend tiers
- NAT routing design
- RDS Subnet Group requirements
- MOdular Terraform Design Patterns

Therefore, a structured subnet architecture is required.

--------------------------------------------------------------------------------------------------------------------------------------------

## 3. Descion
A ##3-tier subnet architecture spread across 2 Availability Zones## has been selected Each tier is isolated and supports specific components:

### **Tier 1 - Public Subnets**
- Hosts: ALB, NAT Gateways
- Allows public internet access
- 'map_public_ip_on_launch = true'
- connected to Internet Gateway (IGW)

### **Tier 2 - Private App Subnets**
- Hosts: EC2 instance in ASG
- No Public IPs allowed
- Outbound internet only via NAT Gateway
- Inbound only from ALB

### **Tier 3 - Private DB Subnets**
- Hosts: RDS (Primary + Replica)
- Fully isolated - no Internet/NAT access
- Inbound only from APP tier
- Required for RDS Subnet Group

Subnets are created using Terraform's 'cidrsubnet()' function to derive '/24' blocks from the VPC '/16' in a predictable, scalable pattern.

CIDR Allocation:

| Tier   | Availability Zone 1 | Availability Zone 2 |
------------------------------------------------------
|Public  |      10.0.0.0/24    |    10.0.1.0/24      |
|APP     |      10.0.2.0/24    |    10.0.3.0/24      |
|DATABASE|      10.0.4.0/24    |    10.0.5.0/24      |

--------------------------------------------------------------------------------------------------------------------------------------------

## 4. Rationale
This Design aligns with AWS Well-Arthitected Framework and Industry best Practices:

### ✔ High Availability
Subnets span across two Availability Zones to Survive AZ-level Failures.

### Security Isolation
Public → App → DB tiers provide strict boundaries:
- Public tier   = Internet exposed
- APP tier      = Internal Compute
- Database tier = Fully isolated

### Predictable CIDR Generation
Using 'cidrsubnet(var.vpc_cidr, 8, index)':
- Prevents Manual CIDR mistakesd
- Ensures non-overlapping subnet ranges
- Scales Cleanly if additional tiers/Availability Zones are Needed

### Terraform Moduke Reusability
Seperating subnet logic into a dedicated module improves:
- Code Redability
- Reusability
- Tesing
- Future expansion

### RDS MUlti-AZ Requirement
RDS Subnet Groups require **at least 2 private DB subnets in a different Availability Zones**

--------------------------------------------------------------------------------------------------------------------------------------------

## 5. Alternatives Considered

### **A. Single-Tier Flat Subnet**
Rejected - Fails Isolated, no NAT seperation, no DB isolation.

### **B. Hardcoded CIDRs**
Rejected - error-prone and not scalable.

### **C. One Public + One Private Subnet**
Rejected - no Multi-AZ HA; RDS Subnet Group limitations.

## 6. Consequences

### **Positive**
- Highly secure network segmentation
- Supports full web-tier → app-tier → db-tier design
- Predictable routing for ALB + NAT + RDS
- Minimizes blast radius in failures
- Fits clean Terraform Modules Architecture

### **Negative**
- Sligehtly more complex routing configuration
- Multiple NAT Gateways increase cost

## 8. Conclusion
This subnet arthitecture provides the necessary security, high availability, scalability, and modularity required for this project. It aligns with the AWS best Practices, supports all application components, and prepares the environment for the further networking steps such as Internet Gateway, NAT Gateway and route. 