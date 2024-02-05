# Testing Istio Usage Scenarios

This repository illustrates some interesting usage scenarios for Istio. To get this running, you need Docker Desktop running a K8S cluster.

## Preparing the Workbench: Installing/Wiping Istio

Basic setup to ensure there is a pristine K8S cluster:

1. Use Docker Desktop to spin up a K8S cluster; 
2. Under Settings/Kubernetes, run `Reset Cluster`.
3. Execute `./baseline.sh`

## Scenario 1: VirtualHost shows different deploys as monolithic system

I have 2 microservices, order-microservice and user-microservice. I want to serve them publically under two FQDNs:

* `first.istiodemo.io>`
* `second.istiodemo.io`

Each offer 2 paths each of which points to either the order- or user-microservice.

* `$HOST/order` -> order-microservice
* `$HOST/user`  -> user-microservice

![Visualization](./scenario1/vis.png)

### Running it

```
cd scenario1
kubectl apply -f setup.yaml
./ping.sh

# remove scenario
./remove-scenario.sh
```

## Scenario 2: Retries

to be done

## Other Scenarios

1. basic load balancing with DRs: https://istio.io/latest/docs/concepts/traffic-management/#load-balancing-options
2. circuit breaking
3. JWT
4. namespace base authX
