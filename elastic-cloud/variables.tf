#AWS
variable "aws_resource_name" {
    type        = string
    description = "AWS objects name"
    default     = "elastic-cloud-link"
}
variable "region" {
    description = "AWS region for objects"
    type        = string
}
variable "ec_region" {
    description = "EC region for deployment"
    type        = string
}
variable "deployment_name" {
    type        = string
    description = "The name of the elastic cloud deployment"
}
variable "deployment_version" {
    type        = string
    description = "Elasticsearch version"
}
variable "deployment_template" {
    type        = string
    description = "Deployment instances type"
    default     = "aws-io-optimized-v2"
}
# Network
variable "ingress_cidr" {
    type        = list(string)
    description = "CIDR Blocks that are allowed to connect to elastic cloud via the VPC"
}
variable "vpc_id" {
    type        = string
    description = "VPC ID"
}
variable "subnet_ids" {
    type        = list(string)
    description = "Subnet ID"
} 
variable "sourceip" {
    type        = string
    description = "External addresses, EC and Kibana access"
     default     = "0.0.0.0/0"
}
#Private Link
variable "service_name" {
    type        = string
    description = "The PrivateLink service name for your elastic cloud deployment. By default, us-east-2 (https://www.elastic.co/guide/en/cloud/current/ec-traffic-filtering-vpc.html)"
    default     = "com.amazonaws.vpce.us-east-2.vpce-svc-02d187d2849ffb478"
}
#Route53
variable "zone_name" {
    type        = string
    description = "Route53 zone name. By default: us-east-2"
    default     = "vpce.us-east-2.aws.elastic-cloud.com"
}
variable "record_ttl" {
    type        = string
    description = "TTL for the Route53 Record. By default: 300"
    default     = "300"
}
variable "deployment_filter_name" {
    type        = string
    description = "Name for the traffic filter for PrivateLink"
    default     = "Allow traffic from AWS VPC"
}
variable "external_filter_name" {
    type        = string
    description = "Name for the traffic filter for PrivateLink"
    default     = "Allow traffic from External IP"
}