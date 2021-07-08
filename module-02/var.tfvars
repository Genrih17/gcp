#instance_name = "nginx-"
project = "arcane-shape-319007"
region = "us-central1"
zone = "us-central1-c"
type = "n1-custom-1-4608"
image = "Cenatos7"
deletion_protection = "true"

labels = {
	server_type = "nginx_server"
	os_family = "redhat"
	way_of_installation = "terraform"
}
