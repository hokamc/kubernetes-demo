kubectl apply -f kubernetes-dashboard-admin.yaml

kubectl -n kubernetes-dashboard describe secret (kubectl -n kubernetes-dashboard get secret | grep kubernetes-dashboard-admin | awk '{print $1}')
