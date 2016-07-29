---
layout: post
title: Suricata Rules - 1
date: 2015-07-21 02:06:06
tag:
 - suricata
 - Signatures
 - Signature
categories: Network
excerpt: Suricata 공식 홈페이지의 설명을 요약 및 번역한 문서입니다. 자세한 설명과 그림은 매 단락마다 첨부된 원문 링크를 참조하세요.
---

> Suricata 공식 홈페이지의 설명을 요약 및 번역한 문서입니다. 자세한 설명과 그림은 매 단락마다 첨부된 원문 링크를 참조하세요.

## Default ##

[Suricata Signatures](https://redmine.openinfosecfoundation.org/projects/suricata/wiki/Suricata_Signatures)

### Action ###

해당 Signature가 어떤 행동을 할 지 설정한다.

> Signature에는 Pass, Drop, Reject, Alert이 있다.

> [Suricata.yaml Action Order](https://redmine.openinfosecfoundation.org/projects/suricata/wiki/Suricatayaml#Action-order) 참조

### Protocol ###

해당 Signature를 특정 프로토콜을 대상으로 하도록 한다.

지원되는 프로토콜은 다음과 같다

 - TCP
 - UDP
 - ICMP
 - IP
 - HTTP
 - FTP
 - TLS (SSL을 포함하여)
 - SMB
 - DNS



### Source And Destination ###

대상 IP를 지정할 수 있으며 .yaml 파일에서 지정한 변수를 사용할 수 있고, Subnet Mask를 사용할 수 있다.

 - **!**를 사용하여 Negation(부정, 대상을 포함하지 않음)
 - **[ ]**를 사용하여 복합 조건 지정

이 가능하다. 

**->** 로 방향을 지정하거나 **<>**로 양방향을 나타낼 수 있음.

방향을 지정할 시에는 **Source** -> **Destination** 의 모습이 되어야 한다.

### Ports ###

Port를 특정할 수 있으며 

 - **!**를 사용하여 Negation(Exception)
 - **:**를 사용하여 범위 지정
 - **[ ]**를 사용하여 복합 조건 지정

이 가능하다.

### Signature Options ###

Keyword들은 기본적으로

*name: settings;* 의 형태를 한다.

## Meta-settings ##

[Suricata. Meta Settings](https://redmine.openinfosecfoundation.org/projects/suricata/wiki/Meta-settings)

Meta-settings는 Suricata의 분석에 영향을 미치지 않으며, 보고와 관리를 위해서 사용된다.

### msg (Message) ###

해당 Signature가 Log에 남기는 메시지를 설정한다.

msg를 가장 첫 Keyword로 사용하는 것이 규약이다.

### sid (Signature ID) ###

각 Signature들은 자신만의 고유한 sid를 갖는다.

### rev (Revision) ###

해당 Signature가 몇 번 Revision 되었는 지 나타낸다.

### gid (Group ID) ###

해당 Signature가 어떤 Group에 속해있는 지 나타낸다. Suricata는 기본값으로 1을 사용한다.

### classtype ###

Signature와 Alert의 분류를 돕기 위한 정보이며 classification.config에 여러 classtype들이 정의되어 있다.

Short Name, Long Name, Priority로 구성된다.

Signature 내에서는 Short Name으로 나타낸다.

### Reference ###

해당 Signature를 만든 목적이 되는 참조 문서등을 기록한다.

일반적으로 많이 사용되는 Site들은 별도로 Keyword를 제공한다.

### Priority ###

해당 Signature의 중요도를 나타낸다.

ClassType에서 정의한 Priority를 덮어 쓴다.

### Metadata ###

Suricata에서는 *metadata* Keyword를 무시한다.

## Payload Keywords ##

[Suricata. Payload Keywords](https://redmine.openinfosecfoundation.org/projects/suricata/wiki/Payload_keywords)

### Content ###

Packet 의 Content에 대한 조건이다. Not Printable 문자나 다른 용도로 사용되고 있는 문자는 **|** **|** 안에 ASCII의 16진수형을 넣어 표현할 수 있다.

다양한 Modifier를 가질 수 있다.

#### Nocase ####
**Content** Keyword는 기본적으로 Case-Sensitive 이지만, **nocase** Keyword를 사용하여 해제할 수 있다.

#### Depth ####

Content의 시작에서 몇 Byte 만큼 떨어진 Data까지 탐색할 지 설정한다.

#### Offset ####

Content의 시작에서 몇 Byte 만큼 떨어진 Data부터 탐색할 지 설정한다.

#### Distance ####

현재 탐색된 Content의 끝부터 다음 탐색될 Content의 처음 부분 사이의 거리를 설정한다.

음수도 가능하다.

#### Within ####

현재 탐색된 Content의 끝부터 지정한 바이트까지 다음 탐색될 Content가 포함되어 있는 지 확인한다.

1 이상의 정수만 가능하다.

### Isdataat ###

Content의 시작에서 부터 지정한 바이트 이후에도 Data가 있는 지 확인한다.

**relative** word를 사용할 경우, 마지막 Match를 기준으로 한다.

### Dsize ###

Payload의 크기에 대한 조건을 설정할 수 있다.

### RPC ###

특정 Application에 대한 RPC를 검사할 수 있으며, Version과 Procedure Number는 Wild Card로 지정할 수 있다.

### Replace ###

Content Modifier로, IPS 에서만 작동하며 특정 Content를 원하는 Data로 대체할 수 있다.

### pcre (Perl Compatible Regular Expressions) ###

Perl의 정규표현식을 빌려서 조건을 설정할 수 있다.

### fast_pattern ###

[Suricata. Fast Pattern](https://redmine.openinfosecfoundation.org/projects/suricata/wiki/Fast_pattern)

분석을 빠르게 하기 위한 설정으로, 정밀도가 떨어질 수 있다.


## **[>> Suricata Rules - 2](http://dal4segno.github.io/network/2015/07/22/suricata-rules-2.html)** ##

