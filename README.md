# Concourse Starter

> Quickly spin up your own concourse ci.

## Getting Started

1. Run `./run.sh` to see usages or simply run `./run.sh a`. Concourse should be running on *localhost:8080* and tunneled to *$WEB_TUNNEL_URL*.
1. `fly -t {target_name} login -c ${WEB_TUNNEL_URL}` creates a target in *~/.flyrc*.
1. `fly ts` shows that your target has registered.
1. Create your pipeline yml file.
1. `fly -t {target_name} sp -c {pipeline_yml} -p {pipeline_name}`
1. `fly -t {target_name} up -p {pipeline_name}`
