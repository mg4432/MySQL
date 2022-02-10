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


# PRACTICE
DROP DATABASE IF EXISTS pokemon ; 
CREATE DATABASE pokemon ;
USE pokemon ; 

CREATE TABLE mypokemon (
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
VALUE (10, 'caterpie', 'bug', 0.3,2.9,30,35,45),
	  (25, 'pikachu', 'electric', 0.4,6,55,40,90),
      (26, 'raichu', 'electric', 0.8,30,90,55,110),
      (133, 'eevee', 'normal', 0.3,6.5,55,50,55),
      (152, 'chikorita', 'grass', 0.9,6.4,49,65,45) ; 
# MISSION 1. 123 x 456 
SELECT 123*456; 

# MISSION 2. 2310 / 30
SELECT 2310 / 30; 

# MISSION 3. '피카츄'라는 문자열을 '포켓몬'이라는 이름의 별명을 가진 컬럼으로 가져오기
SELECT '피카츄' AS '포켓몬' ; 

# MISSION 4. 포켓몬 테이블에서 모든 포켓몬들의 컬럼과 값 전체를 가져오기 
SELECT * FROM mypokemon ; 

# MISSION 5. 포켓몬 테이블에서 모든 포켓몬들의 이름 가져오기 
SELECT name FROM mypokemon ; 

# MISSION 6. 포켓몬 테이블에서 모든 포켓몬들의 이름과 키, 몸무게 가져오기 
SELECT name,height,weight FROM mypokemon ; 

# MISSION 7. 포켓몬 테이블에서 포켓몬들의 키를 중복 제거하고 가져오기 
SELECT DISTINCT height FROM mypokemon ;

# MISSION 8. 포켓몬 테이블에서 모든 포켓몬들의 공격력을 2배 해서 'attack2'라는 별명으로 이름과 함께 가져오기 
SELECT name, attack*2 AS attack2 
FROM mypokemon ; 

# MISSION 9. 포켓몬 테이블에서 모든 포켓몬들의 이름을 '이름'이라는 한글 별명으로 가져오기
SELECT name AS 이름
FROM mypokemon ; 

# MISSION 10. 포켓몬 테이블에서 모든 포켓몬들의 공격력은 '공격력' 이라는 한글 별명으로, 방어력은 '방어력'이라는 한글 별명으로 가져오기 
SELECT attack as 공격력, defense AS 방어력 
FROM mypokemon; 

# MISSION 11. 포켓몬 테이블에서 모든 포켓몬들의 키를 cm단위로 환산하여 'height(cm)'라는 별명으로 가져오기 
SELECT height * 100 AS 'height(cm)' 
FROM mypokemon;

# MISSION 12. 포켓몬 테이블에서 첫 번째 로우에 위치한 포켓몬 데이터만 컬럼 전체 가져오기 
SELECT * 
FROM mypokemon 
LIMIT 1;

# MISSION 13. 포켓몬 테이블에서 2개의 포켓몬 데이터만 이름은 '영문명'이라는 별명으로, 키는 '키(m)'라는 별명으로, 몸무게는 '몸무게(kg)'이라는 별명으로 가져오기 
SELECT name AS 영문명, height AS '키(m)', weight AS '몸무게(kg)'
FROM mypokemon
LIMIT 2; 

/*
# MISSION 14. 포켓몬 테이블에서 포켓몬들의 이름과 능력치의 합 가져오기
	- Condition1. 능력치의 합은 공격력, 방어력, 속도의 합을 의미
    - Condition2. 능력치의 합은 'total'이라는 별명으로 가져오기
    - HINT. 숫자형 데이터 타입 컬럼 간에는 연산이 가능 
*/
SELECT name, attack+defense+speed AS total 
FROM mypokemon ; 

/*
# MISSION 15. 포켓몬들의 이름과, BMI지수 가져오기 BMI지수는 'BMI'라는 별명으로 가져오기 
	- BMI 지수 = 몸무게(kg) / 키(m)^2
*/
SELECT name, weight/height^2 as BMI 
FROM mypokemon ; 

