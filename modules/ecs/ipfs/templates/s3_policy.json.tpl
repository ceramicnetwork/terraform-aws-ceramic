{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "readwrite",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Effect": "Allow",
      "Resource": [
          "${resource}/${directory}",
          "${resource}/${directory}/*"
      ]
    },
    {
      "Sid": "readonly",
      "Action": [
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
          "${resource}"
      ]
    }
  ]
}
