# Configure AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Change if you prefer another region
}

#Variables for easy customization
variable "key_name" {
  description = "Your AWS key pair name"
  type        = string
  default     = "ben-keypair"
}

# Ubuntu Instance for DataSys+ (Database work)
resource "aws_instance" "datasys_ubuntu" {
  ami           = "ami-0866a3c8686eaeeba"  # Ubuntu 24.04 LTS
  instance_type = "t3.medium"               # Enough for DB work
  key_name      = var.key_name

  tags = {
    Name        = "DataSys-Lab"
    Purpose     = "Database Systems Class"
    ManagedBy   = "Terraform"
  }

  # Start stopped to save costs - you'll start it when needed
  instance_initiated_shutdown_behavior = "stop"
}

# Windows Server Instance for Windows Server Admin
#resource "aws_instance" "windows_server" {
#  ami           = "ami-0f9c44e98edf38a2b"  # Windows Server 2022
#  instance_type = "t3.medium"               # Windows needs more resources
#  key_name      = var.key_name

#  tags = {
#    Name        = "WindowsServer-Lab"
#    Purpose     = "Windows Server Admin Class"
#    ManagedBy   = "Terraform"
#  }

#  # Get Windows password with your key pair
#  get_password_data = true

#  instance_initiated_shutdown_behavior = "stop"
#}

# RDS MySQL Instance for DataSys+ (Optional - uncomment if needed)
# resource "aws_db_instance" "datasys_db" {
#   identifier        = "datasys-mysql"
#   engine            = "mysql"
#   engine_version    = "8.0"
#   instance_class    = "db.t3.micro"  # Free tier eligible
#   allocated_storage = 20
#   
#   db_name  = "classdb"
#   username = "admin"
#   password = "ChangeMe123!"  # CHANGE THIS!
#   
#   skip_final_snapshot = true  # For lab purposes
#   
#   tags = {
#     Name      = "DataSys-RDS"
#     ManagedBy = "Terraform"
#   }
# }

# Outputs - Shows you important info after deployment
output "ubuntu_public_ip" {
  description = "Public IP of Ubuntu instance"
  value       = aws_instance.datasys_ubuntu.public_ip
}

#output "windows_public_ip" {
#  description = "Public IP of Windows Server instance"
#  value       = aws_instance.windows_server.public_ip
# }

 output "ubuntu_instance_id" {
  value = aws_instance.datasys_ubuntu.id
 }

#output "windows_instance_id" {
#  value = aws_instance.windows_server.id
# }
