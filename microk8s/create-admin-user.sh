USERNAME=""

CLUSTER_NAME=`microk8s kubectl config view --flatten -o jsonpath='{.clusters[].name}'`
API_SERVER_HOST=`hostname -I | awk '{print $1}'`
API_SERVER_PORT="16443"
CA_DATA=`cat /var/snap/microk8s/current/certs/ca.crt | base64 | tr -d '\n'`

sudo useradd $USERNAME
sudo mkdir /home/$USERNAME
cd /home/$USERNAME

sudo openssl genrsa -out $USERNAME.key 2048
sudo openssl req -new -key $USERNAME.key \
-out $USERNAME.csr \
-subj "/CN=$USERNAME"

cat << EOF | microk8s kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: admin-$USERNAME
spec:
  groups:
  - system:authenticated
  signerName: kubernetes.io/kube-apiserver-client
  request: `cat $USERNAME.csr | base64 | tr -d "\n"`
  usages:
  - client auth
EOF

microk8s kubectl certificate approve admin-$USERNAME
microk8s kubectl create clusterrolebinding admin-$USERNAME --clusterrole=cluster-admin --user=$USERNAME

CLIENT_CRT_DATA=`microk8s kubectl get csr admin-$USERNAME -o jsonpath='{.status.certificate}'`
CLIENT_KEY_DATA=`sudo cat $USERNAME.key | base64 | tr -d '\n'`

IFS=
kubeConfig="
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: $CA_DATA
    server: https://$API_SERVER_HOST:$API_SERVER_PORT
  name: $CLUSTER_NAME
contexts:
- context:
    cluster: $CLUSTER_NAME
    user: admin-$USERNAME
  name: admin-$USERNAME@$CLUSTER_NAME
kind: Config
users:
- name: admin-$USERNAME
  user:
    client-certificate-data: $CLIENT_CRT_DATA
    client-key-data: $CLIENT_KEY_DATA
"

echo $kubeConfig > config

