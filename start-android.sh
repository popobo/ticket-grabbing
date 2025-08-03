#!/bin/bash

# Android 模拟器快速启动脚本
# 用于快速启动 Android 模拟器并检查状态

echo "🚀 Android 模拟器启动脚本"
echo "=========================="

# 设置环境变量
export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# 检查 Android SDK 是否存在
if [ ! -d "$ANDROID_HOME" ]; then
    echo "❌ Android SDK 未找到，请先安装 Android Studio"
    exit 1
fi

# 检查 emulator 命令
EMULATOR_PATH="$ANDROID_HOME/emulator/emulator"
if [ ! -f "$EMULATOR_PATH" ]; then
    echo "❌ emulator 命令未找到"
    exit 1
fi

# 列出可用的 AVD
echo "📱 可用的 Android 虚拟设备："
$EMULATOR_PATH -list-avds

# 设置默认 AVD 名称
DEFAULT_AVD="Medium_Phone_API_36.0"

# 检查默认 AVD 是否存在
AVD_LIST=$($EMULATOR_PATH -list-avds)
if echo "$AVD_LIST" | grep -q "$DEFAULT_AVD"; then
    echo "✅ 找到默认 AVD: $DEFAULT_AVD"
    AVD_NAME="$DEFAULT_AVD"
else
    echo "⚠️  默认 AVD 不存在，请选择："
    echo "$AVD_LIST" | nl
    read -p "请输入 AVD 编号: " AVD_NUM
    AVD_NAME=$(echo "$AVD_LIST" | sed -n "${AVD_NUM}p")
    if [ -z "$AVD_NAME" ]; then
        echo "❌ 无效的选择"
        exit 1
    fi
fi

echo "🎯 启动 AVD: $AVD_NAME"

# 检查是否已有模拟器在运行
RUNNING_DEVICES=$(adb devices | grep -v "List of devices" | grep -v "^$" | wc -l)
if [ $RUNNING_DEVICES -gt 0 ]; then
    echo "⚠️  检测到已有设备运行："
    adb devices
    read -p "是否继续启动新的模拟器？(y/n): " CONTINUE
    if [ "$CONTINUE" != "y" ]; then
        echo "取消启动"
        exit 0
    fi
fi

# 启动模拟器
echo "🚀 启动 Android 模拟器..."
$EMULATOR_PATH \
    -avd "$AVD_NAME" \
    -gpu host \
    -memory 4096 \
    -cores 4 \
    -no-snapshot-load \
    -no-snapshot-save \
    &

# 等待模拟器启动
echo "⏳ 等待模拟器启动..."
sleep 10

# 检查启动状态
MAX_WAIT=60
WAIT_COUNT=0
while [ $WAIT_COUNT -lt $MAX_WAIT ]; do
    DEVICES=$(adb devices | grep -v "List of devices" | grep -v "^$" | wc -l)
    if [ $DEVICES -gt 0 ]; then
        echo "✅ 模拟器启动成功！"
        echo "📱 连接的设备："
        adb devices
        break
    fi
    
    echo "⏳ 等待中... ($WAIT_COUNT/$MAX_WAIT)"
    sleep 2
    WAIT_COUNT=$((WAIT_COUNT + 2))
done

if [ $WAIT_COUNT -ge $MAX_WAIT ]; then
    echo "❌ 模拟器启动超时"
    exit 1
fi

# 显示设备信息
echo ""
echo "📊 设备信息："
adb shell getprop ro.product.model
adb shell getprop ro.build.version.release
adb shell getprop ro.build.version.sdk

# 检查 AutoX.js 是否安装
echo ""
echo "🔍 检查 AutoX.js..."
if adb shell pm list packages | grep -q "org.autojs.autojs"; then
    echo "✅ AutoX.js 已安装"
else
    echo "⚠️  AutoX.js 未安装"
    echo "请运行以下命令安装："
    echo "adb install AutoX-6.5.8.apk"
fi

# 检查票务 APP
echo ""
echo "🔍 检查票务 APP..."
if adb shell pm list packages | grep -q "com.maoyan"; then
    echo "✅ 猫眼 APP 已安装"
else
    echo "⚠️  猫眼 APP 未安装"
fi

if adb shell pm list packages | grep -q "com.fenwandao"; then
    echo "✅ 纷玩岛 APP 已安装"
else
    echo "⚠️  纷玩岛 APP 未安装"
fi

echo ""
echo "🎉 模拟器启动完成！"
echo ""
echo "📋 常用命令："
echo "- 查看设备: adb devices"
echo "- 安装 APK: adb install filename.apk"
echo "- 传输文件: adb push local_file /sdcard/"
echo "- 查看日志: adb logcat"
echo "- 截图: adb shell screencap /sdcard/screenshot.png"
echo ""
echo "🔧 下一步："
echo "1. 安装 AutoX.js（如果未安装）"
echo "2. 安装票务 APP"
echo "3. 导入抢票脚本"
echo "4. 开始使用"
echo ""
echo "⚠️  注意：请确保遵守相关法律法规，仅用于学习和个人使用。" 