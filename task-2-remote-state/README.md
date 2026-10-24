# Task 2 — Remote State and Locking

## Configuration

I configured an Amazon S3 backend to store Terraform state remotely and a DynamoDB table to coordinate state locking.

The S3 backend configuration specifies the bucket, state-file key, AWS region, encryption, and DynamoDB locking table. I also enabled S3 bucket versioning to help recover previous versions of the state file.

## What happens with local state?

When Terraform uses local state, the state file is stored on the machine running Terraform. If two team members work from separate local copies and run `terraform apply` at the same time, their operations do not share a common state lock.

Both users may calculate changes based on outdated state, potentially creating conflicting changes, duplicate resources, or inconsistent state information. Terraform's local locking does not coordinate independent local state files across different machines.

## How does the remote backend help?

With the S3 backend, both team members use the same remote state file. DynamoDB provides a shared locking mechanism so that only one Terraform operation can hold the state lock at a time.

When one operation holds the lock, another operation attempting to acquire the same lock must wait or fail rather than proceed concurrently. Terraform releases the lock when the operation finishes normally.

This reduces the risk of concurrent state modifications and inconsistent state information.

