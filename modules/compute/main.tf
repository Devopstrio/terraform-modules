variable "instance_name" {
  description = "Name of the instance"
  type        = string
}

variable "instance_type" {
  description = "Type of the instance"
  type        = string
  default     = "t3.medium"
}

variable "subnet_id" {
  description = "Subnet ID to deploy the instance"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the instance"
  type        = map(string)
  default     = {}
}

resource "aws_instance" "this" {
  ami           = "ami-0c55b159cbfafe1f0" # Mock AMI
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = merge(
    {
      Name = var.instance_name
    },
    var.tags
  )
}

output "instance_id" {
  value = aws_instance.this.id
}

output "private_ip" {
  value = aws_instance.this.private_ip
}
