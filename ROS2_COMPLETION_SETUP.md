# ROS2 Tab Completion 设置说明

## 问题说明

Pixi 的 `[activation] scripts` 在**非交互式环境**中执行，而 shell 补全功能需要在**交互式 shell** 中才能工作。因此无法通过 pixi.toml 的 activation scripts 自动启用 ROS2 的 tab completion。

## 解决方法

在你的 `~/.bashrc` 文件末尾添加以下内容：

```bash
# ROS2 Pixi Project Tab Completion
if [ -f ~/projects/iRail-Truck/ros2bookcode/bashrc.pixi.sh ]; then
    source ~/projects/iRail-Truck/ros2bookcode/bashrc.pixi.sh
fi
```

## 验证

重新加载你的 bashrc 并进入 pixi 环境：

```bash
source ~/.bashrc          # 重新加载配置
cd ~/projects/iRail-Truck/ros2bookcode
pixi shell                # 进入 pixi 环境

# 测试补全功能
ros2 run <按 Tab 键>       # 应该显示可用的包
ros2 launch <按 Tab 键>    # 应该显示可用的 launch 文件
```

## 工作原理

- 每次启动交互式 shell 时，`~/.bashrc` 会被自动加载
- `bashrc.pixi.sh` 会检测是否在 pixi 环境中
- 如果在正确的 pixi 项目中，自动加载 ROS2 补全脚本
- 不影响其他项目或非 pixi 环境
