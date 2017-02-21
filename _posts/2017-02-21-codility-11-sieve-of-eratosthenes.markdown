---
layout: post
title: "Codility Lesson 11 Sieve of Eratosthenes"
date: 2017-02-21 00:10:42
tag:
 - algorithm
 - prime-number
 - sieve-of-eratosthenes
categories: algorithm
excerpt: "Tell me Prime-Number Don't Hate me !"
---
{% include _toc.html %}

# [CountSemiprimes](https://codility.com/programmers/lessons/11-sieve_of_eratosthenes/count_semiprimes/)

특정 구간에서, 두 소수의 곱으로 만들어지는 SemiPrime의 수를 구하라

## Solution

SemiPrime들을 구한 뒤, 각 구간의 SemiPrime 수를 모두 저장한다.

```c++
#include <vector>
#include <algorithm>
vector<int> solution(int N, vector<int> &P, vector<int> &Q) 
{
    std::vector<bool> isPrime(N + 1, true);
    for(int i = 2 ; (i * i) <= N ; ++i)
	{
		if(isPrime[i])
		{
			for(int j = i * i ; j <= N ; j += i) 
			    isPrime[j]=false;
		}
	}
	
	std::vector<int> prime{};
	for(int i = 2 ; i <= N ; ++i)
	{
	    if(isPrime[i])
	        prime.push_back(i);
	}
	
	std::vector<int> semiPrime(N + 1, 0);
	for(int i = 0 ; i < prime.size() - 1 ; ++i)
	{
	    for(int j = i ; j < prime.size() ; ++j)
	    {
	        if(prime[i] * prime[j] > N)
	            break;
            semiPrime[prime[i] * prime[j]] = 1;
	    }
	}
  
	for(int i = 1 ; i <= N ; ++i)
	    semiPrime[i] += semiPrime[i - 1];
	
	vector<int> result{};
	for(int i = 0 ; i < P.size() ; ++i)
        result.push_back(semiPrime[Q[i]] - semiPrime[P[i] - 1]);
        
	return result;	        
}
```

## Error

모든 SemiPrime을 직접 구하지 않는 풀이도 있는 것 같지만 설명없이는 이해하기 힘든 점 + 그냥 다 구해도 Performance Test를 통과하는 사례가 많아서 그냥 구현했는데, 왠지 모르게 Large Case에서 프로그램이 터져버린다..

다른 언어에서는 N + 1크기 배열 2개 그냥 선언해서 사용하던데, 시스템 문제인지 유저 문제인지 잘 모르겠다 :(



그리고 구간의 SemiPrime 등장 횟수를 기록해두는 것이 중요한데,  Time Over의 원인을 SemiPrime을 구하는 곳이라고 생각하여 굉장히 시간 낭비를 많이 해버렸다.

> 다양한 방법으로 SemiPrime의 등장 횟수를 구하던데, 꽤 오래봐도 이해가 안가더라...

# [CountNonDivisible](https://codility.com/programmers/lessons/11-sieve_of_eratosthenes/count_non_divisible/)

배열 내 원소들이 다른 원소들로 나누어지는 지 확인하라.

## Failure

에라토스테네스의 체와 비슷하게, 각 원소와 그의 배수에 등장 횟수를 기록하였으나 O(N ** 2)의 시간 복잡도로 Performance Test를 통과하지 못했다.

## Solution

매 원소마다 모든 원소를 살펴볼 필요없이, 각 원소의 등장 횟수만 기록한 뒤 10-1, 10-2에서 사용한 것 처럼 인수를 찾아나간다.

```c++
#include <algorithm>

vector<int> solution(vector<int> &A) 
{
    auto N = A.size();
    std::vector<int> count(2 * N + 1, 0);
    for(const auto &a : A)
        ++count[a];
    
    std::vector<int> result{};   
    for(const auto &a : A)
    {
        int divisor{0};
        for(int i = 1 ; i * i <= a ; ++i)
        {
            if(a % i == 0)
            {
                divisor += count[i];
                if(a / i != i)
                    divisor += count[a / i];
            }
        }
        result.push_back(N - divisor);
    }
    return result;        
}
```

