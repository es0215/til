// main.ts
// TypeScript の超基本構文サンプル
// - 型付き変数
// - 条件分岐
// - ループ
// - 関数
// - 配列 / オブジェクト

console.log("Hello, TypeScript TIL!");

// 型付き変数と計算
let num1: number = 10;
let num2: number = 20;
let sum: number = num1 + num2;
console.log("sum:", sum);

// 条件分岐
let age: number = 18;
if (age >= 18) {
  console.log("adult");
} else {
  console.log("minor");
}

// ループ
for (let i = 0; i < 5; i++) {
  console.log("loop:", i);
}

// 関数（引数/戻り値に型を付ける）
function add(a: number, b: number): number {
  return a + b;
}
console.log("add result:", add(3, 4));

// 配列
let fruits: string[] = ["apple", "banana", "cherry"];
fruits.push("date");
console.log("fruits:", fruits);

// オブジェクト型
type Person = {
  name: string;
  age: number;
};

const person: Person = { name: "Taro", age: 30 };
console.log(`${person.name} is ${person.age} years old.`);
