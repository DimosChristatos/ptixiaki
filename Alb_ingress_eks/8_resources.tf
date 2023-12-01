# resource "kubectl_manifest" "example-namespace" {
#   yaml_body = <<YAML
# apiVersion: v1
# kind: Namespace
# metadata:
#   name: my_namespace
# YAML
# }

# resource "kubectl_manifest" "example-Deployment" {
#   yaml_body = <<YAML
# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   name: rmy-deployment
#   namespace: my_namespace
# spec:
#   selector:
#     matchLabels:
#       app: my-deployment
#   replicas: 1
#   template:
#     metadata:
#       labels:
#         app: my-deployment
#     spec:
#       containers:
#       - image: k8s.gcr.io/e2e-test-images/echoserver:2.5
#         name: my-deployment
#         ports:
#         - containerPort: 8080
# ---    
# YAML
# }

# resource "kubectl_manifest" "example-Service" {
#   yaml_body = <<YAML
# apiVersion: v1
# kind: Service
# metadata:
#   name: my-service
#   namespace: my_namespace
# spec:
#   ports:
#   - port: 80
#     targetPort: 8080
#     protocol: TCP
#   type: NodePort
#   selector:
#     app: my-deployment
#     YAML
# }

# resource "kubectl_manifest" "example-ingress" {
#   yaml_body = <<YAML
# apiVersion: networking.k8s.io/v1ye
# kind: Ingress
# metadata:
#   name: my-ingress
#   namespace: my_namespace
#   annotations:
#     alb.ingress.kubernetes.io/scheme: internal #internet-facing
#     alb.ingress.kubernetes.io/group.order: '1'
#     alb.ingress.kubernetes.io/target-type: instance
#     service.beta.kubernetes.io/aws-load-balancer-type: alb
# spec:
#   ingressClassName: alb 
#   rules:
#   - host: test.sendrato-eventos.com
#     http:
#       paths:
#         - path: /
#           pathType: Prefix
#           backend:
#             service:
#               name:  my-service
#               port:
#                 number: 80
#     YAML
# }
# # on host->alb's domain