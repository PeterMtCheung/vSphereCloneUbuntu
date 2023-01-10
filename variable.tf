variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "vsphere_virtual_machine_template" {}
variable "virtual_machine_dc1_ip" {}
variable "virtual_machine_dc2_ip" {}
variable "virtual_machine_dc3_ip" {}
variable "virtual_machine_dc1_gateway" {}
variable "virtual_machine_dc2_gateway" {}
variable "virtual_machine_dc3_gateway" {}
variable "virtual_machine_dc1_DNS" {
  default = "192.168.1.1"
}
variable "virtual_machine_dc2_DNS" {
  default = "192.168.1.1"
}
variable "virtual_machine_dc3_DNS" {
  default = "192.168.1.1"
}