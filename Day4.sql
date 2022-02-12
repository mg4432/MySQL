# 조건에 맞는 데이터 가져오기
# '10번 이상 구매한 VIP 고객 리스트 뽑기'
# '매출 5천만원 이상의 상품 리스트 뽑기'

/* 
WHERE : 가져올 데이터의 조건을 지정해주는 키워드
WHERE[조건식] : 조건식이 참이 되는 row만 선택
SELECT [컬럼 이름] FROM [테이블 이름] WHERE[조건식] ;
	- 조건식 작성 : 연산자를 이용
*/

SELECT 1 = 1; # True (1)
SELECT 1 != 1; # False (0)
SELECT 100 > 10 ; # True (1)
SELECT 'A' in ('A', 'B', 'C'); # True (1)

USE pokemon ; 

SELECT * 
FROM mypokemon; 

# 피카츄의 number 
SELECT number FROM mypokemon WHERE name = 'pikachu' ; 

# speed가 50보다 큰 포켓몬의 이름 
SELECT name FROM mypokemon WHERE speed > 50 ; 


# 전기 타입이 아닌 포켓몬의 이름 
SELECT name From mypokemon WHERE type != 'electric' ; 

# 속도가 100 이하인 전기 타입 포켓몬의 이름 
SELECT name FROM mypokemon WHERE speed < 100 AND type = 'electric' ; 

# 벌레 타입이거나 노말 타입인 포켓몬의 이름 
SELECT name FROM mypokemon WHERE type = 'bug' OR type = 'normal' ; 

# 속도가 100 이하이고 벌레 타입이 아닌 포켓몬의 이름 
SELECT name FROM mypokemon WHERE speed <= 100 AND NOT(type = 'bug') ; 
SELECT name FROM mypokemon WHERE speed <= 100 AND type != 'bug';

/*
BETWEEN : 특정 범위 내의 데이터를 선택할 때 사용하는 연산자
# 특징 
- [컬럼 이름] BETWEEN A AND B 형식으로 사용 
- 해당 컬럼 값이 A와 B 사이에 포함되는 값을 가진 로우만 선택(A <= 컬럼 값 <= B)
- [컬럼 이름] BETWEEN A AND B 쿼리는 A <= [컬럼 이름] <= B와 동일 
# 문법 
SELECT [컬럼 이름]
FROM [테이블 이름]
WHERE [컬럼 이름] BETWEEN [조건 1] AND [조건 2] ; 
*/ 

# 속도가 50과 100 사이인 포켓몬의 이름 
SELECT name 
FROM mypokemon 
WHERE speed BETWEEN 50 AND 100 ; 

/*
IN : 목록 내 포함되는 데이터를 선택할 때 사용하는 연산자
# 특징 
- [컬럼 이름] IN (A, B, ..., C) 형식으로 사용 
- 해당 컬럼 값이 () 내의 값에 포함되는 값을 가진 로우만 선택
- [컬럼 이름] IN (A, B) 쿼리는 [컬럼 이름] = A OR [컬럼 이름] = B와 동일 
- 목록에 넣을 값이 여러 개일 때, OR 연산자보다 표현 및 이해가 쉽다.

# 문법 
SELECT [컬럼 이름]
FROM [테이블 이름]
WHERE [컬럼 이름] BETWEEN [조건 1] AND [조건 2] ; 
*/ 

# 벌레 타입이거나 노말 타입인 포켓몬의 이름 
SELECT name 
FROM mypokemon 
WHERE type IN ('bug', 'normal') ; 


## 문자열 
/*
LIKE : 특정 문자열이 포함된 데이터를 선택하는 연산자
# 특징 
- [컬럼 이름] LIKE [검색할 문자열] 형식으로 사용 
- 해당 컬럼 값이 [검색할 문자열]을 포함하는 로우만 선택
- [검색할 문자열] 내에 와일드카드를 사용하여 검색 조건을 구체적으로 표현할 수 있다.
	- 와일드카드 % : 0개 이상의 문자(몇 개인지 알 수 없음)
    - 와일드카드 _ : 1개의 문자(한 개만 있음) 
		- _% : 1개 이상

# 문법 
SELECT [컬럼 이름]
FROM [테이블 이름]
WHERE [컬럼 이름] LIKE [검색할 문자열] ; 
*/ 
 
 # 이름이 'chu'로 끝나는 포켓몬의 이름 
 SELECT name 
 FROM mypokemon 
 WHERE name LIKE '%chu' ;
 
 # 이름에 'a'가 포함되는 포켓몬의 이름
 SELECT name 
 FROM mypokemon 
 WHERE name LIKE '%a%' ; 
 
 ## NULL 데이터 다루기 : 존재하지 않는 값 
