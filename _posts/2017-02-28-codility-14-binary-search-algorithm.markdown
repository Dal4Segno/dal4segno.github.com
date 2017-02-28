---
layout: post
title: "Codility Lesson 14 Binary Search Algorithm"
date: 2017-02-28 18:49:16
tag:
 - algorithm
 - binary-search
categories: algorithm
excerpt: "Where should I use it?"
---
{% include _toc.html %}

# [NailingPlanks](https://codility.com/programmers/lessons/14-binary_search_algorithm/nailing_planks/)

모든 널빤지에 못을 박기 위해 필요한 못의 최소 개수를 구하라.

## Failure

각 못(C[i])마다 모든 널빤지(A, B)를 확인하는 방식을 사용했으나, 당연하게도 O(NM)의 알고리즘으로는 Performance Test를 통과할 수 없었다.

## Solution

널빤지에 못을 박을 수 있는 못 중 가장 작은 좌표값을 가진 못(lowerBound)를 찾은 다음, 널빤지 위에 있으면서 인덱스가 가장 작은 못을 찾기 위해 선형 탐색을 시도한다.

> std::lower_bound는 이진 탐색을 통해 특정 값 이상의 최소값의 위치를 반환한다.

```c++
#include <vector>
#include <algorithm>

int findFirst(int start, int end, auto &nails, int before)
{
    auto pos = std::lower_bound(nails.begin(), nails.end(), start, [](auto a, auto b){ return a.first < b; }) - nails.begin();
    // Not Found
    if(pos == nails.size())
        return -1;
    auto value = nails[pos].first;
    if(value > end)
        return -1;
    
    int index(-1),  result(1000000);
    while(value <= end && pos < nails.size())
    {
        index = nails[pos].second;
        if(index <= before)
            return before;
        if(index < result)
            result = index;
        ++pos;
        if(pos < nails.size())
            value = nails[pos].first;
    }   
    return result;
}

int solution(vector<int> &A, vector<int> &B, vector<int> &C) 
{
    int N = A.size();
    int M = C.size();
    
    std::vector<pair<int,int>> indexedNail(M, {0, 0});
    for(int i = 0 ; i < M ; ++i)
    {
        indexedNail[i].first = C[i];
        indexedNail[i].second = i;
    }
    std::sort(indexedNail.begin(), indexedNail.end());
    
    int result(-1);
    for(int i = 0 ; i < N ; ++i)
    {
        result = findFirst(A[i], B[i], indexedNail, result);
        if(result == -1)
            return -1;
    }
    return result + 1;
}
```

## Error

못들을 순서대로 처리해야 할 것이라 생각해서 도대체 어디에 이진 탐색을 적용해야 할 지 많이 헤맸고, 솔루션들을 찾아봐도 이해가 안되서 참 힘들었던 문제였다. 코드는 참 이쁘게 나온 거 같은데, 꽤나 아쉬운 문제.

# [MinMaxDivision](https://codility.com/programmers/lessons/14-binary_search_algorithm/min_max_division/)

배열을 K 개의 구간으로 나누었을때, 가장 작은 최대 부분합을 구하라.

## Solution

- 최대 구간합의 최소값은 배열 내 가장 큰 원소의 값이고
- 최대 구간합의 최대값은 배열 내 모든 원소의 합이다.

즉 이 두 값을 Lower/Upper Bound로 사용하여 최대 구간합을 이진 탐색으로 찾아낸다.

```c++
#include <algorithm>
#include <numeric>

bool isDivided(int expected, int K, auto &A)
{
    int sum(A[0]), blocks(1);
    for(int i = 1 ; i < A.size() ; ++i)
    {
        if(sum + A[i] > expected)
        {
            sum = A[i];
            ++blocks;
        }
        else
            sum += A[i];
        
        if(blocks > K)
            return false;
    }
    return true;
}

int solution(int K, int M, vector<int> &A) 
{
    int lowerBound(*std::max_element(A.begin(), A.end()));
    int upperBound(std::accumulate(A.begin(), A.end(), 0));
    
    if(K == 1)
        return upperBound;
    else if(K >= A.size())
        return lowerBound;
    
    int expected(0), result(0);
    bool available = false;
    while(lowerBound <= upperBound)
    {
        expected = (lowerBound + upperBound) / 2;
        available = isDivided(expected, K, A);
        if(available)
        {
            upperBound = expected - 1;
            result = expected;
        }
        else
            lowerBound = expected + 1;
    }
    return result;
}
```

## Error

이 문제는 보고 있어도 어떤 생각도 나지 않아서 빠르게 포기한 케이스다. A에 이진 탐색을 써야하나 싶었는데 최대 구간합에 이진 탐색을 적용하는 것을 보고 약간 감탄. 위 문제와는 참 다른 느낌이었는데 내 손으로 풀지 못했다는 건 두 문제 다 같다 ​:(



# Reference

- NailingPlanks
  - [Software Development. Codility NailingPlanks - Solution with linear time complexity](http://draganbozanovic.blogspot.kr/2016/04/codility-nailingplanks-linear-complexity.html)
  - [Code Says. Solution to Nailing-Planks by codility](https://codesays.com/2014/solution-to-nailing-planks-by-codility/)
- MinMaxDivision
  - [Code Says. Solution to Nailing-Planks by codility](https://codesays.com/2014/solution-to-nailing-planks-by-codility/)