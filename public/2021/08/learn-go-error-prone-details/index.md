# Learn Go Error Prone Details


Go语言中的一些易错细节, 参考资料[^1]

<!--more-->

# 对象创建

1. struct: `new(T)` === `&T{}`
2. slice, map: `make(map[string]int)` === `map[string]int{}`

# interface判等

interface{}类型的相等需要判断其Type与Value两个属性, 只有当两个值都没有设置时才等于nil.

# for循环

## for循环中变量(slice)是副本

```Go
for key, element := range aContainer {...}
```
关于上面for循环有几个点：

1. 实际遍历的aContainer是原始值的一个副本
2. element是遍历到的元素的原始值的一个副本
3. key和element整个循环都是同一个变量，而不是每次迭代都生成新变量

## for循环中变量(map)不是副本

```Go
for key, value := range aMap { ... }
```
## for循环中变量(map)非定序打印

```Go
m := map[int]int{1: 1, 2: 2, 3: 3}
for k, v := range m {
    fmt.Println(k, v)
}
```

三个数字可以以任意顺序出现, 123, 132, 213, 231, 312, 321.

# map的值不可取址

这些类型都不能取址：

- map元素
- string的字节元素
- 常量（有名常量和字面量都不可以）
- 中间结果值（函数调用、显式值转换、各种操作）

```Go
// 下面这几行编译不通过。

_ = &[3]int{2, 3, 5}[0]        //字面量
_ = &map[int]bool{1: true}[1]  //字面量

const pi = 3.14
_ = &pi                        //有名常量

m := map[int]bool{1: true}
_ = &m[1]                      //map的value

lt := [3]int{2, 3, 5}
_ = &lt[1:1]                   //切片操作
```

一般来说，一个不可寻址的值的直接部分是不可修改的。但是map的元素是个例外。 map的元素虽然不可寻址，但是每个映射元素可以被整个修改（但不可以被部分修改）：

```Go
type T struct{age int}
mt := map[string]T{}
mt["John"] = T{age: 29} // 整体修改是允许的
ma := map[int][5]int{}
ma[1] = [5]int{1: 789} // 整体修改是允许的

// 这两个赋值编译不通过，因为部分修改一个映射元素是非法的。这看上去确实有些反直觉。
ma[1][1] = 123      // error
mt["John"].age = 30 // error

// 读取映射元素的元素或者字段是没问题的。
fmt.Println(ma[1][1])       // 789
fmt.Println(mt["John"].age) // 29
```



[^1]: [Go 语言的设计和坑](https://tech.bytedance.net/articles/6982017265923260446)
