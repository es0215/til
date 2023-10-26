#!/bin/bash

# 現在の日時をISO 8601形式で取得
# timestamp=$(date -u +"%Y-%m-%dT%H:%M:%S.%NZ")

# 現在の日時をISO 8601形式で取得（タイムゾーンはJST）
timestamp=$(TZ="Asia/Tokyo" date +"%Y-%m-%dT%H:%M:%S.%NZ")

# gcloudコマンドでログを出力
gcloud logging write my-log "${timestamp} [ERROR] test messages" --severity=WARNING

gcloud logging write my-log "${timestamp} test error messages" --severity=WARNING

gcloud logging write my-log "${timestamp} 12 error messages" --severity=WARNING

gcloud logging write my-log "12 error messages" --severity=WARNING
