# ベースイメージを指定
FROM python:3.11-slim

# 作業ディレクトリを設定
WORKDIR /app

# 先に requirements.txt だけコピー（キャッシュ効きやすくするため）
COPY requirements.txt /app/

# 依存ライブラリのインストール
# 社内プロキシの自己署名証明書対策で --trusted-host を付ける
RUN pip install --no-cache-dir \
    --trusted-host pypi.org \
    --trusted-host files.pythonhosted.org \
    -r requirements.txt

# アプリケーション本体をコピー
COPY . /app

# ポートの公開
EXPOSE 8080

# アプリケーションの実行
CMD ["python", "app.py"]
