# FishROS 小车调试问题记录

## 问题 1: WSL Ubuntu 22.04 安装 ROS2 Humble 后，ros2 node list 无法显示节点

### 问题描述

在 WSL Ubuntu 22.04 环境中安装 ROS2 Humble 后，使用 `ros2 node list` 命令无法显示正在运行的节点名称。

### 解决方案：WSL2 网络环境下 ROS 2 节点发现问题

> **方案概述**：通过配置 `fastdds.xml` 和环境变量，解决 WSL2 网络环境下的 ROS 2 节点发现问题。

---

### 1. 创建 Fast DDS 配置文件

创建 `~/.ros/fastdds.xml` 文件：

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<profiles xmlns="http://www.eprosima.com/XMLSchemas/fastRTPS_Profiles">
    <transport_descriptors>
        <!-- UDP 传输配置：增大缓冲区 -->
        <transport_descriptor>
            <transport_id>CustomUdpTransport</transport_id>
            <type>UDPv4</type>
            <maxMessageSize>65000</maxMessageSize>
            <sendBufferSize>8388608</sendBufferSize>      <!-- 8MB -->
            <receiveBufferSize>8388608</receiveBufferSize> <!-- 8MB -->
            <non_blocking_send>true</non_blocking_send>
        </transport_descriptor>

        <!-- 共享内存传输配置：本地高性能 -->
        <transport_descriptor>
            <transport_id>CustomShmTransport</transport_id>
            <type>SHM</type>
            <maxMessageSize>65000</maxMessageSize>
        </transport_descriptor>
    </transport_descriptors>

    <!-- 参与者配置 -->
    <participant profile_name="participant_profile" is_default_profile="true">
        <rtps>
            <userTransports>
                <transport_id>CustomShmTransport</transport_id>  <!-- 优先 SHM -->
                <transport_id>CustomUdpTransport</transport_id>   <!-- 辅助 UDP -->
            </userTransports>
            <useBuiltinTransports>false</useBuiltinTransports>   <!-- 禁用默认配置 -->
        </rtps>
    </participant>
</profiles>
```

---

### 2. 配置环境变量

添加以下内容到 `~/.bashrc`：

```bash
# ==========================================
# ROS 2 WSL2 网络配置
# ==========================================

# 1. 限制通信到本地回环（最关键）
export ROS_LOCALHOST_ONLY=1

# 2. 指定 Fast DDS 配置文件
export FASTRTPS_DEFAULT_PROFILES_FILE=~/.ros/fastdds.xml

# 3. 禁用 IPv6
export ROS_AUTOMATIC_DISCOVERY_RANGE=SUBNET

# 4. 设置 ROS_DOMAIN_ID=0  确保每次WSL启动后ROS2节点在同一域, 避免daemon状态不一致导致 ros2 node list 等命令卡死
export ROS_DOMAIN_ID=0

# 5. (可选) 启用详细日志（调试时使用）
# export RCUTILS_LOGGING_SEVERITY=DEBUG
```

执行以下命令使配置立即生效：

```bash
source ~/.bashrc
```

---

### 3. 验证配置

#### 3.1 检查环境变量

```bash
echo "ROS_LOCALHOST_ONLY=$ROS_LOCALHOST_ONLY"
echo "FASTRTPS_DEFAULT_PROFILES_FILE=$FASTRTPS_DEFAULT_PROFILES_FILE"
```

#### 3.2 重置 ROS 2 守护进程

```bash
ros2 daemon stop
sleep 1
ros2 daemon start
```

#### 3.3 测试节点发现

**终端 1：启动发布节点**

```bash
ros2 run demo_nodes_cpp talker
```

**终端 2：验证节点和话题**

```bash
ros2 node list          # 应该看到 /talker
ros2 topic list         # 应该看到 /chatter
```

---

### 4. 配置说明

| 配置项 | 说明 |
|--------|------|
| `ROS_LOCALHOST_ONLY=1` | 限制 ROS 2 通信仅使用本地回环，避免 WSL2 虚拟网络问题 |
| `CustomShmTransport` | 优先使用共享内存传输，性能更高 |
| `CustomUdpTransport` | 增大 UDP 缓冲区到 8MB，避免大数据传输丢失 |
| `useBuiltinTransports=false` | 禁用默认传输配置，完全使用自定义配置 |

---

## 问题 2: Win11 使用 Podman 运行 micro-ROS 与小车通讯配置

### 配置步骤

#### 步骤 1: 配置防火墙规则（以管理员身份运行一次，永久生效）

在 Windows PowerShell（管理员）中执行：

```powershell
New-NetFirewallRule -DisplayName "Micro-ROS Agent UDP 8888" -Direction Inbound -Protocol UDP -LocalPort 8888 -Action Allow
```

#### 步骤 2: 运行 micro-ROS Agent（之后每次运行此命令）

```bash
podman run -it --rm -v /dev:/dev -v /dev/shm:/dev/shm --privileged --net=host microros/micro-ros-agent:humble udp4 --port 8888 -v6
```

---

## 问题 3: Win11 使用 Podman 运行 fishbot_laser 与小车雷达通信

### 配置步骤

#### 步骤 1: 配置防火墙规则（以管理员身份运行一次，永久生效）

在 Windows PowerShell（管理员）中执行：

```powershell
New-NetFirewallRule -DisplayName "FishBot Lidar TCP 8889" -Direction Inbound -Protocol TCP -LocalPort 8889 -Action Allow
```

#### 步骤 2: 运行 fishbot_laser（之后每次运行此命令）

```bash
podman run -it --rm --net=host -e DISPLAY=host.docker.internal:0 registry.cn-hangzhou.aliyuncs.com/fishros/fishbot_laser
```

### 说明

- `--net=host`：使用宿主机网络，性能更好，没有额外的端口映射开销


---

## 附录

### 参考链接

- [ROS 2 官方文档](https://docs.ros.org/en/humble/)
- [Fast DDS 配置文档](https://fast-dds.docs.eprosima.com/)
- [micro-ROS 官方文档](https://micro.ros.org/)

### 注意事项

1. WSL2 环境下建议始终使用 `ROS_LOCALHOST_ONLY=1`
2. 配置完成后记得重启终端或执行 `source ~/.bashrc`
3. 如遇问题，可启用 `RCUTILS_LOGGING_SEVERITY=DEBUG` 查看详细日志
