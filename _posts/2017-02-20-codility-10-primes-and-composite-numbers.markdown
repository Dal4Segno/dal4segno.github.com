---
layout: post
title: "Codility Lesson 10 Primes and Composite Numbers"
date: 2017-02-20 23:45:25
tag:
 - algorithm
 - prime-number
 - composite-number
categories: algorithm
excerpt: "Too Hard To Me :("
---
{% include _toc.html %}

#  [CountFactors](https://codility.com/programmers/lessons/10-prime_and_composite_numbers/count_factors/)

주어진 수 N의 인수의 수를 구하라

## Solution

sqrt(N) (혹은 i * i <= N) 까지만 확인하면 모든 인수를 확인할 수 있다.

> A * B = N일 때, A나 B 둘 중 하나는 반드시 sqrt(N)보다 작다.

제곱의 경우만 예외처리 해주면 된다.

```c++
#include <cmath>

int solution(int N) 
{
    unsigned int result{0};
    for(auto i = 1 ; i <= sqrt(N) ; ++i)
    {
        if(N % i == 0)
        {
            result += 2;
            if(i == sqrt(N))
                --result;
        }
    }
    return result;
}
```



#  [MinPerimeterRectangle](https://codility.com/programmers/lessons/10-prime_and_composite_numbers/min_perimeter_rectangle/)

넓이가 N인 사각형의 가장 작은 테두리의 길이를 구하라.

## Solution

N = A * B 일 때, 테두리의 길이인 2 * (A + B)를 최소로 만들어야 하기 때문에 1번 문제와 풀이가 별로 다르지 않다.

```c++
#include <cmath>
#include <algorithm>

int solution(int N) 
{
    int minPerimeter{2000000000};
    for(auto i = 1 ; i <= sqrt(N) ; ++i)
    {
        if(N % i == 0)
            minPerimeter = std::min(minPerimeter, (2 * (i + (N / i))));
    }
    return minPerimeter;
}
```

# [Peaks](https://codility.com/programmers/lessons/10-prime_and_composite_numbers/peaks/)

A[i - 1] < A[i] > A[i + 1]인 Peak를 각 구간에 최소 1개 이상 배치할 때, 최대로 나눌 수 있는 구간의 수를 구하라.

## Solution

모든 Peak의 위치를 구한 다음, 블록의 크기를 줄여가며 모든 블록에 Peak이 배치되지 않을 때 까지 반복한다.

```c++
#include <vector>
#include <set>
#include <cmath>

int solution(vector<int> &A) 
{
    std::vector<unsigned int>peaks{};
    std::set<unsigned int>factors{};
    unsigned int size = A.size();
    
    for(unsigned int i = 1 ; i < size - 1 ; ++i)
    {
        if(A[i - 1] < A[i] && A[i] > A[i + 1])
            peaks.push_back(i);
    }
    
    unsigned int result{0};
    for(unsigned int i = 1 ; i <= peaks.size() ; ++i)
    {   
        if(size % i == 0)
        {
            unsigned int block = size / i;
            unsigned int current{0};
            for(const auto &p : peaks)
            {
                if(current * block <= p && p < (current + 1) * block)
                    ++current;
            }
            if(current == i)
                result = current;
        }
    }
    return result;
}
```





# [Flags](https://codility.com/programmers/lessons/10-prime_and_composite_numbers/flags/)

각 Peak에 Flag를 꽂을 수 있고, 각 Flag는 최소 Flag의 수만큼 떨어져 있어야 할 때, 최대로 꽂을 수 있는 Flag의 수를 구하라.

## Solution

Peak들의 위치를 구하고, 조건에 따라 Flag를 꽂아보면 된다.

```c++
#include <cmath>

int solution(vector<int> &A) 
{
    std::vector<int> peaks{};
    auto size = A.size();
    for(auto i = 1 ; i < size - 1 ; ++i)
    {
        if(A[i - 1] < A[i] &&  A[i] > A[i + 1])
            peaks.push_back(i);
    }
    
    if(peaks.size() < 2)
        return peaks.size();
    
    for(auto k = 2 ; k <= peaks.size() ; ++k)
    {
        unsigned int flags{1};
        auto current = peaks[0];
        for(auto i = 1 ; i < peaks.size() ; ++i)
        {
            if(flags >= k)
                break;
            if(peaks[i] - current >= k)
            {
                ++flags;
                current = peaks[i];
            }
        }
        if(flags < k)
            return k - 1;
    }
    
    return peaks.size();
}
```

## Error

Peak도 그렇고 Flag도 그렇고, 기본적인 알고리즘은 크게 틀리지 않았는데 디테일한 부분에서 삽질을 너무 오래했다.

둘 다 block size나 Flag 간격으로 Peak들의 위치를 나누고 Set을 이용해 Unique하게 만들면 될거라 생각해서 구현해봤는데, 결국 가장 Raw하게 구현해서 통과했다.

```c++
#include <cmath>
#include <set>

int solution(vector<int> &A) 
{
    std::vector<int> peaks{};
    auto size = A.size();
    for(auto i = 1 ; i < size - 1 ; ++i)
    {
        if(A[i - 1] < A[i] &&  A[i] > A[i + 1])
            peaks.push_back(i);
    }
    
    for(auto p : peaks)
        p -= peaks[0];
    
    for(auto i = 1 ; i <= peaks.size() ; ++i)
    {   
        std::set<unsigned int>flags{};
        for(const auto &p : peaks)
            flags.insert(p / i);
        if(flags.size() < i)
            return i - 1;
        flags.clear();
    }
    return peaks.size();
}
```

