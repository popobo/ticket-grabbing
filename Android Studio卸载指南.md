# Android Studio 完全卸载指南

## 概述

本指南提供了完全卸载 Android Studio 及其所有相关文件的方法，包括：
- Android Studio 应用程序
- 配置文件
- 缓存文件
- 日志文件
- Android SDK
- AVD 虚拟机
- 环境变量
- Dock 图标

## 快速卸载

### 方法一：使用自动卸载脚本（推荐）

1. **运行卸载脚本**：
   ```bash
   ./uninstall-android-studio.sh
   ```

2. **确认操作**：
   脚本会提示确认，输入 `y` 继续，输入 `n` 取消

3. **等待完成**：
   脚本会自动执行所有卸载步骤

### 方法二：手动卸载

如果脚本无法运行，可以手动执行以下步骤：

#### 1. 停止相关进程
```bash
# 停止 Android Studio
pkill -f "Android Studio"

# 停止模拟器进程
pkill -f "emulator"

# 停止 ADB 服务
adb kill-server
```

#### 2. 卸载 Homebrew 安装的版本
```bash
# 检查是否通过 Homebrew 安装
brew list --cask android-studio

# 如果存在，则卸载
brew uninstall --cask android-studio
```

#### 3. 删除应用程序
```bash
# 删除应用程序文件
sudo rm -rf "/Applications/Android Studio.app"
sudo rm -rf "/Applications/AndroidStudio.app"
sudo rm -rf "/Applications/Android Studio Canary.app"
sudo rm -rf "/Applications/AndroidStudioCanary.app"
```

#### 4. 删除配置文件
```bash
# 删除配置文件
rm -rf ~/Library/Application\ Support/Google/AndroidStudio*
rm -rf ~/Library/Application\ Support/AndroidStudio*
rm -rf ~/Library/Application\ Support/JetBrains/Toolbox/apps/AndroidStudio
rm -rf ~/Library/Application\ Support/JetBrains/AndroidStudio*
```

#### 5. 删除缓存文件
```bash
# 删除缓存文件
rm -rf ~/Library/Caches/Google/AndroidStudio*
rm -rf ~/Library/Caches/AndroidStudio*
rm -rf ~/Library/Caches/JetBrains/AndroidStudio*
rm -rf ~/Library/Caches/com.google.android.studio*
rm -rf ~/Library/Caches/com.android.studio*
```

#### 6. 删除日志文件
```bash
# 删除日志文件
rm -rf ~/Library/Logs/Google/AndroidStudio*
rm -rf ~/Library/Logs/AndroidStudio*
rm -rf ~/Library/Logs/JetBrains/AndroidStudio*
rm -rf ~/Library/Logs/com.google.android.studio*
rm -rf ~/Library/Logs/com.android.studio*
```

#### 7. 删除偏好设置文件
```bash
# 删除偏好设置文件
rm -f ~/Library/Preferences/com.google.android.studio*
rm -f ~/Library/Preferences/com.android.studio*
rm -f ~/Library/Preferences/AndroidStudio*
rm -f ~/Library/Preferences/com.jetbrains.android*
```

#### 8. 删除 Android SDK
```bash
# 删除 Android SDK
rm -rf ~/Library/Android
rm -rf ~/Android
sudo rm -rf /usr/local/android-sdk
sudo rm -rf /opt/android-sdk
```

#### 9. 删除 AVD 虚拟机
```bash
# 删除 AVD 虚拟机
rm -rf ~/.android/avd/*
rmdir ~/.android/avd 2>/dev/null || true
```

#### 10. 清理环境变量
```bash
# 备份配置文件
cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
cp ~/.bash_profile ~/.bash_profile.backup.$(date +%Y%m%d_%H%M%S)

# 删除 Android 相关环境变量
sed -i '' '/ANDROID_HOME/d' ~/.zshrc
sed -i '' '/ANDROID_SDK_ROOT/d' ~/.zshrc
sed -i '' '/Android.*sdk/d' ~/.zshrc
sed -i '' '/platform-tools/d' ~/.zshrc
sed -i '' '/emulator/d' ~/.zshrc
```

#### 11. 清理 Dock 图标
```bash
# 重启 Dock
killall Dock
```

#### 12. 删除其他相关文件
```bash
# 删除其他相关文件
rm -rf ~/Library/Saved\ Application\ State/com.google.android.studio*
rm -rf ~/Library/Saved\ Application\ State/com.android.studio*
rm -rf ~/Library/WebKit/com.google.android.studio*
rm -rf ~/Library/WebKit/com.android.studio*
rm -rf ~/Library/HTTPStorages/com.google.android.studio*
rm -rf ~/Library/HTTPStorages/com.android.studio*
rm -rf ~/Library/Containers/com.google.android.studio*
rm -rf ~/Library/Containers/com.android.studio*
```

## 验证卸载结果

### 检查残留文件
```bash
# 检查是否还有 Android Studio 相关文件
find ~/Library -name "*Android*" -o -name "*Studio*" 2>/dev/null | grep -i android

# 检查 AVD 目录
ls -la ~/.android/avd 2>/dev/null

# 检查 Android SDK
ls -la ~/Library/Android 2>/dev/null
```

### 检查环境变量
```bash
# 检查环境变量
echo $ANDROID_HOME
echo $ANDROID_SDK_ROOT

# 检查 PATH 中的 Android 相关路径
echo $PATH | grep -i android
```

## 常见问题

### Q: 卸载后 Dock 图标消失了怎么办？
A: 这是正常现象，Dock 会自动清理无效的图标。你可以手动将需要的应用程序拖拽到 Dock 中。

### Q: 卸载后想重新安装怎么办？
A: 可以：
1. 重新下载 DMG 文件进行安装
2. 使用 Homebrew: `brew install --cask android-studio`

### Q: 卸载脚本运行失败怎么办？
A: 可以：
1. 检查脚本权限：`chmod +x uninstall-android-studio.sh`
2. 手动执行卸载步骤
3. 检查是否有文件被占用，先关闭相关程序

### Q: 卸载后系统变慢了怎么办？
A: 这是正常现象，因为清理了大量缓存文件。重启系统后会恢复正常。

## 注意事项

1. **备份重要数据**：卸载前请确保备份重要的项目文件
2. **关闭相关程序**：确保 Android Studio 和相关程序已关闭
3. **管理员权限**：某些文件可能需要管理员权限才能删除
4. **重启系统**：建议卸载完成后重启系统以确保所有更改生效

## 重新安装

如果需要重新安装 Android Studio：

### 方法一：下载官方 DMG 文件
1. 访问 [Android Studio 官网](https://developer.android.com/studio)
2. 下载适合 Mac 的 DMG 文件
3. 双击安装

### 方法二：使用 Homebrew
```bash
# 安装 Android Studio
brew install --cask android-studio

# 安装 Android 平台工具
brew install android-platform-tools
```

### 方法三：使用 JetBrains Toolbox
1. 下载并安装 JetBrains Toolbox
2. 通过 Toolbox 安装 Android Studio

## 总结

通过以上步骤，可以完全卸载 Android Studio 及其所有相关文件。卸载脚本会自动处理大部分工作，如果遇到问题，可以手动执行相应的步骤。

**重要提醒**：请确保遵守相关法律法规，仅用于学习和个人使用。 