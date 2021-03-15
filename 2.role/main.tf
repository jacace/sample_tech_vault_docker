resource "aws_iam_role" "kinesis_ro_role" {
  name                = "kinesis_ro_role"
  assume_role_policy  = "${file("assumerolepolicy-akatrustrelationship.json")}"
  managed_policy_arns = [aws_iam_policy.arnrolepolicy.arn]
}

resource "aws_iam_policy" "arnrolepolicy" {
  name = "arnrolepolicy"

  policy = jsonencode({
    "Version": "2012-10-17"
    "Statement": [
        {
            "Effect": "Allow"
            "Action": [
                "kinesis:GetRecords"                
            ],
            "Resource": [
                "arn:aws:kinesis:us-east-1:<ACC_NUM>:stream/test_stream"
            ]
        }    
    ]
  })
}