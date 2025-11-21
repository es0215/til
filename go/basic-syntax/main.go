// main.go
// Goの超基本構文サンプル
// - 変数
// - 条件分岐
// - ループ
// - 関数
// - 構造体（class相当）

package main

import "fmt"

// 足し算する関数
func add(a int, b int) int {
	return a + b
}

// Person構造体（データのまとまり）
type Person struct {
	Name string
	Age  int
}

// 自己紹介メソッド（レシーバ付き関数）
func (p Person) Introduce() {
	fmt.Printf("Hello, my name is %s and I am %d years old.\n", p.Name, p.Age)
}

func main() {
	fmt.Println("Hello, Go TIL!")

	// 変数と計算
	num1 := 10
	num2 := 20
	sum := num1 + num2
	fmt.Println("sum:", sum)

	// 条件分岐
	age := 18
	if age >= 18 {
		fmt.Println("adult")
	} else {
		fmt.Println("minor")
	}

	// ループ
	for i := 0; i < 5; i++ {
		fmt.Println("loop:", i)
	}

	// 関数呼び出し
	result := add(3, 4)
	fmt.Println("add result:", result)

	// 構造体の利用
	p := Person{Name: "Taro", Age: 30}
	p.Introduce()
}
