#!/bin/bash

# send_log.sh
# GCP Cloud Logging にタイムスタンプ付きログを送信するサンプル
# - JST の ISO 8601 形式で日時を生成
# - gcloud logging write を使ってログを送る

# 現在の日時（タイムゾーン：JST）を ISO 8601 形式で取得
timestamp=$(TZ="Asia/Tokyo" date +"%Y-%m-%dT%H:%M:%S.%NZ")

# Cloud Logging にログを送信
gcloud logging write my-log "${timestamp} [ERROR] test messages" --severity=WARNING
gcloud logging write my-log "${timestamp} test error messages" --severity=WARNING
gcloud logging write my-log "${timestamp} 12 error messages" --severity=WARNING
gcloud logging write my-log "12 error messages" --severity=WARNING
