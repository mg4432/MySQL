### 여러 테이블 한 번에 다루기 ###

DROP DATABASE IF EXISTS pokemon ; 
CREATE DATABASE pokemon ;
USE pokemon ; 


CREATE TABLE mypokemon (
	number INT, 
    name VARCHAR(20),
    type VARCHAR(20),
    attack INT,
    defense INT); 
    
INSERT INTO mypokemon (number, name, type, attack, defense)
VALUE (10, 'caterpie', 'bug', 30, 35),
	  (25, 'pikachu', 'electric', 55, 40),
      (26, 'raichu', 'electric', 90, 55),
      (133, 'eevee', 'normal', 55, 50),
      (152, 'chikorita', 'grass', 49, 65)
      ;
      
CREATE TABLE friendpokemon (
	number INT, 
    name VARCHAR(20),
    type VARCHAR(20),
    attack INT,
    defense INT); 

INSERT INTO friendpokemon (number, name, type, attack, defense)
VALUE (26, 'raichu', 'electric', 80, 60),
	  (125, 'electabuzz', 'electric', 83, 57),
      (137, 'porygon', 'normal', 60, 70),
      (153, 'bayleef', 'grass', 62, 80),
      (172, 'pichu', 'electric', 40, 15),
      (450, 'leafeon', 'grass', 110, 130)
      ;

## 데이터 더하기
/*
UNION (UNION ALL) : 두 테이블에 모두 있는 값만 합치기
- UNION은 동일한 값은 제외
- UNION ALL은 동일한 값도 포함

# 문법 
SELECT [컬럼 이름] 
FROM [테이블 A 이름] 
UNION
SELECT [컬럼 이름]
FROM [테이블 B 이름] 
*/

SELECT name 
FROM mypokemon 
UNION ALL 
SELECT name 
FROM friendpokemon ; 

SELECT number, name, attack 
FROM mypokemon 
UNION  
SELECT number, name, attack 
FROM friendpokemon 
ORDER BY number ; # ORDER BY는 쿼리 마지막에 작성 가능하고, 쿼리A에서 가져온 컬럼으로만 가능

/* 교집합
SELECT [컬럼 이름]
FROM [테이블 A 이름] AS A 
INNER JOIN [테이블 B 이름] AS B 
ON A.[컬럼 1 이름] = B.[컬럼 2 이름] AND ... AND A.[컬럼 n 이름] = B.[컬럼 n 이름] ; 
*/

SELECT A.name 
FROM mypokemon AS A 
INNER JOIN friendpokemon AS B
ON A.name = B.name ;

SELECT A.name 
FROM mypokemon as A 
INNER JOIN friendpokemon as B 
on A.number = B.number AND A.name = B.name AND A.type = B.type AND A.attack = B.attack AND A.defense = B.defense ; 

/* 차집합
SELECT [컬럼 이름]
FROM [테이블 A 이름] AS A 
INNER JOIN [테이블 B 이름] AS B 
ON A.[컬럼 1 이름] = B.[컬럼 2 이름] AND ... AND A.[컬럼 n 이름] = B.[컬럼 n 이름] 
WHERE B.[컬럼 이름] IS NULL; 
*/

SELECT A.name 
FROM mypokemon AS A 
LEFT JOIN friendpokemon AS B 
ON A.name = B.name 
WHERE B.name IS NULL ; 

SELECT A.name 
FROM mypokemon AS A 
LEFT JOIN friendpokemon AS B 
ON A.number = B.number AND A.name = B.name AND A.type = B.type AND A.attack = B.attack AND A.defense = B.defense
WHERE B.name IS NULL ; 

# Practice 
# MISSION 1. 내 포켓몬과 친구 포켓몬에 어떤 타입들이 있는지 중복을 제외하고 같은 타입은 한 번씩만 표시 
SELECT type
FROM mypokemon 
UNION 
SELECT type 
FROM friendpokemon;

# MISSION 2. 내 포켓몬과 친구 포켓몬 중에 grass 타입 포켓몬들의 포켓몬 번호와 이름을 중복을 포함해서 모두 가져오기 
SELECT * FROM mypokemon ; 
SELECT number, name, "my" AS whose
FROM mypokemon 
WHERE type = 'grass'
UNION ALL 
SELECT number, name, "friend's" AS whose
FROM friendpokemon 
WHERE type = 'grass' ;

## PRACTICE 
# MISSION 1. 나도 가지고 있고, 친구도 가지고 있는 포켓몬의 이름 
SELECT mypokemon.name 
FROM mypokemon INNER JOIN friendpokemon 
ON mypokemon.number = friendpokemon.number ; 

# MISSION 2. 나만 가지고 있고, 친구는 가지고 있지 않은 포켓몬의 이름 
SELECT A.name 
FROM mypokemon AS A 
LEFT JOIN friendpokemon AS B  
ON A.name = B.name
WHERE B.name IS NULL ;  


SELECT * 
FROM mypokemon AS A 
LEFT JOIN friendpokemon AS B  
ON A.name = B.name ;  
