resource "google_container_cluster" "sql-cluster" {
  name                     = var.sql_name
  location                 = var.zone 
  ip_allocation_policy {}
  initial_node_count       = 1
  workload_identity_config {
    identity_namespace     = "arcane-shape-319007.svc.id.goog"
  }
}

resource "google_container_node_pool" "sql-noge-pool" {
  name       = "sql-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.sql-cluster.name
  node_count = 1

  node_config {
    machine_type = "custom-1-4096"
  }
}

module "workload-identity" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  cluster_name = google_container_cluster.sql-cluster.name
  name       = var.sa_name
  namespace  = kubernetes_namespace.sql.metadata.0.name
  project_id = var.project
  roles      = ["roles/cloudsql.admin"]
}
