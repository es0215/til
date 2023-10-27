# Functions
## concat Function
### 参考サイト
https://developer.hashicorp.com/terraform/language/functions/concat

### 役割
2つ以上のリストを1つのリストに結合する。

### 例
```
> concat(["a", ""], ["b", "c"])
[
  "a",
  "",
  "b",
  "c",
]
```
