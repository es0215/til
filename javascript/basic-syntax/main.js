// main.js
// JavaScript の基本構文をまとめたサンプル
// - アラート
// - 変数と計算
// - 条件分岐
// - ループ
// - 関数
// - 配列
// - オブジェクト

// アラートを表示する
alert('こんにちは、世界！');

// 変数を宣言して計算する
let num1 = 10;
let num2 = 20;
let sum = num1 + num2;
console.log('合計:', sum);

// 条件分岐
let age = 18;

if (age >= 18) {
  console.log('成人です');
} else {
  console.log('未成年です');
}

// ループ
for (let i = 0; i < 5; i++) {
  console.log('ループ回数:', i);
}

// 関数を定義する
function greet(name) {
  console.log('こんにちは、' + name + 'さん！');
}

greet('太郎');

// 配列を操作する
let fruits = ['りんご', 'バナナ', 'オレンジ'];
console.log('最初のフルーツ:', fruits[0]);

fruits.push('イチゴ');
console.log('新しいフルーツ:', fruits);

// オブジェクトを作成する
let person = {
  firstName: '太郎',
  lastName: '山田',
  age: 30,
};

console.log(person.firstName + ' ' + person.lastName + ' は ' + person.age + ' 歳です');
