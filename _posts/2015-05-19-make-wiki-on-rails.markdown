---
layout: post
title: Make Wiki on Rails
date: 2015-05-19 22:41:47
tag:
 - wiki
 - ror
 - rails
 - ruby
categories: web-programming
---

# 환경
 - Windows 10 TP x64
 - Ruby 2.1.5
 - Rails 4.1.8
 - Bundler
 - Git
 - Sqlite
	 - Heroku를 이용해서 배포할 생각이라면 처음부터 **PostgreSQL**을 사용하도록 하자.
 - DevKit

Windows와 OS X에서는 [RailsInstaller](http://railsinstaller.org/en)를 통해서 해당 환경을 쉽게 구축할 수 있다.

> 여담으로 레일즈가 필요하지 않아도 RailsInstaller를 통해서 환경을 구축하는 것이 훨씬 편하다.

# Gems
 - Rails 4.1.8
 - sqlite
	 - PostgreSQL의 경우에는 pg
 - sass-rails
 - uglifier
 - coffee-rails
 - jquery-rails
 - turbolinks
 - jbuilder
 - sdoc

> pg를 사용할 경우, database.yml의 설정들도 변경해야 한다.

위의 목록은 Ruby/Rails IDE인 RubyMine으로 Rails Project 생성시 기본으로 넣어주는 gem들이다. DB나 JS, SCSS 등의 기능을 적용하기 위해 필요하다.

 - sorcery
 - paper_trail
 - diffy
 - redcarpet
 - albino
 - nokogiri

위의 gem들은 아래 항목에서 다시 언급하도록 한다.

> Rails는 Gemfile에 사용할 gem을 명시한 후에 **bundle install** 명령을 통해 해당 gem들을 모두 설치할 수 있다.

# Modeling
크게 사용자와 문서로 이루어진다. 하지만 위키의 특성상, 문서가 사용자에게 귀속되지 않기 때문에 문서에 최종 수정자만 기록하고, 별도의 관계는 만들지 않아도 된다.

위키는 문서 제목이 Primary Key가 되지만 Rails에서는 보통 id 를 통해 검색을 하는데, Rails는 각 Attribute 별로 검색할 수 있는 함수를 만들어 주기 때문에 별도로 함수를 만들 필요는 없다.

# User Authentication
지인들을 위한 폐쇄형 위키이기 때문에, 회원이 아니면 로그인/회원가입을 제외한 모든 페이지 및 문서에 접근을 제한해야 했다.

회원 시스템은 **sorcery** 라는 gem을 이용했다.

 - [sorcery GitHub](https://github.com/NoamB/sorcery)
 - [Authentication With Sorcery. RailsCast](http://railscasts.com/episodes/283-authentication-with-sorcery)

RailsCast의 문서에 있는 코드는 아직도 잘 작동하기 때문에, 유용하게 사용할 수 있다.

내가 만드는 위키의 경우에는 email이 아닌 이름(닉네임)을 ID로 사용했기 때문에, Parameter나 다른 부분들의 email을 바꿔주어야 했다.

> 이렇게 할 경우, email 정보가 없으므로 비밀번호 찾기 기능은 사용할 수 없다.

attr_accessible는 Deprecate 되었으므로, 지우면 된다.

# History
위키에서 문서의 수정내역 확인 및 비교 기능은 매우 유용하다. 

## Versioning
수정내역 등을 확인하기 위해서는 문서 모든 버전(혹은 최근 n개 라도)을 가지고 있어야 한다.

해당 기능은 **paper_trail** 이라는 gem을 이용했다.

 - [paper_trail GitHub](https://github.com/airblade/paper_trail)
 - [Samurails. Jutsu #8 – Version your models with PaperTrail (Rails 4)](http://samurails.com/gems/papertrail/)

Samurails의 문서가 매우 친절하기 때문에, 별도의 설명은 하지 않는다.

## Diff
각 버전과의 비교는 **diffy**라는 gem을 이용했다.

 - [diffy GitHub](https://github.com/samg/diffy)

Windows 환경에서는 diff가 기본 제공 명령어가 아니라 별도의 설치가 필요하지만, RailsInstaller에 포함되어 있는 DevKit에서 제공되므로, RailsInstaller를 활용한 경우에는 별 문제없이 진행할 수 있다.

> DevKit의 bin을 %PATH% 환경 변수에 넣어주어야 한다.

사용법은 위의 Samuarails의 문서에 같이 있으므로 생략한다.

# Grammar
HTML 태그를 직접 사용하는 방법도 있으나, 위키의 사용자가 대부분 비전공자인 것과, CSS 요소를 활용하여 문서의 디자인을 뭉갤 수 있는 위험이 있는 관계로 별도의 문법을 제정하게 되었다.

## Markdown
AtoZ까지 전부 다 만드는 것은 아니고 현재 이 블로그에서 사용하고 있는 Markdown이 굉장히 편리해서 위키에 적용시켜 보았다.

사용한 gem은 **redcarpet**이다.

> 특별한 이유는 없고, Jekyll 기본 설정이어서 변경없이 그대로 사용하고 있다.

 - [redcarpet GitHub](https://github.com/vmg/redcarpet)
 - [RailsCast. Markdown with Redcarpet](http://railscasts.com/episodes/272-markdown-with-redcarpet)
 - [RichOnRails. Rendering Markdown with Redcarpet](http://richonrails.com/articles/rendering-markdown-with-redcarpet)
 - [hamcois. Redcarpet for Rails 4.0](http://www.hamcois.com/articles/4)

RailsCast의 문서는 구 버전의 Redcarpet을 이용했으므로, 구조만 참조하도록 한다.

### Customize ###
여러 위키를 돌아다니다 보면 **틀**이 많이 사용되고 있는 것을 볼 수 있는데, 틀은 기본 제공되는 마크다운 문법이 아니기 때문에 redcarpet을 커스텀하여 문법을 추가할 필요가 있었다.

 - [StackOverflow. custom markdown in user input](http://stackoverflow.com/questions/14741197/custom-markdown-in-user-input)

추가할 문법이 2개 이상이어서 gsub를 2번 이상 호출해야할 경우에는, **마지막을 제외한 gsub는 gsub!로 호출하도록 한다.** 

> gsub만 사용할 경우에는 가장 마지막 문법만 적용되며, gsub!만 사용할 경우에는 별도로 추가한 문법이 사용되지 않은 문서에 대해 nil을 반환하기 때문에 nil을 render하게 되어 오류가 발생한다.

# Asset Pipeline #
위키를 구성하는 기능은 아니지만 Rails에서 여러 Assets(JS, CSS, Image, etc...)들을 관리하는 기능이다. 

1. 사전 컴파일(Precompile)
2. 병합(Concatenate)
3. 압축(Minify)

의 과정을 통해 클라이언트가 Asset을 최소한으로 요청하도록 하는 기능이다.

 - [RailsGuides. The Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html)
 - [RORLAB. 초보자를 위한 Asset Pipeline 개념잡기](http://rorlab.org/rblogs/152)

## 설정법 ##
### StyleSheet, JS ###
 - /app/assets/javascript/application.js
 - /app/assets/stylesheets/application.css

에서 각 파일들을 추가하면된다. 확장자는 붙이지 않아도되며, JS는 //=, StyleSheet는 *= 을 앞에 붙이는 것을 명심하자. 반드시 주석문 안에 작성되어야 한다.

각 파일들은 /app/assets 뿐만 아니라 lib나 vendor 의 assets에 있어도 상관없다.

### 기타 ###
폰트와 같은 자원들은 /config/initializers/assets.rb 에서 추가해야한다.

> Rails.application.config.assets.paths << Rails.root.join("fonts")
> Rails.application.config.assets.precompile += %w( *.eot *.woff *.svg *.ttf )

assets의 경로에 "fonts" 를 추가한다. StyleSheet, JS와 같이 app, lib, vendor 중 어디의 assets에 있는 fonts 여도 상관없다.

그리고 해당 확장자를 가진 파일들을 precompile 하도록 설정한다.

> 설정 후에는 rake assets:precompile 을 실행해야 한다.


# Design #

Bootstrap을 사용하여 어렵지 않게 있어보이는 레이아웃을 만들어낼 수 있다.

 - [Bootstrap Korean](http://bootstrapk.com/)

# Deploy Using Heroku #

별도의 포스트에서 설명하도록 한다.
 
 - [Dal4segno's Whatnot. Rails on Heroku](http://dal4segno.github.io/webprogramming/web-programming/2015/05/21/rails-on-heroku.html)


# 후기 #

크게 활용도가 높은 서비스도 아니고, 폐쇄형이라 남들에게 자랑도 하기 힘든 그런 사이트이지만, 배운 기술로 뭔가 뚝딱뚝딱 만들어내니 재밌고 보람찬 시간이었습니다. 이걸 계기로 더 많은 Rails 앱을 만들게 될 것 같네요.

