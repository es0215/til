#!/bin/bash

# main.sh
# curl を使った HTTP リクエストのサンプル
# - GET リクエスト
# - JSON 整形 (jq があれば使用)

URL="https://api.github.com"

echo "Requesting: $URL"

response=$(curl -s $URL)

echo "Raw response:"
echo "$response"

# jq があれば整形
if command -v jq >/dev/null 2>&1; then
  echo "Formatted JSON:"
  echo "$response" | jq .
fi
