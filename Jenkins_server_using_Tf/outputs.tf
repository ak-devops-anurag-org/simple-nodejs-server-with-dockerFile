output "public_ip" {
  description = "Public IP address of the Jenkins VM"
  value       = module.jenkins_vm.public_ip
}

output "jenkins_url" {
  description = "URL to access Jenkins web UI"
  value       = "http://${module.jenkins_vm.public_ip}:${var.jenkins_admin_port}"
}
