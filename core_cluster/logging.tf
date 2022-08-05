resource "kubernetes_namespace" "logging" {
  metadata {
    labels = {
      service = "logging"
    }

    name = "logging"
  }
  depends_on = [module.aks.kubernetes_cluster_id]
}

# Use fluentD to collect and insert logs in Elasticsearch cluster
resource "helm_release" "fluentd" {
  chart     = "fluentd"
  name      = "fluentd"
  version   = "0.3.9"
  repository= "https://fluent.github.io/helm-charts"
  namespace = kubernetes_namespace.logging.metadata.0.name
  values = [file("../helm_charts/fluentd/values.yaml")]
  depends_on = [helm_release.elasticsearch]
}

