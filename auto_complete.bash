# =============================================================================
# ROS2 Pixi Project Shell Configuration
# =============================================================================
# 该脚本为 pixi 环境启用 ROS2 命令行补全功能（tab completion）
#
# 使用方法：在你的 ~/.bashrc 中添加以下行：
#   if [ -f ~/path/to/ros2bookcode/bashrc.pixi.sh ]; then
#     source ~/path/to/ros2bookcode/bashrc.pixi.sh
#   fi
# =============================================================================

# 检查是否在 pixi 环境中
# -n: 测试变量非空（长度大于 0）
# PIXI_PROJECT_ROOT: pixi 设置的环境变量，指向项目根目录
# PIXI_ENVIRONMENT_NAME: pixi 设置的环境变量，表示当前激活的环境名称
if [ -n "$PIXI_PROJECT_ROOT" ] && [ -n "$PIXI_ENVIRONMENT_NAME" ]; then
    # 防止在其他 pixi 项目中意外加载
    # [[ ]]: bash 扩展条件测试，支持通配符匹配
    # *ros2bookcode*: 通配符模式，检查路径中是否包含 "ros2bookcode"
    if [[ "$PIXI_PROJECT_ROOT" == *"ros2bookcode"* ]]; then
        # 构建 pixi 环境的完整路径
        # 例如: /home/jarvis/projects/iRail-Truck/ros2bookcode/.pixi/envs/default
        PIXI_ENV_PATH="${PIXI_PROJECT_ROOT}/.pixi/envs/${PIXI_ENVIRONMENT_NAME}"

        # -------------------------------------------------------------------------
        # 启用 ament_index 包名补全
        # -f: 测试文件存在且是普通文件
        # source: 在当前 shell 中执行脚本（使补全功能立即生效）
        # -------------------------------------------------------------------------
        if [ -f "${PIXI_ENV_PATH}/share/ament_index_python/environment/ament_index-argcomplete.bash" ]; then
            source "${PIXI_ENV_PATH}/share/ament_index_python/environment/ament_index-argcomplete.bash"
        fi

        # -------------------------------------------------------------------------
        # 启用 ros2cli 命令补全
        # 支持 ros2 run、ros2 launch、ros2 node 等命令的 tab 补全
        # -------------------------------------------------------------------------
        if [ -f "${PIXI_ENV_PATH}/share/ros2cli/environment/ros2-argcomplete.bash" ]; then
            source "${PIXI_ENV_PATH}/share/ros2cli/environment/ros2-argcomplete.bash"
        fi
    fi
fi

# autocomplete for ros2 & colcon method 2 
# eval "$(register-python-argcomplete ros2)"
# eval "$(register-python-argcomplete colcon)"