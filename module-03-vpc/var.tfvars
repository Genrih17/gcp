vm_name = "nginx-terraform"
project = "arcane-shape-319007"
region = "us-central1"
zone = "us-central1-c"
type = "n1-custom-1-4608"
image = "centos-cloud/centos-7"
delete_protection = "true"
disk_type = "pd-ssd"
disk_size = 35
startup_script = "yum install -y nginx; systemctl enable nginx; systemctl start nginx; echo '<h1> Hello from Henadzi Ivashkevich </h1>' > /usr/share/nginx/html/index.html"
vm_timeout_delete = "40m"
student_name = "hivashkevich"
student_IDnum = 1

labels = {
	server_type = "nginx_server"
	os_family = "redhat"
	way_of_installation = "terraform"
}
