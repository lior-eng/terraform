resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "5.52.1"

  #   values = [file("values/argocd.yaml")]
}

resource "kubectl_manifest" "parent_app" {
  depends_on = [helm_release.argocd, kubernetes_secret.argocd_ssh_key, kubernetes_secret.postgresql_secret]
  yaml_body  = file(var.main_app_path)
}
