#!/bin/bash

# main.sh
# Bash の基本構文サンプル
# - 変数
# - 条件分岐
# - ループ
# - 関数

name="Taro"
age=20

echo "Name: $name"
echo "Age: $age"

# 条件分岐
if [ $age -ge 18 ]; then
  echo "adult"
else
  echo "minor"
fi

# ループ（1〜5）
for i in {1..5}; do
  echo "loop: $i"
done

# 関数
greet() {
  echo "Hello, $1!"
}

greet "Taro"
