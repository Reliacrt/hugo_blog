---
title: "Go泛型体验"
date: 2021-09-17T15:27:16+08:00
draft: false

tags: [
	"Go",
	"Study",
	"Generics"
]

categories: [
	"Go"
]
---

久等的泛型终于在Go语言中提供了支持, 所以赶快体验一下泛型的舒适.

<!--more-->

# 环境说明:
> 1. Go版本1.17.1
> 2. 运行命令: go run -gcflags=-G=3 main.go

# 泛型约束类型定义

## 类型聚合

### 函数定义
```go
type Addable interface {
	type int, int8, int16, int32, int64
}
func add[T Addable](x, y T)T{
	return x + y
}

```
### 函数使用

```go
fmt.Println(add(1, 2))
```

### 打印结果

```text
3
```

## 结构体泛化

### 函数定义
```go
type myMap[T any] struct {
  m map[int]T
}
func newMyMap[T any](size int)*myMap[T]{
  return &myMap[T]{
    m: make(map[int]T, size),
  }
}
```
### 函数使用

```go
ss := newMyMap[string](1)
ss.m[1] = "hello"
fmt.Println(ss)
```

### 打印结果

```text
&{map[1:hello]}
```

# 泛型约束函数定义

## 参数约束

### 函数定义
```go
func testGeneric[R any](array []R) {
	for _, e := range array {
		fmt.Println(e)
	}
}
```
### 函数使用

```go
testGeneric([][]int{[]int{1, 2, 3}, []int{4, 5, 6}, []int{7, 8, 9}})
```

### 打印结果

```text
[1 2 3]
[4 5 6]
[7 8 9]
```

## 返回值约束（自动推断）

> 注意：无法从赋值语句中自动推断类型

### 函数定义
```go
func newMap[V any]() map[int]V {
	return make(map[int]V, 0)
}
```
### 函数使用
```go
var myMap map[int]string = newMap()
fmt.Println(myMap)
```
### 输出结果
```text
./main.go:206:35: cannot infer V (/Path/To/main.go:224:13) ([<nil>])
```

## 返回值约束（类型传参）

### 函数定义
```go
func newMap[V any]() map[int]V {
	return make(map[int]V, 0)
}
```
### 函数使用
```go
var myMap = newMap[string]()
fmt.Println(myMap)
```
### 输出结果
```text
map[]
```

## 参数和返回值皆约束
### 函数定义
```go
func PointerOf[V any](value V) *V {
	return &value
}
```
### 函数使用
```go
p := PointerOf(1)
fmt.Println(p)
```
### 输出结果
```text
0xc0000b0150
```
