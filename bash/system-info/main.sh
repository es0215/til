#!/bin/bash

# main.sh
# システム情報取得のサンプル
# - CPU
# - メモリ
# - ディスク
# - ネットワーク

echo "=== CPU Info ==="
lscpu | head -5

echo "=== Memory Info ==="
free -h

echo "=== Disk Info ==="
df -h

echo "=== Network Interfaces ==="
ip addr show | head -10
