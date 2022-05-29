# 조건에 조건 더하기 (서브쿼리) 
DROP DATABASE IF EXISTS pokemon ; 
CREATE DATABASE pokemon ;
USE pokemon ; 


CREATE TABLE mypokemon (
	number INT, 
    name VARCHAR(20),
    type VARCHAR(20)); 
    
INSERT INTO mypokemon (number, name, type)
VALUE (10, 'caterpie', 'bug'),
	  (25, 'pikachu', 'electric'),
      (26, 'raichu', 'electric'),
      (133, 'eevee', 'normal'),
      (152, 'chikorita', 'grass')
      ;
      
CREATE TABLE ability (
	number INT, 
    type VARCHAR(20),
    height FLOAT,
    weight FLOAT,
    attack INT,
    defense INT,
    speed INT) ; 

INSERT INTO ability (number, type, height, weight, attack, defense, speed)
VALUE (10, 'bug', 0.3, 2.9, 30, 35, 45),
	  (25, 'electric', 0.4, 6, 55, 40, 90),
	  (26, 'electric', 0.8, 30, 90, 55, 110),
      (133, 'normal', 0.3, 6.5, 55, 50, 55),
      (152, 'grass', 0.9, 6.4, 49, 65, 45)
      ;
      
/*
특징 : 
1. 하나의 쿼리 내 포함된 또 하나의 쿼리를 의미 
2. 서브 쿼리는 반드시 괄호 안에 있어야 함 
3. SELECT, FROM, WHERE, HAVING, ORDER BY절에 사용 가능 
4. INSERT, UPDATE, DELETE문에도 사용 가능 
5. 서브 쿼리에는 ;을 붙이지 않아도 됨 
*/

/* 
SELECT 절의 서브쿼리 
: 스칼라 서브쿼리라고도 하며, SELECT절의 서브쿼리는 반드시 하나의 값으로 결과값이 나와아 함 
*/

# 피카츄의 번호, 영문 이름, 키 가져오기 
SELECT number, name,
(SELECT height FROM ability WHERE number = 25)   AS height 
FROM mypokemon 
WHERE name = 'pikachu' ;

/* 
FROM 절의 서브쿼리 
: 인라인 뷰 서브쿼리라고도 하며, FROM 절의 서브쿼리는 반드시 하나의 테이블로 결과값이 나와아 함 ,
  서브 쿼리로 만든 테이블은 반드시 별명을 가져야 함 
*/

# 키 순위가 3위인 포켓몬의 번호와 키 순위를 가져오기 
SELECT number, height_rank 
FROM (SELECT number, rank() OVER(ORDER BY height DESC) AS height_rank FROM ability) AS A 
WHERE height_rank = 3 ;

SELECT * FROM ability  ; 

/* 
WHERE 절의 서브쿼리 
: 중첩 서브쿼리라고도 하며, WHERE 절의 서브쿼리는 반드시 하나의 컬럼으로 결과값이 나와아 함 (EXISTS 제외)
	- 하나의 컬럼에는 여러 값이 존재할 수 있다.
  연산자와 함께 사용한다.
	- 보통 WHERE [컬럼 이름] [연산자] [서브 쿼리] 형식으로 사용한다.
    
문법 
SELECT [컬럼 이름] 
FROM [테이블 이름]
WHERE [컬럼 이름][연산자] (SELECT [컬럼 이름]
					   FROM [테이블 이름]
                       WHERE [조건식]);
*/

# 키가 평균 키보다 작은 포켓몬의 번호 
SELECT number 
FROM ability 
WHERE height < (SELECT AVG(height) FROM ability ) ; 

# 공격력이 모든 전기 포켓몬의 공격력보다 작은 포켓몬의 번호 
SELECT number 
FROM ability 
WHERE attack < ALL(SELECT attack FROM ability WHERE type = 'electric') ; 

# 방어력이 모든 전기 포켓몬의 공격력보다 하나라도 큰 포켓몬의 번호 
SELECT number 
FROM ability 
WHERE defense > ANY(SELECT attack FROM ability WHERE type = 'electric'); 

# bug 타입의 포켓몬이 있다면 모든 포켓몬의 번호 가져오기 
SELECT number 
FROM ability 
WHERE EXISTS(SELECT * FROM ability where type = 'bug') ; 

## PRACTICE 
# MISSION 1. 내 포켓몬 중에 몸무게가 가장 많이 나가는 포켓몬의 번호 
SELECT number 
FROM (SELECT number, rank() OVER (ORDER BY weight DESC) AS weight_rank FROM ability) AS A 
WHERE weight_rank = 1 ;

SELECT number 
FROM ability 
WHERE weight = (SELECT MAX(weight) FROM ability ) ; 

# MISSION 2. 속도가 모든 전기 포켓몬의 공격력보다 하나라도 작은 포켓몬의 번호
SELECT number 
FROM ability 
WHERE speed < ANY(SELECT attack FROM ability WHERE type = 'electric') ; 
 
# MISSION 3. 공격력이 방어력보다 큰 포켓몬이 있다면 모든 포켓몬의 이름 가져오기 
SELECT name 
FROM mypokemon 
WHERE EXISTS(SELECT * FROM ability WHERE attack > defense) ; 

SELECT * FROM mypokemon ; 
SELECT * FROM ability ; 

## PRACTICE 
# MISSION 1. 이브이의 번호 133을 활용해서 이브이의 영문 이름, 키, 몸무게 가져오기 
SELECT (SELECT name FROM mypokemon WHERE number = 133) AS name, weight, height 
FROM ability 
WHERE number = 133;

# MISSION 2. 속도가 두번째로 빠른 포켓몬의 번호와 속도 
SELECT number, speed
FROM (SELECT number, speed, rank() OVER (ORDER BY speed DESC) AS speed_rank FROM ability) AS A  
WHERE speed_rank = 2;

# MISSION 3. 방어력이 모든 전기 포켓몬의 방어력보다 큰 포켓몬의 이름 가져오기 
SELECT name 
FROM mypokemon 
WHERE number IN (SELECT number FROM ability WHERE defense > ALL(SELECT defense FROM ability WHERE type = 'electric')) ; 
