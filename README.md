kubernetes-reverseproxy
=======================

From:
https://github.com/osixia/kubernetes-reverseproxy
https://github.com/arkadijs/kubernetes-reverseproxy

Docker:
https://hub.docker.com/r/nick4fake/kubernetes-reverseproxy/
[base image](https://registry.hub.docker.com/_/ubuntu/)

Usage:
* Enable low ports. Add this to API server:
--service-node-port-range=1-32767
* Deploy service and rc:
kubectl kubernetes/create -f rc.yml; kubectl create -f kubernetes/service.yml
* Add annotations to you services:
apiVersion: v1
kind: Service
metadata:
  name: <NAME>
  annotations:
    kubernetesReverseproxy: '{"hosts": [{"host": "example.com", "port": 80}]}'
spec:
  selector:
    app: <NAME>
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
* configure L4 load balancer to nodes
