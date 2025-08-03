# Mac 环境搭建指南

## 概述

在 Mac 系统上通过 Android 虚拟机运行抢票工具是完全可行的。本指南将详细介绍如何在 Mac 上搭建完整的 Android 开发环境，并运行抢票脚本。

## 方案对比

### 方案一：Android Studio 模拟器（推荐）
- **优点**: 官方支持，稳定性好，功能完整
- **缺点**: 资源占用较大
- **适用**: 开发测试和日常使用

### 方案二：Genymotion
- **优点**: 性能优秀，启动快速
- **缺点**: 免费版功能有限
- **适用**: 专业开发

### 方案三：Parallels Desktop + Android
- **优点**: 性能最佳，接近原生体验
- **缺点**: 需要付费
- **适用**: 重度使用

## 方案一：Android Studio 模拟器（推荐）

### 1. 安装 Android Studio

#### 下载安装
```bash
# 方法一：官网下载
# 访问 https://developer.android.com/studio
# 下载 Mac 版本并安装

# 方法二：使用 Homebrew
brew install --cask android-studio
```

#### 安装步骤
1. 下载 Android Studio
2. 双击 `.dmg` 文件
3. 拖拽到 Applications 文件夹
4. 首次启动时完成初始化设置

### 2. 配置 Android 模拟器

#### 创建虚拟设备
1. 打开 Android Studio
2. 点击 "Tools" → "AVD Manager"
3. 点击 "Create Virtual Device"
4. 选择设备类型（推荐：Pixel 6）
5. 选择系统镜像（推荐：API 30 或更高）
6. 配置设备参数：
   - RAM: 4GB 或更高
   - Internal Storage: 8GB 或更高
   - SD Card: 2GB

#### 优化配置
```bash
# 在 AVD Manager 中设置以下参数：
# - Graphics: Hardware - GLES 2.0
# - Boot option: Cold boot
# - Multi-core CPU: 4 cores
# - Memory: 4GB RAM
# - VM heap: 512MB
```

### 3. 安装 AutoX.js

#### 方法一：APK 安装
1. 下载 AutoX.js APK
   ```bash
   # 下载地址
   wget https://github.com/kkevsekk1/AutoX/releases/download/6.5.8/AutoX-6.5.8.apk
   ```

2. 安装到模拟器
   ```bash
   # 启动模拟器
   # 在 Android Studio 中启动 AVD
   
   # 安装 APK
   adb install AutoX-6.5.8.apk
   ```

#### 方法二：直接安装
1. 在模拟器中打开浏览器
2. 访问 AutoX.js 下载页面
3. 下载并安装 APK

### 4. 配置权限

#### 开启无障碍服务
1. 打开 AutoX.js
2. 点击"无障碍服务"
3. 在系统设置中开启无障碍服务
4. 返回 AutoX.js 确认服务已启用

#### 其他必要权限
- 存储权限
- 悬浮窗权限
- 后台运行权限

### 5. 安装票务 APP

#### 安装猫眼 APP
```bash
# 方法一：通过 ADB 安装
adb install maoyan.apk

# 方法二：在模拟器中直接下载安装
```

#### 安装纷玩岛 APP
```bash
# 同样方法安装纷玩岛 APP
```

### 6. 导入抢票脚本

#### 方法一：通过 AutoX.js 导入
1. 在 AutoX.js 中点击"文件"
2. 选择"导入脚本"
3. 选择项目中的 JS 文件

#### 方法二：通过 ADB 传输
```bash
# 将脚本文件传输到模拟器
adb push MaoYan/MaoYanGoNew.js /sdcard/AutoX/
adb push MaoYan/MaoYanMonitor.js /sdcard/AutoX/
adb push FenWanDao/FenWanDaoGo.js /sdcard/AutoX/
```

## 方案二：Genymotion

### 1. 安装 Genymotion

#### 下载安装
```bash
# 访问 https://www.genymotion.com/
# 下载 Mac 版本
# 安装并注册账号（免费版即可）
```

#### 安装 VirtualBox
```bash
# Genymotion 需要 VirtualBox
brew install --cask virtualbox
```

### 2. 创建虚拟设备
1. 打开 Genymotion
2. 点击 "Add" 创建新设备
3. 选择设备模板（推荐：Google Pixel 6）
4. 选择 Android 版本（推荐：API 30）
5. 配置设备参数

