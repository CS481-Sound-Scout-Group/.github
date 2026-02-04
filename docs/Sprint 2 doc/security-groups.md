# Security Groups (Sprint 2)

## Purpose
This document defines the AWS security groups used to enforce network boundaries for the Sound Scout project.
The rules defined here reflect the current development setup and will be tightened in future sprints.

---

## Security Group: backend-ec2-sg

### Description
Security group for the backend EC2 service.  
Allows controlled inbound access for development and outbound access to required AWS services.

### Inbound Rules
- SSH (22) — Source: developer IP only  
- HTTP (80) — Source: 0.0.0.0/0 (temporary, development only)

### Outbound Rules
- All traffic allowed (default)

---

## Security Group: aurora-db-sg

### Description
Security group protecting the PostgreSQL database.
Restricts database access to backend services only.

### Inbound Rules
- PostgreSQL (5432) — Source: `backend-ec2-sg`

### Outbound Rules
- Default (no public outbound access required)

---

## Architecture Mapping
Traffic flow enforced by these security groups:

Cloudflare / API Gateway  
→ Backend EC2 (`backend-ec2-sg`)  
→ Aurora PostgreSQL (`aurora-db-sg`)

The database is not directly accessible from the internet or client devices.

---

## Assumptions
- Single backend EC2 instance
- PostgreSQL database engine
- All resources reside in the same VPC
- Development-only access rules for Sprint 2

---

## Deferred Work
- Aurora database provisioning
- Credential and secret management
- TLS enforcement
- Further restriction of inbound rules
