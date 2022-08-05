resource "kubernetes_namespace" "ingress" {
  metadata {
    labels = {
      service = "ingress"
    }

    name = "ingress-basic"
  }
  depends_on = [module.aks.kubernetes_cluster_id]
}

resource "helm_release" "ingress_nginx" {
  chart     = "ingress-nginx"
  name      = "ingress-nginx"
  version   = "4.2.0"
  repository= "https://kubernetes.github.io/ingress-nginx"
  namespace = kubernetes_namespace.ingress.metadata.0.name

  # Use existing load balancer IP for ingress resource
  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.load_balancer.ip_address
  }
}
