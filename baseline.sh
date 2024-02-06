./istio-dist/bin/istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled
../istio-1.20.2/bin/istioctl analyze
