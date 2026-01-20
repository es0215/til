# docker-nginx

Docker で動かすための、最小構成の Nginx サンプルです。

- 静的ファイル配信用のシンプルな Nginx 構成
- Docker でのローカル実行を想定
- `index.html` を使った動作確認用ページ
- 学習・検証・雛形用途向けの最小構成


## ファイル構成

```
nginx/
├── Dockerfile # Nginx コンテナ定義
├── index.html # 表示確認用の静的 HTML
└── docker-logo.png # サンプル用画像
```

## ローカル実行方法（Docker）

### 1. ビルド

```bash
docker build -t docker-nginx:dev .
```

### 2. 起動

```bash
docker run --rm -p 8080:80 docker-nginx:dev
```

動作確認
ブラウザで以下にアクセスしてください。

```
http://localhost:8080
```

index.html の内容が表示されれば成功
