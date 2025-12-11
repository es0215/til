# gke-zabbix

GKE 上で **Zabbix Server + Zabbix Web + PostgreSQL** を動かす最小構成サンプルです。

- PostgreSQL / Zabbix Server / Zabbix Web を Kubernetes 上で動作  
- GKE 内に閉じた構成（外部 DB 不要）  
- Web UI は LoadBalancer 経由でアクセス可能  
- Cloud SQL 版 / Ingress 版へ拡張も容易  

## ファイル構成

```
gke-zabbix/
└── k8s/
├── namespace-and-secret.yaml # Namespace と DB 認証用 Secret
├── postgres-statefulset.yaml # PostgreSQL StatefulSet + Service
├── zabbix-server-deployment.yaml # Zabbix Server Deployment
├── zabbix-web-deployment.yaml # Zabbix Web (NGINX + PHP) Deployment
└── services.yaml # 各サービスの Service 定義
```

## デプロイ方法

1. Namespace & Secret の作成

```bash
kubectl apply -f k8s/namespace-and-secret.yaml
```

2. PostgreSQL のデプロイ

```bash
kubectl apply -f k8s/postgres-statefulset.yaml
```

3. Zabbix Server のデプロイ

```bash
kubectl apply -f k8s/zabbix-server-deployment.yaml
```

4. Zabbix Web のデプロイ

```bash
kubectl apply -f k8s/zabbix-web-deployment.yaml
```

5. Service の作成

```bash
kubectl apply -f k8s/services.yaml
```

## Zabbix Web UI へのアクセス

`services.yaml`では`zabbix-web Service`が`LoadBalancer`になっています。

```bash
kubectl get svc -n monitoring
```

例：
```pgsql
NAME          TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)
zabbix-web    LoadBalancer   10.20.30.40    34.82.xxx.xxx   80:31672/TCP
```

ブラウザでアクセス：
```cpp
http://<EXTERNAL-IP>
```