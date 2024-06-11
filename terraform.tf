terraform {
  required_version = ">= 1.8.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.40"
    }
    null = {
      source  = "hashicorp/null"
      version = ">=3.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.5.1"
    }
    http = {
      source  = "terraform-aws-modules/http"
      version = "2.4.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.20"


    }
  }
  /*
   backend "s3" {
    # Replace this with your bucket name!
    bucket         = "rocon-eks-tf"
    #key            = "ekswordpress/terraform.tfstate"
    key             = "deveks/terraform.tfstate"
    region         = "us-west-2"

}
*/
}
provider "aws" {
  region = var.aws_region

}
