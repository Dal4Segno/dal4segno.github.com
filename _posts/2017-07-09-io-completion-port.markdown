---
layout: post
title: "I/O Completion Port"
date: 2017-07-09 19:48:28
tag:
 - iocp
 - windows
 - c++
categories: windows
excerpt: "I/O Completion Port(이하 IOCP)는 멀티 프로세서 환경에서 다수의 비동기 I/O를 처리하기 위해 고안된 모델이다."
---
{% include _toc.html %}

# I/O Completion Port

I/O Completion Port(이하 IOCP)는 멀티 프로세서 환경에서 다수의 비동기 I/O를 처리하기 위해 고안된 모델이다.

## Overlapped I/O

Windows에서 사용하는 Non-Block + Asynchronous I/O 모델이며, IOCP를 비롯한 많은 비동기 I/O에서 해당 모델을 사용한다.

- I/O 의 처리를 장치에게 맡겨 I/O 완료까지 대기하지 않음
- I/O 가 완료되는 순간에 통지를 받음

이와 같은 특징으로 인해 여러 개의 I/O가 중첩되어(Overlapped) 처리될 수 있다.

또한 장치가 I/O 작업을 사용자가 제공하는 버퍼에 바로 수행하므로 별도의 복사 작업을 위한 비용이 소모되지 않는다.

Overlapped I/O 시에는 OVERLAPPED 구조체를 I/O 함수에 전달해야 하며, 해당 I/O가 끝날 때까지 해당 구조체 변수가 변경/제거되지 않아야 한다.

# 구성

![IOCP 1]({{site.url}}/image/iocp1.png "IOCP 1")

![IOCP 2]({{site.url}}/image/iocp2.png "IOCP 2")

- IOCP
  - I/O 완료 통지를 보관하는 큐(Queue)
    - FIFO
  - I/O 이후 작업을 처리하기 위해 대기 중인 스레드를 보관하는 큐
    - LIFO
- IOCP와 연결된(Associated) 장치들
  - I/O 작업 완료시 IOCP의 큐에 통지를 EnQueue

## 스레드 풀

특정 작업을 수행할 때마다 새로운 스레드를 생성하지 않고, 미리 충분한 양의 스레드를 생성해두고 필요할 때마다 일부 스레드를 사용하여 스레드의 생성/소멸 비용을 절약하는 구조이다. 사용 중이지 않은 스레드들은 대기 상태로 존재한다.

IOCP는 I/O 이 후의 작업을 처리할 스레드를 스레드 풀로 관리하며, 후술할 *GetQueuedCompletionStatus* 함수를 통해 IOCP의 대기 스레드 큐에 현재 스레드를 EnQueue 할 수 있다.

# 사용 방법

## 생성

[*CreateIoCompletionPort*](https://msdn.microsoft.com/ko-kr/library/windows/desktop/aa363862(v=vs.85).aspx) 함수를 이용한다.

```c++
HANDLE WINAPI CreateIoCompletionPort(
  _In_     HANDLE    FileHandle,
  _In_opt_ HANDLE    ExistingCompletionPort,
  _In_     ULONG_PTR CompletionKey,
  _In_     DWORD     NumberOfConcurrentThreads
);
```

해당 함수는 IOCP를 생성하거나, 장치를 IOCP에 연결하는 용도(혹은 둘을 동시에)로 사용할 수 있는데, IOCP를 생성만 하기 위해서는 다음과 같이 사용한다.

```c++
HANDLE iocp = CreateIoCompletionPort(INVALID_HANDLE_VALUE, NULL, NULL, n);
```

## 연결

생성에서 언급했듯이 [*CreateIoCompletionPort*](https://msdn.microsoft.com/ko-kr/library/windows/desktop/aa363862(v=vs.85).aspx) 함수를 이용한다.

```c++
CreateIoCompletionPort(deviceHandle, iocp, completionKey, 0);
```

연결할 장치와 IOCP,  각 I/O를 구분하기 위한 completionKey를 인자로 호출하면 된다. completionKey는 해당 함수 내에서는 사용되지 않으며, 완료 통지를 DeQueue 하는 시점에서 개발자가 사용할 수 있다.

장치가 IOCP와 성공적으로 연결되면 해당 장치에서 I/O가 완료될 때마다 IOCP의 큐에 완료 통지를 EnQueue 한다.

> I/O가 처리되는 순서는 I/O 함수를 호출한 순서가 아니라 장치 드라이버에 의존적이다.

## 처리

[*GetQueuedCompletionStatus*](https://msdn.microsoft.com/ko-kr/library/windows/desktop/aa364986(v=vs.85).aspx) 함수(이하 GQCS)를 이용한다.

```c++
BOOL WINAPI GetQueuedCompletionStatus(
  _In_  HANDLE       CompletionPort,
  _Out_ LPDWORD      lpNumberOfBytes,
  _Out_ PULONG_PTR   lpCompletionKey,
  _Out_ LPOVERLAPPED *lpOverlapped,
  _In_  DWORD        dwMilliseconds
);
```

```c++
DWORD iocpRecieved;
SOCKET iocpClientSocket;
IODATA iocpIoData;

GetQueuedCompletionStatus(completionPort, &iocpRecieved, (PULONG_PTR)&iocpClientSocket, (LPOVERLAPPED*)&iocpIoData, INFINITE);
```

lpCompletionKey와 lpOverlapped 인자를 통해 IOCP 연결 및 I/O 함수 호출 시 사용한 인자들을 받아와 IOCP 및 장치를 특정할 수 있다.

IOCP의 대기 스레드 큐는 후입선출(LIFO)이기 때문에 가장 최근에 삽입된 스레드가 활성화된다.

# Reference

- [MSDN, I/O Completion Ports](https://msdn.microsoft.com/ko-kr/library/windows/desktop/aa365198(v=vs.85).aspx)
- [Joinc, Overlapped I/O 모델](https://www.joinc.co.kr/w/Site/win_network_prog/doc/overlapped)
- [Joinc, IOCP에 대하여](https://www.joinc.co.kr/w/Site/win_network_prog/doc/iocp)
- 제프리 리처의 Windows via C/C++, 10장 동기 및 비동기 장치 I/O

> Reference의 유효성은 포스트 작성 시점에 검증되었습니다.