---
layout: post
title: Rails on Heroku
date: 2015-05-20 23:38:05
tag:
 - heroku
 - rails
 - ruby
 - ror
 - paas
categories: web-programming
---

Heroku는 PaaS, Platform as a Service 중 하나로, 플랫폼을 제공함으로서 사용자가 어플리케이션에만 집중할 수 있도록 해주는 서비스이다. Heroku에 어플리케이션을 올리면 알아서 가상 서버에서 설정 같은걸 다 해주고 심지어 도메인까지 하나 제공한다.

 - [Heroku](https://www.google.co.kr/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0CCMQ7QgwAA&url=https%3A%2F%2Fwww.heroku.com%2F&ei=hZxcVejxIM_X8gXa4oLgAg&usg=AFQjCNF8-hoB8iHVyZ2dDq3bYi_oSmHVtg&sig2=tfCbeO9LOZvll5vWv3PLMA)

게다가 안내 및 튜토리얼도 매우 친절하게 잘 되어있어서, 따라가면 어렵지 않게 Heroku의 서비스를 이용할 수 있다.

다음에 언급할 사항들만 잘 알고있다면.

> Windows 10 TP 환경이다.

# PostgreSQL #

Heroku는 PostgreSQL 을 DBMS로 사용한다. 여러가지 장점이 있다고 하는데, 설명은 링크로 대체한다.

 - [PostgreSQL](http://www.postgresql.org/)
 - [hello world, NAVER. 한눈에 살펴보는 PostgreSQL ](http://helloworld.naver.com/helloworld/227936)

문제는 Rails 어플리케이션에서 기본으로 이용하는 DBMS가 Sqlite3 이고, Heroku에서는 이를 지원하지 않는다. sqlite gem을 설치할 수 없다.

> RubyMine 기준

## Migrate Sqlite3 to PostgreSQL ##

Rails는 Development, Production, Test의 3가지 환경을 제공하는데, Heroku는 Production 모드로 배포된다. 그래서 _database.yml_ 의 production: 의 adapter만 **postgresql**로 바꾸면 된다고 하는데, 필자는 계속 sqilte 관련 에러가 났기 때문에, 모든 모드의 adapter를 postgresql로 수정하였다.

> 지금 생각해보면 yml 파일 수정 후 git add , commit을 안해서 그런 것 같다.

사용 중인 sqilte3 DB를 PostgreSQL로 이전하는 방법은 다음과 같다.

> PostgreSQL 설치 및 기본 설정은 크게 어렵지 않으므로 생략한다.

- [watabe. Migrating Rails Application Data from sqlite3 to PostgreSQL](http://watabelabs.com/blog/view/migrating-rails-application-data-from-sqlite3-to-postgresql)
- [RailsCast. Migrating to PostgreSQL](http://railscasts.com/episodes/342-migrating-to-postgresql?language=ko&view=asciicast)

요약하면 다음과 같다. 

1. yml 파일에서 adapter 수정
2. rake db:create:all
3. sequel -C sqlite://db/development.sqlite3 postgres://pgusername@localhost/**YourDB**

이렇게 하면 기존의 sqlite3 DB를 postgreSQL로 사용할 수 있다.

### Push Local DB to Heroku ###

이제 Local의 PostgreSQL DB를 Heroku 서버로 보내주어야 한다. 

> heroku pg:push

가 기본적으로 제공되는 명령어이긴 하지만, 필자는 _Invaild Argument_ 에러를 뿜으며 실패했기 때문에 다른 방법을 찾았다.

#### Sequel ####

로컬에서 사용했던 **Sequel**을 Heroku 서버를 대상으로 사용했다.

> sequel -C sqlite://db/development.sqlite3 **{Your Heroku DB URL}**

Heroku App의 DB 주소는 설정 창에서 어렵지 않게 발견할 수 있다.

#### pg_dump ####

**이 방법은 Windows 에서는 작동하지 않는다.** 

 - [chrismccord. A better heroku db:push and db:pull](http://www.chrismccord.com/blog/2013/01/09/better-heroku-db-push-and-db-pull/)

pg:push 내부적으로 사용하는 pg_dump를 사용하는 방법이다. pg\_dump를 사용하면 대상 데이터베이스의 Schema와 Record 전체를 생성하는 sql파일이 만들어진다. 이를 Heroku PostgreSQL Shell에 입력하여 DB를 복사하는 방법이다.

PowerShell에서는 Stdin Redirect인 '<'가 먹히지 않으며, CMD에서는 쿼리가 제대로 작동하지 않는다.

# 후기 #
적은 건 얼마 없지만 어마어마한 삽질 끝에 얻은 결과입니다. 다음부터 Rails 개발할 때는 초장부터 PostgreSQL 쓰겠습니다.



