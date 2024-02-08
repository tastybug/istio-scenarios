export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')


echo 'Next a request to BFF in namespace green. This will go through:'
curl -v -s -H 'Host: works.istiodemo.io' "http://$INGRESS_HOST:$INGRESS_PORT" | jq .code
echo 'show cert passthrough here'

echo
echo 'Next a request to BFF in namespace red. This will fail:'
curl -v -s -H 'Host: broken.istiodemo.io' "http://$INGRESS_HOST:$INGRESS_PORT" | jq .code
