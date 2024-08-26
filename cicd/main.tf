module "jenkins_master" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "tf-jenkins-master"

  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-092ff5452a39fc34b"]
  subnet_id              = "subnet-0d295cd04ccf27520"
  #ami                    = data.aws_ami.ami_info.id
  ami                    = "ami-041e2ea9402c46c32"
  user_data              = file("install_jenkins_master.sh")

  tags = {
    Name   = "Jenkins-Master"
  }
}

module "jenkins_agent" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "tf-jenkins-agent"

  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-092ff5452a39fc34b"]
  subnet_id              = "subnet-0d295cd04ccf27520"
  #ami                    = data.aws_ami.ami_info.id
  ami                    = "ami-041e2ea9402c46c32"
  user_data              = file("install_jenkins_agent.sh")

  tags = {
    Name   = "Jenkins-Agent"
  }
}


module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"
  zone_name = var.zone_name

records = [
  {
    name = "jenkins-master"
    type = "A"
    ttl  = 1
    records = [
      module.jenkins_master.public_ip
    ]
    allow_overwrite = true
  },
   {
    name = "jenkins-agent"
    type = "A"
    ttl  = 1
    records = [
      module.jenkins_agent.private_ip
    ]
    allow_overwrite = true
  }

]
}

# module "records" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 2.0"

#   zone_name = var.zone_name

#   records = [
#     {
#       name    = "jenkins"
#       type    = "A"
#       ttl     = 1
#       records = [
#         module.jenkins.public_ip
#       ]
#       allow_overwrite = true
#     },
#     {
#       name    = "jenkins-agent"
#       type    = "A"
#       ttl     = 1
#       records = [
#         module.jenkins_agent.private_ip
#       ]
#       allow_overwrite = true
#     }
        
#   ]

# }
  















