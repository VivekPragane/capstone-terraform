# ADR-008: Routing Setup with Internet Gateway and Public Route Table

## Status
Implemented

## Date
04-12-2025

## Context
In Phase 2 Step 3 of the Capstone project, I needed to enable internet access for the public subnet inside my VPC.
Until now, I only had a VPC and Subnet created, but nothing in the design could to the internet.

For Example:
- EC2 instance in public subnet would need to download packages (yum, dnf, apt)
- Future resources like ALB or Bastion host require public connectivity
- Private subnet (App + DB) must stay isolated and **must not** get internet directly

To achive this safely, AWS uses two main Components:
1. **Internet Gateway (IGW)** - the "internet door" for the VPC
2. **Public Route Table** - Controls which subnets are allowed to use that door

So the goal of this step was to create and connect these two components properly.

--------------------------------------------------------------------------------------------------------------------------------------------

## Problem
Without an Internet Gateway and route table:
- Public subnets cannot reach the internet
- The architecture cannot support ALB or a Bastion host in the future
- EC2 instance won't be able to install software packages
- There is no seperation between public and private routing

We needed:
1. - A way for **Public Subnet** to connet to the internet
2. - A way to keep **Private Subnet safe and isolated**
3. A clear and AWS-recommended routing structure

--------------------------------------------------------------------------------------------------------------------------------------------

## Decision
I decided to:
1. **Create an Internet Gateway (IGW)**
    - Attach it to the VPC
    - This gives the VPC a Connection to the internet

2. **Create a Public Route Table**
    - Add a route '0.0.0.0/0 → IGW'
    - This means "Send all internet traffic to IGW"

3. **Associate only the Public Subnets with this Public Route Table**
    - dev-public-ap-south-1a
    - dev-public-ap-south-1b

4. **Did not associated private subents with this route table**
    - They stay on the default main route table (no internet access)

This design follows AWS best Pratices for Networking and Security.

--------------------------------------------------------------------------------------------------------------------------------------------

## Rational (Why we Chose this)
### 1. Clear Separtion of the Public vs Private networks
Public subnets = internet access
Private Subents = no internet access

This is the most important security principle in AWS Design.

### 2. Internet Gateway is free
There is no Cost to create or attach an IGW

### 3. Route Tables are also free
SO this step does not increse billing.

### 4. Allows future components to work correctly
- ALB requires public subnets with IGW routing
- Bastian host may require public internet
- NAT Gateway (Later) also depends on proper routing

### 5. Beginner-friendly, simple, predictable architecture the structure is clean:
- One route table for publuc 
- One Default Route table for private

--------------------------------------------------------------------------------------------------------------------------------------------

## Alternate Considered 
### 1. Put everything in public subnets
Rejected Because:
- APP servers and DB would become publicly exposed
- Major Security Risk
- Not recommanded by AWS

### 2. Use Main Route Table for Everything
Rejected Because:
- Harder to manage
- Harder to Secure
- No Logical Separation
- Can accidentlly expose private resources

### 3. Skip IGW Entirely
Rejected Because:
- No internet for public subnets
- ALB / Bastion / EC2 install would Fail

--------------------------------------------------------------------------------------------------------------------------------------------

## Consequences

### Positive
- Public Subnets now have proper Intenet Access
- Private Subnets remain secure
- Architecture is ready for future phases (NAT, ALB, ASG)
- Follows AWS Well-Architected Guidelines
- Zero Cost Resources Used

### Negative
- Extra attention is required to ensure the correct subnets are asoociated with the correct route table
- Misabeling subnets can cause confusion

--------------------------------------------------------------------------------------------------------------------------------------------

## Implementation Details
The routing resources are implemented inside the Terraform Modules:

The modules Creates:
- 'aws_internet_gateway.this'
- 'aws_route_table.public'
- 'aws_route.public_default_route'
- 'aws_route_table_association.public_assoc'

And is used in the route module like this:

------Hashicorp Language-----------------------------------

module "routing" {
    source            = "./modules/routing"
    vpc_id            = modules.vpc.vpc_id
    public_subnet_ids = modules.subnets.public_subnet_ids
}