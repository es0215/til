// usingディレクティブは、名前空間を使うための宣言です。
using System;

// Programクラスの定義
class Program
{
    // Mainメソッド: プログラムのエントリーポイント
    static void Main()
    {
        // Hello Worldを表示
        Console.WriteLine("Hello, World!");

        // 条件文とループ
        int number = 5;

        if (number > 0)
        {
            Console.WriteLine("The number is positive.");
        }
        else if (number < 0)
        {
            Console.WriteLine("The number is negative.");
        }
        else
        {
            Console.WriteLine("The number is zero.");
        }

        for (int i = 0; i < 5; i++)
        {
            Console.WriteLine("Iteration " + i);
        }

        // 関数の定義と呼び出し
        int result = AddNumbers(3, 4);
        Console.WriteLine("The result is: " + result);

        // クラスとオブジェクトの利用
        Person person1 = new Person();
        person1.Name = "John";
        person1.Age = 30;
        person1.Introduce();

        Person person2 = new Person();
        person2.Name = "Jane";
        person2.Age = 25;
        person2.Introduce();
    }

    // 関数の定義
    static int AddNumbers(int a, int b)
    {
        return a + b;
    }

    // Personクラスの定義
    class Person
    {
        // プロパティの定義
        public string Name { get; set; }
        public int Age { get; set; }

        // メソッドの定義
        public void Introduce()
        {
            Console.WriteLine("Hello, my name is " + Name + " and I am " + Age + " years old.");
        }
    }
}
