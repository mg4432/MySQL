/*
# SELECT : 가져올 데이터를 선택하는 키워드(필수 포함)
  ex. SELECT 1+2+3; -> 6출력

# 실제 이름은 변하지 않으며 실제 컬럼 이름을 변경하고 싶을 때는 ALTER TABLE 구문 사용 

SELECT [컬럼 이름]
FROM [데이터베이스 이름].[테이블 이름];
*/



/*
# AS : 컬럼 이름에 부가 설명을 하거나 불필요한 내용을 제거할 때 사용 
  AS [컬럼 별명]
# 실제 이름은 변하지 않으며 실제 컬럼 이름을 변경하고 싶을 때는 ALTER TABLE 구문 사용 

SELECT [컬럼 이름] AS [별명]
FROM [테이블 이름];
*/

/*
# LIMIT : 가져울 데이터의 row 개수를 지정하는 키워드(데이터의 일부만 확인하고 싶을 때 사용)
  LIMIT [row 수]
  쿼리의 가장 마지막에 사용

# ex) SELECT number, name
	  FROM pokemon.mypokemon
      LIMIT 2;
*/

/*
# DISTICNT : 중복된 값 제거하고 unique한 값들만 가져오는 키워드
  DISTICNT [컬럼 이름]
  SELECT 절에 사용 
  
# ex) SELECT DISTICNT type 
	  FROM pokemon.mypokemon;
*/


/* DAY3 실습
# MISSION 1. 포켓몬 테이블에서 포켓몬들의 이름과 키, 몸무게 가져오기
# MISSION 2. 포켓몬 테이블에서 포켓몬들의 이름과 공격력, 방어력, 속도 가져오기 
# MISSION 3. 포켓몬 테이블에서 포켓몬들의 이름과 능력치의 합 가져오기 
	- Condition1. 능력치의 합은 공격력, 방어력, 속도의 합을 의미
    - Condition2. 능력치의 합은 'total'이라는 별명으로 가져오기
    - HINT. 숫자형 데이터 타입 컬럼 간에는 연산이 가능 
*/

# 포켓몬 데이터 입력 
DROP DATABASE IF EXISTS pokemon; # pokemon 데이터베이스 삭제
CREATE DATABASE pokemon ; 
USE pokemon ; 
CREATE TABLE mypokemon(
		number INT, 
        name VARCHAR(20),
        type VARCHAR(20),
        height FLOAT,
        weight FLOAT,
        attack FLOAT,
        defense FLOAT,
        speed FLOAT
        ) ;
INSERT INTO mypokemon (number, name, type, height, weight, attack, defense, speed)
VALUES (10, 'caterpie', 'bug', 0.3, 2.9, 30, 35, 45),
(25, 'pikachu', 'electric', 0.4, 6, 55, 40, 90),
(26, 'raichu', 'electric', 0.8, 30, 90, 55, 110),
(133, 'eevee', 'normal', 0.3, 6.5, 55, 50, 55),
(152, 'chikoirita', 'grass', 0.9, 6.4, 49, 65, 45);

SELECT * 
FROM mypokemon ; 

# MISSION 1. 포켓몬 테이블에서 포켓몬들의 이름과 키, 몸무게 가져오기
SELECT name, height, weight
FROM mypokemon ;

# MISSION 2. 포켓몬 테이블에서 포켓몬들의 이름과 공격력, 방어력, 속도 가져오기 
SELECT name, attack, defense, speed
FROM mypokemon ;

/*
# MISSION 3. 포켓몬 테이블에서 포켓몬들의 이름과 능력치의 합 가져오기 
	- Condition1. 능력치의 합은 공격력, 방어력, 속도의 합을 의미
    - Condition2. 능력치의 합은 'total'이라는 별명으로 가져오기
    - HINT. 숫자형 데이터 타입 컬럼 간에는 연산이 가능 
*/
SELECT name, attack+ defense+speed AS TOTAL
FROM mypokemon;