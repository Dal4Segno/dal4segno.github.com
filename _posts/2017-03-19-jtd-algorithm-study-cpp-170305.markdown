---
layout: post
title: "JTD Algoritm Study Cpp Class 170305"
date: 2017-03-19 15:55:36
tag:
 - algorithm
 - linked-list
categories: algorithm
excerpt: ""
---
{% include _toc.html %}

>  대부분의 문제와 솔루션은 링크이므로 클릭해서 이동하실 수 있습니다.

# [Copy List with Random Pointer](https://leetcode.com/problems/copy-list-with-random-pointer/)

일반적인 Single Linked List에서 각 노드마다 임의의 노드와 연결되는 Random Pointer가 추가적으로 있는 List를 Deep Copy하라

## Failure

내가 내놓은 답안은 다음과 같다.

1. 리스트를 순회하면서 각 Node의 주소와 Random Pointer의 값을 저장
2. 각 Random Pointer의 값을 Node의 주소가 저장된 배열에서 검색하여 Random Pointer의 Index를 생성
3. 새로운 리스트를 생성
4. Random Pointer의 Index를 이용하여 새로운 리스트의 Random Pointer 설정

결과적으로 Node, Random Pointer, Random Pointer Index 를 저장해야 하고 Random Pointer Index를 만들기 위해 N개의 Random Pointer마다 N개의 Node 주소를 확인해야 하는 굉장히 비효율적인 답안이 되었다.

## [Solution](https://leetcode.com/problems/copy-list-with-random-pointer/#/solutions)

### 원본을 활용하는 경우

기존의 리스트(*old*)와 새로 만드는 리스트(*new*)의 노드를 map으로 묶어버린 후, new의 next와 random을 old의 next와 random으로 설정한다.

> Pointer를 복사하는 형태인데 Deep Copy라고 할 수 있는지 잘 모르겠다.

### [원본을 활용하지 않는 경우](https://discuss.leetcode.com/topic/5831/2-clean-c-algorithms-without-using-extra-array-hash-table-algorithms-are-explained-step-by-step)

![1]({{site.url}}/image/deep-copy-list-1.png "1단계")

복사본을 만든 뒤 위와 같은 구조가 되도록 old와 new의 next를 설정한다.

![2]({{site.url}}/image/deep-copy-list-2.png "2단계")

new의 random은 old의 random의 next와 같아야 한다.

![3]({{site.url}}/image/deep-copy-list-3.png "3단계")

new의 next를 재설정한다.



new 노드들을 제외하면 별도로 사용하는 공간도 없고 시간 복잡도도 O(N)으로 작동하며, 각 노드와 그의 Next, Random도 원본과는 별도로 동작하는 완벽한 Deep Copy이다.

# [Single Number II](https://leetcode.com/problems/single-number-ii/#/description)

배열 내에 모든 원소는 세 번씩 등장하지만, 한 원소는 단 한 번만 등장한다. 이 때 한 번만 등장하는 원소를 찾아라

## [Solution](https://discuss.leetcode.com/topic/43166/java-o-n-easy-to-understand-solution-easily-extended-to-any-times-of-occurance)

### [직관적인 답](https://discuss.leetcode.com/topic/43166/java-o-n-easy-to-understand-solution-easily-extended-to-any-times-of-occurance)

int가 32 Bit 자료형일 때, N개의 수의 각 비트의 값을 더하고 Mod 3을 취한다. 세 번 등장한 수는 해당 비트를 3번 사용하기 때문에 Mod 3에 의해 제거되고 1번 등장한 수의 비트만 남게된다.

### [상태를 이용한 답](https://discuss.leetcode.com/topic/2031/challenge-me-thx/17)

도발적인 제목에 걸맞게, 꽤 충격적인 답안이다. 밑에 있는 친절한 설명들을 통해 이해할 수 있었다.

32 비트 중 각 비트가 몇 번 등장했는지 저장하기 위해 2개의 값을(*ones, twos*) 사용한다. 2개인 이유는 2 비트를 이용하면 최대 4 개의 경우를 처리할 수 있기 때문에 같은 수가 3번까지 등장하는 이 문제를 처리할 수 있기 때문이다.

2개의 int값을 이용하면 각 비트마다 2개의 비트를 통해 상태를 나타낼 수 있게 되는데, 00 -> 01 -> 10 -> 00 (0 -> 1 -> 2 -> 3/0)의 순서로 동작하게 하여 최종적으로 3번 나타난 수는 사라지고 1번 등장한 수만 남게 된다.



# [Minimum Moves to Equal Array Elements]([https://leetcode.com/problems/minimum-moves-to-equal-array-elements/?tab=Description](https://leetcode.com/problems/minimum-moves-to-equal-array-elements/?tab=Description))

1번의 동작으로 한 원소를 제외한 모든 원소의 값을 1씩 증가시킬 때, 모든 원소의 값을 같게 만들기 위한 최소 동작 횟수를 구하라.

## Solution

한 원소를 제외한 모든 원소의 값을 1씩 증가시킨다는 말은 **한 원소만 상대적으로 1 감소시킨다는 말과 같다.**

결국 모든 원소를 최소값까지 감소시키면 쉽게 구할 수 있다.



# Search Largest Zero Space

0끼리 상하좌우로 인접해있는 공간 중, 가장 큰 공간의 크기를 구하라.

## Solution

상하좌우 4방향으로 재귀적인 탐색을 시도하면 된다. 알고리즘의 이름은 처음 알게되었는데 [Flood Fill](https://ko.wikipedia.org/wiki/%ED%94%8C%EB%9F%AC%EB%93%9C_%ED%95%84) 알고리즘이라고 한다.

