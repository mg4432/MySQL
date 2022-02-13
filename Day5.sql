### 원하는 데이터 만들기 ### 

# 10번 이상 구매한 VIP 고객, '구매 금액 순으로' 뽑기
# 매출 5000만원 이상의 상품, '판매량 순으로' 뽑기

/*
ORDER BY : 가져온 데이터를 정렬
# 특징 
- ORDER BY [컬럼 이름] 형식으로 사용 
- 입력한 [컬럼 이름]의 값을 기준으로 모든 row를 정렬
- 기본 정렬 규칙은 오름차순
	- ORDER BY [컬럼 이름] = ORDER BY [컬럼 이름] ASC
- 여러 컬럼으로 정렬도 가능하며 컬럼 이름을 여러 개 입력하면 됨 
	- 입력한 순서대로 정렬
# 문법 
SELECT [컬럼 이름]
FROM [테이블 이름]
WHERE 조건식
ORDER BY [컬럼 이름] ASC ; 
*/ 

USE pokemon ; 

SELECT number, name 
FROM mypokemon 
ORDER BY number DESC ;

SELECT number, name, attack, defense 
FROM mypokemon 
ORDER BY attack DESC, defense ; 

SELECT number, name, attack, defense 
FROM mypokemon 
ORDER BY 3 DESC, 4 ;    

## 순위를 정해 원하는 데이터 가져오기

# 10번 이상 구매한 VIP 고객 중  7번째 고객 뽑기
# 매출 5000만원 이상의 상품 중 판매량 하위 10번째 상품 뽑기
/*
RANK : 데이터를 정렬해 순위를 만드는 함수
# 특징 
- RANK() OVER (ORDER BY [컬럼 이름]) 형식으로 사용 
- 항상 ORDER BY와 함께 사용
- SELECT 절에 사용하며 정렬된 순서에 순위를 붙인 새로운 컬럼 보여줌
	- 실제 데이터에는 영향 X 
- 여러 컬럼으로 정렬도 가능하며 컬럼 이름을 여러 개 입력하면 됨 
	- 입력한 순서대로 정렬
# 문법 
SELECT [컬럼 이름], ..., RANK() OVER (ORDER BY [컬럼 이름])
FROM [테이블 이름]
WHERE 조건식;
*/

SELECT name, attack, RANK() OVER (ORDER BY attack DESC) AS attack_rank
FROM mypokemon ; 
 
# 데이터를 정렬해 순위를 만들어주는 함수로 RANK 외에도 DENSE_RANK, ROW_NUMBER이 있음

# DENSE_RANK는 공동 순위가 있어도 순위를 뛰어넘지 않음
SELECT name, attack, DENSE_RANK() OVER (ORDER BY attack DESC) AS attack_rank
FROM mypokemon ; 

# ROW_NUMBER는 공동 순위를 매기지 않음
SELECT name, attack, ROW_NUMBER() OVER (ORDER BY attack DESC) AS attack_rank
FROM mypokemon ; 
 
SELECT name, attack, 
	RANK() OVER (ORDER BY attack DESC) AS rank_rank,
    DENSE_RANK() OVER (ORDER BY attack DESC) AS attack_rank,
    ROW_NUMBER() OVER (ORDER BY attack DESC) AS rank_row_number
FROM mypokemon ; 
 
/*
## 자주 사용하는 함수 예시
- LOCATE('a', 'abc') 
	- 'abc'에서 'a'가 몇 번째에 위치해 있는지 검색해서 위치 반환
- SUBSTRING('abc', 2)
	- 'abc'에서 2번째 문자부터 반환
- RIGHT('abc', 1) [LEFT도 동일]
	- 'abc'에서 오른쪽[왼쪽]에서 1번째 문자까지 반환
- UPPER('abc') [LOWER도 동일]
	- 'abc'를 대문자로 [소문자로]
- LENGTH('abc')
	- 'abc'의 글자 수 반환
- CONCAT('abc','def')
	'abc'문자열과 'def'문자열 합쳐 반환 -> 'abcdef'
- REPLACE('abc','a','z') 
	- 'abc'문자열에서 'a'를 'z'로 바꿔 반환 
*/

/*
## 날짜형 데이터
- NOW 
	- 현재 날짜와 시간 반환
- CURRENT_DATE
	- 현재 날짜 반환
- CURRENT_TIME
	- 현재 시간 반환
*/

SELECT NOW(), CURRENT_DATE(), CURRENT_TIME() ; 

SELECT NOW(), YEAR(NOW()), MONTH(NOW()), MONTHNAME(NOW()) ; 

SELECT NOW(), DAYNAME(NOW()), DAYOFMONTH(NOW()), DAYOFWEEK(NOW()), WEEK(NOW()) ; 

# DATE_FORMAT : 날짜/시간의 형식을 원하는 형식으로 반환
# 	- DATE_FORMAT(날짜/시간, 형식)
SELECT DATE_FORMAT('1996-11-06 17:34:58', '%Y년 %M월 %d일 %H시 %i분 %s초') AS formatted_date; 

