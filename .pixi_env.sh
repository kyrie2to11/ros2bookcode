#!/bin/bash
# Pixi 环境激活脚本
# 此脚本会在 pixi 环境激活时自动执行

# 检查系统是否安装了 ROS2 Jazzy
if [ -f /opt/ros/jazzy/setup.bash ]; then
    source /opt/ros/jazzy/setup.bash
fi

# 设置 colcon 的默认选项
export COLCON_CURRENT_PREFIX="${COLCON_CURRENT_PREFIX:-$(pwd)}"
export COLCON_HOME="${COLCON_HOME:-$HOME/.colcon}"
