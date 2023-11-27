# ベースイメージを指定
FROM python:3.8

# 作業ディレクトリを設定
WORKDIR /app

# カレントディレクトリの内容をコピー
COPY . /app

# 依存ライブラリのインストール
RUN pip install --no-cache-dir -r requirements.txt

# ポートの公開
EXPOSE 8080

# アプリケーションの実行
CMD ["python", "app.py"]
