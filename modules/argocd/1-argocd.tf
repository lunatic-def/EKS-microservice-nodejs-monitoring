resource "helm_release" "argocd" {
  name = "argocd"

  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-cd"

  namespace = "argocd"
  create_namespace = true
  version = "3.35.4"

  values = ["${file("values/argocd.yml")}"]

#"global.image.tag" "v2.6.6" latest argocd version tag


#"server.extraArgs" -- insecure for argocd to not generate a self-signed certificate and
# redirect http to https but instead use and secure https ingress 
}