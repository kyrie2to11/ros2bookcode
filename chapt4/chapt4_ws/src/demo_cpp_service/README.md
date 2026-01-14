# Demo CPP Service 运行指南

本包演示了ROS2服务通信,包含海龟控制和巡逻功能。

## 运行步骤

要运行此演示,需要在三个不同的终端中依次执行以下命令:

### 终端 1: 启动 Turtlesim 仿真环境
```bash
ros2 run turtlesim turtlesim_node
```

### 终端 2: 启动海龟控制服务
```bash
ros2 run demo_cpp_service turtle_control
```

### 终端 3: 启动巡逻客户端
```bash
ros2 run demo_cpp_service patrol_client
```

## 功能说明

- **turtlesim_node**: 提供海龟仿真环境
- **turtle_control**: 提供海龟运动控制服务
- **patrol_client**: 向海龟控制服务发送巡逻命令

运行前请确保已source ROS2工作空间环境:
```bash
source /path/to/your/ros2_ws/install/setup.bash
```
