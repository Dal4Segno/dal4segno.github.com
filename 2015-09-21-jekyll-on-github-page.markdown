---
layout: post
title: Jekyll Blog on Github Page
date: 2015-09-21 01:51:37
tag: jekyll blog github githubpage
categories: web-programming
excerpt: Jekyll 과 Github Page를 이용하여 나만의 블로그를 만들어보자
---

{% include _toc.html %}

## Github Page ##

Github에서는 [**Github Page**](https://pages.github.com/)라는 이름으로 Github Repository를 통해 웹호스팅과 도메인 서비스를 제공한다.
정적인 웹페이지만 호스팅할 수 있으며 가벼운 용도로 사용하기에 적절하다.

## [Jekyll](https://jekyllrb.com/) ##
Markdown과 같은 텍스트 문서를 정적인 웹사이트, 블로그로 변환시켜주는 도구이다.

Ruby로 만들어졌지만 Ruby를 사용하지 않으며, 여러 요소들을 관리하는데에 데이터베이스도 사용하지 않아 매우 간단하다. 또한 카테고리나 페이지, 포스트 등을 지원하여 블로그 친화적이다.

## Jekyll With Github Page ##
Jekyll 을 통해 만들어지는 웹사이트는 정적이기 때문에 Github Page로 이용하기에 적합하다.

### Requirement ###

 - RailsIntaller
	 - Ruby
	 - Gem
	 - Bundle
	 - RubyDevKit
	 - Git
 - Jekyll
	 
> Windows에서는 Ruby, Rails 개발환경을 [**RailsInstaller**](http://railsinstaller.org/)를 통해 쉽게 설치할 수 있으며, Jekyll은 *gem install jeykll* 을 통해 설치할 수 있다. 

### New Jekyll Site ###
Github Page를 생성하는 것은 공식 홈페이지의 [**설명**](https://pages.github.com/)으로 대체한다.

{% highlight text %}
bundle exec jekyll new #{foldername}
cd #{foldername}
bundle exec jekyll serve
{% endhighlight %}

> Bundle을 통해 실행시키지 않을 경우 다른 Gem들과 충돌이 일어나거나 필요한 Gem을 로드하지 않는 상황이 발생할 수 있다.

### Structure ###

Jekyll의 기본적인 구조는 다음과 같다.

{% highlight text %}
.
├── _config.yml
├── _drafts --> 완성되지 않은 포스트 초안을 저장
|   ├── begin-with-the-crazy-ideas.textile
|   └── on-simplicity-in-technology.markdown
├── _includes --> 다른 html 파일 등에 삽입되는 파일들을 저장
|   ├── footer.html
|   └── header.html
├── _layouts --> 포스트에서 사용될 레이아웃들을 저장
|   ├── default.html
|   └── post.html
├── _posts --> 작성한 포스트들을 저장
|   ├── 2007-10-29-why-every-programmer-should-play-nethack.textile
|   └── 2009-04-26-barcamp-boston-4-roundup.textile
├── _data --> 사용되는 각종 데이터들을 저장
|   └── members.yml
├── _site --> Jekyll을 통해 생성되는 정적 사이트가 저장된다
├── .jekyll-metadata
└── index.html
{% endhighlight %}

### Theme & Config ###

HTML과 CSS를 통해서 직접 블로그 디자인을 할 수 있지만, 이미 다른 사람들이 잘 만들어둔 테마를 사용할 수도 있다. 

 - [Made Mistake. Jekyll Themes](https://mademistakes.com/work/jekyll-themes/)
 - [Jekyll Themes.](http://jekyllthemes.org/)

> 일부 부트스트랩 테마 중에서는 Jekyll용을 같이 제공하는 경우도 있다.

Jekyll은 정적인 문서만 사용하기 때문에 테마 압축 파일을 해제하는 것만으로 간단하게 테마를 적용할 수 있다.

하지만 각 테마마다 사용하는 **Gem**이 다를 수 있으며, **디렉토리 구조**가 다른 경우도 있기 때문에 테마를 변경할 때는 **주의해야 한다.**

테마를 적용한 후에는 **\_config.yml** 파일의 이름이나 홈페이지 주소 등을 수정해주어야 한다.

### Post ###

#### Front-Matter ####

Jekyll에서 처리해야 하는 파일은 파일 최상단에 [YAML Front-Matter](http://jekyllrb.com/docs/frontmatter/)가 있어야 한다.

layout과 title은 반드시 있어야 한다.

#### Writing ####

작성하는 모든 포스트들은 **\_posts** 폴더 내에 있어야 한다. 

하지만 반드시 최상위 폴더에 있는 _posts외에 다른 하위 폴더 내에 _posts 폴더를 만들어서 두어도 된다. 이는 포스트들을 카테고리 별로 분류할 때 편리하다.

그리고 포스트 파일의 이름은 반드시 **YYYY-MM-DD-#{slug}.#{format}** 의 형태를 띄어야 한다. 

확장자는 마크다운 확장자(.markdown, .md)면 어떤 것이든 상관없다.

> 예를 들면 *2015-09-21-jekyll-on-github-page.markdown* 과 같은 형태.

> slug란 하이픈 - 과 영어 소문자로만 이루어진 문자열을 의미한다. slug와 포스트 제목과는 다르므로 적당한 문자열을 지정하자

#### Octopress ####

매 포스팅마다 Front-Matter와 이름 형식을 맞추는 것은 매우 귀찮은 일이지만, 다른 Markdown 기반의 블로그 프레임워크인 **Octopress** Gem을 빌려서 이를 해결할 수 있다.

{% highlight text %}
bundle exec octopress new post #{slug}
bundle exec octopress new post #{slug} --dir #{foldername}
{% endhighlight %}

## Outro ##

Jekyll 과 Github Page를 이용한 블로깅은 일반적인 블로그 서비스를 이용하는 것보다는 조금 귀찮을 수도 있지만, 

 - 블로그의 모든 부분을 제어할 수 있고
 - Github을 이용하기 때문에 별도의 백업이 필요 없으며
 - Markdown이 적응되면 생각보다 글쓰기에 편하다

는 장점이 있다.

새 블로그를 만들거나, 이주 계획이 있다면 .github.io라는 매력적인 도메인을 제공해주는 Github Page를 고려해보는 것도 좋을 듯 하다.

## Reference ##

 - [Nolboo's Blog. 지킬로 깃허브에 무료 블로그 만들기](https://nolboo.github.io/blog/2013/10/15/free-blog-with-github-jekyll/)
 - [Minimal Mistake. Theme Setup](https://mmistakes.github.io/minimal-mistakes/theme-setup/)