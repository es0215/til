# 変数strに値"TEST1"を代入します。
str = "TEST1"

# もし変数strが文字列"TEST1"と等しい場合、以下のコードが実行されます。
if str == "TEST1"
    # "This is Test1"がコンソールに出力されます。
    puts "This is Test1"
# もし変数strが文字列"TEST2"と等しい場合、以下のコードが実行されます。
elsif str == "TEST2"
    # "This is TEST2"がコンソールに出力されます。
    puts "This is TEST2"
# それ以外の場合、つまり変数strが"TEST1"でも"TEST2"でもない場合、以下のコードが実行されます。
else
    # "Error"がコンソールに出力されます。
    puts "Error"
end
