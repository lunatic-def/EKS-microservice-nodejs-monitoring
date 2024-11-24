# https://github.com/argoproj/argo-helm/blob/main/charts/argocd-image-updater/values.yaml
# https://argocd-image-updater.readthedocs.io/en/stable/
resource "helm_release" "updater" {
  name = "updater"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-image-updater"
  namespace        = "argocd"
  create_namespace = true
  version          = "0.8.4"

  values = [file("values/image-updater.yml")]
}