---
title: "Try Mnist"
date: 2021-07-26T10:23:26+08:00
draft: false
math:
  enable:
    true
tags: [
  "Study",
  "MNIST",
  "ANN",
  "Python"
]
categories: [
  "神经网络"
]
---

Artificial Neural Network的尝试, 资料来源[^1]

<!--more-->

# Perceptrons 神经元

## Orignal representation
- **inputs** **输入**: $x_1, x_2, ...,$ inputs number
- **weights** **权重**: $w_1,w_2,…,$ importance of the respective inputs
- **threshold** **阈值**: decide if neuron should be activated

<!-- mathjax language rule
{{< equation >}}
\begin{eqnarray}
  \mbox{output} & = & \left\{ 
    \begin{array}{ll}
      0 & \mbox{if } \sum_j w_j x_j \leq \mbox{ threshold} \\
      1 & \mbox{if } \sum_j w_j x_j > \mbox{ threshold}
      \end{array} \right.
\tag{1}\end{eqnarray}
{{< /equation >}} -->

$$
\text{output} = \begin{cases}
0 &\text{if}&\sum_j w_j x_j \leq threshold \newline
1 &\text{if}&\sum_j w_j x_j \leq threshold 
\end{cases} \tag{1}
$$

## Simplification 简化

move threshold to another side of the inequality:

<!-- {{< equation >}}
\begin{eqnarray}
  output = \left \{
    \begin{array}{ll} 
      0 & \mbox{if } w\cdot x + b \leq 0 \\
      1 & \mbox{if } w\cdot x + b > 0
    \end{array}
  \right .
\tag{2}\end{eqnarray}
{{< /equation >}} -->

$$
\text{output} = \begin{cases}
0 & \text{if}&w\cdot x + b \leq 0 \newline
1 & \text{if}&w\cdot x + b \gt 0
\end{cases} \tag {2}
$$

# Generate basical logical function 生成逻辑函数

perceptrons can be used is to compute the elementary logical functions 
we usually think of as underlying computation, functions such as 
AND, OR, and NAND.

## NAND 与非门

For example, suppose we have a perceptron with two inputs, each with weight −2, and an overall bias of 3. Here's our perceptron:

{{% center %}}
![image](https://i.loli.net/2021/08/02/kKF9lVJ1dO2NvQ8.png "img")
{{% /center %}}

Then we see that input 00 produces output 1, since $(−2)\times0+(−2)\times0+3=3$ 
is positive. 

Similar calculations show that the inputs 01 and 10 produce output 1. 

But the input 11 produces output 0, since $(−2)\times1+(−2)\times1+3=−1$ is negative. 

# Sigmoid function

## Definition 定义
$$
  \sigma(z) \equiv \frac{1}{1+e^{-z}}\tag{3}
$$

## With z 带入z

$$
  \frac{1}{1+\exp(-\sum_j w_j x_j-b)}\tag{4}
$$

# Total differential 全微分

$$
  \Delta \text{output} \approx
  \sum_j 
  \frac{\partial\,\text{output}}{\partial w_j}\Delta w_j +
  \frac{\partial\,\text{output}}{\partial b} \Delta b,
\tag{5}
$$

# Cost function 损失函数

To quantify how well we're achieving this goal we define a **cost function**

> Sometimes referred to as a **loss or objective function**.

$$
C(w,b) \equiv\frac{1}{2n} \sum_x \| y(x) - a\|^2\tag{6}
$$

 For example, if a particular training image, $x$, depicts a $6$, then $y(x)=(0,0,0,0,0,0,1,0,0,0)^T$ is the desired output from the network.

We'll call $C$ the quadratic cost function; it's also sometimes known as the *mean squared error* or just ***MSE***.

## Gradient descent 梯度下降

The aim of our training algorithm will be to minimize the cost $C(w,b)$ as a function of the weights and biases. In other words, we want to find a set of weights and biases which make the cost as small as possible. We'll do that using an algorithm known as *gradient descent*.



[^1]:[Neural Networks and Deep Learning](http://neuralnetworksanddeeplearning.com/)



