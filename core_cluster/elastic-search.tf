resource "kubernetes_namespace" "elasticsearch" {
  metadata {
    labels = {
      service = "elasticsearch"
    }

    name = "elasticsearch"
  }
}


# Use Bitnami helm chart to create ES cluster
resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  chart      = "elasticsearch"
  version    = "19.1.4"
  repository = "https://charts.bitnami.com/bitnami"
  namespace  = kubernetes_namespace.elasticsearch.metadata.0.name
  values     = ["${file("../helm_charts/elasticsearch/values.yaml")}"]
  depends_on = [module.aks.aks_nodepool]
}

