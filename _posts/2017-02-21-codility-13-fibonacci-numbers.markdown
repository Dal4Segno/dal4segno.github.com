---
layout: post
title: "Codility Lesson 13 Fibonacci Numbers"
date: 2017-02-21 21:54:29
tag:
 - algorithm
 - fibonacci
categories: algorithm
excerpt: "Wow, 0% 0% is Real?"
---
{% include _toc.html %}

# [Ladder](https://codility.com/programmers/lessons/13-fibonacci_numbers/ladder/)

사다리를 1칸 혹은 2칸 씩 올라갈 수 있을 때, N칸까지 도달할 수 있는 경우의 수를 구하라.

## Solution

정직하게 피보나치 수열을 이용하는 문제이다.

> 사실 Big Big Integer를 잘 Handling 할 수 있냐고 물어보는 문제인 것 같기도 하다.

```c++
#include <vector>
#include <algorithm>
#include <cmath>

vector<int> solution(vector<int> &A, vector<int> &B) 
{
    auto L = A.size();    
    std::vector<unsigned long long> fibo(*std::max_element(A.begin(), A.end()) + 1, 0);
    fibo[1] = 1;
    fibo[2] = 2;
    for(int i = 3 ; i < fibo.size() ; ++i)
        fibo[i] = fibo[i - 1] + fibo[i - 2];
    
    std::vector<int> result{};
    for(int i = 0 ; i < L ; ++i)
        result.push_back(fibo[A[i]] % static_cast<unsigned long long>(pow(2, B[i])));
    
    return result;
}
```



# [FibFrog](https://codility.com/programmers/lessons/13-fibonacci_numbers/fib_frog/)

정확하게 피보나치 수만큼 뛰는 개구리가 있을 때, N까지 도달하는 데 최소 몇 번의 도약이 필요한 지 구하라.

## Failure

모든 피보나치 수는 다른 피보나치 수를 이용해서 만들 수 있기 때문에 Greedy하게 해결해도 될 것 같았지만 Leaf가 모든 위치에 있는 것이 아니라서 실패했고,

피보나치 수열과 비슷하게, 다른 Leaf들에서 현재 Leaf로 올 수 있을 때 Jump 수가 최소인 것을 택하는 방식을 사용했지만 0% 0%를 기록하며 처참히 실패했다.

> 이 정도면 예제 샘플이 너무 빈약한거 아닌가??

```c++
#include <unordered_map>
#include <algorithm>

int solution(vector<int> &A) 
{
    std::vector<int> fibo{0, 1};
    int N = A.size();
    for(int i = 2 ; fibo.back() <= N + 1 ; ++i)
        fibo.push_back(fibo[i - 1] + fibo[i - 2]);
    
    A.push_back(1);
    std::unordered_map<int, int> min{ {-1, 0}, {N, -1} };
    for(int i = 0 ; i <= N ; ++i)
    {
        if(A[i] == 1)
        {
            min[i] = 2 * N;
            for(int j = 2 ; j <= i + 1 ; ++j)
            {   
                if(min.find(i - fibo[j]) != min.end())
                    min[i] = std::min(min[i], min[i - fibo[j]] + 1);
            }
        }
    }
    return min[N];
}
```



## Solution

차근차근 처음부터 하나 씩 직접 뛰어보았다.

Queue를 사용하여 점프 횟수 순으로 경로가 처리되므로 최솟값을 구하기 위해 별도의 처리를 하지 않아도 되었다.

> 이미 처리했던 Leaf에 대해 가지치기를 하지 않으면 C++ 기준으로 Time Out이 나온다. Python은 그냥 되는 것 같던데.

### Additional Description (+170402)

각 Leaf를 Node로 하는 Tree를 탐색하는 것으로 생각할 수 있다. 

그러면 최소 Depth에서 N의 값을 갖는 Node를 찾는 문제가 되는데,  Queue를 이용한 BFS를 이용하게 되면 점프 횟수의 오름차순으로 각 Node가 처리되기 때문에 모든 경우의 수를 볼 필요 없이 한 노드라도 N에 도달하는 즉시 함수를 종료할 수 있다.

원래는 2개 이상의 Leaf에서 한 Leaf로 이동할 수 있기 때문에 Tree가 아니지만(*한 Node의 부모가 2개 이상*), 먼저 처리된 Leaf만을 취함으로서 Tree 형태로 만들 수 있다.

> 코드의 !already[pos] 부분

```c++
#include <queue>
#include <algorithm>

int solution(vector<int> &A) 
{
    std::vector<int> fibo{0, 1};
    unsigned int N{A.size()};
    for(int i = 2 ; fibo.back() <= N + 1 ; ++i)
        fibo.push_back(fibo[i - 1] + fibo[i - 2]);
    std::reverse(fibo.begin(), fibo.end());
    
    int pos{-1};
    std::queue<pair<int, int>> leaves;
    std::vector<bool> already(N, false);
    leaves.push(make_pair(pos, 0));
    while(!leaves.empty())
    {
        pair<int, int> leaf = leaves.front();
        leaves.pop();
        for(const auto &f : fibo)
        {
            pos = leaf.first + f;
            if(pos == N)
                return leaf.second + 1;
            else if(pos < N && A[pos] == 1 && !already[pos])
            {
                leaves.push(make_pair(pos, leaf.second + 1));
                already[pos] = true;
            }
        }
    }
    return -1;
}
```

## Error

아무래도 피보나치 수는 급격하게 커지기 때문에 직접 써보거나 돌려보기 힘들어 약간 대책없이 문제를 풀어나간 것 같다.