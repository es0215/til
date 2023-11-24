# マルチステージビルドを使用して、Goアプリケーションをビルド
FROM golang:alpine AS builder

WORKDIR /go/src/app
COPY . .

# 依存関係をダウンロードし、アプリケーションをビルド
RUN go get -d -v ./...
RUN go install -v ./...

# 本番用の軽量なAlpineベースのイメージを使用
FROM alpine:latest

WORKDIR /root/

# ビルドステージからアプリケーションバイナリをコピー
COPY --from=builder /go/bin/app .

# アプリケーションが使用するポートをエクスポート
EXPOSE 8080

# アプリケーションの実行コマンド
CMD ["./app"]
