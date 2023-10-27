# Functions
## concat
### 参考サイト
https://developer.hashicorp.com/terraform/language/functions/concat
### 役割
2つ以上のリストを1つのリストに結合する。
### 例
```
      setting = concat(
        local.setting_a_enabled ? [
          { #1
            parameter_a = xxxx
            parameter_b = xxxx
            parameter_c = xxxx
          }
        ] : [],
        local.setting_b_enabled ? [
          { #2
            parameter_a = xxxx
            parameter_b = xxxx
            parameter_c = xxxx
          }
        ] : [],
      )

>>>
[
  "1",
  "2",
]
```

## flatten
### 参考サイト
https://developer.hashicorp.com/terraform/language/functions/flatten
### 役割
リストを受け取り、リストである要素をリストの内容のフラット化されたシーケンスに置き換える。
### 例
```
      setting = flatten([
        local.setting_a_enabled ? [
          { #1
            parameter_a = xxxx
            parameter_b = xxxx
            parameter_c = xxxx
          }
        ] : [],
        local.setting_b_enabled ? [
          { #2
            parameter_a = xxxx
            parameter_b = xxxx
            parameter_c = xxxx
          }
        ] : [],
      ]
    )

>>>
["1", "2"]
```
