data "tls_certificate" "tfc_certificate" {
  url = "https://${var.tfc_hostname}"
}

# Bootrapped IAM OIDC Provider, created in Cloud Factory repository.
data "aws_iam_openid_connect_provider" "tfc_provider" {
  url = data.tls_certificate.tfc_certificate.url
}

resource "aws_iam_role" "tfc_ct_role" {
  name                  = "tfc-ct-role"
  force_detach_policies = true

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Effect": "Allow",
     "Principal": {
       "Federated": "${data.aws_iam_openid_connect_provider.tfc_provider.arn}"
     },
     "Action": "sts:AssumeRoleWithWebIdentity",
     "Condition": {
       "StringEquals": {
         "${var.tfc_hostname}:aud": "${one(data.aws_iam_openid_connect_provider.tfc_provider.client_id_list)}"
       },
       "StringLike": {
         "${var.tfc_hostname}:sub": "organization:${var.tfc_organisation_name}:project:${var.tfc_project_name}:workspace:${var.tfc_workspace_name}:run_phase:*"
         
       }
     }
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "tfc_ct_role_superpowers" {
  role       = aws_iam_role.tfc_ct_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
