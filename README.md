# SAMPLE SIMPLE TODO API

適当なAPIが欲しかったので作った

## POST /user

ユーザーを登録します。

### パラメーター

```
email String
password String
```

### 結果例

```
{
  "auth": {
    "token": "AAAAA"
  }
}
```

## POST /auth

認証し、APIの実行に必要なTokenを取得します。取得したTokenがbodyにtokenとして含めるか、
ヘッダにTokenとして含めることができます。

### パラメーター

```
email String
password String
```

### 結果例

```
{
  "auth": {
    "token": "AAAAA"
  }
}
```

## DELETE /auth

Tokenを抹消します。

### パラメーター

```
token String (optional)
```

### 結果例

```
{
  "result": "success"
}
```

## POST /task

タスクを登録します。

### パラメーター

```
token String (optional)
title String
description String
```

### 結果例

```
{"result":"success"}
```

## GET /task

タスクを取得します。

### パラメーター

```
token String (optional)
```

### 結果例

```
[{"task":{"id":1,"title":"早起きする","description":"早起きは三文の得と言いますし、明日から早起きするぞ！"}}]
```

## DELETE /task/;id

タスクを削除します。

### パラメーター

```
token String (optional)
```

### 結果例

```
{"result":"success"}
```




