./istio-dist/bin/istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled
./istio-dist/bin/istioctl analyze
