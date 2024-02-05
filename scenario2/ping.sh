while true; do curl -s -H "Host: backend.istiodemo.io" "http://$INGRESS_HOST:$INGRESS_PORT" | jq .body; sleep 1; done
