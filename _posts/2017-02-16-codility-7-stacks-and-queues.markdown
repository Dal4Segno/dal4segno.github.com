---
layout: post
title: "Codility Lesson 7 Stacks and Queues"
date: 2017-02-16 15:22:36
tag:
 - algorithm
 - stack
 - queue
categories: algorithm
excerpt: ""
---
{% include _toc.html %}

# [Brackets](https://codility.com/programmers/lessons/7-stacks_and_queues/brackets/) 및 [Nesting](https://codility.com/programmers/lessons/7-stacks_and_queues/nesting/)

> 왜 분리되었는지 이유를 알 수 없는 두 문제이다. 풀이법이 같다.

여는 괄호 및 닫는 괄호로 이루어진 문자열이 괄호를 잘 열고 닫았는지 판단하라.

> Brackets는 소, 중, 대괄호를, Nesting은 소괄호만 사용한다.
>
> 편의상 Nesting에 대해서만 다루도록 한다.

## Solution

정상적인 경우에, 닫는 괄호는 가장 최근에 등장한 여는 괄호와 매칭된다. 따라서 여는 괄호를 Stack을 이용하여 관리할 수 있다.

닫는 괄호가 등장할 때 여는 괄호의 Stack이 비어있거나, 문자열을 다 읽은 다음 Stack이 비어있지 않을 경우 비정상 문자열로 판단할 수 있다.

```c++
#include <vector>

int solution(string &S) 
{
    std::vector<char> opened{};
    for(const auto &c : S)
    {
        if(c == '(')
            opened.push_back(c);
        else
        {
            if(opened.empty())
                return 0;
            else
                opened.pop_back();
        }
    }
    return (opened.empty()) ? 1 : 0;
}
```

# [StoneWall](https://codility.com/programmers/lessons/7-stacks_and_queues/stone_wall/)

주어진 모양의 벽을 만들기 위해 최소 몇 개의 블록이 필요한 지 계산하라.

## Solution

현재 높이를 기준으로 다음 블록이

- 더 높다면, 현재 블록을 계속 사용할 수 있다. (밑에 깔아둠)
- 같은 높이라면, 현재 블록을 계속 사용할 수 있다. (한 블록으로 합침)
- 더 낮다면, 그 높이 보다 높은 블럭들을 그만 사용한다. 
  - 그 보다 더 낮은 블록들은 첫 번째 경우처럼 계속 밑에 깔아둘 수 있다.

```c++
#include <vector>

int solution(vector<int> &H) 
{
    std::vector<int> stack{};
    unsigned long long blocks{};

    for(const auto &h : H)
    {
        while(!stack.empty() && h < stack.back())
        {
            ++blocks;
            stack.pop_back();
        }
        
        if(stack.empty() || h > stack.back())
            stack.push_back(h);
    }   
    return blocks + stack.size();
}
```

# [Fish](https://codility.com/programmers/lessons/7-stacks_and_queues/fish/)

마주치면 서로 잡아먹는 물고기들이 있을 때, 최종적으로 몇 마리의 물고기가 살아남는지 구하라.

## Solution

- 초기 상태에는 모든 물고기가 살아있음
- 모든 물고기의 속력이 같기 때문에 배열의 앞에 있는 물고기가 내려오는 상황에서만 마주칠 수 있다

내려오는 물고기를 Stack으로 관리한다.

```c++
#include <vector>

int solution(vector<int> &A, vector<int> &B) 
{
    unsigned long long alive = A.size();
    std::vector<int>downFishes{};
    
    for(auto i = 0 ; i < A.size() ; ++i)
    {
        if(B[i] == 1)
            downFishes.push_back(A[i]);
        else if(B[i] == 0)
        {
            while(!downFishes.empty() && A[i] > downFishes.back())
            {
                downFishes.pop_back();
                --alive;
            }
            
            if(!downFishes.empty() && A[i] < downFishes.back())
                --alive;
        }
    }
    return alive;
}
```

