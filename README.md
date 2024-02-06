# Istio Usage Scenarios

This repository illustrates some interesting usage scenarios for Istio. This project assumes that Docker Desktop is running a K8S cluster.

## Preparing the Workbench by Installing & Wiping Istio

Basic setup to ensure there is a pristine K8S cluster:

1. `curl -L https://istio.io/downloadIstio | sh -`, rename the folder to `istio-dist`
1. In Docker Desktop spin up a K8S cluster;
2. Under Settings/Kubernetes, run `Reset Cluster`.
3. Execute `./baseline.sh`

## Scenario 1: Routing by Host and URI

This scenario use a `Gateway` and 2 `VirtualService`s to route to two backend `Deployment`s. These are the FQDNs:

* `first.istiodemo.io>`
* `second.istiodemo.io`

Each offer 2 paths each of which points to a deployment.

* `$HOST/order` -> `order-microservice`
* `$HOST/user`  -> `user-microservice`

![Visualization](./scenario1/vis.png)

Roll out and testing:

```
cd scenario1
kubectl apply -f setup.yaml
./ping.sh

# remove scenario
./remove-scenario.sh
```

## Scenario 2: Canary Deployment to Test a New Version

This scenario has two `Deployment`s of the same application, with different `version` labels. One of the versions is to be tested on 10% of the requests. 

Two `Service`s expose the `Deployment`s respectively. With the help of a `VirtualService`, there is a weighted distribution between the two applications, achieving the canary behaviour.

![Visualization](./scenario2/vis.png)

```
cd scenario2
kubectl apply -f setup.yaml
./ping.sh

# remove scenario
./remove-scenario.sh
```

## Other Scenarios

1. basic load balancing with DRs: https://istio.io/latest/docs/concepts/traffic-management/#load-balancing-options
1. Retries
1. circuit breaking
1. JWT
1. namespace base authX
