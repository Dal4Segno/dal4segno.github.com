---
layout: post
title: SQL Injection 방어 방법
date: 2016-10-07 13:29:19
tag: 
 - sql
 - sql-injection 
 - injection 
categories: web-security
excerpt: 개발자가 의도하지 않은 SQL문을 실행하는 SQL Injection 공격을 방어하는 방법에 대하여
---

## Prepared Statement (with Parameterized Query) ##

SQL Statement를 미리 준비해두고, Parameter를 입력받아 Statement에서 사용한다. 
이 방법은 Code와 Data를 분리할 수 있도록 하며, 공격자가 SQL Statement의 목적을 바꿀 수 없도록 한다.

    String custname = request.getParameter("customerName"); 
    String query = "SELECT account_balance FROM user_data WHERE user_name = ? ";  
    PreparedStatement pstmt = connection.prepareStatement( query );
    pstmt.setString( 1, custname); 
    ResultSet results = pstmt.executeQuery( );

> custname에 SQL Injection을 시도해도 해당 입력 전체를 string으로 받아서 처리하기 때문에 Statement의 행동이 변경되지 않는다.

## Stored Procedure ##

SQL Injection에 대한 완벽한 방어 기법은 아니지만, Prepared Statement와 같은 효율을 낼 수 있다.

> Stored Procedure에서 안전하지 않은 동적 SQL 생성을 포함하지 않았을 경우

    String custname = request.getParameter("customerName"); // This should REALLY be validated
    try {
        CallableStatement cs = connection.prepareCall("{call sp_getAccountBalance(?)}");
		cs.setString(1, custname);
		ResultSet results = cs.executeQuery();		
		// … result set handling 
    } catch (SQLException se) {			
    // … logging and error handling
    }

## White LIst ##

특정 값의 Parameter만 허용하는 방법으로, 모든 케이스에서 부차적인 보호 기법으로 사용하는 것이 좋다.

## Escaping Input ##

User로 부터 받는 모든 값들에 대해서 Escape를 진행한다. 

## 참조 ##

 - [AppVigil. SQL Injection In Android Apps](https://www.appvigil.co/blog/2015/01/sql-injection-in-android-apps/)
 - [OWASP. SQL Injection Prevention Cheat Sheet](https://www.owasp.org/index.php/SQL_Injection_Prevention_Cheat_Sheet)
 - [OWASP. Query Parameterization Cheat Sheet](https://www.owasp.org/index.php/Query_Parameterization_Cheat_Sheet)

