resource "kubernetes_namespace" "monitoring" {
  metadata {
    labels = {
      service = "prometheus"
    }

    name = "monitoring"
  }
  depends_on = [module.aks.kubernetes_cluster_id]
}

resource "helm_release" "prometheus" {
  chart     = "prometheus"
  name      = "prometheus"
  version   = "14.0.1"
  repository= "https://prometheus-community.github.io/helm-charts"
  namespace = kubernetes_namespace.monitoring.metadata.0.name
  values = [file("../helm_charts/prometheus/values.yaml")]
}

