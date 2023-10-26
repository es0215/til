デプロイコマンド
```
gcloud run deploy cloudrun \
    --image asia-northeast1-docker.pkg.dev/${project_id}/cloudrun/${image_tag}:${image_version} \
    --platform managed \
    --region asia-northeast1
```
