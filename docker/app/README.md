# docker-app

Docker で実行するための、最小構成の Python アプリサンプルです。

- シンプルな Python アプリ構成
- Docker でのローカル実行を想定
- Pipenv / requirements.txt の両対応
- 学習・検証・雛形用途向けの最小構成


## ファイル構成

```
.
├── app/
├── venv/ # ローカル用仮想環境（※通常は .gitignore 対象）
├── Dockerfile # コンテナビルド定義
├── Pipfile # Pipenv 定義
├── Pipfile.lock # Pipenv ロックファイル
├── requirements.in # 依存関係（手書き）
└── requirements.txt # 依存関係（固定化）
```

> 補足  
> - `venv/` はローカル検証用の仮想環境です  
> - 通常は `.gitignore` に追加し、リポジトリには含めません  
> - `requirements.in` → `requirements.txt` は pip-tools 等で生成する想定です  

## ローカル実行方法（Docker）

### 1. ビルド & 起動

```bash
docker build -t docker-app:dev .
docker run --rm docker-app:dev
※ Web アプリの場合は -p <host>:<container> を指定してください。
```

### ローカル実行方法（Pipenv）

1. 依存関係のインストール

```bash
コードをコピーする
pip install pipenv
pipenv install
```

2. 実行

```bash
pipenv run python -m app.main
ローカル実行方法（requirements.txt）
Pipenv を使用しない場合の例です。
```

```bash
python -m venv .venv
# Windows
.\.venv\Scripts\activate
# macOS / Linux
source .venv/bin/activate

pip install -r requirements.txt
python -m app.main
```

依存関係の管理方針
依存ライブラリは requirements.in に記述

requirements.txt は固定化された成果物として管理

例（pip-tools 使用時）：

```bash
pip install pip-tools
pip-compile requirements.in
```
