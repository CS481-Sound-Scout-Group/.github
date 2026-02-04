# Database Design (Sprint 2)

## Purpose
This document declares the intended database design and access boundaries for the Sound Scout project.
The database is defined in this sprint but is not fully provisioned yet.

## Database Engine
- Engine: PostgreSQL
- Port: 5432

## Intended Usage
The database will store the results of sound classification.
All database access is restricted to backend services.

## Example Tables (High-Level)

### classification_results
Stores aggregated and derived sound classification outputs.
No raw or reconstructable audio data is retained.
- result_id
- label
- confidence
- model_version
- timestamp
- approximate_location


### devices
Registered microphone devices.
- device_id
- location
- status

## Access Pattern
- Backend EC2 service reads and writes to the database
- No direct access from clients, IoT devices, or ML jobs

## Sprint 2 Note
This sprint focuses on defining database intent and security boundaries.
Database advancment and live connections are deferred to a later sprint.
