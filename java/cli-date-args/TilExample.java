// TilExample.java
// Today I Learned: Java の超シンプルサンプル
// - 今日の日付を表示
// - コマンドライン引数の数と中身を表示
// - メソッド呼び出し（足し算）の例

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class TilExample {

    public static void main(String[] args) {
        // 今日の日付を表示
        LocalDate today = LocalDate.now();
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        System.out.println("Today I Learned in Java! (" + today.format(fmt) + ")");

        // コマンドライン引数の表示
        if (args.length == 0) {
            System.out.println("引数はありません。");
        } else {
            System.out.println("引数の数: " + args.length);
            for (int i = 0; i < args.length; i++) {
                System.out.println("arg[" + i + "]: " + args[i]);
            }
        }

        // 簡単なメソッド呼び出しの例
        int a = 3;
        int b = 5;
        int sum = add(a, b);
        System.out.println(a + " + " + b + " = " + sum);
    }

    /**
     * 2つの整数を足し算するだけのメソッド
     */
    private static int add(int x, int y) {
        return x + y;
    }
}
