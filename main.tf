module "dev-infra" {
    source = "./infra"
    env = "dev"
    bucket_name = "my-dev-bucket-002211"
    instance_count = 1
    instance_type = "t3.micro"
    ec2_ami = "ami-0244c35c41029d9d1"
    hash_key = "StudentID"
    dynamo_name = "my-dynamo-table-4548"
}
module "prd-infra" {
    source = "./infra"
    env = "prd"
    bucket_name = "my-prd-bucket-002211"
    instance_count = 2
    instance_type = "t3.small"
    ec2_ami = "ami-0244c35c41029d9d1"
    hash_key = "StudentID"
    dynamo_name = "my-dynamo-table-4548"
}
module "stg-infra" {
    source = "./infra"
    env = "stg"
    bucket_name = "my-stg-bucket-002211"
    instance_count = 1
    instance_type = "c7i-flex.large"
    ec2_ami = "ami-0244c35c41029d9d1"
    hash_key = "StudentID"
    dynamo_name = "my-dynamo-table-4548"
}