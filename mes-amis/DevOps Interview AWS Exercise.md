# DevOps AWS Exercise

At Mon Ami we use Terraform to manage our AWS assets and Github Actions config. The purpose of this exercise is to demonstrate Terraform and AWS skills as well as proficiency in leveraging AI to speed up delivery.

The goal of the exercise is not necessarily to complete every task, but to demonstrate that you understand the process and know how to approach it effectively.

## Scenario

You have been given a Sinatra app in a Github account and have credentials to an empty AWS account. Your goal is to Terraform an AWS environment from zero, to a healthy application behind a load balancer with deployments from Github Actions on merge to main.

[https://github.com/mes-amis/devops-terraform-exercise](https://github.com/mes-amis/devops-terraform-exercise)

### Getting Started

### Prior to the live coding exercise you can setup your Terraform state S3 backend so everything is ready to use.

You may use Claude Code, Codex or whatever your favorite LLM tools are to complete the task. You should make sure any generated code reflects your preferences and sensibilities. We all use AI tools to create code, but we’re responsible for understanding and maintaining what we make.

### TODOs

- [x] ~~Terraform state managed in an S3 bucket with no public access~~
- [x] ~~Private Subnet hosting DB and Application servers~~
- [x] ~~Public Subnet for load balancers~~
- [x] ~~RDS Postgres DB connected to the application (no schema needed)~~
- [x] ~~ECS Cluster to host the application server~~
- [x] ~~ECR to host built application images~~
- [x] ~~Github Actions for CI and Deployment~~
