# ROS 2机器人开发：从入门到实践 / ROS 2 Robot Development: From Beginner to Practice  
书籍配套代码 / Book Companion Code

![](./image/book.jpg)

---

机器人开发是一项复杂的系统工程，ROS 2为智能机器人开发提供了强有力的支持，极大地提高了机器人软件开发效率。本书首先对ROS 2的基础概念、通信机制、常用库和工具进行介绍，带领读者入门ROS 2机器人开发；接着引导读者完成移动机器人的建模和仿真、建图和导航、自定义控制器和规划器等一系列实践；然后在真机实战环节，通过制作一个基于ROS 2的真实机器人，帮助读者打通仿真与真机之间的壁垒；最后，本书深入讲解了ROS 2进阶使用的相关知识，为读者进一步在实战中使用ROS 2进行机器人开发打下夯实基础。考虑读者基础，书中示例均以C++和Python两种语言实现，同时加入了关于C++新特性、Git工具、多线程和回调函数等基础知识的讲解。  

Robot development is a complex system engineering task. ROS 2 provides robust support for intelligent robot development, significantly improving the efficiency of robot software development. This book first introduces the fundamental concepts, communication mechanisms, common libraries, and tools of ROS 2 to guide readers into ROS 2 robot development. It then leads readers through practical tasks such as mobile robot modeling and simulation, mapping and navigation, and custom controllers and planners. In the real-world implementation section, by building an actual ROS 2-based robot, the book helps readers bridge the gap between simulation and real hardware. Finally, it dives into advanced ROS 2 topics, laying a solid foundation for further practical applications. To accommodate diverse reader backgrounds, all examples are implemented in both C++ and Python, with additional explanations on modern C++ features, Git tools, multithreading, and callback functions.

---

## 配套代码介绍 / Companion Code Introduction  
本项目为《ROS 2机器人开发：从入门到实践》书籍配套代码，包含ROS 2机器人开发相关的示例代码。  

This project contains companion code for the book *ROS 2 Robot Development: From Beginner to Practice*, including example code related to ROS 2 robot development.

---

## 原作者 / Original Author

- [小鱼 (Fish)](https://github.com/fishros)

## 改进版 / Modified Version

- [kyrie2to11](https://github.com/kyrie2to11)

---

## 环境配置 / Environment Setup

本项目使用 [pixi](https://pixi.sh) 进行依赖管理和环境配置,便于复现环境。

This project uses [pixi](https://pixi.sh) for dependency management and environment configuration.

### ROS2 命令行自动补全 / ROS2 Command Line Autocomplete

在 pixi 环境中使用 ROS2 命令时，可以启用 tab 补全功能。

To enable tab completion for ROS2 commands in the pixi environment, use the following methods:

**方法 1 / Method 1**: Source the completion script

```bash
pixi shell
source auto_complete.bash
```

**方法 2 / Method 2**: 使用 `register-python-argcomplete` (需要安装 argcomplete 但由于依赖传递已自动安装 / argcomplete needs to be installed, but it was already installed automatically due to transitive dependencies.)

```bash
pixi shell
eval "$(register-python-argcomplete ros2)"
eval "$(register-python-argcomplete colcon)"
```

**注意 / Note**: 由于 pixi 的 activation scripts 限制，自动激活补全功能暂时无法通过 `[activation]` 配置实现，需要在进入 pixi 环境后手动执行上述命令。

Due to pixi activation scripts limitations, automatic completion activation cannot be achieved through `[activation]` configuration yet. You need to manually execute the above commands after entering the pixi environment.

### 构建工作空间 / Build Workspace

```bash
# 进入 pixi 环境 / Enter pixi environment
pixi shell

# 进入 ROS2 workspace / Enter ROS2 workspace
cd /path/to/workspace

# 构建工作空间 / Build workspace
pixi run build
# 或 / or
colcon build
```
