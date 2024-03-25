resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "5.52.1"

  #   values = [file("values/argocd.yaml")]
}

resource "kubectl_manifest" "parent_app" {
  depends_on = [helm_release.argocd, helm_release.updater, kubernetes_secret.argocd_ssh_key, kubernetes_secret.postgresql_secret, kubernetes_secret.ecr_credentials]
  yaml_body  = file(var.parent-application)
}

####################################

resource "helm_release" "updater" {
  name             = "updater"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-image-updater"
  namespace        = "argocd"
  create_namespace = true
  version          = "0.9.1"

  values = [file("${path.root}/helm_values/image_updater_values.yaml")]
}