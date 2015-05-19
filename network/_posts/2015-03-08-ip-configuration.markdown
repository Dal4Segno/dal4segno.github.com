---
layout: post
title: "IP Configuration"
date: 2015-03-08 10:58:47
tag: network ip dhcp subnetting supernetting gateway dns
categories: "Network" 
---

## IP Address Allocation ##
어느 프로토콜이나, 통신 대상을 특정하기 위해서는 **Address(주소)**등의 정보를 지정, 할당하는 작업이 필요하다. 

IP에서는 IP 주소와 Default Gateway(기본 게이트웨이), DNS 서버 등을 사용자가 직접 할당하는 방법과, **DHCP(Dynamic Host Configuration Protocol)**을 이용하여 자동으로 그리고 동적으로 할당 받는 방법이 있다.

> 기본 게이트웨이는 두 말단이 직접 통신이 불가능 한 경우 우선적으로 패킷을 전송하는 대상이다.

### DHCP ###
IP를 사용하는 네트워크에서 사용되며, IP 주소, 기본 게이트웨이, DNS 서버등을 중앙에서 관리하고 설정하기 위한 프로토콜이다. 설정을 요청하는 Client와 해당 요청에 응답하는 DHCP Server가 있는 Client-Server 모델을 이용한다.

DHCP에서 IP 주소는 **Lease(임대)**되는 것 이기때문에, 정책에 따라 부여받은 IP 주소가 회수되거나 재할당되는 경우가 있을 수 있다.
#### DORA Operation ####
![DHCP DORA Operation]({{site.url}}/image/dhcp_dora.png "DHCP의 과정(DORA)")

DHCP 작업은 **UDP(User Datagram Protocol)**을 이용한다. 이는 추후에 상세한 포스팅을 올릴 예정이다.

1. **Discover** - 브로드캐스팅을 통해 DHCP 서버를 찾는다
2. **Offer** -  Discover에 대한 응답으로, DHCP Server 자신의 IP 주소와 Client가 할당 받을 수 있는 IP 주소를 전달한다.
3. **Request** - Offer에서 받은, 할당 받을 수 있는 IP 주소에 대해 임대를 요청한다.
4. **Acknowledge** - 임대 절차가 완료된 IP의 주소, 기간 등의 정보를 전송한다.

## CIDR(Classless Inter-Domain Routing) ##
네트워크가 다른 네트워크의 집합으로 구성되어 있을 경우, 내부 네트워크(Subnetwork) 간의 통신을 위해 각 내부 네트워크에도 주소가 할당되어야 할 필요가 있다.**(Subnetting)**

Class 기반의 주소 할당으로도 계층 구조를 나타낼 수 있지만, Class를 나타내는 데에 필요한 주소 길이가 고정적인 특성으로 인해 유연한 주소 할당이 불가하며 낭비되는 주소가 많다는 문제점이 있다. 이를 해결하기 위해 도입된 방법이 CIDR이다.

![Subnetwork]({{site.url}}/image/subnetting.png "Subnetwork 주소 구조")

상위 네트워크의 Network ID를 사용하여, 하위 네트워크임을 명시하고 뒤에 **Subnet ID**를 이용하여 내부 네트워크들을 구분한다. Class가 아닌, 주소의 접두(Prefix), Network ID와 Subnet ID의 연속을 통해 계층을 나타내는 것이 가능하다. 해당 접두 부분의 길이를 Masking으로 나타내는 것을 **Subnet Mask**라 한다.

111.222.333.444/24 의 경우 Subnet Mask의 길이가 24 Bit임을 명시한 것이다.

### Supernetting ###
여러 Subnetwork의 접두 부분의 공통 부분을 취해서 각 Subnetwork들이 같은 Network ID를 갖는 것처럼 표현하여, 라우팅 테이블을 간소화하는 방법이다.

## Gateway ##
두 말단이 직접 연결되어 있지 않은 경우, 패킷의 직접 전송이 불가능하기 때문에 다른 지점들을 거쳐서 전송해야 하는데, 이 때 게이트웨이로 패킷을 전송하게 된다. 일반적으로 외부와 연결되어 있는 지점이 기본 게이트웨이가 된다.

## DNS(Domain Name Service) ##
컴퓨터들은 IP 주소를 통해 서로를 구별하고 통신하지만, 이 주소를 사람이 외워서 사용하기는 힘들기 때문에 사람이 기억하고 사용하기 쉬운 문자열로 만든 **도메인 이름(Domain Name)**을 이용한다.

도메인도 IP와 같이 계층적인 구조이며, 다수의 서버로 구성되는 분산 구조로 이루어져 있다.

keeper.cse.pusan.ac.kr 과 같은 도메인 이름에서는 

1. Root DNS Server -> .kr
2. .kr -> .ac.kr
3. .ac.kr -> pusan.ac.kr
4. pusan.ac.kr -> cse.pusan.ac.kr
5. cse.pusan.ac.kr -> keeper.cse.pusan.ac.kr

의 순서로 해당 도메인의 IP 주소를 찾아간다. 

## 참고자료, Reference ##
 - [Microsoft Support. DHCP 기본 사항](http://support.microsoft.com/kb/169289/ko)
 - [IEFT. RFC 2131](https://www.ietf.org/rfc/rfc2131.txt)
 - [Wikipedia, English. Dynamic Host Configuration Protocol](http://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol)
 - [Netmanias. DHCP 프로토콜 기본 원리](http://www.netmanias.com/ko/post/blog/5348/dhcp-ip-allocation/understanding-the-basic-operations-of-dhcp)
 - [S.M.A.R.T . CIDR(Subnetting, Supernetting, VLSM)](http://www.secure.pe.kr/15)
 - [Wikipedia, Korean. 사이더_(네트워킹)](http://ko.wikipedia.org/wiki/%EC%82%AC%EC%9D%B4%EB%8D%94_(%EB%84%A4%ED%8A%B8%EC%9B%8C%ED%82%B9))

> 본 문서는 부산대학교 정보컴퓨터공학부 김종덕 교수님의 컴퓨터 네트워크 강의의 내용을 기반으로 작성됩니다.