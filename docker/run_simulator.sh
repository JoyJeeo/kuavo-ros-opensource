#!/bin/bash
TASK_ID=${1:-1}
# CONTAINER_NAME="kuavo_container_GPU_a3e27def"
# CONTAINER_NAME="kuavo_container_GPU_70be76ae"
CONTAINER_NAME="kuavo_container_GPU_ae83ed4b"

# 启动容器，如果没运行就启动
if [ "$(docker ps -q -f name=${CONTAINER_NAME})" ]; then
    echo "Container ${CONTAINER_NAME} is already running."
else
    echo "Starting container ${CONTAINER_NAME}..."
    docker start  ${CONTAINER_NAME}
fi

# 在容器里执行命令s
docker exec -it ${CONTAINER_NAME} bash -c "
    ulimit -c 0 && \
    source ~/.zshrc && \
    export ROBOT_VERSION=45 && \
    cd devel && source setup.bash && cd .. && \
    python3 src/data_challenge_simulator/examples/deploy/deploy.py --task_id=${TASK_ID}
"
