package main

import (
	"net/http"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

// メトリクスのためのカウンター
var (
	requests = prometheus.NewCounterVec(
		prometheus.CounterOpts{
			Name: "http_requests_total",
			Help: "Total number of HTTP requests",
		},
		[]string{"code", "method"},
	)

	// メトリクスのためのヒストグラム
	duration = prometheus.NewHistogramVec(
		prometheus.HistogramOpts{
			Name:    "http_request_duration_seconds",
			Help:    "Histogram of the HTTP request duration",
			Buckets: prometheus.DefBuckets,
		},
		[]string{"code", "method"},
	)
)

// カウンターとヒストグラムを初期化して登録する
func init() {
	prometheus.MustRegister(requests)
	prometheus.MustRegister(duration)
}

// メインのHTTPハンドラー
func main() {
	// メトリクスエンドポイントのハンドラーを設定
	http.Handle("/metrics", promhttp.Handler())
	// アプリケーションのメインハンドラーを設定
	http.HandleFunc("/", handler)
	// ポート8080でHTTPサーバーを起動
	http.ListenAndServe(":8080", nil)
}

// 実際のリクエストを処理するハンドラー
func handler(w http.ResponseWriter, r *http.Request) {
	// レスポンスコードとHTTPメソッドを取得
	code := http.StatusOK
	method := r.Method

	// レスポンス時間を計測するためのタイマーを作成し、関数が終了したら観測
	timer := prometheus.NewTimer(duration.WithLabelValues(http.StatusText(code), method))
	defer timer.ObserveDuration()

	// カウンターをインクリメント
	requests.WithLabelValues(http.StatusText(code), method).Inc()

	// レスポンスコードとメッセージを返す
	w.WriteHeader(code)
	w.Write([]byte("Hello, World!"))
}
