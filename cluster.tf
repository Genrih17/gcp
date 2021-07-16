resource "google_container_cluster" "sql-cluster" {
  name                     = "sql-cluster"
  location                 = us-central1-c
  ip_allocation_policy {}
  initial_node_count       = 1
  workload_identity_config {
    identity_namespace     = "arcane-shape-319007.svc.id.goog"
  }
}

resource "google_container_node_pool" "sql-noge-pool" {
  name       = "sql-node-pool"
  location   = us-central1-c
  cluster    = google_container_cluster.sql-cluster.name
  node_count = 1

  node_config {
    machine_type = "custom-1-4096"
  }
}

module "workload-identity" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  cluster_name = google_container_cluster.sql-cluster.name
  name       = "sql-kube-sa"
  namespace  = kubernetes_namespace.sql.metadata.0.name
  project_id = "arcane-shape-319007"
  roles      = ["roles/cloudsql.admin"]
}
