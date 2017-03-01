---
layout: post
title: "Codility Lesson 15 Caterpilar Method"
date: 2017-03-02 00:40:09
tag:
 - algorithm
 - traverse
 - caterpilar-method
categories: algorithm
excerpt: "Is this really looks like Caterpilar?"
---

{% include _toc.html %}

# Caterpilar Method

배열 내의 원소들을 마치 Caterpilar 처럼 탐색한다고 해서 붙여진 이름이다. 

기본적으로는 선형 탐색이지만, 임의의 크기 영역을 두고 탐색하면서 영역의 앞과 뒤(Front, Back)을 기록하면서 나아가는 것이 특징이다.

# [AbsDistinct](https://codility.com/programmers/lessons/15-caterpillar_method/abs_distinct/)

서로 다른 절대값을 가진 수의 수를 구하라.

## Failure

Caterpilar Method를 이용하여 해결하기 위해서 무던히 노력했지만, 이 문제는 Caterpilar Method 보다는 다른 자료 구조(Set, Map, Deque)를 사용하거나 배열의 양 끝에서부터 탐색하는 것이 더 좋을 거란 결론을 내리고 100% 100%을 채우지 못하고 그만두었다.

무엇보다 Caterpilar Method로 해결하기 위해서는 처리해야 할 예외들이 너무 많다.

```c++
#include <cmath>

int solution(vector<int> &A) 
{
    int front(0), result(1);
    for(int back = 0 ; back < A.size() ; ++back)
    {
        while((front < A.size() - 1) && ((A[back] < 0 && A[front + 1] + A[back] <= 0) || (A[back] >= 0)))
        {
            ++result;
            ++front;
        }
        for(int i = back ; i <= front ; ++i)
            cout << A[i] << " ";
            cout << endl;
        
        if(front != back)
        {
            if(A[front] + A[back] == 0 || A[back] == A[back + 1])
                --result;
        }
    }
    return result;
}
```

## Solution

중복을 허용하지 않는 자료 구조를 사용하면 쉽게 해결할 수 있다. 원소의 순서는 전혀 필요하지 않으므로 속도를 위해 unordered_set을 사용했다.

```c++
#include <unordered_set>
#include <cmath>

int solution(vector<int> &A) 
{
    std::unordered_set<int> result{};
    for(const auto &a : A)
        result.insert(abs(a));
    
    return result.size();
}
```

이걸 가장 먼저 떠올렸으나 Caterpilar Method로 해결하겠다고 소모한 시간이 꽤 커서 안타까운 문제이다.

# [CountDistinctSlices](https://codility.com/programmers/lessons/15-caterpillar_method/count_distinct_slices/)

각 구역에 중복되는 원소가 없도록 배열을 분할하면 최대 몇 개의 구역을 생성할 수 있는가?

## Failure

unordered_set을 이용하여 중복 원소가 삽입될 때마다 구역의 수를 구하고, set을 초기화해주면 깔끔하게 될 줄 알았으나 그렇지 않았다.

```c++
#include <unordered_set>

int solution(int M, vector<int> &A) 
{
    std::unordered_set<int> slice{};
    int result(0);
    
    for(const auto &elem : A)
    {
        if(result > 1000000000)
            return 1000000000;
            
        if(slice.insert(elem).second == false)
        {
            result += (slice.size() * (slice.size() + 1)) / 2;
            slice.clear();
            slice.insert(elem);
        }
    }
    result += (slice.size() * (slice.size() + 1)) / 2;
    return result > 1000000000 ? 1000000000 : result;
}
```

## Solution

위 방법은 중복되는 두 원소 사이의 모든 원소를 다음 계산에서 배제하지만 실제로는 배제되는 원소들과 다음에 나오는 원소들을 이용해서도 구역을 만들 수 있다.

또한 이 들로부터 만들어지는 구역들은 앞서 나온 중복된 원소가 포함된 구역에서 계산되었던  구역들을 포함하므로 이를 제거해주는 작업도 필요하다.

```c++
#include <vector>

int solution(int M, vector<int> &A) 
{
    std::vector<int> lastOccur(M + 1, -1);
    int result(0), start(0), N(A.size());
    
    for(int i = 0 ; i < N ; ++i)
    {
        if(result > 1000000000)
            return 1000000000;
        
        if(lastOccur[A[i]] >= start)
        {
            result += (i - start) * (i - start + 1) / 2;
            start = lastOccur[A[i]] + 1;
        }
        lastOccur[A[i]] = i;
    }
    result += (N - start) * (N - start + 1) / 2;
    return result > 1000000000 ? 1000000000 : result;
}
```

# [CountTriangles](https://codility.com/programmers/lessons/15-caterpillar_method/count_triangles/)

모서리의 길이를 담은 배열에서, 총 몇개의 삼각형을 만들 수 있는 지 구하라.

## Solution

정렬을 하고 나면, 해당 Lesson의 Material에 있는 문제와 똑같다.

```c++
#include <algorithm>

int solution(vector<int> &A) 
{
    int N(A.size());
    if (N < 3)
        return 0;
    std::sort(A.begin(), A.end());
    int count(0), P(0), Q(0);
    for (int R = N - 1; R > 1; --R)
    {
        P = 0;
        Q = R - 1;
        while ((P < Q))
        {
            while ((P < Q) && (A[P] + A[Q] <= A[R]))
                ++P;
            count += Q - P;
            --Q;
        }        
    }
    return count;
}
```

## Error

P < Q < R의 조건이 있긴 하지만, A[P] < A[Q] < A[R]의 조건은 아니기 때문에 정렬 후에 각 모서리의 index를 계산할 필요는 없다.

다른 언어들은 (x, y, z) = (1, 2, 3) 부터 시작해도 되는 것 같은데 C++은 유난히 Time Limit이 적은 지 Test Set에 최적화된 순서로 보이는 (x, y, z) = (1, N - 1, N)부터 시작해야 한다.

# [MinAbsSumOfTwo](https://codility.com/programmers/lessons/15-caterpillar_method/min_abs_sum_of_two/)

배열의 두 원소의 합의 절대값 중 가장 작은 값을 구하라.

## Failure

음수, 양수 배열을 따로 만들려고 했으나 음수/양수로만 구성된 배열이 있을 수 있기 때문에 수정

## Solution

배열이 모두 음수나 양수(+ 0)로만 이루어진 것이 아니라면 음수와 양수를 더했을 때가 합의 절대값의 기대값이 낮기 때문에 정렬된 배열의 양 끝에서부터 탐색을 시작한다.

```c++
#include <vector>
#include <algorithm>
#include <cmath>

int solution(vector<int> &A) 
{
    int N(A.size());
    std::sort(A.begin(), A.end());
    
    int left(0), right(N - 1);
    if(A[left] >= 0)
        return 2 * A[left];
    else if(A[right] < 0)
        return 2 * abs(A[right]);
        
    int result(2000000000), sum(0);
    while(left <= right)
    {
        sum = A[left] + A[right];   
        result = std::min(result, abs(sum));
        if(sum == 0)
            return 0;
        else if(sum < 0)
            ++left;
        else
            --right;
    }
    return result;    
}
```

## Error

두 index는 서로 같은 값을 가질 수 있다는 조건을 놓쳐서 재시도를 해야 했다.