echo "pinging first.istiodemo.io"
curl -s -H "Host: first.istiodemo.io" "http://$INGRESS_HOST:$INGRESS_PORT/order" | jq .body
sleep 1
curl -s -H "Host: first.istiodemo.io" "http://$INGRESS_HOST:$INGRESS_PORT/user" | jq .body
sleep 1
echo "pinging second.istiodemo.io"
curl -s -H "Host: second.istiodemo.io" "http://$INGRESS_HOST:$INGRESS_PORT/order" | jq .body
sleep 1
curl -s -H "Host: second.istiodemo.io" "http://$INGRESS_HOST:$INGRESS_PORT/user" | jq .body
