using System;

namespace BasicSyntaxSample
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, C# TIL!");

            // 条件文の例
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

            // forループの例
            for (int i = 0; i < 5; i++)
            {
                Console.WriteLine($"Iteration {i}");
            }

            // メソッド呼び出しの例
            int result = AddNumbers(3, 4);
            Console.WriteLine($"The result is: {result}");

            // クラスとオブジェクトの利用例
            var person1 = new Person("John", 30);
            person1.Introduce();

            var person2 = new Person("Jane", 25);
            person2.Introduce();
        }

        // 2つの整数を足し算するだけのメソッド
        static int AddNumbers(int a, int b)
        {
            return a + b;
        }
    }
}
