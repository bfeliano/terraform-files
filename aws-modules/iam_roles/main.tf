resource "aws_iam_role" "Task_Execution_Role" {
  name = "TaskExecutionRole"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameters",
                "ssm:GetParameter"
            ],
            "Resource": "arn:aws:ssm:*:AWSAccountNumber:parameter/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetSecretValue",
                "secretsmanager:ListSecrets"
            ],
            "Resource": "*"
        },
        {
            "Action": [
                "kms:Decrypt"
            ],
            "Resource": [
                "arn:aws:kms:us-east-1:AWSAccountNumber:key/*"
            ],
            "Effect": "Allow"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
        
    ]
})

  tags = {
    Environment = "production"
  }
}


resource "aws_iam_role" "STS_OIDC" {
  name = "StsOpenIdConnect"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "arn:aws:iam::AWSAccountNumber:role/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ecs:PutAttributes",
                "ecs:UpdateCluster",
                "ecs:ListAttributes",
                "ecs:ExecuteCommand",
                "ecs:UpdateContainerInstancesState",
                "ecs:StartTask",
                "ecs:RegisterContainerInstance",
                "ecs:DescribeTaskSets",
                "ecs:DescribeTaskDefinition",
                "ecs:SubmitAttachmentStateChanges",
                "ecs:CreateCapacityProvider",
                "ecs:ListServices",
                "ecs:Poll",
                "ecs:UpdateService",
                "ecs:DescribeCapacityProviders",
                "ecs:CreateService",
                "ecs:RunTask",
                "ecs:ListTasks",
                "ecs:RegisterTaskDefinition",
                "ecs:DescribeServices",
                "ecs:SubmitContainerStateChange",
                "ecs:DescribeContainerInstances",
                "ecs:DescribeTasks",
                "ecs:PutClusterCapacityProviders",
                "ecs:ListTaskDefinitions",
                "ecs:UpdateTaskSet",
                "ecs:CreateTaskSet",
                "ecs:ListClusters",
                "ecs:SubmitTaskStateChange",
                "ecs:DiscoverPollEndpoint",
                "ecs:UpdateClusterSettings",
                "ecs:CreateCluster",
                "ecs:UpdateCapacityProvider",
                "ecs:DescribeClusters",
                "ecs:ListAccountSettings",
                "ecs:ListTagsForResource",
                "ecs:StartTelemetrySession",
                "ecs:ListTaskDefinitionFamilies",
                "ecs:UpdateContainerAgent",
                "ecs:ListContainerInstances",
                "ecs:UpdateServicePrimaryTaskSet",
                "servicediscovery:GetNamespace",
                "servicediscovery:GetOperation",
                "servicediscovery:GetService",
                "servicediscovery:ListNamespaces",
                "servicediscovery:ListServices",
                "servicediscovery:UpdateService",
                "servicediscovery:CreatePrivateDnsNamespace",
                "servicediscovery:CreateService",
                "events:DescribeRule",
                "events:ListRuleNamesByTarget",
                "events:ListTargetsByRule",
                "events:PutRule",
                "events:PutTargets",
                "events:RemoveTargets",
                "iam:ListInstanceProfiles",
                "elasticloadbalancing:DescribeListeners",
                "elasticloadbalancing:DescribeLoadBalancers",
                "elasticloadbalancing:DescribeRules",
                "elasticloadbalancing:DescribeTargetGroups",
                "elasticfilesystem:DescribeAccessPoints",
                "elasticfilesystem:DescribeFileSystems",
                "elasticloadbalancing:CreateListener",
                "elasticloadbalancing:CreateLoadBalancer",
                "elasticloadbalancing:CreateRule",
                "elasticloadbalancing:CreateTargetGroup",
                "ec2:AssociateRouteTable",
                "ec2:AttachInternetGateway",
                "ec2:AuthorizeSecurityGroupIngress",
                "autoscaling:Describe*",
                "autoscaling:UpdateAutoScalingGroup",
                "autoscaling:CreateAutoScalingGroup",
                "autoscaling:CreateLaunchConfiguration",
                "application-autoscaling:DescribeScalableTargets",
                "application-autoscaling:DescribeScalingActivities",
                "application-autoscaling:DescribeScalingPolicies",
                "application-autoscaling:PutScalingPolicy",
                "application-autoscaling:RegisterScalableTarget"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ecr:PutImageTagMutability",
                "ecr:DescribeImageReplicationStatus",
                "ecr:ListTagsForResource",
                "ecr:UploadLayerPart",
                "ecr:BatchDeleteImage",
                "ecr:CreatePullThroughCacheRule",
                "ecr:ListImages",
                "ecr:BatchGetRepositoryScanningConfiguration",
                "ecr:GetRegistryScanningConfiguration",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:BatchCheckLayerAvailability",
                "ecr:ReplicateImage",
                "ecr:GetLifecyclePolicy",
                "ecr:GetRegistryPolicy",
                "ecr:PutLifecyclePolicy",
                "ecr:DescribeImageScanFindings",
                "ecr:GetLifecyclePolicyPreview",
                "ecr:DescribeRegistry",
                "ecr:PutImageScanningConfiguration",
                "ecr:GetDownloadUrlForLayer",
                "ecr:DescribePullThroughCacheRules",
                "ecr:GetAuthorizationToken",
                "ecr:PutImage",
                "ecr:BatchImportUpstreamImage",
                "ecr:BatchGetImage",
                "ecr:DescribeImages",
                "ecr:InitiateLayerUpload",
                "ecr:GetRepositoryPolicy"
            ],
            "Resource": "*"
        }
    ]
})

  tags = {
    Environment = "production"
  }
}



resource "aws_iam_openid_connect_provider" "default" {
  url = "https://api.bitbucket.org/2.0/workspaces/liqi-assets/pipelines-config/identity/oidc"

  client_id_list = [
    "ari:cloud:bitbucket::workspace/aae70906-76bf-468b-be56-ad742532aab8",
  ]

  thumbprint_list = []
}