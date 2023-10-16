

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