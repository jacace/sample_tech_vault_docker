resource "aws_iam_user" "vault_user" {
  name = "vault_user"
}

resource "aws_iam_access_key" "vault_user" {
  user = aws_iam_user.vault_user.name
}

resource "aws_iam_policy" "assume_kinesis-role_policy" {
  name        = "assume_kinesis-role_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "sts:AssumeRole",
        Resource = "arn:aws:iam::<ACC_NUM>:role/kinesis_ro_role"
      }      
    ]
  })
}
 
resource "aws_iam_user_policy_attachment" "assume_kinesis-role_policy" {
  user       = aws_iam_user.vault_user.name
  policy_arn = aws_iam_policy.assume_kinesis-role_policy.arn
}
