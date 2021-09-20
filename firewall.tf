# Retrieve the subnet data to get the network name
data "google_compute_subnetwork" "dataproc" {
  self_link = var.vpc_subnet
}

# Create firewall rule required for cluster interconnectivity
resource "google_compute_firewall" "dataproc" {
 project     = var.vpc_project
 name        = "allow-tcp-udp-icmp-dataproc-${var.cluster_name}"
 network     = data.google_compute_subnetwork.dataproc.network
 description = "Enable Dataproc master and nodes connectivity"

 # VMs within that applies the firewall rule
 source_tags = ["dataproc-${var.cluster_name}"]
 target_tags = ["dataproc-${var.cluster_name}"]

 # Protocols/ports allowed
 allow {
   protocol  = "tcp"
 }
 allow {
   protocol  = "udp"
 }
 allow {
   protocol  = "icmp"
 }
}