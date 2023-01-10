provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}
data "vsphere_datacenter" "datacenter" {
  name = "dc-01"
}
data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_compute_cluster" "cluster" {
  name          = "cluster-01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_virtual_machine" "template" {
  name          = "${var.vsphere_virtual_machine_template}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

resource "vsphere_virtual_machine" "dc1" {
  name = "DC1"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  disk {
    label = "disk0"
    size = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned

  }

  num_cpus = 1
  memory   = 8192
  guest_id = data.vsphere_virtual_machine.template.guest_id
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "DC1"
        domain    = data.vsphere_network.network.name
      }
      network_interface {
        ipv4_address = var.virtual_machine_dc1_ip
        ipv4_netmask = 24
    }
      dns_server_list = [var.virtual_machine_dc1_DNS]
      ipv4_gateway = var.virtual_machine_dc1_gateway
    }
  }
  
  network_interface {
      network_id   = data.vsphere_network.network.id
      adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
}
resource "vsphere_virtual_machine" "dc2" {
  name = "DC2"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  disk {
    label = "disk0"
    size = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned

  }

  num_cpus = 1
  memory   = 8192
  guest_id = data.vsphere_virtual_machine.template.guest_id
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "DC2"
        domain    = data.vsphere_network.network.name
      }
      network_interface {
        ipv4_address = var.virtual_machine_dc2_ip
        ipv4_netmask = 24
    }
      dns_server_list = [var.virtual_machine_dc2_DNS]
      ipv4_gateway = var.virtual_machine_dc2_gateway
    }
  }

  network_interface {
      network_id   = data.vsphere_network.network.id
      adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
}
resource "vsphere_virtual_machine" "dc3" {
  name = "DC3"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  disk {
    label = "disk0"
    size = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned

  }

  num_cpus = 1
  memory   = 8192
  guest_id = data.vsphere_virtual_machine.template.guest_id
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "DC3"
        domain    = data.vsphere_network.network.name
      }
      network_interface {
        ipv4_address = var.virtual_machine_dc3_ip
        ipv4_netmask = 24
    }
      dns_server_list = [var.virtual_machine_dc3_DNS]
      ipv4_gateway = var.virtual_machine_dc3_gateway
    }
  }

  network_interface {
      network_id   = data.vsphere_network.network.id
      adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
}
output "mac_dc1"{
value ="${vsphere_virtual_machine.dc1.network_interface[0].mac_address}"
}
output "mac_dc2"{
value ="${vsphere_virtual_machine.dc2.network_interface[0].mac_address}"
}
output "mac_dc3"{
value ="${vsphere_virtual_machine.dc3.network_interface[0].mac_address}"
}