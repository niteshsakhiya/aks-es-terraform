
resource "helm_release" "kibana" {
  chart     = "kibana"
  name      = "kibana"
  version   = "7.17.3"
  repository= "https://helm.elastic.co"
  namespace = kubernetes_namespace.elasticsearch.metadata.0.name
  values = [file("../helm_charts/kibana/values.yaml")]
  depends_on = [helm_release.elasticsearch, helm_release.ingress_nginx]
}

# Add A record for Kibana sub domain
resource "cloudflare_record" "kibana_a_record" {
  zone_id         = var.cloudflare_zone_id
  name            = "kibana"
  value           = azurerm_public_ip.load_balancer.ip_address
  type            = "A"
  ttl             = 3600
  allow_overwrite = true
}