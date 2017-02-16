---
layout: post
title: "Codility Lesson 8 Leader"
date: 2017-02-16 16:10:40
tag:
 - algorithm
 - leader
categories: algorithm
excerpt: ""
---
{% include _toc.html %}

# [Dominator](https://codility.com/programmers/lessons/8-leader/dominator/)

주어진 배열의 절반 초과를 차지하는 원소의 위치 중 임의의 하나를 구하라.

## Solution

가장 많이 등장하는 원소를 구하는 것은 단 한 번의 배열 순회로 가능하지만, 배열의 각 원소가 *signed int* 범위이기 때문에 이를 기록/저장하는 방법이 중요하다.

std::map\<int, int\> 를 사용하여 <원소, 등장 횟수>를 기록하면 쉽게 Dominator를 구할 수 있다.

```c++
#include <map>
#include <algorithm>

int solution(vector<int> &A) 
{
    if(A.empty())
        return -1;
    else if(A.size() == 1)
        return 0;
    
    std::map<int, int> occured{};
    for(const auto &i : A)
    {
        auto target = occured.find(i);
        if(target == occured.end())
            occured.insert({i, 1});
        else
            ++(target->second);
    }
        
    auto dominator = std::max_element(occured.begin(), occured.end(), [](auto a, auto b){ return a.second < b.second; })->first;
     
    if(occured[dominator] <= A.size() / 2)
        return -1;

    for(auto i = 0 ; i < A.size() ; ++i)
    {
        if(A[i] == dominator)
            return i;
    }
}
```

# [EquiLeader](https://codility.com/programmers/lessons/8-leader/equi_leader/)

배열을 임의의 위치에서 둘로 나눴을 때, 두 부분 모두에서 Dominator가 되는 EquiLeader의 수를 구하라

## Solution

기본적으로 EquiLeader는 Dominator여야 한다. 절반 이상을 차지하지 않으면 임의로 배열을 나누었을 때 동시에 두 구간의 EquiLeader가 될 수 없다.

Dominator의 등장 횟수를 모두 저장한 후, 각 위치에서 Dominator가 EquiLeader가 될 수 있는지 판단한다.

```c++
#include <map>
#include <vector>
#include <algorithm>

int solution(vector<int> &A) 
{
    // 구역을 둘로 나눌 수 없음
    if(A.size() == 1)
        return 0;
    
    std::map<int, int> occured{};
    for(const auto &i : A)
    {
        auto target = occured.find(i);
        if(target == occured.end())
            occured.insert({i, 1});
        else
            ++(target->second);
    }
  
    auto equiLeader = std::max_element(occured.begin(), occured.end(), [](auto a, auto b){ return a.second < b.second; })->first;
    const auto size = A.size();
    std::vector<unsigned int> leaderOccured(size, 0);
    unsigned int currentOccured{};
    for(auto i = 0 ; i < size ; ++i)
    {
        if(A[i] == equiLeader)
            ++currentOccured;
        leaderOccured[i] = currentOccured;    
    }
    
    unsigned int result{};
    for(auto i = 0 ; i < size ; i += 1)
    {
        if(leaderOccured[i] > ((i + 1) / 2) && (leaderOccured[size - 1] - leaderOccured[i]) > ((size - i - 1) / 2))
        {
            ++result;
        }
    }
    return result;
}
```

