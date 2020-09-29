/*
 * Copyright 2020 techinducers.com.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 * Terraform  declarations for AWS VPC
 */
# VPC Creation

resource "aws_vpc" "aws-vpc" {
  cidr_block           = var.aws_network_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    "Name" = "k8-Controller"
  }
}
#subnet Creation

resource "aws_subnet" "k8-subnet" {
  vpc_id     = aws_vpc.aws-vpc.id
  cidr_block = var.aws_subnet1_cidr


  tags = {
    Name = "k8-controller-subnet"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "aws-vpc-igw" {
  vpc_id = aws_vpc.aws-vpc.id

  tags = {
    Name = "k8-controller-igw"
  }
}

# Route Tables

resource "aws_route_table" "k8_route" {
  vpc_id = aws_vpc.aws-vpc.id

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route" "k8-route_table_id" {
  route_table_id            = aws_route_table.k8_route.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.aws-vpc-igw.id
}


/*
 * --------------------------------------
 * ----------VPN Connection----------
 *---------------------------------------
 */

resource "aws_vpn_gateway" "aws-vpn-gw" {
  vpc_id = aws_vpc.aws-vpc.id
}

resource "aws_customer_gateway" "aws-cgw" {
  bgp_asn    = 65000
  ip_address = google_compute_address.gcp-vpn-ip.address
  type       = "ipsec.1"
  tags = {
    "Name" = "aws-customer-gw"
  }
}

resource "aws_default_route_table" "aws-vpc" {
  default_route_table_id = aws_vpc.aws-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-vpc-igw.id
  }
  propagating_vgws = [
    aws_vpn_gateway.aws-vpn-gw.id,
  ]
}

resource "aws_vpn_connection" "aws-vpn-connection1" {
  vpn_gateway_id      = aws_vpn_gateway.aws-vpn-gw.id
  customer_gateway_id = aws_customer_gateway.aws-cgw.id
  type                = "ipsec.1"
  static_routes_only  = false
  tags = {
    "Name" = "aws-GCP-VPN"
  }
}
