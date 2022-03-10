# Kubernetes (k8s)

## Basic operations

```sh
# Delete all failed pods with a specific name
kubectl get pods --field-selector 'status.phase=Failed' -o name | grep podname | xargs kubectl delete
```

## Cluster management GUIs

- [Lens](https://k8slens.dev/)

- [k9s](https://k9scli.io/)
