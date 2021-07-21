project = "gcp-lab-1-hivashkevich"
region  = "us-central1"
zone    = "us-central1-c"
vm_name = "nginx"
type = "n1-custom-1-4608"
image = "centos-cloud/centos-7"
delete_protection = "true"
disk_type = "pd-ssd"
disk_size = 35
startup_script = "yum install -y nginx; systemctl enable nginx; systemctl start nginx"
vm_timeout_delete = "40m"

labels = {
	server_type = "nginx_server"
	os_family = "redhat"
	way_of_installation = "terraform"
}
