// Main.kt
// Kotlin の超基本構文サンプル
// - 変数（val / var）
// - 条件分岐
// - ループ
// - 関数
// - data class

fun add(a: Int, b: Int): Int {
    return a + b
}

data class Person(val name: String, val age: Int) {
    fun introduce() {
        println("Hello, my name is $name and I am $age years old.")
    }
}

fun main() {
    println("Hello, Kotlin TIL!")

    // 変数と計算
    val num1 = 10
    val num2 = 20
    val sum = num1 + num2
    println("sum: $sum")

    // 条件分岐
    val age = 18
    if (age >= 18) {
        println("adult")
    } else {
        println("minor")
    }

    // ループ
    for (i in 0 until 5) {
        println("loop: $i")
    }

    // 関数呼び出し
    println("add result: ${add(3, 4)}")

    // data class
    val person = Person("Taro", 30)
    person.introduce()
}
