#!/bin/bash

# Android Studio 完全卸载脚本
# 用于卸载 Android Studio 及其所有相关文件，包括虚拟机

echo "🚀 开始卸载 Android Studio 及其虚拟机..."

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 函数：打印带颜色的消息
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 函数：检查文件是否存在
check_and_remove() {
    local path="$1"
    local description="$2"
    
    if [ -e "$path" ]; then
        print_status "删除 $description: $path"
        rm -rf "$path"
        print_success "$description 已删除"
    else
        print_warning "$description 不存在: $path"
    fi
}

# 函数：停止相关进程
stop_processes() {
    print_status "停止 Android Studio 相关进程..."
    
    # 停止 Android Studio
    pkill -f "Android Studio" 2>/dev/null || true
    
    # 停止模拟器进程
    pkill -f "emulator" 2>/dev/null || true
    
    # 停止 ADB 服务
    adb kill-server 2>/dev/null || true
    
    print_success "进程已停止"
}

# 函数：卸载 Homebrew 安装的 Android Studio
uninstall_homebrew_android_studio() {
    print_status "检查 Homebrew 安装的 Android Studio..."
    
    if brew list --cask android-studio &> /dev/null; then
        print_status "发现 Homebrew 安装的 Android Studio，正在卸载..."
        brew uninstall --cask android-studio
        print_success "Homebrew Android Studio 已卸载"
    else
        print_warning "未发现 Homebrew 安装的 Android Studio"
    fi
}

# 函数：删除应用程序
remove_application() {
    print_status "删除 Android Studio 应用程序..."
    
    # 查找 Android Studio 应用程序
    local android_studio_apps=(
        "/Applications/Android Studio.app"
        "/Applications/AndroidStudio.app"
        "/Applications/Android Studio Canary.app"
        "/Applications/AndroidStudioCanary.app"
    )
    
    for app in "${android_studio_apps[@]}"; do
        check_and_remove "$app" "Android Studio 应用程序"
    done
}

# 函数：删除配置文件
remove_config_files() {
    print_status "删除 Android Studio 配置文件..."
    
    # Android Studio 配置文件
    local config_paths=(
        "$HOME/Library/Application Support/Google/AndroidStudio*"
        "$HOME/Library/Application Support/AndroidStudio*"
        "$HOME/Library/Application Support/JetBrains/Toolbox/apps/AndroidStudio"
        "$HOME/Library/Application Support/JetBrains/AndroidStudio*"
    )
    
    for path in "${config_paths[@]}"; do
        for dir in $path; do
            check_and_remove "$dir" "Android Studio 配置文件"
        done
    done
}

# 函数：删除缓存文件
remove_cache_files() {
    print_status "删除 Android Studio 缓存文件..."
    
    # 缓存文件路径
    local cache_paths=(
        "$HOME/Library/Caches/Google/AndroidStudio*"
        "$HOME/Library/Caches/AndroidStudio*"
        "$HOME/Library/Caches/JetBrains/AndroidStudio*"
        "$HOME/Library/Caches/com.google.android.studio*"
        "$HOME/Library/Caches/com.android.studio*"
    )
    
    for path in "${cache_paths[@]}"; do
        for dir in $path; do
            check_and_remove "$dir" "Android Studio 缓存文件"
        done
    done
}

# 函数：删除日志文件
remove_log_files() {
    print_status "删除 Android Studio 日志文件..."
    
    # 日志文件路径
    local log_paths=(
        "$HOME/Library/Logs/Google/AndroidStudio*"
        "$HOME/Library/Logs/AndroidStudio*"
        "$HOME/Library/Logs/JetBrains/AndroidStudio*"
        "$HOME/Library/Logs/com.google.android.studio*"
        "$HOME/Library/Logs/com.android.studio*"
    )
    
    for path in "${log_paths[@]}"; do
        for dir in $path; do
            check_and_remove "$dir" "Android Studio 日志文件"
        done
    done
}

# 函数：删除偏好设置文件
remove_preferences() {
    print_status "删除 Android Studio 偏好设置文件..."
    
    # 偏好设置文件路径
    local preference_paths=(
        "$HOME/Library/Preferences/com.google.android.studio*"
        "$HOME/Library/Preferences/com.android.studio*"
        "$HOME/Library/Preferences/AndroidStudio*"
        "$HOME/Library/Preferences/com.jetbrains.android*"
    )
    
    for path in "${preference_paths[@]}"; do
        for file in $path; do
            check_and_remove "$file" "Android Studio 偏好设置文件"
        done
    done
}

# 函数：删除 Android SDK
remove_android_sdk() {
    print_status "删除 Android SDK..."
    
    # Android SDK 路径
    local sdk_paths=(
        "$HOME/Library/Android"
        "$HOME/Android"
        "/usr/local/android-sdk"
        "/opt/android-sdk"
    )
    
    for path in "${sdk_paths[@]}"; do
        check_and_remove "$path" "Android SDK"
    done
}