INSERT INTO mypokemon (name, type) 
VALUES ('kkobugi', '') ; 

SELECT *
FROM mypokemon; 
 
 /*
IS NULL : 데이터가 NULL인지 아닌지 확인하는 연산자

# 특징 
- [컬럼 이름] IS NULL 형식으로 사용 
- 해당 컬럼 값이 NULL인 로우만 선택
- NULL이 아닌 데이터를 검색하고 싶다면 IS NOT NULL을 사용
- [컬럼 이름] = NULL 또는 [컬럼 이름] != NULL 은 사용하지 X

# 문법 
SELECT [컬럼 이름]
FROM [테이블 이름]
WHERE [컬럼 이름] IS NULL ; 
*/ 

# number가 NULL인 포켓몬의 이름 
SELECT name 
FROM mypokemon 
WHERE number IS NULL ;

# type이 NULL이 아닌 포켓몬의 이름
SELECT name 
FROM mypokemon 
WHERE type IS NOT NULL ; 

## PRACTICE 
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
# MISSION 1. 이브이의 타입 
SELECT type 
FROM mypokemon 
WHERE name = 'eevee'; 

# MISSION 2. 캐터피의 공격력과 방어력 
SELECT attack, defense
FROM mypokemon 
WHERE name = 'caterpie';

# MISSION 3. 몸무게가 6kg보다 큰 포켓몬들의 모든 데이터 
SELECT *
FROM mypokemon 
WHERE weight > 6 ; 

# MISSION 4. 키가 0.5m보다 크고 몸무게가 6kg보다 크거나 같은 포켓몬들의 이름 
SELECT name 
FROM mypokemon 
WHERE height > 0.5 AND weight >= 6 ; 

# MISSION 5. 포켓몬 테이블에서 공격력이 50 미만이거나 방어력이 50 미만인 포켓몬들의 이름을 'weak_pokemon'이라는 별명으로 가져오기
SELECT name as 'weak_pokemon'
FROM mypokemon 
WHERE attack < 50 OR defense < 50 ; 

# MISSION 6. 노말 타입이 아닌 포켓몬들의 데이터를 전부 가져오기 
SELECT *
FROM mypokemon 
WHERE type != 'normal' ; 

# MISSION 7. 타입이 (normal, fire, water, grass) 중 하나인 포켓몬의 이름과 타입 
SELECT name, type 
FROM mypokemon 
WHERE type IN ('normal', 'fire', 'water', 'grass') ; 

# MISSION 8. 공격력이 40과 60 사이인 포켓몬들의 이름과 공격력 
SELECT name, attack 
FROM mypokemon 
WHERE attack BETWEEN 40 AND 60 ; 

# MISSION 9. 이름에 'e'가 포함되는 포켓몬들의 이름 
SELECT name 
FROM mypokemon 
WHERE name LIKE '%e%' ; 

# MISSION 10. 이름에 'i'가 포함되고, 속도가 50 이하인 포켓몬 데이터를 전부 가져오기
SELECT * 
FROM mypokemon 
WHERE name LIKE '%' AND speed <= 50 ; 

# MISSION 11. 이름이 'chu'로 끝나는 포켓몬들의 이름, 키, 몸무게
SELECT name, height, weight 
FROM mypokemon 
WHERE name LIKE '%chu' ; 
 
# MISSION 12. 이름이 'e'로 끝나고 방어력이 50 미만인 포켓몬들의 이름, 방어력 
SELECT name, defense 
FROM mypokemon 
WHERE name LIKE '%e' AND defense < 50 ; 

# MISSION 13. 공격력과 방어력의 차이가 10 이상인 포켓몬들의 이름, 공격력, 방어력 
SELECT name, attack, defense 
FROM mypokemon 
WHERE abs(attack - defense) >= 10 ;

# MISSION 14. 능력치의 합이 150 이상인 포켓몬의 이름과 능력치의 합 'total'이라는 별명으로 가져오기 
# 조건 1. 능력치의 합은 공격력, 방어력, 속도의 합 
SELECT name, attack + defense + speed AS total 
FROM mypokemon 
WHERE attack + defense + speed >= 150 ;