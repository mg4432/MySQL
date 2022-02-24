### 데이터 그룹화 하기 ### 

# 고객 등급 별 매출 통계 
# 상품 카테고리 별 실적 통계

/*
GROUP BY : 컬럼에서 동일한 값을 가지는 로우를 그룹화하는 키워드
# 특징 
- GROUP BY [컬럼 이름] 형식으로 사용 
- 주로 그룹 별 데이터를 집계할 때 사용하며 엑셀의 피벗 기능과 유사
- GROUP BY가 쓰인 쿼리의 SELECT 절에는 GROUP BY 대상 컬럼과 그룹 함수만 사용 가능 
	- 만약 GROUP BY 대상 컬럼이 아닌 컬럼을 SELECT하면 에러 발생
- 여러 컬럼으로 그룹화도 가능하며 키워드 뒤에 [컬럼 이름]을 복수 개 입력하면 됨 
- 컬럼 번호로도 그룹화가 가능한데, 이 때 컬럼 번호는 SELECT 절의 컬럼 이름 순서를 의미
# 문법 
SELECT [컬럼 이름], ..., RANK() OVER (ORDER BY [컬럼 이름])
FROM [테이블 이름]
WHERE 조건식;
*/

USE pokemon ; 
SELECT * FROM mypokemon ; 

SELECT type 
FROM mypokemon 
GROUP BY type ; 


/*
HAVING : 가져올 데이터 그룹에 조건을 지정해주는 키워드
# 특징 
- HAVING 조건식 형식으로 사용
- 조건식이 참이 되는 그룹만 선택
- HAVING절의 조건식에서는 그룹 함수를 활용

# 문법 
SELECT [컬럼 이름], ..., [그룹 함수]
FROM [테이블 이름]
WHERE 조건식
GROUP BY [컬럼 이름]
HAVING [조건식] ; 
*/

SELECT type 
FROM mypokemon 
GROUP BY type ;       

/*
COUNT : 그룹의 값 수를 세는 함수
# 특징 
- COUNT([컬럼 이름]) 형식으로 SELECT, HAVING 절에서 사용
	- 집계할 컬럼 이름은 그룹의 기준이 되는 컬럼 이름과 같아도 되고, 같지 않아도 됨
	- COUNT(1)은 하나의 값을 1로 세어주는 표현으로 COUNT 함수에 자주 사용
- GROUP BY가 없는 쿼리에서도 사용 가능하며 이 때는 전체 로우에 함수가 적용

# 문법 
SELECT [컬럼 이름], ..., COUNT ([컬럼 이름])
FROM [테이블 이름]
GROUP BY [컬럼 이름]
HAVING [조건문] ; 
*/

/*
SUM : 그룹의 합을 계산하는 함수
# 특징 
- SUM([컬럼 이름]) 형식으로 SELECT, HAVING 절에서 사용
	- 집계할 컬럼 이름은 그룹의 기준이 되는 컬럼 이름과 같아도 되고, 같지 않아도 됨
- GROUP BY가 없는 쿼리에서도 사용 가능하며 이 때는 전체 로우에 함수가 적용

# 문법 
SELECT [컬럼 이름], ..., SUM ([컬럼 이름])
FROM [테이블 이름]
GROUP BY [컬럼 이름]
HAVING [조건문] ; 
*/

# AVG, MIN, MAX도 동일

DROP DATABASE IF EXISTS pokemon ; 
CREATE DATABASE pokemon ;
USE pokemon ; 

CREATE TABLE mypokemon (
	number INT, 
    name VARCHAR(20),
    type VARCHAR(20),
    height FLOAT,
    weight FLOAT
    ); 
    
INSERT INTO mypokemon (number, name, type, height, weight)
VALUE (10, 'caterpie', 'bug', 0.3, 2.9),
	  (25, 'pikachu', 'electric', 0.4, 6),
      (26, 'raichu', 'electric', 0.8, 30),
      (125, 'electabuzz', 'electric', 1.1, 30),
      (133, 'eevee', 'normal', 0.3,6.5),
      (137, 'porygon', 'normal', 0.8, 36.5),
      (152, 'chikorita', 'grass', 0.9,6.4),
      (153, 'bayleef', 'grass', 1.2, 15.8),
      (172, 'pichu', 'electric', 0.3, 2),
      (470, 'leafeon', 'grass', 1, 25.5) 
      ;
      
SELECT type, COUNT(*), COUNT(1), AVG(height), MAX(weight)
FROM mypokemon 
GROUP BY type ; 

SELECT type, COUNT(*), COUNT(1), AVG(height), MAX(weight)
FROM mypokemon 
GROUP BY type 
HAVING COUNT(1) = 2; 



SELECT type, COUNT(1), MAX(weight)
FROM mypokemon 
WHERE name LIKE '%a%'
GROUP BY type
HAVING MAX(height) > 1  
ORDER BY 3 ; 


## PRACTICE 
# MISSION 1. 포켓몬 테이블에서 name의 길이가 5보다 큰 포켓몬들을 type을 기준으로 그룹화하고, weight의 평균이 20이상인 그룹의 type과, weight의 평균 가져오기
#  			 이 때, 결과는 weight의 평균을 내림차순으로 정렬
SELECT name, type, AVG(weight)
FROM mypokemon 
WHERE LENGTH(name) > 5 
GROUP BY type 
HAVING AVG(weight) >= 20 
ORDER BY AVG(weight) DESC;

# MISSION 2. 포켓몬 테이블에서 number가 200보다 작은 포켓몬들을 type을 기준으로 그룹화 한 후에, weight의 최댓값이 10보다 크거나 같고 최솟값은 2보다 크거나 같은 그룹의 type, min, max 가져오기
# 			 이 때, 결과는 키의 최솟값의 내림차순으로 정렬, 키의 최솟값이 같다면 키의 최댓값의 내림차순

SELECT number, type, MIN(height), MAX(height)
FROM mypokemon 
WHERE number < 200
GROUP BY type 
HAVING MIN(weight) >= 2 AND MAX(weight) >= 10 
ORDER BY MIN(height) DESC, MAX(height) DESC ; 

