## Task 4 — Least-Privilege IAM Policy for CI

### Objective

The custom IAM policy for the `ci` user allows the CI/CD pipeline to push Docker images to one ECR repository, register and deploy ECS task definitions to one ECS service, and read build artifacts from one S3 bucket.

### Permissions Granted

1. **ECR image push:** Allows the pipeline to authenticate with ECR and upload image layers and manifests to the specified repository. `ecr:GetAuthorizationToken` uses `Resource: "*"` because this authorization action does not support repository-level resource scoping. The remaining ECR permissions are restricted to the specified repository.

2. **ECS deployment:** Allows the pipeline to register and inspect task definitions for the specified application family and update and inspect the specified ECS service.

3. **IAM PassRole:** Allows the pipeline to pass only the application's task role and execution role to ECS tasks. The `iam:PassedToService` condition restricts this delegation to the ECS tasks service.

4. **S3 build artifacts:** Allows the pipeline to list the specified bucket and retrieve objects from it. It does not grant permission to upload, overwrite, or delete artifacts.

### Permissions Deliberately Excluded

- No `ecr:*` permission across all repositories.
- No permission to delete ECR repositories or images.
- No permission to create or delete ECS clusters or services.
- No permission to update unrelated ECS services.
- No unrestricted `iam:PassRole` or IAM administration permissions.
- No S3 write, delete, or access to unrelated buckets.
- No broad administrator or PowerUser managed policy.

