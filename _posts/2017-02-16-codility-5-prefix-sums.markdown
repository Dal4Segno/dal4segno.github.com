---
layout: post
title: Codility Lesson 5 Prefix Sums
date: 2017-02-16 00:17:20
tag:
 - algorithm
 - prefixsum
categories: algorithm
excerpt: ""
---

{% include _toc.html %}

# [CountDiv](https://codility.com/programmers/lessons/5-prefix_sums/count_div/)

> { i : A ≤ i ≤ B, i **mod** K = 0 }

A와 B 사이에서 K 로 나눈 나머지가 0인 수의 수를 구하라



## Failure

처음에는 (B - A) / K 라고 생각했으나 0부터 (B - A)는 K로 나누어지는 수를 포함하지 않지만, A부터 B까지는 K로 나누어지는 수를 포함하는 경우가 있음



## Solution

0부터 B까지 K로 나누어지는 수의 수에서 0부터 A - 1까지 K로 나누어지는 수의 수를 뺀다.

> A부터 B이기 때문에 A - 1까지만 구한다.

또한 0은 무엇으로 나누어도 나머지가 0이기 때문에 별도로 처리해주어야 한다.

```c++
int solution(int A, int B, int K) 
{
    return (A == 0) ? (B / K) + 1: ((B / K) - ((A - 1) / K));
}
```



# [PassingCars](https://codility.com/programmers/lessons/5-prefix_sums/passing_cars/)

동쪽으로 가는 차와 서쪽으로 가는 차의 쌍의 수를 구하라

## Solution

모든 서쪽으로 가는 차는 자신 이전에 등장한 동쪽으로 가는 차와 짝을 이룰 수 있기 때문에, 서쪽으로 가는 차가 등장하면 현재까지 등장한 동쪽으로 가는 차의 수를 결과에 더한다.

```c++
int solution(vector<int> &A) 
{
    unsigned long long east = 0, result = 0;

    for(const auto &i : A)
    {
        if(i == 0)
            ++east;
        else
            result += east;
    }
    return (result > 1000000000) ? -1 : result;
}
```

## Error

정답에는 지장이 없으나 판단에 오류가 있었음.

동쪽으로 가는 차가 서쪽으로 가는 차보다 먼저 등장해야 하므로 첫 동쪽으로 가는 차 등장 이전의 서쪽으로 가는 차는 무시해야 한다고 생각했지만, 위의 알고리즘을 적용하면 첫 동쪽으로 가는 차 등장 전에는 0을 더하기 때문에 전혀 지장이 없다.

# [GenomicRangeQuery](https://codility.com/programmers/lessons/5-prefix_sums/genomic_range_query/)

범위 내의 가장 작은 뉴클레오티드를 구하라

## Solution

각 위치에서 각 뉴클레오티드의 총 등장횟수를 기록한다.

> A, C, G 모두 아닐 경우 T가 존재한다고 추론할 수 있기 때문에, T는 기록하지 않아도 된다.

그 후, [P-1, Q] 범위에서 A, C, G의 등장 횟수의 변화가 있는지 확인한다.

> 등장 횟수는 반드시 양수로 증가하며, 변화가 있으면 해당 범위에서 특정 뉴클리오티드가 등장했음을 알 수 있다.

```c++
#include <set>
#include <vector>
#include <algorithm>

vector<int> solution(string &S, vector<int> &P, vector<int> &Q) 
{
    auto size = S.size();
    // 범위가 0부터 시작될 수 있으므로 크기를 1 더 크게 설정
    std::vector<int> A(size + 1, 0), C(size + 1, 0), G(size + 1, 0);
    int a{}, c{}, g{};
  
    for(auto i = 0 ; i < size ; ++i)
    {
        switch(S[i])
        {
            case 'A' :
                ++a;    break;
            case 'C' :
                ++c;    break;
            case 'G' :
                ++g;    break;
            default :   break;
        }
        A[i + 1]=a;
        C[i + 1]=c;
        G[i + 1]=g;
    }
  
    auto M = P.size();
    std::vector<int> result{};
    for(auto i = 0 ; i < M ; ++i)
    {
        if(A[ P[i] ] != A[ Q[i] + 1 ])
            result.push_back(1);
        else if(C[ P[i] ] != C[ Q[i] + 1])
            result.push_back(2);
        else if(G[ P[i] ] != G[ Q[i] + 1 ])
            result.push_back(3);
        else    
            result.push_back(4);
    }
    return result;
}
```

# [MinAvgTwoSlice](https://codility.com/programmers/lessons/5-prefix_sums/min_avg_two_slice/)

가장 작은 평균을 갖는 구간의 시작점을 구하라

## Solution

원소가 4개 이상인 부분은 원소가 2개 혹은 3개인 더 작은 부분으로 나눌 수 있기 때문에, 최소 평균을 갖는 구간의 크기는 2 혹은 3이다.

> 이것을 파악한다면 쉽게 해결할 수 있는 문제지만, 파악하지 못한다면 O(N)으로는 절대 해결할 수 없다.

```c++
int solution(vector<int> &A) 
{
    int minAvgPos;
    // 평균값은 소수
    double partialAvg, minAvg = 50000; 
    
    for(auto i = 0 ; i < A.size() - 1 ; ++i)
    {
        // 꼭 소수로 나눠주자
        partialAvg = (A[i] + A[i + 1]) / 2.0;
        if(partialAvg < minAvg)
        {
            minAvg = partialAvg;
            minAvgPos = i;
        }
        if(i < A.size() - 2)
        {
            partialAvg = (A[i] + A[i + 1] + A[i + 2]) / 3.0;
            if(partialAvg < minAvg)
            {
                minAvg = partialAvg;
                minAvgPos = i;
            }
        }
    }
    return minAvgPos;
}
```

