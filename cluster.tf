resource "google_container_cluster" "gke-cluster" {
  name                     = "gke-cluster"
  location                 = var.zone 
  remove_default_node_pool = true
  initial_node_count       = 1
  workload_identity_config {
    identity_namespace     = "arcane-shape-319007.svc.id.goog"
  }
}

resource "google_container_node_pool" "nginx-noge-pool" {
  name       = "nginx-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.gke-cluster.name
  node_count = 1

  node_config {
    machine_type = "custom-1-1024"
  }
}

module "my-app-workload-identity" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  cluster_name = google_container_cluster.gke-cluster.name
  name       = var.kub_name
  namespace  = kubernetes_namespace.nginxns.metadata.0.name
  project_id = var.project
  roles      = ["roles/customrole"]
}
