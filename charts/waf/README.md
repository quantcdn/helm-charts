# quant-waf

[quant-waf](https://quantcdn.io) ingress proxy for Kubernetes deployments. Intended to be deployed as first-hop in the cluster and passing the request back to your deployed ingress controller.

This chart bootstraps a quant-waf deployment on a [Kubernetes](https://kubernetes.io) cluster using the [helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes v1.16+

## Get repo info

```
helm repo add quant-waf https://github.com/quantcdn/quant-waf-chart
helm repo update
```

## Install Chart

```
helm install [RELEASE_NAME] quantcdn/quant-waf
```

The command will deploy quant-waf on a Kubernetes cluster with the default configuration.

## Uninstall Chart

```
helm uninstall [RELEASE_NAME]
```

## Upgrading Chart

```
helm upgrade [RELEASE_NAME]
```

# Configuration

To see all available configuration options view the chart's [values.yml](https://github.com/quantcdn/quant-waf-chart) or run the configuration command:

```
helm show values quantcdn/quant-waf
```

## Values

| Key | Type | Default | Description |
| --- | ---- | ------- | ----------- |
| `nextHop.selector` | object | {} | Selector metadata to instruct where the WAF is to direct traffic |
| `nexthop.port` | int | 80 | The port for the application service |
| | | | |
| `quant.endpoint` | string | "" | The log forwarding endpoint |
| `quant.key` | string | "" | Secret token for authenticating the log forwarding |
| `quant.organization` | string | "" | The quant organization for the project |
| `quant.project` | string | The quant project name |
| `quant.errorPage.blocked` | string | `<html><h1>Blocked by WAF</h1><p>Rule was: {{ waf_rule_id }}</p><p>{{ timestamp }}</p></html>` | Markup to be served when WAF is breached |
| `quant.errorPage.threshold` | string | `<html><h1>Rate limits exceeded.</h1><p>Your request has been blocked as we have detected traffic that exceeds rate limiting thresholds.</p><p>{{ timestamp }}</p><p>{{ request_id }}</p></html>` | Markup to serve when thresholds are reached |
| `quant.config.paranoia` | int | 1 | Set the paranoia level for the CRS |
| `quant.config.mode` | string | block | Control the WAF behavior when a breach is detected, supported modes are **block** or **report** |
| `quant.config.logLevel` | string | standard | The verbosity of the logs |
| `quant.config.httpblEnabled` | bool | false | Enable project honeypot integration |
| `quant.config.httpblKey` | string | "" | Your API key for Http:BL |
| `quant.config.httpblBlockSuspicious` | bool | false | Request handling if flagged as suspicious |
| `quant.config.BlockHarvester` | bool | true | Request handling if flagged as a harvester |
| `quant.config.BlockSpam` | bool | true | Request handling if flagged as spam |
| `quant.config.htttpblBlockSearchEngine` | bool | false | Request handling if flagged as a search engine |
| `quant.config.allowIp` | list | [] | IPs to exclude from WAF interactions |
| `quant.config.blockIp` | list | [] | IPs to block immediately |
| `quant.config.blockUa` | list | [] | Additional user agents to block |
| `quant.config.allowRules` | list | [] | CRS rule ids to exclude for all requests |
| `quant.config.blockCountry` | list | [] | 2 letter country codes to restrict |
| `quant.config.rules` | list | [] | Additional rules to include in the configuration |
| `quant.config.thresholds` | list | [] | Thresholds to enforce on the request |
| | | | |
| `waf.pullPolicy` | string | Always | |
| `waf.tag` | string | "" | |
| `waf.podAnnotations` | object | {} | |
| `waf.nodeSelector` | object | {} | |
| `waf.tolerations` | list | [] | |
| `waf.affinity` | object | {} | |
| `waf.podSecurityContext` | object | {} | |
| `waf.securityContext` | object | {} | |
| `waf.imagePullSecrets` | list | [] | |
| `waf.resources` | object | `{"requests": {"memory": "1Gi", "cpu": "500m"}, "limits": {"memory": "1Gi", "cpu": "}}` | |