## PRACTICE 
DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number INT,
name VARCHAR(20),
type VARCHAR(10),
attack INT,
defense INT,
capture_date DATE
);
INSERT INTO mypokemon (number, name, type, attack, defense, capture_date)
VALUES (10, 'caterpie', 'bug', 30, 35, '2019-10-14'),
(25, 'pikachu', 'electric', 55, 40, '2018-11-04'),
(26, 'raichu', 'electric', 90, 55, '2019-05-28'),
(125, 'electabuzz', 'electric', 83, 57, '2020-12-29'),
(133, 'eevee', 'normal', 55, 50, '2021-10-03'),
(137, 'porygon', 'normal', 60, 70, '2021-01-16'),
(152, 'chikoirita', 'grass', 49, 65, '2020-03-05'),
(153, 'bayleef', 'grass', 62, 80, '2022-01-01');
# MISSION 1. 포켓몬 테이블에서 포켓몬의 이름과 이름의 글자 수를 이름의 글자 수로 정렬해서 가져오기(오름차순)
SELECT name, LENGTH(name) as length
FROM mypokemon 
ORDER BY(LENGTH(name)) ; 

/*
# MISSION 2. 포켓몬 테이블에서 방어력 순위를 보여주는 컬럼을 새로 만들어서 'defense_rank'라는 별명으로 가져오기 + 이름 데이터도 포함
	- 방어력 순위는 방어력이 높은 순서대로 나열한 순위
    - 공동 순위가 있으면 다음 순서로 건너뛰기
*/
SELECT name, RANK() OVER(ORDER BY(defense) DESC) as defense_rank
FROM mypokemon ;

# MISSION 3. 포켓몬 테이블에서 포켓몬을 포획한지 기준 날짜까지 며칠이 지났는지를 'days'라는 별명으로 가져오기 + 이름 데이터도 포함 (기준 날짜 2022-02-14)
SELECT name, DATEDIFF('2022-02-14', capture_date) AS days
FROM mypokemon ;


## PRACTICE 2

# MISSION 1. 포켓몬의 이름을 마지막 3개 문자만 'last_char'이라는 별명으로 가져오기 
SELECT RIGHT(name, 3) AS last_char
FROM mypokemon ;

# MISSION 2. 포켓몬 이름을 왼쪽에서 2개 문자를 'left2'라는 별명으로 가져오기 
SELECT LEFT(name, 2) AS left2 
FROM mypokemon; 

# MISSION 3. 포켓몬 이름에서 'o'가 포함된 포켓몬만 모든 소문자 'o'를 대문자 'O'로 바꿔서 'bigO'라는 별명으로 가져오기
SELECT REPLACE(name, 'o', 'O') as bigO
FROM mypokemon 
WHERE LOCATE('o', name) > 0 ; 

# MISSION 4. 포켓몬 타입을 가장 첫 번째 1글자, 가장 마지막 1글자를 합친 후 대문자로 변환해서 'type_code'라는 별명으로 가져오기 + 이름도 
SELECT name, UPPER(CONCAT(LEFT(type,1), RIGHT(type,1))) AS type_code
FROM mypokemon ;

# MISSION 5. 포켓몬 이름의 글자 수가 8보다 큰 포켓몬의 데이터를 전부 가져오기
SELECT *
FROM mypokemon 
WHERE LENGTH(name) > 8 ; 

# MISSION 6. 모든 포켓몬의 공격력 평균을 정수로 반올림해서 'avg_of_attack'이라는 별명으로 가져오기 
SELECT ROUND(AVG(attack),0) as avg_of_attack
FROM mypokemon ;

# MISSION 7. 모든 포켓몬의 방어력 평균을 정수로 내림해서 'avg_of_defense'라는 별명으로 가져오기 
SELECT TRUNCATE(AVG(defense), 0) as avg_of_defense
FROM mypokemon ;
SELECT * FROM mypokemon ;

# MISSION 8. 이름의 길이가 8미만인 포켓몬의 공격력의 제곱을 'attack2'라는 별명으로 이름과 함께 가져오기 
SELECT name, POWER(attack, 2) AS attack2 
FROM mypokemon
WHERE LENGTH(name) < 8 ; 

# MISSION 9. 모든 포켓몬의 공격력을 2로 나눈 나머지를 'div2'라는 별명으로 이름과 함께 가져오기
SELECT name, MOD(attack, 2) as div2
FROM mypokemon ; 

# MISSION 10. 공격력이 50 이하인 포켓몬의 공격력을 방어력으로 뺀 값의 절댓값을 'diff'라는 별명으로 이름과 함께 가져오기 
SELECT name, ABS(attack - defense) as diff 
FROM mypokemon 
WHERE attack <= 50 ; 

# MISSION 11. 현재 날짜와 시간을 'now_date', 'now_time'이라는 별명으로 가져오기 
SELECT DATE(NOW()) AS now_date, TIME(NOW()) AS now_time;

# MISSION 12. 포켓몬을 포획한 달을 숫자와 영어로 가져오기. 숫자는 'month_num', 영어는 'month_eng'이라는 별명으로 가져오기
SELECT MONTH(capture_date) AS month_num, MONTHNAME(capture_date) AS month_eng
FROM mypokemon ;

# MISSION 13. 포켓몬을 포획한 날의 요일을 숫자와 영어로 가져오기. 숫자는 'day_num', 영어는 'day_eng'이라는 별명으로 가져오기 
SELECT DAYOFWEEK(capture_date) AS month_num, DAYNAME(capture_date) AS month_eng
FROM mypokemon ;

# MISSION 14. 포켓몬을 포획한 날의 연도, 월, 일을 각각 숫자로 가져오기 'year', 'month', 'day'라는 별명으로 가져오기
SELECT YEAR(capture_date) AS year, MONTH(capture_date) AS month, DAY(capture_date) AS day 
FROM mypokemon ;
