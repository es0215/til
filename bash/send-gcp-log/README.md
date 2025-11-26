# send-gcp-log

GCP Cloud Logging にログを送信する Bash の TIL 用サンプルです。

- JST の ISO 8601 タイムスタンプを生成する  
- gcloud コマンドで Cloud Logging にログを書き込む  
- severity（WARNING など）を指定できる  

## ファイル構成

- `send_log.sh`  
  timestamp 付きのログを GCP に送信するスクリプトです。

## 実行方法

```bash
# ディレクトリに移動
cd til/bash/send-gcp-log

# 実行権限を付与（初回のみ）
chmod +x send_log.sh

# 実行
./send_log.sh
```
