---
layout: post
title: "Codility Lesson 9 Maximum Slice Problem"
date: 2017-02-16 19:27:15
tag: 
 - algorithm
 - maximum-slice
categories: algorithm
excerpt: ""
---
{% include _toc.html %}

# [MaxDoubleSliceSum](https://codility.com/programmers/lessons/9-maximum_slice_problem/max_double_slice_sum/)

X, Y, Z (X < Y < Z)를 이용해서 만든 두 구간(X to Y, Y to Z)의 합을 가장 크게 만들어라

## Solution

배열의 시작과 끝에서부터 각 위치에서의 최대 부분합을 구한다. X, Y, Z의 위치는 부분 합에 포함되지 않으므로 최소 부분합은 0이다.

```c++
#include <vector>
#include <algorithm>

int solution(vector<int> &A) 
{
    auto N = A.size();
    vector<int> s1(N, 0);
    vector<int> s2(N, 0);
  
    for(auto i = 1 ; i < N - 1; ++i)
        s1[i] = std::max(s1[i - 1] + A[i], 0);
    for(auto i = N - 2 ; i > 0 ; --i)
        s2[i] = std::max(s2[i + 1] + A[i], 0);

    // i - 1 , i + 1 -> Y 위치 미포함
    int result = 0;
    for(auto i = 1 ; i < N - 1 ; ++i)
        result = std::max(result, (s1[i - 1] + s2[i + 1]));
    return result;
}
```

# [MaxProfit](https://codility.com/programmers/lessons/9-maximum_slice_problem/max_profit/)

이익이 최대가 되는 구간을 구하라

## Failure

1번 문제와 비슷하게 풀어야 한다고 생각해서 그랬는지, 임의의 구간에서 획득할 수 있는 이득을 모두 저장해두고 그 중의 최대를 구하는 방법으로 구현해보았다.

```c++
#include <set>
#include <algorithm>

int solution(vector<int> &A) 
{
    auto size = A.size();
    if(size < 2)
        return 0;
    
    std::set<unsigned long long> result{};
    long long current{0};
    long long sub{};
    for(auto i = 0 ; i < size - 1; ++i)
    {   
        sub = A[i + 1] - A[i];
        if(sub < 0)
        {
            if(sub + current > 0)
                current += sub;
            else
            {
                result.insert(current);
                current = 0;
            }
        }
        else
            current += sub;        
    }
    result.insert(current);
    return *(result.rbegin());
}
```

틀린 풀이는 아니라고 생각하지만, 어째서인지 Performance Test에서 Wrong Answer를 뿜어냈다.

## Solution

- 현재 구간의 이득은 별도의 저장된 값 없이도 구할 수 있다.
- 현재 구간의 이득이 이전 구간의 이득보다 크다면, 현재 구간의 이득이 최대 이득이다.

결국 값을 저장할 필요도, 정렬할 필요도 없이, 값을 읽으면서 바로바로 최대 이득을 구해낼 수 있는 문제였다.

```c++
#include <algorithm>

int solution(vector<int> &A) 
{
    auto size = A.size();
    if(size < 2)
        return 0;
    
    int minPrice = 200000;
    int maxProfit = 0;
    for(const auto& price : A)
    {
        minPrice = std::min(minPrice, price);
        maxProfit = std::max(maxProfit, price - minPrice);
    }
    return maxProfit;
}
```



# [MaxSliceSum](https://codility.com/programmers/lessons/9-maximum_slice_problem/max_slice_sum/)

합이 최대가 되는 부분을 구하라

## Solution

1번과 비슷한 문제라고 생각해서 가벼운 마음으로 도전했지만, 생각보다 까다로웠다.

- 구간의 경계가 포함된다.
  - 최소 하나의 원소는 포함해야하기 때문에 최대 부분합이 0보다 작을 수 있다.

기본적인 구조는 1번 문제와 같지만, 각 위치에서 최대 부분합을 구할 때, 최소값을 0이 아니라 각 위치의 원소로 설정해야 한다.

```c++
#include <vector>
#include <algorithm>

int solution(vector<int> &A) 
{
    auto N = A.size();
    vector<int> s1(N, 0);
    s1[0] = A[0];

    for(auto i = 1 ; i < N; ++i)
        s1[i] = std::max(s1[i - 1] + A[i], A[i]);
        
    return *std::max_element(s1.begin(), s1.end());
}
```

