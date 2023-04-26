#Create SG for PrivateLink
resource "aws_security_group" "private-link" {
    name   = var.aws_resource_name
    vpc_id = var.vpc_id

    ingress {
        description = "Allow HTTPS to elastic cloud deployment"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = var.ingress_cidr
    }

    tags = {
        Name = var.aws_resource_name
    }
}

#Create VPC Endpoint 
resource "aws_vpc_endpoint" "private-link" {
    service_name = var.service_name

    vpc_id            = var.vpc_id
    vpc_endpoint_type = "Interface"

    security_group_ids = [ aws_security_group.private-link.id ]
    subnet_ids         = var.subnet_ids

    tags = {
        Name = var.aws_resource_name
    }

    depends_on = [ aws_security_group.private-link ]
}

#Create Route53 Zone
resource "aws_route53_zone" "private-link" {
    name = var.zone_name

    vpc {
        vpc_id = var.vpc_id
    }
}

#Add CNAME record to Zone
resource "aws_route53_record" "private-link" {
    zone_id = aws_route53_zone.private-link.zone_id

    name    = "*"
    type    = "CNAME"
    records = [ lookup(aws_vpc_endpoint.private-link.dns_entry[ 0 ], "dns_name") ]

    ttl = var.record_ttl

    depends_on = [ aws_route53_zone.private-link ]
}

# Create an Elastic Cloud deployment
resource "ec_deployment" "cloud_deployment" {
  name                   = var.deployment_name
  region                 = var.region
  version                = var.deployment_version
  deployment_template_id = var.deployment_template

  traffic_filter = merge([ ec_deployment_traffic_filter.deployment_filter.id ], var.extra_traffic_filters)

  elasticsearch = {
    autoscale = "false"
    hot = {
      size        = "1g"
      zone_count  = 1
      autoscaling = {} 
    }
  }
  kibana = {
    size = "1g"
  }
}

# Elastic Cloud traffic filter
resource "ec_deployment_traffic_filter" "deployment_filter" {
  name   = var.filter_name
  type   = "vpce"
  region = var.region

  rule {
    source = aws_vpc_endpoint.private-link.id
  }
  depends_on = [ aws_vpc_endpoint.private-link ]
}

# resource "null_resource" "elastisearch-initial-settings" {
#   provisioner "local-exec" {
#     command = "es-init/update-initial-settings.sh"

#     environment = {
#       ES_URL = ec_deployment.cloud_deployment.elasticsearch.https_endpoint
#       ES_USER = ec_deployment.cloud_deployment.elasticsearch_username
#       ES_PASSWORD = ec_deployment.cloud_deployment.elasticsearch_password
#     }
#   }
# }