# 函数：删除 AVD 虚拟机
remove_avd_virtual_machines() {
    print_status "删除 Android 虚拟设备 (AVD)..."
    
    # AVD 目录
    local avd_path="$HOME/.android/avd"
    
    if [ -d "$avd_path" ]; then
        print_status "发现 AVD 目录: $avd_path"
        
        # 列出所有 AVD
        if [ -d "$avd_path" ] && [ "$(ls -A "$avd_path" 2>/dev/null)" ]; then
            echo "发现的 AVD 列表："
            ls -la "$avd_path"
            
            # 删除所有 AVD
            rm -rf "$avd_path"/*
            print_success "所有 AVD 已删除"
        else
            print_warning "AVD 目录为空"
        fi
        
        # 删除 AVD 目录本身
        rmdir "$avd_path" 2>/dev/null || true
    else
        print_warning "未发现 AVD 目录"
    fi
}

# 函数：删除 Android 相关环境变量
remove_environment_variables() {
    print_status "清理 Android 相关环境变量..."
    
    # 备份配置文件
    local config_files=("$HOME/.zshrc" "$HOME/.bash_profile" "$HOME/.bashrc")
    
    for config_file in "${config_files[@]}"; do
        if [ -f "$config_file" ]; then
            print_status "清理 $config_file 中的 Android 环境变量..."
            
            # 创建备份
            cp "$config_file" "$config_file.backup.$(date +%Y%m%d_%H%M%S)"
            
            # 删除 Android 相关环境变量
            sed -i '' '/ANDROID_HOME/d' "$config_file"
            sed -i '' '/ANDROID_SDK_ROOT/d' "$config_file"
            sed -i '' '/Android.*sdk/d' "$config_file"
            sed -i '' '/platform-tools/d' "$config_file"
            sed -i '' '/emulator/d' "$config_file"
            
            print_success "$config_file 已清理"
        fi
    done
}

# 函数：清理 Dock 图标
clean_dock_icons() {
    print_status "清理 Dock 中的 Android Studio 图标..."
    
    # 重启 Dock 来清理图标
    killall Dock 2>/dev/null || true
    print_success "Dock 图标已清理"
}

# 函数：清理其他相关文件
remove_other_files() {
    print_status "清理其他相关文件..."
    
    # 其他可能的文件路径
    local other_paths=(
        "$HOME/Library/Saved Application State/com.google.android.studio*"
        "$HOME/Library/Saved Application State/com.android.studio*"
        "$HOME/Library/WebKit/com.google.android.studio*"
        "$HOME/Library/WebKit/com.android.studio*"
        "$HOME/Library/HTTPStorages/com.google.android.studio*"
        "$HOME/Library/HTTPStorages/com.android.studio*"
        "$HOME/Library/Containers/com.google.android.studio*"
        "$HOME/Library/Containers/com.android.studio*"
    )
    
    for path in "${other_paths[@]}"; do
        for dir in $path; do
            check_and_remove "$dir" "其他相关文件"
        done
    done
}

# 函数：验证卸载结果
verify_uninstall() {
    print_status "验证卸载结果..."
    
    local remaining_files=0
    
    # 检查是否还有 Android Studio 相关文件
    local check_paths=(
        "$HOME/Library/Application Support/Google/AndroidStudio*"
        "$HOME/Library/Caches/Google/AndroidStudio*"
        "$HOME/Library/Logs/Google/AndroidStudio*"
        "$HOME/Library/Preferences/com.google.android.studio*"
        "$HOME/Library/Android"
        "$HOME/.android/avd"
    )
    
    for path in "${check_paths[@]}"; do
        for file in $path; do
            if [ -e "$file" ]; then
                print_warning "发现残留文件: $file"
                ((remaining_files++))
            fi
        done
    done
    
    if [ $remaining_files -eq 0 ]; then
        print_success "✅ Android Studio 卸载完成！"
    else
        print_warning "⚠️  发现 $remaining_files 个残留文件，可能需要手动清理"
    fi
}

# 函数：显示卸载总结
show_summary() {
    echo ""
    echo "📋 Android Studio 卸载总结："
    echo "✓ 应用程序文件"
    echo "✓ 配置文件"
    echo "✓ 缓存文件"
    echo "✓ 日志文件"
    echo "✓ 偏好设置文件"
    echo "✓ Android SDK"
    echo "✓ AVD 虚拟机"
    echo "✓ 环境变量"
    echo "✓ Dock 图标"
    echo "✓ 其他相关文件"
    echo ""
    echo "🎉 卸载完成！"
    echo ""
    echo "💡 提示："
    echo "- 如果需要重新安装，可以下载新的 DMG 文件"
    echo "- 或者使用 Homebrew: brew install --cask android-studio"
    echo "- 重启系统以确保所有更改生效"
    echo ""
    echo "⚠️  注意：请确保遵守相关法律法规，仅用于学习和个人使用。"
}

# 主函数
main() {
    echo "=========================================="
    echo "    Android Studio 完全卸载脚本"
    echo "=========================================="
    echo ""
    
    # 确认操作
    read -p "⚠️  此操作将完全删除 Android Studio 及其所有相关文件，包括虚拟机。确定继续吗？(y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ 操作已取消"
        exit 1
    fi
    
    echo ""
    
    # 执行卸载步骤
    stop_processes
    uninstall_homebrew_android_studio
    remove_application
    remove_config_files
    remove_cache_files
    remove_log_files
    remove_preferences
    remove_android_sdk
    remove_avd_virtual_machines
    remove_environment_variables
    clean_dock_icons
    remove_other_files
    verify_uninstall
    show_summary
}

# 执行主函数
main "$@" 