[
    {
        "name": "go-ipfs",
        "image": "${image}",
        "cpu": ${cpu},
        "memory": ${memory},
        "ulimits": [
            {
                "name": "nofile",
                "hardLimit": 1000000,
                "softLimit": 1000000
            }
        ],
        "mountPoints": [
            {
                "sourceVolume": "${repo_volume_source}",
                "containerPath": "/data/ipfs"
            }
        ],
        "portMappings": [
            {
                "containerPort": ${api_port}
            },
            {
                "containerPort": ${gateway_port}
            },
            {
                "containerPort": ${healthcheck_port}
            },
            {
                "containerPort": ${swarm_tcp_port}
            },
            {
                "containerPort": ${swarm_ws_port}
            }
        ],
        "environment": [
            {
                "name": "IPFS_LOGGING",
                "value": "${log_level}"
            },
            {
                "name": "IPFS_ANNOUNCE_ADDRESS_LIST",
                "value": "${announce_address_list}"
            },
            {
                "name": "IPFS_API_PORT",
                "value": "${api_port}"
            },
            {
                "name": "IPFS_ENABLE_API",
                "value": "${enable_api}"
            },
            {
                "name": "IPFS_ENABLE_GATEWAY",
                "value": "${enable_gateway}"
            },
            {
                "name": "IPFS_ENABLE_HEALTHCHECK",
                "value": "true"
            },
            {
                "name": "IPFS_PEER_ID",
                "value": "${peer_id}"
            },
            {
                "name": "IPFS_GATEWAY_PORT",
                "value": "${gateway_port}"
            },
            {
                "name": "IPFS_HEALTHCHECK_PORT",
                "value": "${healthcheck_port}"
            },
            {
                "name": "IPFS_S3_ACCESS_KEY_ID",
                "value": "${s3_access_key_id}"
            },
            {
                "name": "IPFS_S3_SECRET_ACCESS_KEY",
                "value": "${s3_secret_access_key}"
            },
            {
                "name": "IPFS_S3_BUCKET_NAME",
                "value": "${s3_bucket_name}"
            },
            {
                "name": "IPFS_S3_KEY_TRANSFORM",
                "value": "${s3_key_transform}"
            },
            {
                "name": "IPFS_S3_REGION",
                "value": "${s3_region}"
            },
            {
                "name": "IPFS_S3_ROOT_DIRECTORY",
                "value": "${s3_root_directory}"
            },
            {
                "name": "IPFS_SWARM_TCP_PORT",
                "value": "${swarm_tcp_port}"
            },
            {
                "name": "IPFS_SWARM_WS_PORT",
                "value": "${swarm_ws_port}"
            }
        ],
        "secrets": [
            {
                "name": "IPFS_PRIVATE_KEY",
                "valueFrom": "${private_key_arn}"
            }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${log_group}",
                "awslogs-region": "${region}",
                "awslogs-stream-prefix": "${log_stream_prefix}"
            }
        }
    }
]
