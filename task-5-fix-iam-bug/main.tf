
# Account B: Trust policy for roleC
data "aws_iam_policy_document" "roleC_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"

      # Correct: roleB is an IAM role, not a user
      identifiers = [
        "arn:aws:iam::000000000000:role/roleB"
      ]
    }
  }
}

resource "aws_iam_role" "roleC" {
  name               = "roleC"
  assume_role_policy = data.aws_iam_policy_document.roleC_trust.json
}

# Account B: Give roleC access to one specific S3 bucket
data "aws_iam_policy_document" "roleC_s3_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = [
      "arn:aws:s3:::arrise-assessment-bucket",
      "arn:aws:s3:::arrise-assessment-bucket/*"
    ]
  }
}

resource "aws_iam_role_policy" "roleC_s3" {
  name   = "roleC-s3-access"
  role   = aws_iam_role.roleC.id
  policy = data.aws_iam_policy_document.roleC_s3_policy.json
}
