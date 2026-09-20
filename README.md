# AWS HealthCheck

A URL uptime monitoring service

## What it does

- Add a URL to monitor via a REST API (`POST /monitors`)
- The system periodically checks each monitored URL's availability
- Records status code, response time, success/failure, and failure reason
- Exposes current health status via an API
- Generates alerts/logs on failure

## Tech stack

Python · FastAPI · Docker · Terraform · AWS (ECS/Fargate, ALB, DynamoDB,
CloudWatch, EventBridge, IAM) · GitHub Actions
# CI test
