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

## Scenario 3: Load Balancing Across Service Subgroups

This scenario has one applications deployed, but in 3 `Deployment`s with different labels. The label reflects a zone they are deployed in but the label could be anything actually. There is a single `Service` that spans across all application pods. In front of the service is a `DestinationRule`, which will break down the pods into subgroups (by label). Then, load balancing happens between these subgroups.

So we see that the `Service` can be oblivious to the finer grouping logic, with the `DirectionRule` helping to fine-tune the routing.

Problem with this scenario: I don't know yet how to prove LB settings within a subgroup (e.g. globally `RANDOM`, but in subgroup `ROUND_ROBIN`).

```
cd scenario3
kubectl apply -f setup.yaml
./ping.sh

# remove scenario
./remove-scenario.sh
```

## Scenario 4: Timeouts


In this scenario, there are 2 applications deployed: a BFF and a BACKEND. The backend is kinda slow, so we play with timeout settings here.
Timeouts are configured per destination in a `VirtualService`. Whenever a timeout occurs, you get a `504 Gateway Timeout`.

To illustrate different ways of utilizing this, this setup comes with a whopping 4 `VirtualService`s:

* `vs/bff-vs`: this is bound to the gateway and exposes the BFF only. The BFF invokes the BACKEND
* `vs/internal-backend-with-timeout-vs`: this is NOT bound to a gateway (it took me a while to figure this detail out), making it an internal VS. It has a timeout configuration. It sits between clients of BACKEND.
* `vs/external-backend-with-timeout-vs`: simply to illustrate that one can also have a timeout setting when calling from a gateway, this VS exists.
* `vs/external-backend-without-timeout-vs`: this exposes BACKEND to the gateway, but without the timeout setting.

You'll run 3 tests:
* call BFF: this times out
* call BACKEND with a strict timeout setting: this times out
* call BACKEND without a timeout setting: this works

```
cd scenario3
kubectl apply -f setup.yaml
./ping.sh

# remove scenario
./remove-scenario.sh
```

![Visualization](./scenario2/vis.drawio.png)

## Other Scenarios

1. Retries
1. circuit breaking
1. JWT
1. namespace base authX
