---
layout: post
title: "JTD Algorithm Study Cpp Class 170409"
date: 2017-04-09 12:51:44
tag:
 - binary-search
 - bitwise-operation
categories: algorithm
excerpt: "어렵다 어려워"
---
{% include _toc.html %}

# MinMaxDivision

[이 전 포스트]()



# [Hamming Distance](https://leetcode.com/problems/hamming-distance/#/description)

입력된 두 수(X, Y)의 서로 다른 비트 수를 구하라

## Solution

1. X와 Y의 XOR 값을 저장한다. (Z = X ^ Y)
2. Z의 이진표현에서 1의 수를 센다.

### Mine

1. Z를 계속 2로 나누어가면서 나머지를 string에 push_back
2. 해당 string에서 1의 개수를 셈

#### Improving

- string처럼 처리한다고 진짜 string을 만들 필요는 없음
  - 2로 나누면서 생기는 나머지를 바로바로 처리
  - 1의 위치나 순서가 필요 없음
- 별도의 string에서 1의 개수를 세지 않아도 됨
  - 2로 나누면서 생기는 나머지가 1인지 확인하고 셈
- 2로 나누는 연산은 Bit Shift를 통해 빠르게 연산 가능

### Using Bitwise AND

```c++
int N = X ^ Y;
int count = 0;
while(N)
{
    ++count;
  	N &= (N - 1);
}
```

**N &= (N - 1)** 을 통해 가장 바깥 쪽의 1을 제거할 수 있다. N에 1인 비트가 하나라도 있는 동안 반복문을 돌기 때문에 이를 이용해서 1의 개수를 구할 수 있다.



### Using Hash Table

(X, Y) 쌍이 무수히 많이 들어오고, 메모리가 충분하다면 각 수가 갖는 1의 수를 Hash Table에 저장해서 사용할 수 있다.

2^32 크기의 Hash Table이 부담된다면 4 * (2^8) 등으로 분리해서 사용할 수도 있다.



### Using BitMasking (Add 170416)

> 곧 추가됩니다.

