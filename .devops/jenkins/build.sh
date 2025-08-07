docker build -t "${IMAGE_TAG_ADMIN_SERVER}" \
  -f ${WORKSPACE}/docker/Dockerfile ${WORKSPACE}/spring-petclinic-admin-server/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-admin-server-${VERSION} \
  --build-arg EXPOSED_PORT=9090

docker build -t "petclinic-api-gateway:dev" \
  -f ${WORKSPACE}/docker/Dockerfile ${WORKSPACE}/spring-petclinic-api-gateway/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-api-gateway-${VERSION} \
  --build-arg EXPOSED_PORT=8080

docker build -t "petclinic-config-server:dev" \
  -f ${WORKSPACE}/docker/Dockerfile ${WORKSPACE}/spring-petclinic-config-server/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-config-server-${VERSION} \
  --build-arg EXPOSED_PORT=8888

docker build -t "petclinic-customers-service:dev" \
  -f ${WORKSPACE}/docker/Dockerfile ${WORKSPACE}/spring-petclinic-customers-service/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-customers-service-${VERSION} \
  --build-arg EXPOSED_PORT=8081

docker build -t "petclinic-discovery-server:dev" \
  -f ${WORKSPACE}/docker/Dockerfile ${WORKSPACE}/spring-petclinic-discovery-server/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-discovery-server-${VERSION} \
  --build-arg EXPOSED_PORT=8761

docker build -t "petclinic-genai-service:dev" \
  -f ${WORKSPACE}/docker/Dockerfile ${WORKSPACE}/spring-petclinic-genai-service/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-genai-service-${VERSION} \
  --build-arg EXPOSED_PORT=9091

docker build -t "petclinic-vets-service:dev" \
  -f ${WORKSPACE}/docker/Dockerfile ${WORKSPACE}/spring-petclinic-vets-service/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-vets-service-${VERSION} \
  --build-arg EXPOSED_PORT=8082

docker build -t "petclinic-visits-service:dev" \
  -f ${WORKSPACE}/docker/Dockerfile ${WORKSPACE}/spring-petclinic-visits-service/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-visits-service-${VERSION} \
  --build-arg EXPOSED_PORT=8083

docker build  -t "petclinic-grafana-server:dev" ${WORKSPACE}/docker/grafana
docker build  -t "petclinic-prometheus-server:dev" ${WORKSPACE}/docker/prometheus

