export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
printenv | grep INGRESS

echo "pinging first.istiodemo.io"
curl -s -H "Host: first.istiodemo.io" "http://$INGRESS_HOST:$INGRESS_PORT/order" | jq .body
sleep 1
curl -s -H "Host: first.istiodemo.io" "http://$INGRESS_HOST:$INGRESS_PORT/user" | jq .body
sleep 1
echo "pinging second.istiodemo.io"
curl -s -H "Host: second.istiodemo.io" "http://$INGRESS_HOST:$INGRESS_PORT/order" | jq .body
sleep 1
curl -s -H "Host: second.istiodemo.io" "http://$INGRESS_HOST:$INGRESS_PORT/user" | jq .body
