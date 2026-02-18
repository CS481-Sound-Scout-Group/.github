# Sprint 3 – Backend Infrastructure & Database Integration

## Overview

Sprint 3 focused on deploying and securing the backend database infrastructure in AWS, aligning networking components, and verifying application-to-database connectivity.

---

## 1. VPC Alignment

All appropriate resources were moved and verified within the correct VPC to ensure proper internal communication and isolation.

### Actions Completed
- Confirmed EC2 instance exists in the project VPC.
- Deployed RDS instance inside the same VPC.
- Added tables to databse
- Verified subnet alignment between EC2 and RDS.
- Ensured database is not publicly accessible.

### Result
EC2 and RDS communicate securely within a private VPC environment.

---

## 2. Security Group Configuration

Proper security boundaries were implemented between backend and database services.

### Backend Security Group
- Allows SSH (restricted to developer IPs)
- Allows application traffic (as needed)
- Assigned to EC2 instance

### RDS Security Group
- Allows PostgreSQL (port 5432)
- Source restricted to backend EC2 security group only
- No public (0.0.0.0/0) access permitted

---

## 3. IAM Role Configuration

IAM roles were configured to support secure multi-user collaboration and secrets access.

### Actions Completed
- IAM users for all team members were created.
- Assigned appropriate roles 
- Updated EC2 IAM role to allow:
  - `secretsmanager:GetSecretValue`

---

## 4. RDS Provisioning

A managed PostgreSQL database was deployed.

### Configuration
- Engine: PostgreSQL
- Deployment: Single-AZ (cost-efficient)
- Storage: 20 GiB (gp3)
- Public Access: Disabled
- Database Name: `soundscoutdb`
- Credentials stored in AWS Secrets Manager


## 5. Database Schema Implementation

Core relational tables were created in RDS.

### Tables Created
- `supported_cities`
- `classifiable_sounds`
- `audio_sources`
- `classification_results`

### Features
- Primary keys
- Foreign keys
- Constraints
- Indexes for query performance
