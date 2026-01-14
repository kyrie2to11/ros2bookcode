#!/bin/bash
# Filter out host ROS2 paths from CMAKE_PREFIX_PATH to avoid conflicts
# Only keep pixi environment paths

if [ -n "$CMAKE_PREFIX_PATH" ]; then
    # Filter out paths containing /opt/ros/ to remove host ROS2 installations
    # Keep only pixi environment paths
    filtered_path=$(echo "$CMAKE_PREFIX_PATH" | tr ':' '\n' | grep -v '/opt/ros/' | tr '\n' ':' | sed 's/:$//')
    export CMAKE_PREFIX_PATH="$filtered_path"
fi
