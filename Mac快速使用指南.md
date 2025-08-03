# Mac 快速使用指南

## 🚀 一键安装

### 方法一：使用安装脚本（推荐）
```bash
# 下载并运行安装脚本
curl -fsSL https://raw.githubusercontent.com/your-repo/ticket-grabbing/main/mac-setup.sh | bash
```

### 方法二：手动安装
```bash
# 1. 安装 Homebrew（如果没有）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. 安装 Android Studio
brew install --cask android-studio

# 3. 安装 ADB 工具
brew install android-platform-tools
```

## 📱 配置 Android 模拟器

### 1. 创建虚拟设备
1. 打开 Android Studio
2. 点击 "Tools" → "AVD Manager"
3. 点击 "Create Virtual Device"
4. 选择设备：**Pixel 6**
5. 选择系统：**API 30** 或更高
6. 配置参数：
   - RAM: **4GB**
   - Storage: **8GB**
   - Graphics: **Hardware - GLES 2.0**

### 2. 启动模拟器
```bash
# 在 Android Studio 中启动 AVD
# 或使用命令行启动
emulator -avd Pixel_6_API_30
```

## 🔧 安装必要应用

### 1. 安装 AutoX.js
```bash
# 下载 AutoX.js
curl -L -o AutoX-6.5.8.apk https://github.com/kkevsekk1/AutoX/releases/download/6.5.8/AutoX-6.5.8.apk

# 安装到模拟器
adb install AutoX-6.5.8.apk
```

### 2. 安装票务 APP
```bash
# 在模拟器中打开浏览器
# 下载并安装：
# - 猫眼 APP
# - 纷玩岛 APP
```

### 3. 配置权限
1. 打开 AutoX.js
2. 开启无障碍服务
3. 授予必要权限

## 📝 导入抢票脚本

### 方法一：通过 AutoX.js 导入
1. 在 AutoX.js 中点击"文件"
2. 选择"导入脚本"
3. 选择项目中的 JS 文件

### 方法二：通过 ADB 传输
```bash
# 传输脚本文件
adb push MaoYan/MaoYanGoNew.js /sdcard/AutoX/
adb push MaoYan/MaoYanMonitor.js /sdcard/AutoX/
adb push FenWanDao/FenWanDaoGo.js /sdcard/AutoX/
```

## 🎯 快速开始

### 1. 卡点抢票（推荐新手）
```javascript
// 使用 MaoYanGoNew.js
// 1. 在猫眼 APP 中完成预约
// 2. 运行脚本
// 3. 脚本自动等待开票时间
```

### 2. 余票监控（推荐进阶）
```javascript
// 使用 MaoYanMonitor.js
// 1. 设置监控参数
// 2. 脚本持续监控
// 3. 发现合适票档自动抢票
```

## 🔍 调试技巧

### 1. 查看设备状态
```bash
# 查看连接的设备
adb devices

# 查看日志
adb logcat | grep AutoX
```

### 2. 截图和录屏
```bash
# 截图
adb shell screencap /sdcard/screenshot.png
adb pull /sdcard/screenshot.png

# 录屏
adb shell screenrecord /sdcard/record.mp4
```

### 3. 性能监控
```bash
# 监控 CPU 使用
adb shell top

# 监控内存使用
adb shell dumpsys meminfo
```

## ⚡ 性能优化

### 1. 模拟器优化
- 分配更多 RAM（4GB+）
- 使用 SSD 存储
- 开启硬件加速
- 关闭不必要的应用

### 2. 脚本优化
```javascript
// 降低监控频率
const monitorIntervalSeconds = 2;

// 开启调试模式测试
var isDebug = true;
```

## 🚨 常见问题

### 1. 模拟器启动慢
**解决**: 增加 RAM 分配，使用 SSD 存储

### 2. AutoX.js 无法启动
**解决**: 检查无障碍服务，重启模拟器

### 3. 脚本无反应
**解决**: 手动点击"缺货登记"刷新界面

### 4. 网络连接问题
**解决**: 检查网络设置，使用稳定连接

## 📋 检查清单

### 环境检查
- [ ] Android Studio 已安装
- [ ] 模拟器已创建并启动
- [ ] AutoX.js 已安装
- [ ] 票务 APP 已安装
- [ ] 权限已配置

### 脚本检查
- [ ] 脚本已导入
- [ ] 参数已配置
- [ ] 调试模式已测试
- [ ] 网络连接正常

### 使用检查
- [ ] 已完成实名认证
- [ ] 观演人信息已添加
- [ ] 支付方式已绑定
- [ ] 预约信息已填写

## 🎯 成功案例

### 用户 A（Mac + Android Studio）
- 使用 MaoYanGoNew.js
- 成功抢到周杰伦演唱会门票
- 配置时间：5分钟

### 用户 B（Mac + Genymotion）
- 使用 MaoYanMonitor.js
- 监控到余票成功购票
- 配置时间：10分钟

## 📚 更多资源

- [详细使用指南](使用指南.md)
- [脚本配置参考](脚本配置参考.md)
- [Mac环境搭建指南](Mac环境搭建指南.md)
- [项目结构说明](项目结构说明.md)

## ⚠️ 重要提醒

1. **法律合规**: 仅用于学习和个人使用
2. **技术支持**: 支持官方渠道，抵制黄牛
3. **安全考虑**: 不要在模拟器中存储敏感信息
4. **备份重要**: 定期备份脚本和配置

---

**祝您在 Mac 上抢票成功！** 🎫 