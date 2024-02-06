export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
printenv | grep INGRESS

echo "Calling BFF, which calls BACKEND which will likely time out."
curl -s -H "Host: timeout.istiodemo.io" "http://$INGRESS_HOST:$INGRESS_PORT/bff" | jq .
echo "Calling BACKEND directly, again with a timeout configured."
curl -v -s -H "Host: timeout.istiodemo.io" "http://$INGRESS_HOST:$INGRESS_PORT/backend"
echo
echo "For the sake of completeness, this calls BACKEND directly again, this time without timeout configured."
curl -s -H "Host: notimeout.istiodemo.io" "http://$INGRESS_HOST:$INGRESS_PORT/backend" | jq .