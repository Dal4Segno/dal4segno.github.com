---
layout: post
title: "Internetworking, 인터네트워킹"
date: 2015-02-12 00:26:44
tag: network internetworking ip arp fowarding routing
categories: "Network"
---
문자 그대로, 네트워크 간의 교류(통신)하는 개념 혹은 기술 전반을 이르는 단어이다. 여기서의 네트워크는 물리적으로 직접 연결되지 않은 네트워크와 심지어 구성이 다른 것들을 모두 포함한다. 마치 우리가 일반적으로 인터넷을 사용할 때 네트워크 구성 및 구조를 고려하지 않는 것처럼 말이다.


 - 연결된 각 네트워크는 다른 구성일 수 있으므로 다양한 구성에 대응할 수 있는 **Heterogeneity(이질성)**와
 - 수 많은 네트워크에 대응할 수 있는 **Scalability(확장성)**

가 매우 중요하다. 

여러 네트워크가 서로 다른 통신 규약(**Protocol, 프로토콜**)을 사용한다면, 통신이 불가능하기 때문에 표준을 정하여 모두가 같은 프로토콜을 사용함으로서 이질성을 확보하였다. 현재의 표준은 **[OSI 참조 모델(OSI Reference Model)](http://ko.wikipedia.org/wiki/OSI_%EB%AA%A8%ED%98%95)**이다. 본 포스트는 해당 모델에 대한 지식이 있다는 것을 전제로 작성된다.

##IP Service Model##
인터넷을 사용 중이라면, 많이 들어보았을 법 한 이름이다. **IP(Internet Protocol)**는 OSI 참조 모델에서 3 계층, 네트워크 계층의 역할을 맡는다.

통신 시, 데이터는 송신자와 수신자 외에도 그 사이에 있는 많은 네트워크를 거치게 되는데, IP는 각종 세부 사항의 처리는 **End Point(말단)**, 송신자와 수신자**(상위 계층)**에게 맡기고, 최대한 단순한 구성을 통해 확장성을 높인 프로토콜이다. 

데이터 전송은 의미 단위(파일 등)가 아닌 **용량, 덩어리(Datagram, Packet)** 단위로 이루어진다.

또한, IP는 **Best-Effort Delivery**의 특성을 갖는데, 이는 통신에 대해 보장하지 않는다는(Unreliable) 의미이다. 즉, 손실, 순서 바뀜, 중복, 지연 등의 문제가 발생 가능하며, 이는  IP에서 해결하지 않는다.

###IP Address###
v4 기준으로 32bit의 주소를 사용한다. 네트워크의 크기에 따라 [Class를 나누어 Hierachical한 구조를 형성한다](http://ko.wikipedia.org/wiki/IPv4). 하위 네트워크들은 모두 상위 네트워크 주소가 같기 때문에, 여러 호스트들을 네트워크 단위로 관리할 수 있는 장점이 있다.

특수 목적용으로 일반적인 호스트에 할당할 수 없는 주소도 있다.

###ARP, Address Resolution Protocol###
통신 시, IP 주소를 사용한다고 해도 직접적인 통신은 하위 계층인 물리 계층을 통해 이루어지므로, IP 주소를 MAC 주소로 변환하는 과정이 필요하다.

이 과정은 수신자의 IP에 대한(혹은 상위 네트워크) MAC 주소를 알고 있는 호스트를 **Broadcasting(브로드캐스팅)** 을 통해서 찾는다.
> 브로드캐스팅이란, 같은 네트워크에 있는 모든 호스트에게 데이터를 전송하는 것이다.

ARP를 통해 알아낸 MAC 주소는 별도로 저장하여 사용한다. 

####Vulnerability, 취약점####
ARP 과정에는 별도의 인증 과정이 없기 때문에, 요청과 응답(Request, Response)이 모두 위조될 수 있다. 이와 관련된 공격 기법은 **ARP Spoofing, Poisoning**이라 하며, 이 후 별도의 포스트에서 다뤄보도록 한다.

또한, [**Stateless(무상태)**]() 프로토콜이기 때문에, Reply가 적절한 Request없이 전송될 수도 있다.

##Fowarding / Routing##
위에서도 언급했듯이, 매 송신마다 ARP를 통해 MAC 주소를 알아내는 것이 아니라, 한 번 알아낸 주소는 별도의 Table에 저장하여 사용한다. 이 때,
 
- Table을 만드는 작업을 **Routing(라우팅)**
- Table을 이용하여 데이터를 적절하게 송신하는 것을 **Fowarding(포워딩)**

이라 한다. 
###Fowarding Algorithm###
Destination(목적지, 수신측) IP를, 현재 자신이 전송 가능한 대상의 주소들과 Masking 한 후, **앞 부분이 가장 길게 일치하는(Longest Prefix Matched)** 대상으로 전송한다.

##Fragmentation / Reassembly##
각 네트워크에는 **MTU, Maximum Transmission Unit**, 최대로 전송 가능한 용량이 정해져 있기 때문에 이 크기보다 큰 데이터를 보내기 위해서는 **MTU 단위로 나누어서(Fragmentation)** 전송해야 한다. 또한, 재조립을 위해서 Fragmentation 되었다는 사실과, 순서 정보를 포함해야 한다.

##참고 자료, Reference##
 - [pldworld.com. 인터네트워킹의 개념적 이해](http://www1.pldworld.com/@xilinx/html/link/network/inter.htm)
 - [텀즈. 인터네트워킹](http://www.terms.co.kr/internetworking.htm)

> 본 문서는 부산대학교 정보컴퓨터공학부 김종덕 교수님의 컴퓨터 네트워크 강의의 내용을 기반으로 작성됩니다.