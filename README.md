# Testing Istio Usage Scenarios

This repository illustrates some interesting usage scenarios for Istio. To get this running, you need Docker Desktop running a K8S cluster.

## Preparing the Workbench: Installing/Wiping Istio

Basic setup to ensure there is a pristine K8S cluster:

1. Use Docker Desktop to spin up a K8S cluster; 
2. Under Settings/Kubernetes, run `Reset Cluster`.
3. Execute `./baseline.sh`

## Scenario 1: VirtualHost shows different deploys as monolithic

I have 2 microservices, order-microservice and user-microservice. I want to serve them publically under two FQDNs:

* <first.istiodemo.io>
* <second.istiodemo.io>

There are 2 paths that I want to expose, each of which points to either order- or user-microservice.

* `/order` -> order-microservice
* `/user`  -> user-microservice

![Visualization](./scenario1/vis.png)

### Running it

```
cd scenario1
kubectl apply -f setup.yaml
./ping.sh

# remove scenario
./remove-scenario.sh
```

## Scenario 2

Not quite sure what this is about yet.
