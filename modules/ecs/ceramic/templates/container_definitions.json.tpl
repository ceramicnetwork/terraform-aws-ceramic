[
    {
        "name": "${name}",
        "image": "${ceramic_image}",
        "cpu": ${ecs_cpu},
        "memory": ${ceramic_memory},
        "ulimits": [
            {
                "name": "nofile",
                "hardLimit": 1000000,
                "softLimit": 1000000
            }
        ],
        "mountPoints": [
            {
                "sourceVolume": "${logs_volume_source}",
                "containerPath": "/usr/local/var/log"
            }
        ],
        "command": [
            "--port", "${ceramic_port}",
            "--network", "${network}",
            "--anchor-service-api", "${anchor_service_api_url}",
            "--ethereum-rpc", "${eth_rpc_url}",
            "--gateway", "${gateway}",
            "--debug", "${debug}",
            "--verbose", "${verbose}",
            "--log-to-files", "true",
            "--log-directory", "/usr/local/var/log/${directory_namespace}",
            "--cors-allowed-origins", "${cors_allowed_origins}",
            "--state-store-s3-bucket", "${s3_state_store_bucket_name}/${directory_namespace}"
        ],
        "portMappings": [
            {
                "containerPort": ${ceramic_port}
            },
            {
                "containerPort": 9229
            }
        ],
        "environment": [
            {
                "name": "NODE_ENV",
                "value": "production"
            },
            {
                "name": "AWS_ACCESS_KEY_ID",
                "value": "${s3_access_key_id}"
            },
            {
                "name": "AWS_SECRET_ACCESS_KEY",
                "value": "${s3_secret_access_key}"
            }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${log_group}",
                "awslogs-region": "${region}",
                "awslogs-stream-prefix" : "${log_stream_prefix}"
            }
        }
    }
]
