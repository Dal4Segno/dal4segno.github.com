---
layout: post
title: "Codility Lesson 12 Euclidean Algorithm"
date: 2017-02-21 21:54:06
tag:
 - algorithm
 - common-divisor
 - gcd
 - lcm
categories: algorithm
excerpt: "Thanks Euclide !"
---
{% include _toc.html %}

# [ChocolatesByNumbers](https://codility.com/programmers/lessons/12-euclidean_algorithm/chocolates_by_numbers/)

N 개의 초콜릿으로 이루어진 원형에서 M씩 건너뛰면서 초콜릿을 먹을 때, 연속으로 몇 개까지 먹을 수 있는지 구하라.

## Solution

이동한 거리가 N과 M의 최소공배수일 때, 최초로 포장지를 만나게 된다.

> 최소공배수 = (N * M) / GCD 이지만, 구하려는 값은 이동한 거리(xM)가 아니라 먹은 초콜릿의 수(x)이기 때문에 M으로 나눠준다.

```c++
int getGcd(int n, int m)
{
    while(m != 0)
    {
        int temp{n};
        n = m;
        m = temp % m;
    }
    return n;
}

int solution(int N, int M) 
{
    auto gcd = getGcd(N, M);
    return N / gcd;
}
```



# [CommonPrimeDivisors](https://codility.com/programmers/lessons/12-euclidean_algorithm/common_prime_divisors/)

주어진 두 수가 정확히 같은 소인수를 가지고 있는지 판단하라.

## Failure

GCD % (B / GCD) 를 통해 판단할 수 있을 거라고 생각했는데, 정확히 같은 소인수를 가지고 있어도 10 % 4 != 0 과 같은 경우가 있었다.

## Solution

두 수가 정확히 같은 소인수들을 가지고 있다면, 두 수의 모든 인수는 최대공약수의 인수가 된다. 같은 소인수를 가지고 있지 않다면 최대공약수의 인수가 아닌 소인수가 존재한다.

이에 착안하여 A와 B 두 수와 최대공약수 사이의 최대공약수를 반복적으로 구하고, 최종적으로 두 수가 모두 1이 되면 두 수가 정확히 같은 소인수들을 가지고 있는 것이라 판단할 수 있다.

```c++
#include <algorithm>

int getGcd(int n, int m)
{
    while(m != 0)
    {
        int temp{n};
        n = m;
        m = temp % m;
    }
    return n;
}

int solution(vector<int> &A, vector<int> &B) 
{
    int Z = A.size();
    int result{0};
    while(Z--)
    {
        int a, b;
        a = std::min(A[Z], B[Z]);
        b = std::max(A[Z], B[Z]);
        
        int gcd{getGcd(a, b)};
        int tempGcd{0};
        while(tempGcd != 1)
        {
            tempGcd = getGcd(a, gcd);
            a /= tempGcd;
        }

        tempGcd = 0;
        while(tempGcd != 1)
        {
            tempGcd = getGcd(b, gcd);
            b /= tempGcd;
        }

        if(a == 1 & b == 1)
            ++result;
    }
    return result;
}
```

