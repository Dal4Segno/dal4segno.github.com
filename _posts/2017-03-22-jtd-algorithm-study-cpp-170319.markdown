---
layout: post
title: "JTD Algorithm Study Cpp Class 170319"
date: 2017-03-22 03:35:29
tag:
 - algorithm
 - tree
categories: algorithm
excerpt: ""
---
{% include _toc.html %}

# [Validate Binary Search Tree](https://leetcode.com/problems/validate-binary-search-tree)

주어진 이진 트리가 [이진 탐색 트리](https://ko.wikipedia.org/wiki/%EC%9D%B4%EC%A7%84_%ED%83%90%EC%83%89_%ED%8A%B8%EB%A6%AC)인지 판단하라

## Failure

처음에는 트리의 일부 역시 트리가 되기 때문에 모든 노드에서 자신과 자식 노드만 확인하면 될 것 같았다.

하지만, 부모 노드와는 이진 탐색 트리를 만들지만 그 위의 노드(들)와는 이진 탐색 트리가 되지 않는 경우가 있었다.

## Solution

각 노드마다 Lower/Upper Bound를 설정하는 방법으로 해결 가능하다. 특히 탐색 방향이 바뀌는 경우(Left -> Right 혹은 Right -> Left)의 경우의 Boundary 설정이 중요하다.

> 구현해보진 않았지만 매 탐색 시 탐색 방향을 인자로 보내, 탐색 방향이 바뀔 때만 적절히 처리해도 될 것 같긴 하다.



# [Minimum Depth of Binary Tree](https://leetcode.com/problems/minimum-depth-of-binary-tree/)

이진 트리에서 최소 깊이를 구하라

## Solution

각 노드에서 자식 노드에서 얻을 수 있는 최소 깊이를 구한다.

```c++
int minDepth(TreeNode* root) {
    if (!root) return 0;
    int L = minDepth(root->left), R = minDepth(root->right);
    return 1 + (min(L, R) ? min(L, R) : max(L, R));
}
```



# [Sparse Arrays](https://www.hackerrank.com/challenges/sparse-arrays?h_r=next-challenge&h_v=zen)

1. N개의 문자열을 입력 받아 저장한다.
2. M개의 문자열을 입력 받으며 저장된 문자열에 입력 받은 문자열이 몇 번 등장했는지 구하라

## Solution

해시 테이블 등 Key-Value 형태로 자료를 저장할 수 있는 자료구조를 사용하여 {문자열, 등장횟수} 를 저장하면 된다.

