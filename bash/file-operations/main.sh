
#!/bin/bash

# main.sh
# Bash のファイル操作サンプル
# - ファイルの存在チェック
# - 作成
# - 読み込み
# - 削除

FILE="sample.txt"

# ファイル作成
echo "Hello World" > $FILE
echo "Created: $FILE"

# 存在チェック
if [ -f $FILE ]; then
  echo "File exists."
fi

# 中身を読み込む
echo "Contents:"
cat $FILE

# 削除
rm $FILE
echo "Deleted: $FILE"
