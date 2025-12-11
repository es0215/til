# gke-base-app

GKE（Google Kubernetes Engine）で動かすための、最小構成のコンテナアプリサンプルです。

- FastAPI を使ったシンプルな Web API  
- Liveness / Readiness Probe 用エンドポイント  
- Cloud Logging を意識した標準出力ログ  
- 非 root ユーザーで安全に実行  
- Kubernetes Deployment / Service のサンプルマニフェスト付き  

## ファイル構成

```
gke-app/
├── app/
│ ├── main.py # アプリ本体
│ └── init.py
├── Dockerfile # GKE 用コンテナビルド定義
├── requirements.txt # Python ライブラリ
├── .dockerignore
└── k8s/
├── deployment.yaml # Deployment（Probe 設定あり）
└── service.yaml # ClusterIP Service
```

## ローカル実行方法

1. コマンド実行

```bash
cd gke-app
docker build -t gke-base-app:dev .
docker run --rm -p 8080:8080 gke-base-app:dev
```

2. ブラウザでアクセス：
http://localhost:8080

### 主なエンドポイント

| パス       | 用途                     |
|-----------|--------------------------|
| `/`       | 動作確認用のレスポンス   |
| `/healthz`| Liveness Probe 用        |
| `/readyz` | Readiness Probe 用       |

## GKE へのデプロイ方法

1. Artifact Registry / GCR に Push
```bash
docker tag gke-base-app:dev gcr.io/<PROJECT_ID>/gke-base-app:0.1.0
docker push gcr.io/<PROJECT_ID>/gke-base-app:0.1.0
```

2. Kubernetes リソースを適用

```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```
