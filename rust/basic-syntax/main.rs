// main.rs
// Rust の超基本構文サンプル
// - 変数（let / mut）
// - 条件分岐
// - ループ
// - 関数
// - 構造体

fn add(a: i32, b: i32) -> i32 {
    a + b
}

struct Person {
    name: String,
    age: u32,
}

impl Person {
    fn introduce(&self) {
        println!("Hello, my name is {} and I am {} years old.", self.name, self.age);
    }
}

fn main() {
    println!("Hello, Rust TIL!");

    // 変数と計算
    let num1 = 10;
    let num2 = 20;
    let sum = num1 + num2;
    println!("sum: {}", sum);

    // 条件分岐
    let age = 18;
    if age >= 18 {
        println!("adult");
    } else {
        println!("minor");
    }

    // ループ
    for i in 0..5 {
        println!("loop: {}", i);
    }

    // 関数呼び出し
    println!("add result: {}", add(3, 4));

    // 構造体
    let person = Person {
        name: "Taro".to_string(),
        age: 30,
    };
    person.introduce();
}
