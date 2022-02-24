### 규칙 만들기 ### 

# 구매 금액 10억 이상 고객은 VVIP, 1억 이상 고객은 VIP로
# 상품 매출이 1억 이상이면 O, 미만이면 xa

/*
IF : IF(조건식, 참일 때 값, 거짓일 때 값)
*/

DROP DATABASE IF EXISTS pokemon ; 
CREATE DATABASE pokemon ;
USE pokemon ; 

CREATE TABLE mypokemon (
	number INT, 
    name VARCHAR(20),
    type VARCHAR(20),
    attack FLOAT,
    defense FLOAT
    ); 
    
INSERT INTO mypokemon (number, name, type, attack, defense)
VALUE (10, 'caterpie', 'bug', 30, 35),
	  (25, 'pikachu', 'electric', 55, 40),
      (26, 'raichu', 'electric', 90, 55),
      (125, 'electabuzz', 'electric', 83, 57),
      (133, 'eevee', 'normal', 55, 50),
      (137, 'porygon', 'normal', 60, 70),
      (152, 'chikorita', 'grass', 49, 65),
      (153, 'bayleef', 'grass', 62, 80),
      (172, 'pichu', 'electric', 40, 15),
      (470, 'leafeon', 'grass', 110, 130) 
      ;
      
SELECT * FROM mypokemon ; 

SELECT name, IF(attack >= 60, 'strong', 'weak') AS attack_class 
FROM mypokemon ; 

/*
IFNULL : IF(조건식, 참일 때 값, 거짓일 때 값)

# 특징
	- IFNULL([컬럼 이름], NULL일 때 값) 형식으로 사용 
    - 해당 컬럼의 값이 NULL인 로우에서 NULL일 때 값을 반환 
    - 주로 SELECT 절에 사용하는 함ㅅ로 결과 값을 새로운 컬럼으로 반환 
*/

SELECT name, IFNULL(name, 'unknown') AS full_name # NULL값이 없기 때문에 그대로 반환 
FROM mypokemon ; 

### 여러 조건 한 번에 만들기(CASE)

/*
# 형식 1
CASE 
	WHEN 조건식1 THEN 결과1
    WHEN 조건식2 THEN 결과2
    ELSE 결과값3
END

# 형식 2
CASE [컬럼 이름]
	WHEN 조건식1 THEN 결과1
    WHEN 조건식2 THEN 결과2
    ELSE 결과값3
END

# 특징
	- IFNULL([컬럼 이름], NULL일 때 값) 형식으로 사용 
    - 해당 컬럼의 값이 NULL인 로우에서 NULL일 때 값을 반환 
    - 주로 SELECT 절에 사용하는 함ㅅ로 결과 값을 새로운 컬럼으로 반환 
*/

SELECT * FROM mypokemon ; 

SELECT name, 
CASE 
	WHEN attack >= 100 THEN 'very strong'
    WHEN attack >= 60 THEN 'strong'
    ELSE 'weak'
END AS attack_class 
FROM mypokemon ; 

SELECT name, type,
CASE type 
	WHEN 'bug' THEN 'grass' 
    WHEN 'electric' THEN 'water'
    WHEN 'grass' THEN 'bug'
END AS rival_type FROM mypokemon ; 

/*
### 함수 만들기
# 문법 
CREATE FUNCTION [함수 이름] ([입력 값] [데이터 타입], ...)
	RETURNS [결과값 데이터 타입]
BEGIN 
	DECLARE [임시값 이름] [데이터 타입];
    SET [임시값 이름] = [입력값 이름] ; 
    쿼리 ; 
    RETURN 결과값
END 
*/

/*
# 공격력과 방어력의 합을 가져오는 함수
CREATE FUNCTION getAbility(attack INT, defense INT)
	RETURNS INT 
BEGIN 
	DECLARE a INT ; 
    DECLARE b INT ;
    DECLARE ability INT ;
    SET a = attack ; 
    SET b = defense ; 
    SELECT a + b INTO ability ; 
    RETURN ability ;
END
*/

/*
# 사용자 계정에 function create 권한 생성 해줘야함 
SET GLOBAL log_bin_trust_function_creators = 1 ; 
DELIMITER // # 함수의 시작 지정 

[함수]

// DELIMITER; # 함수의 끝 지정 
*/ 

/*
# MISSION 
공격력과 방어력의 합이 120보다 크면 'very strong', 90보다 크면 'strong', 모두 해당되지 않으면 'not strong'을 반환하는 함수 'isStrong'을 만들고 사용 
	- 조건1. attack과 defense를 입력값으로 사용 
    - 조건2. 결과값 데이터 타입은 VARCHAR(20)

쿼리
SELECT name, isStrong(attack, defense) AS isStrong
FROM mypokemon ; 
*/ 


SET GLOBAL log_bin_trust_function_creators = 1; 

DELIMITER // 

CREATE FUNCTION `isStrong`(attack INT, defense INT)
	RETURNS VARCHAR(20)
BEGIN 
	DECLARE a INT ; 
    DECLARE b INT ;
    DECLARE isStrong VARCHAR(20) ;
    SET a = attack ; 
    SET b = defense ; 
    SELECT CASE 
		WHEN a+b > 120 THEN 'very strong'
        WHEN a+b > 90 THEN 'strong'
        ELSE 'not strong'
		END INTO isStrong;
    RETURN isStrong ;
END; 

// DELIMITER ; # 함수의 끝 지정 

SELECT name, isStrong(attack, defense) AS isStrong
FROM mypokemon ; 