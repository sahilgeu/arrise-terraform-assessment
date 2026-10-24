## Task 5 — Bug Fixes and Explanation

### Issue 1: Incorrect Principal Identifier in Trust Policy

**Root Cause:** The identifier in `data.aws_iam_policy_document.roleC_trust` was incorrectly configured as:

`arn:aws:iam::000000000000:user/roleB`

**Explanation:** `roleB` is an IAM role in Account A, not an IAM user. IAM role ARNs follow the format `arn:aws:iam::<ACCOUNT_ID>:role/<ROLE_NAME>`, whereas IAM user ARNs use `user/<USER_NAME>`. The incorrect principal did not identify the intended role, preventing the trust policy from authorizing the intended cross-account role assumption.

**Fix:** Updated the principal identifier to:

`arn:aws:iam::000000000000:role/roleB`

Additionally, `roleB` must have an identity-based policy allowing `sts:AssumeRole` on the specific `roleC` ARN in Account B. The trust policy in Account B and the identity policy in Account A must both permit the role assumption.

### Issue 2: Violation of Least Privilege and the Single-Bucket Requirement

**Root Cause:** The `aws_iam_role_policy.roleC_s3` policy allowed `s3:*` with `Resource = "*"`.

**Explanation:** The assignment requires `roleC` to have full access to one specific S3 bucket. Using `Resource = "*"` grants unnecessarily broad S3 permissions across resources, subject to other applicable policies and restrictions.

S3 bucket-level actions, such as `s3:ListBucket`, use the bucket ARN:

`arn:aws:s3:::my-target-bucket`

Object-level actions, such as `s3:GetObject` and `s3:PutObject`, use the object ARN:

`arn:aws:s3:::my-target-bucket/*`

**Fix:** Restricted the policy resources to these two ARNs:

- `arn:aws:s3:::my-target-bucket`
- `arn:aws:s3:::my-target-bucket/*`

This scopes the policy to the specified bucket and its objects instead of all S3 resources. Replace `my-target-bucket` with the actual bucket name before deployment.

