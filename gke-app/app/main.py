from fastapi import FastAPI
from starlette.requests import Request
import os
import logging

# ------- Logging 設定（Cloud Logging 向け：stdout にシンプルフォーマットで出す） -------
logging.basicConfig(
    level=os.getenv("LOG_LEVEL", "INFO"),
    format="%(asctime)s %(levelname)s %(name)s - %(message)s"
)
logger = logging.getLogger("gke-app")

app = FastAPI(
    title="GKE Base App",
    version=os.getenv("APP_VERSION", "0.1.0")
)


@app.middleware("http")
async def log_requests(request: Request, call_next):
    logger.info(f"request: {request.method} {request.url.path}")
    response = await call_next(request)
    logger.info(f"response: {request.method} {request.url.path} status={response.status_code}")
    return response


@app.get("/")
async def root():
    return {
        "message": "Hello from GKE base app!",
        "version": os.getenv("APP_VERSION", "0.1.0"),
        "env": os.getenv("APP_ENV", "local")
    }


# ---- Liveness probe 用 ----
@app.get("/healthz")
async def healthz():
    # ここで DB や外部 API の簡易チェックを入れてもOK
    return {"status": "ok"}


# ---- Readiness probe 用 ----
@app.get("/readyz")
async def readyz():
    # ここで依存サービス接続可否等を判定しても良い
    return {"status": "ready"}
