export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

echo 'To prove that there is a fauly BACKEND service: call it, show how it behaves.'
for x in {1..10}; do curl -s -H "Host: noretries.istiodemo.io" "http://$INGRESS_HOST:$INGRESS_PORT/backend" | jq .code; done
echo 'Pinging the BFF service, which utilizes silent retries. You should only see 200 here.'
for x in {1..10}; do curl -s -H "Host: silentretries.istiodemo.io" "http://$INGRESS_HOST:$INGRESS_PORT/bff" | jq .code; done
echo 'Pinging the faulty BACKEND service, again with silent retries. You should only see 200 here.'
for x in {1..10}; do curl -s -H "Host: silentretries.istiodemo.io" "http://$INGRESS_HOST:$INGRESS_PORT/backend" | jq .code; done