### 3. 安装应用
```bash
# 启动虚拟设备
# 在 Genymotion 中启动设备

# 安装 AutoX.js
adb install AutoX-6.5.8.apk

# 安装票务 APP
adb install maoyan.apk
adb install fenwandao.apk
```

## 方案三：Parallels Desktop

### 1. 安装 Parallels Desktop
```bash
# 从官网下载或使用 Homebrew
brew install --cask parallels
```

### 2. 安装 Android 系统
1. 打开 Parallels Desktop
2. 选择"安装 Windows 或其他操作系统"
3. 选择"Android"选项
4. 下载并安装 Android 系统

### 3. 配置和安装
1. 在 Android 系统中安装 AutoX.js
2. 安装票务 APP
3. 配置权限和脚本

## 性能优化建议

### 1. 模拟器优化
```bash
# 在 AVD Manager 中设置：
# - Graphics: Hardware acceleration
# - Multi-core CPU: 4 cores
# - Memory: 4GB RAM
# - VM heap: 512MB
# - Boot option: Cold boot
```

### 2. 系统优化
```bash
# 关闭不必要的应用
# 释放内存空间
# 确保网络连接稳定
```

### 3. 脚本优化
```javascript
// 在脚本中添加性能优化
// 减少不必要的 DOM 查询
// 优化循环频率
// 使用更高效的点击方式
```

## 常见问题解决

### 1. 模拟器启动慢
**解决方案**:
- 增加 RAM 分配
- 使用 SSD 存储
- 开启硬件加速
- 关闭不必要的后台应用

### 2. AutoX.js 无法启动
**解决方案**:
- 检查无障碍服务是否开启
- 确认权限设置正确
- 重启模拟器
- 重新安装 AutoX.js

### 3. 脚本运行卡顿
**解决方案**:
- 降低监控频率
- 优化脚本逻辑
- 增加模拟器资源
- 关闭其他应用

### 4. 网络连接问题
**解决方案**:
- 检查网络设置
- 配置代理（如需要）
- 使用稳定的网络连接
- 测试网络延迟

## 调试技巧

### 1. 使用 ADB 调试
```bash
# 查看设备连接
adb devices

# 查看日志
adb logcat

# 截图
adb shell screencap /sdcard/screenshot.png
adb pull /sdcard/screenshot.png

# 录屏
adb shell screenrecord /sdcard/record.mp4
```

### 2. AutoX.js 调试
```javascript
// 开启调试模式
var isDebug = true;

// 添加调试日志
console.log("调试信息");

// 使用开发者工具
// 在 AutoX.js 中开启开发者模式
```

### 3. 性能监控
```bash
# 监控 CPU 使用率
adb shell top

# 监控内存使用
adb shell dumpsys meminfo

# 监控网络状态
adb shell dumpsys connectivity
```

## 最佳实践

### 1. 环境准备
- 使用稳定的网络连接
- 确保 Mac 有足够的存储空间
- 定期清理模拟器缓存
- 备份重要的脚本文件

### 2. 脚本使用
- 先在调试模式下测试
- 逐步调整参数
- 监控脚本运行状态
- 及时处理异常情况

### 3. 安全考虑
- 不要在模拟器中存储敏感信息
- 定期更新 AutoX.js 版本
- 使用安全的网络环境
- 遵守相关法律法规

## 性能对比

| 方案 | 启动速度 | 运行性能 | 稳定性 | 资源占用 | 推荐指数 |
|------|----------|----------|--------|----------|----------|
| Android Studio | 中等 | 良好 | 优秀 | 高 | ⭐⭐⭐⭐⭐ |
| Genymotion | 快 | 优秀 | 良好 | 中等 | ⭐⭐⭐⭐ |
| Parallels | 快 | 优秀 | 优秀 | 高 | ⭐⭐⭐⭐⭐ |

## 总结

在 Mac 上通过 Android 虚拟机运行抢票工具是完全可行的，推荐使用 **Android Studio 模拟器** 方案，因为它：

1. **官方支持**：稳定性好，兼容性强
2. **功能完整**：支持所有 Android 功能
3. **免费使用**：无需额外付费
4. **易于配置**：图形化界面，操作简单

通过本指南，您可以在 Mac 上成功搭建完整的抢票环境，享受跨平台的便利性。

---

**注意**: 请确保遵守相关法律法规，仅用于学习和个人使用。 