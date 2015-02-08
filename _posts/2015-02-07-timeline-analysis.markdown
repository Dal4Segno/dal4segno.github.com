---
layout: post
title: "타임라인, 타임스탬프"
date: 2015-02-07 22:42:58
tag: digitalforensics timeline supertimeline timestamp log2timeline 
---

Facebook 메인의 그것과 같이, 어떤 것을 시간 순서에 따라 나열한 것을 **타임라인(Timeline)**이라 한다. Facebook의 경우에는 친구들의 작성 글이 작성 시간 순서에 따라 나타나고, 흔히 볼 수 있는 연대기나, 연표도 일종의 타임라인이다.

타임라인은 디지털 포렌식 분야에서도 많이 사용되는 단어인데, 그 뜻은 크게 다르지 않다. 특정 환경, 보통 사건이 일어난 환경에 남아 있는 기록들을 시간 순에 따라 정리한 것을 의미한다. 

##타임 스탬프, Timestamp##
기록을 시간 순으로 정리하기 위해서는 당연히, 기록 외에도 추가적인 시간 정보가 필요하다. 대부분의 시스템은 다양한 이유로 행동/작업 등에 시간 기록을 추가로 남겨두는데 이를 **타임 스탬프(Timestamp)**라 한다.

각 운영체제와 파일 시스템마다, 시간 정보를 기록해두는 요소가 다르므로 분석할 환경에서 어떤 시간 정보가 남는지 숙지하고 있으면 좋을 듯하다.

##Super Timeline##
타임라인 중에서도, 전체 시스템을 대상으로 구축된 타임라인을 **수퍼 타임라인(Super Timeline)**이라 한다.

타임 스탬프를 하나하나 조사하여 타임라인을 구축하는 것이 불가능하지는 않겠지만, 각 환경에 따라 조사 대상이 다르고, 매우 많은 양의 정보를 수집 및 분석해야 하기 때문에 오랜 시간이 걸리는 작업이 될 것이다. 그렇기 때문에 수퍼 타임라인을 구축해주는 도구들이 몇 있는데, 그 중 대표적인 것이 **log2timeline**이란 도구이다.

해당 도구의 사용법은 
**[SANS Digital Forensics and Incident Response Blog
 . Digital Forensic SIFTing: SUPER Timeline Creation using log2timeline](http://digital-forensics.sans.org/blog/2011/12/07/digital-forensic-sifting-super-timeline-analysis-and-creation#)** 에 튜토리얼과 함께 친절하게 설명되어 있으므로, 도구를 사용해보고 싶다면 천천히 따라해보는 것이 좋을 듯하다.
> 해당 글 사이사이에 많은 참조 링크가 있으니, 막히는 부분에서 참조하도록 한다.
> 또한, 이미지 파일의 다운로드 링크가 바뀌었으나 해당 사이트에서 쉽게 찾을 수 있다.


##한계점##
log2timeline 등의 도구를 이용하면 타임라인은 쉽게 얻어낼 수 있다. 하지만, 각각의 행동을 조립하여 하나의 사건으로 묶어내는 것은 오롯이 조사자의 역량에 달려있다.
또한, 타임 스탬프는 조작이 어렵지 않기 때문에, 생성된 타임라인이 온전하지 않을 수 있다.


##참고 자료, Reference##

- [Wikipedia, English. TimeStamp](http://en.wikipedia.org/wiki/Timestamp)
- [Forensic-Proof. 타임라인 분석](http://forensic-proof.com/archives/3779)
- [Forensic-Proof. 타임라인 통합 분석](http://forensic-proof.com/archives/2323)
- [The Senator Patrick Leahy Center for Digital Investigation
Champlain College. Super Timeline](http://www.champlain.edu/Documents/LCDI/archive/SuperTimelineReport.pdf)



