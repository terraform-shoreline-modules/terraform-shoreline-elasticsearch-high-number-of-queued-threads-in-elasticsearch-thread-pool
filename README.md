
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# High Number of Queued Threads in Elasticsearch Thread Pool
---

This incident type occurs when the number of queued threads in a thread pool in elasticsearch is higher than the acceptable limit. This may indicate that the thread pool is unable to handle the current workload, which can lead to performance issues and delays in processing requests. It is important to investigate and address this issue promptly to ensure optimal performance of the system.

### Parameters
```shell
export ELASTICSEARCH_HOST="PLACEHOLDER"

export DESIRED_THREAD_COUNT="PLACEHOLDER"

export THREAD_POOL_NAME="PLACEHOLDER"

export ELASTICSEARCH_CONFIG_PATH="PLACEHOLDER"
```

## Debug

### Check the number of queued threads in Elasticsearch
```shell
curl -s -XGET 'http://${ELASTICSEARCH_HOST}:9200/_cat/thread_pool?v' | grep -E '^search' | awk '{print $5}'
```

### Check the number of available threads in Elasticsearch
```shell
curl -s -XGET 'http://${ELASTICSEARCH_HOST}:9200/_cat/thread_pool?v' | grep -E '^search' | awk '{print $4}'
```

### Check the number of active threads in Elasticsearch
```shell
curl -s -XGET 'http://${ELASTICSEARCH_HOST}:9200/_cat/thread_pool?v' | grep -E '^search' | awk '{print $3}'
```

### Check the number of rejected requests in Elasticsearch
```shell
curl -s -XGET 'http://${ELASTICSEARCH_HOST}:9200/_cat/thread_pool?v' | grep -E '^search' | awk '{print $6}'
```

### Check the number of completed requests in Elasticsearch
```shell
curl -s -XGET 'http://${ELASTICSEARCH_HOST}:9200/_cat/thread_pool?v' | grep -E '^search' | awk '{print $7}'
```

### Check the number of failed requests in Elasticsearch
```shell
curl -s -XGET 'http://${ELASTICSEARCH_HOST}:9200/_cat/thread_pool?v' | grep -E '^search' | awk '{print $8}'
```

## Repair

### Increase the number of threads available in the thread pool in elasticsearch to avoid excessive queuing.
```shell


#!/bin/bash



# Set the number of threads to increase

NEW_THREAD_COUNT=${DESIRED_THREAD_COUNT}



# Set the Elasticsearch configuration file path

ELASTICSEARCH_CONFIG=${ELASTICSEARCH_CONFIG_PATH}



# Set the name of the thread pool to increase

THREAD_POOL_NAME=${THREAD_POOL_NAME}



# Update the thread pool configuration in the Elasticsearch configuration file

sed -i "s/\"$THREAD_POOL_NAME\" : {/\"$THREAD_POOL_NAME\" : {\n    \"size\" : $NEW_THREAD_COUNT,/g" $ELASTICSEARCH_CONFIG



# Restart Elasticsearch to apply the configuration changes

systemctl restart elasticsearch


```