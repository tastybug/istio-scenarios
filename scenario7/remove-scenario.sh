kubectl delete ns/red
kubectl delete ns/green
kubectl delete ns/blue
kubectl delete virtualservice,deployment,service,destinationrule,gateway,requestauthentication,AuthorizationPolicy,PeerAuthentication --all