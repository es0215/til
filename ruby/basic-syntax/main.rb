# main.rb
# Ruby の基本構文を確認するためのサンプル
# - 変数の代入
# - 条件分岐（if / elsif / else）
# - puts による出力

# 変数 str に "TEST1" という文字列を代入します。
str = "TEST1"

# 条件分岐の例：
# str の値に応じて実行される処理が変わります。
if str == "TEST1"
  # str が "TEST1" の場合に実行されます。
  puts "This is Test1"

elsif str == "TEST2"
  # str が "TEST2" の場合に実行されます。
  puts "This is TEST2"

else
  # それ以外の値が入っている場合はこちらが実行されます。
  puts "Error"
end
