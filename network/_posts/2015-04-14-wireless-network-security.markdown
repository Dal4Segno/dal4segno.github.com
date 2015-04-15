---
layout: post
title: "Wireless Network Security"
date: 2015-04-14 22:36:39
tag: wireless network wi-fi wifi wep wpa wpa2
categories: network
---
> 본 포스트에서 언급되는 암호학적 지식(과 취약점)은 별도의 **[포스트]()**에서 설명하도록 하겠습니다. 가급적, 먼저 읽고 오시는 것을 추천합니다.

## WEP ##
유선 동등 프라이버시(**Wired Equivalent Privacy**)는 이름 그대로, WEP가 도입되던 시절(1999)의 유선 보안과 맞먹는 보안성을 갖도록 설계되었다.

기밀성을 위해 **RC4** 암호화 기법을 사용하였으며, CRC-32 체크섬(Checksum)을 사용하여 무결성을 확보하였다.

각 통신 단말들은 사전에 공유된 비밀키(비밀번호)를 사용하여 데이터의 암호화/복호화를 수행한다.

2004년도에 **IEEE 802.11i**(or IEEE 802.11i-2004, 무선 네트워크 보안에 관한 표준)이 제정되면서 사용 중지(Deprecated)되었다.

## WPA ##
와이파이 보호 접속(**Wi-Fi Protected Access**)은 IEEE 802.11i가 제정되기 이전에 WEP를 대체하기 위해 구현되었으며, IEEE 802.11i에 큰 영향을 미쳤다.

### TKIP ###
WPA는 임시 키 무결성 프로토콜(Temporal Key Integrity Protocol)을 사용하여 입력된 키를 모든 패킷에 사용하는 WEP에 반해서 각 패킷에 대한 암호화키를 동적으로 생성할 수 있었다.

WEP를 사용하던 하드웨어에서도 WPA를 사용할 수 있어야 했기 때문에, TKIP는 RC4 방식의 암호화를 사용하고, 그로 인해서 WEP와 비슷한 공격에 대해서 취약하다.

2009년도에 사용 중지되었다.

## WPA2 ##
IEEE 802.11i에서 제정된 기술로, WPA를 기반으로 만들어졌다. 
암호화키를 동적으로 생성하는 **CCMP**(Counter Mode Cipher Block Chaining Message Authentication Code Protocol, Counter Mode CBC-MAC Protocol or CCM mode Protocol)를 사용하는데, WPA-TKIP와는 다르게 안전한 AES 암호화 방식을 사용한다.

현재까지 나온 무선 네트워크 보안 기술 중에 가장 안전하므로, 공유기나 각종 설정 시 WPA2를 사용하는 것이 권장됨.

## Reference ##

 - [Wikipedia(KR). 유선 동등 프라이버시](http://ko.wikipedia.org/wiki/%EC%9C%A0%EC%84%A0_%EB%8F%99%EB%93%B1_%ED%94%84%EB%9D%BC%EC%9D%B4%EB%B2%84%EC%8B%9C)
 - [Wikipedia(EN). Wired Equivalent Privacy](http://en.wikipedia.org/wiki/Wired_Equivalent_Privacy)
 - [Wikipedia(EN). IEEE 802.11-2004](http://en.wikipedia.org/wiki/IEEE_802.11i-2004)
 - [Wikipedia(EN). Wi-Fi Protected Access](http://en.wikipedia.org/wiki/Wi-Fi_Protected_Access)
 - [Wikipedia(KR). 와이파이 보호 접속](http://ko.wikipedia.org/wiki/%EC%99%80%EC%9D%B4%ED%8C%8C%EC%9D%B4_%EB%B3%B4%ED%98%B8_%EC%A0%91%EC%86%8D)