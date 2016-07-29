---
layout: post
title: "Wi-Fi Sense"
date: 2015-07-06 12:47:38
tag:
 - microsoft
 - wifi
 - wifisense
 - tethering
categories: network
excerpt: Windows 10에 탑재되는 기술로 유명해진 기술이지만 Windows Phone 8.1 부터 지원하는 기술로, 자신의 Wi-Fi 테터링에 Facebook, Outlook, Skype 친구들이 별도의 인증 절차 없이 접근할 수 있도록 하는 기술이다.
---

Windows 10에 탑재되는 기술로 유명해진 기술이지만 Windows Phone 8.1 부터 지원하는 기술로, 자신의 Wi-Fi 테터링에 Facebook, Outlook, Skype 친구들이 별도의 인증 절차 없이 접근할 수 있도록 하는 기술이다.

## 과정 ##
테더링의 Host(이하 Host)가 자신의 정보를 MS에 보내면, 이를 저장해두었다가 Host의 친구들에게 해당 정보를 건네준다.

## 효과 ##
관련 정보(SSID, Password 등)을 직접 알려주지 않아도 접근할 수 있기 때문에, 알려주는 과정에서 발생하는 누출을 걱정하지 않아도 되며 편리하다.

> 관련 정보를 어딘가에 적어두면 누구나 볼 수 있는 것과 같은 문제를 걱정하지 않아도 된다.

## 문제점 ##
### 불투명성 ###
정보를 저장하고 건네주는 과정이 MS에 의해 이루어지기 때문에, 실제 사용자는 알 수 없다.

### 사회공학 ###
테더링 접근 권한을 위해서 Host에게 친구 신청을 하는 경우가 있을 것으로 보인다.

## 바라는 점 ##
Host에게 사용자 필터 기능이나 접근 시도시 승인 과정이 추가되어야 할 것으로 보인다.

## Reference ##

 - [Computer World. Wi-fi Password Sharing Feature in Windows 10 Raises Security Concerns.](www.computerworld.com/article/2943636/mobile-wireless/wifi-passwordsharing-feature-in-windows-10-raises-security-concerns.html
)
 - [Windows Phone. Use Wi-Fi Sense to get Connected](https://www.windowsphone.com/en-in/how-to/wp8/connectivity/use-wi-fi-sense-to-get-connected
)