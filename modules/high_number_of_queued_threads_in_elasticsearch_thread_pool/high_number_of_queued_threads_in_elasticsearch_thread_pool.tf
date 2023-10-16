resource "shoreline_notebook" "high_number_of_queued_threads_in_elasticsearch_thread_pool" {
  name       = "high_number_of_queued_threads_in_elasticsearch_thread_pool"
  data       = file("${path.module}/data/high_number_of_queued_threads_in_elasticsearch_thread_pool.json")
  depends_on = [shoreline_action.invoke_elasticsearch_threadpool_increase]
}

resource "shoreline_file" "elasticsearch_threadpool_increase" {
  name             = "elasticsearch_threadpool_increase"
  input_file       = "${path.module}/data/elasticsearch_threadpool_increase.sh"
  md5              = filemd5("${path.module}/data/elasticsearch_threadpool_increase.sh")
  description      = "Increase the number of threads available in the thread pool in elasticsearch to avoid excessive queuing."
  destination_path = "/tmp/elasticsearch_threadpool_increase.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_elasticsearch_threadpool_increase" {
  name        = "invoke_elasticsearch_threadpool_increase"
  description = "Increase the number of threads available in the thread pool in elasticsearch to avoid excessive queuing."
  command     = "`chmod +x /tmp/elasticsearch_threadpool_increase.sh && /tmp/elasticsearch_threadpool_increase.sh`"
  params      = ["ELASTICSEARCH_CONFIG_PATH","DESIRED_THREAD_COUNT","THREAD_POOL_NAME"]
  file_deps   = ["elasticsearch_threadpool_increase"]
  enabled     = true
  depends_on  = [shoreline_file.elasticsearch_threadpool_increase]
}

