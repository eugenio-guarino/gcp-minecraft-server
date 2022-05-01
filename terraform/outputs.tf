output "server-ip-name" {
    description = "external ip address"
    value = module.minecraft_ip_address.ip_addr
}