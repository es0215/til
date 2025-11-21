# cli-date-args

Java での超シンプルな TIL 用サンプルです。

- 今日の日付を表示する
- コマンドライン引数の数と中身を表示する
- メソッドを定義して呼び出す（足し算）

## ファイル構成

- `TilExample.java`  
  メインの Java コード

- `build.sh`  
  コンパイル & 実行用のシェルスクリプト  
  （引数はそのまま Java プログラムに渡されます）

## 実行方法

```bash
# ディレクトリに移動
cd til/java/cli-date-args

# 初回のみ（権限付与）
chmod +x build.sh

# 引数なしで実行
./build.sh

# 引数ありで実行
./build.sh hello world 123
```
