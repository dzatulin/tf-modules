#AWS
variable "aws_resource_name" {
    type        = string
    description = "AWS objects name"
    default     = "elastic-cloud-link"
}
variable "region" {
    type        = string
}
variable "ec_region" {
    type        = string
}
variable "deployment_name" {
    type        = string
    description = "The name of the elastic cloud deployment"
}
variable "deployment_version" {
    type        = string
    description = "Version of the elastic deployment. (https://registry.terraform.io/providers/elastic/ec/latest/docs/data-sources/ec_stack)"
}
variable "deployment_template" {
    type        = string
    description = "Deployment template ID. (https://www.elastic.co/guide/en/cloud-enterprise/current/ece-deployment-templates.html)"
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
variable "sourceip" {
    default     = "0.0.0.0/0"
    type        = string
    description = "External addresses, EC and Kibana access"
}
#Private Link
variable "service_name" {
    type        = string
    description = "The PrivateLink service name for your elastic cloud deployment. By default, us-east-2 (https://www.elastic.co/guide/en/cloud/current/ec-traffic-filtering-vpc.html)"
    default     = "com.amazonaws.vpce.us-east-2.vpce-svc-02d187d2849ffb478"
}
variable "extra_security_groups" {
    type        = list(string)
    description = "Extra security groups attached to the VPCE for the PrivateLink"
    default     = [ ]
}
variable "subnet_ids" {
    type        = list(string)
    description = "ID's of the subnets to use for the VPCE. Be aware they MUST be in the supported AZ (https://www.elastic.co/guide/en/cloud/current/ec-traffic-filtering-vpc.html#ec-traffic-filtering-vpc)"
}
#Route53
variable "zone_name" {
    type        = string
    description = "Route53 zone name. By default: us-east-1"
    default     = "vpce.us-east-1.aws.elastic-cloud.com"
}
variable "record_ttl" {
    type        = string
    description = "TTL for the Route53 Record. By default: 300"
    default     = "300"
}
variable "deployment_filter_name" {
    type        = string
    description = "Name for the traffic filter on elastic cloud"
    default     = "Allow traffic from AWS VPC"
}