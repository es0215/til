#!/usr/bin/env bash
set -eu

# このスクリプトがあるディレクトリに移動
cd "$(dirname "$0")"

# コンパイル
javac TilExample.java

# 実行（build.sh に渡された引数をそのまま Java に渡す）
java TilExample "$@"
