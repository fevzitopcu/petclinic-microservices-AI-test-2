
echo 'Deploying App on EKS K8s Cluster'

# Helm S3 plugin kontrolü
if ! helm plugin list | grep -q 's3'; then
    echo "Helm S3 plugin yükleniyor..."
    helm plugin install https://github.com/hypnoglow/helm-s3.git
else
    echo "Helm S3 plugin zaten yüklü."
fi

export KUBECONFIG=/var/lib/jenkins/.kube/config
aws eks update-kubeconfig --region us-east-1 --name petclinic-cluster --kubeconfig $KUBECONFIG

envsubst < .devops/k8s/petclinic_chart/values-template.yaml > .devops/k8s/petclinic_chart/values.yaml


sed -i "s/^version:.*/version: ${BUILD_NUMBER}/" .devops/k8s/petclinic_chart/Chart.yaml

AWS_REGION=$AWS_REGION helm repo add stable-petclinic s3://petclinic-charts-fevzitopcu/stable/myapp/ || echo "repository name already exists"

AWS_REGION=$AWS_REGION helm repo update
helm package .devops/k8s/petclinic_chart

AWS_REGION=$AWS_REGION helm s3 push --force petclinic_chart-${BUILD_NUMBER}.tgz stable-petclinic

kubectl create ns petclinic-prod || echo "namespace petclinic-prod already exists"
kubectl delete secret regcred -n petclinic-prod || echo "there is no regcred secret in petclinic-prod namespace"

kubectl create secret generic regcred -n petclinic-prod \
    --from-file=.dockerconfigjson=/var/lib/jenkins/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson


AWS_REGION=$AWS_REGION helm repo update
AWS_REGION=$AWS_REGION helm upgrade --install \
    petclinic-app-release stable-petclinic/petclinic_chart --version ${BUILD_NUMBER} \
    --namespace petclinic-prod
