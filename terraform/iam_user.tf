

resource aws_iam_user "UserA" {
    name = "UserA"
}

resource aws_iam_user "UserB" {
    name = "UserB"
}

resource "aws_iam_access_key" "UserA" {
  user = aws_iam_user.UserA.name
}

resource "aws_iam_access_key" "UserB" {
  user = aws_iam_user.UserB.name
}


resource "aws_iam_user_policy" "UserA_Policy" {
  name = "UserA_Policy"
  user = aws_iam_user.UserA.name

  policy = data.template_file.iam_user_a_access_role_policy.rendered
}

resource "aws_iam_user_policy" "UserB_Policy" {
  name = "UserB_Policy"
  user = aws_iam_user.UserB.name

  policy = data.template_file.iam_user_b_access_role_policy.rendered
}