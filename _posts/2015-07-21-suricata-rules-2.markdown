---
layout: post
title: Suricata Rules - 2
date: 2015-07-21 16:40:45
tag:
 - suricata
 - signature
 - rule
 - keyword
 - http
 - flow
 - dns
 - ipreputation
categories: Network
excerpt: Suricata 공식 홈페이지의 설명을 요약 및 번역한 문서입니다. 자세한 설명과 그림은 매 단락마다 첨부된 원문 링크를 참조하세요.
---
{% include _toc.html %}

## **[<< Suricata Rules - 1](http://dal4segno.github.io/network/2015/07/21/suricata-rules.html)** ##

## HTTP Keywords ##

[Suricata. HTTP Keywords](https://redmine.openinfosecfoundation.org/projects/suricata/wiki/HTTP-keywords)

### http_method ###

해당 Keyword를 사용하면 탐색 범위를 method-buffer에 한정한다. 다른 Content Modifier와 조합하여 사용할 수 있다.

> HTTP Method는 method-buffer에 별도 저장된다.


### http_uri, http_raw_uri ###

해당 Keyword를 사용하면 탐색 범위를 uri-buffer에 한정한다. 다른 Content Modifier와 조합하여 사용할 수 있다.

**http_raw_uri** Keyword는 *%20*과 같이 uri Encoding 된 상태의 uri를 대상으로 사용한다.

> URI 는 uri-buffer에 별도 저장된다.

### uricontent ###

*Deprecated*

### http_header, http_raw_header ###

해당 Keyword를 사용하면 탐색 범위를 header-buffer에 한정한다. 다른 Content Modifier와 조합하여 사용할 수 있다.

> HTTP Header는 header-buffer에 별도 저장된다.

Normalize 되므로 마지막에 붙는 공백이나 Tab은 모두 제거된다. 이를 확인하고 싶으면 raw를 사용해야 한다.

### http_cookie ###

해당 Keyword를 사용하면 탐색 범위를 cookie-buffer에 한정한다. 다른 Content Modifier와 조합하여 사용할 수 있다.

> Cookie는 cookie-buffer에 별도 저장된다.

### http_user_agent ###

HTTP Header의 Content Modifier로, 탐색 영역은 header-buffer에 한정된다.

조건에 **"User-Agent: "**를 **쓰지 않는다.**

> User-Agent 를 대상으로 탐색 시에는 **http_user_agent**가 **http_header**보다 더 빠르며, 사용하기 쉽다.
> [](http://blog.inliniac.net/2012/07/09/suricata-http_user_agent-vs-http_header/)



### http_client_body ###

해당 Keyword를 사용하면 탐색 범위를 Request Body에 한정한다. 다른 Content Modifier와 조합하여 사용할 수 있다.

### http_stat_code ###

해당 Keyword를 사용하면 탐색 범위를 stat-code-buffer에 한정한다. 다른 Content Modifier와 조합하여 사용할 수 있다.

> Stat Code는 stat-code-buffer에 별도 저장된다.

### http_stat_msg ###

해당 Keyword를 사용하면 탐색 범위를 stat-msg-buffer에 한정한다. 다른 Content Modifier와 조합하여 사용할 수 있다.

> Stat Code는 stat-msg-buffer에 별도 저장된다.

### http_server_body ###

해당 Keyword를 사용하면 탐색 범위를 Response Body에 한정한다. 다른 Content Modifier와 조합하여 사용할 수 있다.

### file_data ###

해당 Keyword는 **http_server_body** Keyword와 같이 탐색 범위를 HTTP Response body에 한정한다.

다른 Content Modifier와 다르게 **pkt_data** 를 만나기 전까지 모든 Content 에 영향을 미친다.

> gzip Encoding이 되어 있는 경우 압축해제 후에 분석한다.


### urilen ###

uri의 길이를 제한한다.

## DNS Keywords ##

### dns_query ###

DNS Response에 영향을 미치며, 다른 Content Modifier와 다르게 **pkt_data** 를 만나기 전까지 모든 Content 에 영향을 미친다.

## Flow Keywords ##

### Flowbits ###

하나의 Flow에 여러 패킷이 있을 때, Suricata는 이 Flow들을 Memory에 남겨둔다. 

독립 된 패킷 내의 Data가 아니라 특정 Flow 내의 패킷 Data를 검사할 때 사용한다.

Flowbits는 Action과 Name의 두 부분으로 구성되어 있으며 Action의 종류는 다음과 같다.

 - set : 현재 Flow의 해당 Condition을 Set 한다.
 - isset : 해당 Condition이 Set 되어 있을 경우 Alert을 생성한다.
 - toggle : 해당 Condition의 상태를 반전한다. set <-> unset
 - unset : 현재 Flow의 해당 Condition을 Unset 한다.
 - isnotset : 해당 Condition이 Set 되어 있지 **않을** 경우 Alert을 생성한다.
 - noalert : 이 Rule에 대하여 Alert을 생성하지 않는다.

### Flow ###

해당 Keyword는 **Flow의 방향**, **성립 여부**, 혹은 검사를 **Stream/Packet 단위**로 할 지 결정할 때 사용할 수 있다. 각 요소마다 하나씩, 총 3개의 Option을 사용할 수 있다.

#### Direction ####

 - to_client
 - from_server
 - to_server
 - from_client

> to_client와 from_server, 그리고 to_server와 from_client는 동의어이지만, 기존의 Snort Rule과의 호환성을 위해 유지되고 있다.

#### Established ####

 - established
 - stateless

#### Match ####

 - only_stream
 - no_stream : 독립된 패킷에 대해서 검사하도록 한다.

### FlowInt ###

[Suricata. FlowInt](https://redmine.openinfosecfoundation.org/projects/suricata/wiki/Flowint)

Stream 내에서 사용하는 변수와 그에 대한 조건 및 연산에 대한 Keyword이다.


#### stream_size ####

Stream의 크기를 제한한다.

## IP Reputation Rules ##

### iprep ###

해당 IP의 등장 횟수에 따른 조건을 설정할 수 있다.

 - [Suricata. IP Reputation Config](https://redmine.openinfosecfoundation.org/projects/suricata/wiki/IPReputationConfig)
 - [Suricata. IP Reputation Format](https://redmine.openinfosecfoundation.org/projects/suricata/wiki/IPReputationFormat)

