# Jenkins Integration

This repository includes a Jenkins CI/CD pipeline for continuous deployment.

## Pipeline Overview

The `Jenkinsfile` defines the following stages:

| Stage    | Description                                      |
|----------|--------------------------------------------------|
| Checkout | Checks out the source code from SCM              |
| Build    | Compiles the application and installs dependencies |
| Test     | Runs the test suite and publishes results         |
| Deploy   | Deploys to **staging** or **production** based on branch |

The **Deploy** stage is triggered automatically for the `main` (production) and `staging` branches.

## Getting Started

### Prerequisites

- Jenkins 2.x or later with the **Pipeline** plugin installed
- A Jenkins agent with Bash available

### Setting Up the Jenkins Job

1. Create a new **Pipeline** job in Jenkins.
2. Under **Pipeline**, select **Pipeline script from SCM**.
3. Point it at this repository and set the **Script Path** to `Jenkinsfile`.
4. Save and run the job.

## Scripts

| Script               | Purpose                     |
|----------------------|-----------------------------|
| `scripts/build.sh`   | Build / dependency install  |
| `scripts/test.sh`    | Run tests & generate report |
| `scripts/deploy.sh`  | Deploy to target environment |

## Branch Strategy

| Branch    | Deploy Target |
|-----------|---------------|
| `main`    | production    |
| `staging` | staging       |
| others    | no deploy     |
