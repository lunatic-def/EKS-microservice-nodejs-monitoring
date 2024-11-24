# EKS IRSA - IAM Roles for service accounts
**Components**
- AWS resources: 
    + IAM identity provider
    + STS AssumeRoleWithWebIdentity API operations
    + IAM temporary role
- K8s resources:
    + OpenID Connect Provider
    + Service accounts
    + ProjectedServiceAccountToken (OIDC Json WebToken)

**Use-cases:**
1. EBS CSI controller + Kubernets storage class + PVC + PV
> create/resize/delete retain EBS volumes from kube resource in EKS cluster
2. EFS CSI controller 
> map EFS file system to our Kube Pods in EKS cluster
3. AWS LoadBalencer Controller + Ingress resources 
> create AWS ALB/NLB with all the settings from EKS cluster using k8s Ingress Resource
4. External DNS controller
> create/update/delete AWS route53 DNS records using External DNS


