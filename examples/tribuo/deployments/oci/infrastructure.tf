// Credits: https://github.com/graalvm/graalvm-demos/tree/master/micronaut-webapp/
// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
// The Universal Permissive License (UPL), Version 1.0

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}

// Keep number of characters to minimum (3 to 5 chars max)
// `project_code` is used as prefix to `xxx_label` variables
// Terraform & OCI conventions mean they should be under 15 characters
variable "project_code" {
  default = "tribuo"
}

// `project_name` is used as prefix to `display_name` variables
// Can be long, but must follow Terraform & OCI conventions
variable "project_name" {
  default = "Tribuo-OCI-TF"
}

variable "suffix_name" {
  default = "public"
}

variable "num_instances" {
  default = "1"
}

// https://docs.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm#vmshapes
variable "instance_shape" {
  default = "VM.Standard2.1"
}

variable "instance_image_ocid" {
  type = map(string)

  default = {
    # See https://docs.us-phoenix-1.oraclecloud.com/images/
    # Oracle-provided image "Oracle-Linux-7.5-2018.10.16-0"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaaoqj42sokaoh42l76wsyhn3k2beuntrh5maj3gmgmzeyr55zzrwwa"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaageeenzyuxgia726xur4ztaoxbxyjlxogdhreu3ngfj2gji3bayda"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaitzn6tdyjer7jl34h2ujz74jwy5nkbukbh55ekp6oyzwrtfa4zma"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaa32voyikkkzfxyo4xbdmadc2dmvorfxxgdhpnk6dw64fa3l4jh7wa"
  }
}

provider "oci" {
  tenancy_ocid     = "${var.tenancy_ocid}"
  user_ocid        = "${var.user_ocid}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region           = "${var.region}"
}

data "oci_identity_availability_domain" "ad" {
  compartment_id = "${var.tenancy_ocid}"
  ad_number      = 1
}

resource "oci_core_vcn" "ocivcn" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.project_name}-Vcn-${var.suffix_name}"
  dns_label      = "${var.project_code}vcn${var.suffix_name}"
}

resource "oci_core_security_list" "oci_hosts_security_list" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.ocivcn.id}"
  display_name   = "${var.project_name}-HostsSecurityLists-${var.suffix_name}"

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
    stateless = false
  }

  // allow inbound ssh traffic from a specific port
  ingress_security_rules {
    protocol  = "6"         // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      // These values correspond to the destination port range.
      min = 22
      max = 22
    }
  }

  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol  = 1
    source    = "0.0.0.0/0"
    stateless = true

    icmp_options {
      type = 3
      code = 4
    }
  }

  // allow inbound http traffic on specific ports 8888
  ingress_security_rules {
    protocol  = "6"         // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      // These values correspond to the destination port range.
      min = 8888
      max = 8888
    }
  }
}

resource "oci_core_internet_gateway" "oci_internet_gateway" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.project_name}-InternetGateway-${var.suffix_name}"
  vcn_id         = "${oci_core_vcn.ocivcn.id}"
}

resource "oci_core_route_table" "oci_route_table" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.ocivcn.id}"
  display_name   = "${var.project_name}-RouteTable-${var.suffix_name}"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "${oci_core_internet_gateway.oci_internet_gateway.id}"
  }
}

resource "oci_core_subnet" "oci_subnet" {
  availability_domain = "${data.oci_identity_availability_domain.ad.name}"
  cidr_block          = "10.1.20.0/24"
  display_name        = "${var.project_name}-Subnet-${var.suffix_name}"
  dns_label           = "${var.project_code}subnet"
  security_list_ids   = ["${oci_core_security_list.oci_hosts_security_list.id}"]
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_vcn.ocivcn.id}"
  route_table_id      = "${oci_core_route_table.oci_route_table.id}"
  dhcp_options_id     = "${oci_core_vcn.ocivcn.default_dhcp_options_id}"
}


resource "oci_core_instance" "oci_oci_instance" {
  availability_domain = "${data.oci_identity_availability_domain.ad.name}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "${var.project_name}-Host-${var.suffix_name}"
  shape               = "${var.instance_shape}"
  count = "${var.num_instances}"

  create_vnic_details {
    subnet_id        = "${oci_core_subnet.oci_subnet.id}"
    display_name     = "HostPrimaryVnic-${var.suffix_name}"
    assign_public_ip = true
    hostname_label   = "${var.project_name}-Host-${var.suffix_name}-${count.index}"
  }

  metadata = {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data           = "${base64encode(file("./init.sh"))}"
  }

  source_details {
    source_type = "image"
    source_id   = "${var.instance_image_ocid[var.region]}"
  }

  timeouts {
    create = "60m"
  }
}

resource "null_resource" "remote-exec" {
  depends_on = [oci_core_instance.oci_oci_instance]
  count = "${var.num_instances}"

  provisioner "remote-exec" {
    connection {
      agent = false
      timeout = "30m"
      host = "${oci_core_instance.oci_oci_instance.*.public_ip[count.index % var.num_instances]}"
      user = "opc"
      private_key = "${var.ssh_private_key}"
    }

    script = "provision.sh"
  }
}

output "instance_private_ips" {
  value = ["${oci_core_instance.oci_oci_instance.*.private_ip}"]
}

output "instance_public_ips" {
  value = ["${oci_core_instance.oci_oci_instance.*.public_ip}"]
}