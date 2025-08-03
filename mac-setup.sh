#!/bin/bash

# Mac 环境快速安装脚本
# 用于在 Mac 上快速搭建 Android 开发环境

echo "🚀 开始安装 Mac Android 开发环境..."

# 检查是否安装了 Homebrew
if ! command -v brew &> /dev/null; then
    echo "📦 安装 Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✅ Homebrew 已安装"
fi

# 更新 Homebrew
echo "🔄 更新 Homebrew..."
brew update

# 安装 Android Studio
echo "📱 安装 Android Studio..."
if ! brew list --cask android-studio &> /dev/null; then
    brew install --cask android-studio
else
    echo "✅ Android Studio 已安装"
fi

# 安装 ADB 工具
echo "🔧 安装 ADB 工具..."
brew install android-platform-tools

# 安装 Java 开发环境（用于后端服务）
echo "☕ 安装 Java 开发环境..."
brew install openjdk@11

# 安装 Maven（用于后端服务）
echo "📦 安装 Maven..."
brew install maven

# 创建项目目录
echo "📁 创建项目目录..."
mkdir -p ~/ticket-grabbing
cd ~/ticket-grabbing

# 下载 AutoX.js
echo "⬇️ 下载 AutoX.js..."
curl -L -o AutoX-6.5.8.apk https://github.com/kkevsekk1/AutoX/releases/download/6.5.8/AutoX-6.5.8.apk

# 创建配置文件
echo "⚙️ 创建配置文件..."
cat > ~/.android/adb_usb.ini << EOF
# AutoX.js USB 配置
# 添加你的设备 ID（如果需要）
EOF

# 设置环境变量
echo "🔧 设置环境变量..."
echo 'export ANDROID_HOME=$HOME/Library/Android/sdk' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/tools' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/tools/bin' >> ~/.zshrc

# 重新加载配置
source ~/.zshrc

echo ""
echo "🎉 安装完成！"
echo ""
echo "📋 接下来的步骤："
echo "1. 打开 Android Studio"
echo "2. 创建 Android 虚拟设备 (AVD)"
echo "3. 启动模拟器"
echo "4. 安装 AutoX.js: adb install AutoX-6.5.8.apk"
echo "5. 安装票务 APP"
echo "6. 导入抢票脚本"
echo ""
echo "📚 详细说明请查看：Mac环境搭建指南.md"
echo ""
echo "🔧 常用命令："
echo "- 查看设备: adb devices"
echo "- 安装 APK: adb install filename.apk"
echo "- 传输文件: adb push local_file /sdcard/"
echo "- 查看日志: adb logcat"
echo ""
echo "⚠️  注意：请确保遵守相关法律法规，仅用于学习和个人使用。" 