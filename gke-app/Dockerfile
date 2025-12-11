# 1. ベースイメージ
FROM python:3.12-slim AS runtime

# 2. 環境変数（Python高速起動 & バッファリング無効化）
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    APP_HOME=/app \
    PORT=8080

WORKDIR ${APP_HOME}

# 3. 必要パッケージ（ビルド・ランタイム）
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 4. 依存関係のインストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. アプリケーションコードコピー
COPY app ./app

# 6. 非rootユーザーを作成して切り替え
RUN useradd -m appuser
USER appuser

# 7. 起動コマンド（uvicorn）
#   - GKE用に 0.0.0.0:8080 で待ち受け
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]

# 8. Cloud Run / GKE 用にポート 8080 を宣言
EXPOSE 8080
