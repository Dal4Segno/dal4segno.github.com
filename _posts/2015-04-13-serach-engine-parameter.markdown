---
layout: post
title: Search Engine Query Parameter
date: 2015-04-13 19:57:07
tag:
 - se
 - seo
 - searchengine
 - google
 - query
 - parameter
 - search
categories: digitalforensics
excerpt: 각 검색엔진이 사용하는 parameter에 대해서 알아본다
---

검색 엔진을 통해 어떤 것을 검색했는 지는 사용자의 행동을 추측하는데에 꽤 쓸만한 정보가 될 수 있다. 
Google, Bing 등과 같이, 여러 검색 엔진을 사용할 때, 사용자가 입력한 검색어는 특정 매개 변수(Parameter)를 통해 서버로 전송된다. 하지만 각 검색 엔진들은 서로 다른 매개 변수명을 사용하기 때문에, 검색어를 자동으로 수집하기 위해서는 각 검색엔진에서 사용하는 매개 변수명을 알고 있어야한다.
> 수동으로 한다면 매개 변수명 앞에 있는 url을 통해서 어떤 검색 엔진을 사용했는 지 쉽게 알 수 있을 것이다.

하지만, 다행히도 Google에서 본인들의 Analytics 서비스(자신의 사이트를 어디서 검색해서 들어왔는지에 대한 데이터를 제공)를 위해서 사용하고 있는 여러 유명한 검색 엔진들의 Domain Name과 매개 변수명을 공개하고 있다.

[Search Engine Configuration - Web Tracking (ga.js)](https://developers.google.com/analytics/devguides/collection/gajs/gaTrackingTraffic#searchEngine)

이 정보를 통해서 간단하게 사용자의 검색 엔진 사용결과를 조사할 수 있을 것으로 보인다.