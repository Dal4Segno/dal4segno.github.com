---
layout: post
title: "JTD Algorithm Study Cpp Class 170416"
date: 2017-04-17 18:55:46
tag:
 - algorithm
 - dynamic-programming
 - duplicate
categories: algorithm
excerpt: ""
---
{% include _toc.html %}

# [Contains Duplicate](https://leetcode.com/problems/contains-duplicate/#/description)

주어진 정수 배열에서 중복된 원소가 있는지 확인하라.

## Solution

주어진 배열로 Set을 구성한 뒤 원소의 수를 비교한다

> std::set은 Binary Search Tree로, std::unordered_set은 Hash Table로 구성되어 있다.



# [Maximum Product Subarray](https://leetcode.com/problems/maximum-product-subarray/#/description)

모든 원소를 곱했을 때 가장 큰 값을 갖는 부분 배열을 구하라.

## Solution

### Brute Force

모든 시작/끝 지점으로 Subarray를 구성하고 값을 계산한다.

모든 시작/끝 지점의 쌍을 구하기 위해서 O(N^2), 각 쌍마다 값을 계산하기 위해서 O(N)이므로 최종 시간 복잡도는 O(N^3), 별도의 저장공간은 필요하지 않으므로 공간 복잡도는 O(1)이 된다.

### Dynamic Programming 1

Subarray의 시작 지점과 끝 지점을 축으로 하는 2차원 배열을 이용한 Memoization을 통해 Dynamic Programming이 가능하다.

최대값을 저장하면서 진행하면 한 Row만 저장하면 되기 때문에 시간 복잡도는 O(N^2), 공간 복잡도는 O(N)이 된다.

### Dynamic Programming 2

배열의 각 원소에 대해 Traverse하면서 해당 원소에서 가능한 **최대값**과 **최소값**을 기록한다. 현 위치에서의 최대값과 최소값은

- 직전 위치의 최대값 혹은 최소값을 자신과 곱한 것
- 자기 자신

이 되기 때문에 자신 이전의 모든 값을 확인하지 않고도 최대값과 최소값을 확인할 수 있다.

> 음수 * 음수로 최대값이 변경될 수 있기 때문에 최소값도 기록한다

단 1번의 Traverse로 값을 구할 수 있기 때문에 시간 복잡도는 O(N), 최소/최대값 이외에 별도로 N에 비례하는 저장 공간을 필요로 하지 않기 때문에 공간 복잡도는 O(1).



# Hamming Code

[저번 주]()에 나왔던 문제지만, 새로 멋있는 솔루션을 알게되었다 :)



=======
excerpt: ""
---
{% include _toc.html %}

# [Contains Duplicate](https://leetcode.com/problems/contains-duplicate/#/description)

주어진 정수 배열에서 중복된 원소가 있는지 확인하라.

## Solution

주어진 배열로 Set을 구성한 뒤 원소의 수를 비교한다

> std::set은 Binary Search Tree로, std::unordered_set은 Hash Table로 구성되어 있다.



# [Maximum Product Subarray](https://leetcode.com/problems/maximum-product-subarray/#/description)

모든 원소를 곱했을 때 가장 큰 값을 갖는 부분 배열을 구하라.

## Solution

### Brute Force

모든 시작/끝 지점으로 Subarray를 구성하고 값을 계산한다.

모든 시작/끝 지점의 쌍을 구하기 위해서 O(N^2), 각 쌍마다 값을 계산하기 위해서 O(N)이므로 최종 시간 복잡도는 O(N^3), 별도의 저장공간은 필요하지 않으므로 공간 복잡도는 O(1)이 된다.

### Dynamic Programming 1

Subarray의 시작 지점과 끝 지점을 축으로 하는 2차원 배열을 이용한 Memoization을 통해 Dynamic Programming이 가능하다.

최대값을 저장하면서 진행하면 한 Row만 저장하면 되기 때문에 시간 복잡도는 O(N^2), 공간 복잡도는 O(N)이 된다.

### Dynamic Programming 2

배열의 각 원소에 대해 Traverse하면서 해당 원소에서 가능한 **최대값**과 **최소값**을 기록한다. 현 위치에서의 최대값과 최소값은

- 직전 위치의 최대값 혹은 최소값을 자신과 곱한 것
- 자기 자신

이 되기 때문에 자신 이전의 모든 값을 확인하지 않고도 최대값과 최소값을 확인할 수 있다.

> 음수 * 음수로 최대값이 변경될 수 있기 때문에 최소값도 기록한다

단 1번의 Traverse로 값을 구할 수 있기 때문에 시간 복잡도는 O(N), 최소/최대값 이외에 별도로 N에 비례하는 저장 공간을 필요로 하지 않기 때문에 공간 복잡도는 O(1).



# Hamming Code

[저번 주]()에 나왔던 문제지만, 새로 멋있는 솔루션을 알게되었다 :)

> 초안 분실로 인해 나중에 추가됩니다.
