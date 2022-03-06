### 테이블 합치기 ### 

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
    height FLOAT,
    weight float,
    attack INT,
    defense INT,
    speed INT) ; 

INSERT INTO ability (number, height, weight, attack, defense, speed)
VALUE (10, 0.3, 2.9, 30, 35, 45),
	  (25, 0.4, 6, 55, 40, 90),
      (125, 1.1, 30, 83, 57, 105),
      (133, 0.3, 6.5, 55, 50, 55),
      (137, 0.8, 36.5, 60, 70, 40),
      (152, 0.9, 6.4, 49, 65, 45),
      (153, 1.2, 15.8, 62, 80, 60),
      (172, 0.3, 2, 40, 15, 60),
      (470, 1, 25.5, 110, 130, 95)
      ;
      
SELECT * FROM mypokemon ; 
SELECT * FROM ability ; 


/*
JOIN : 테이블을 합칠 때 사용하는 키워드
*/

/*
INNER JOIN : 두 테이블에 모두 있는 값만 합치기

# 문법 
SELECT [컬럼 이름] 
FROM [테이블 A 이름] 
INNER JOIN [테이블 B 이름]
ON [테이블 A 이름].[컬럼 A 이름] = [테이블 B 이름].[컬럼 B이름]
WHERE 조건식 ; 
*/
# 예시
SELECT *
FROM mypokemon 
INNER JOIN ability 
ON mypokemon.number = ability.number ; 

/*
LEFT(RIGHT) JOIN : 왼쪽(오른쪽) 테이블에 있는 값만 합치기

# 문법 
SELECT [컬럼 이름] 
FROM [테이블 A 이름] 
LEFT(RIGHT) JOIN [테이블 B 이름]
ON [테이블 A 이름].[컬럼 A 이름] = [테이블 B 이름].[컬럼 B이름]
WHERE 조건식 ; 
*/

# 예시
SELECT *
FROM mypokemon 
LEFT JOIN ability 
ON mypokemon.number = ability.number ; 

SELECT *
FROM mypokemon 
RIGHT JOIN ability 
ON mypokemon.number = ability.number ; 

/*
OUTER JOIN : 두 테이블에 있는 모든 값 합치기
# MySQL에는 존재하지 X -> LEFT JOIN, RIGHT JOIN의 UNION을 이용

# 문법 
SELECT [컬럼 이름] 
FROM [테이블 A 이름] 
LEFT JOIN [테이블 B 이름]
ON [테이블 A 이름].[컬럼 A 이름] = [테이블 B 이름].[컬럼 B이름]
UNION
SELECT [컬럼 이름] 
FROM [테이블 A 이름] 
RIGHT JOIN [테이블 B 이름]
ON [테이블 A 이름].[컬럼 A 이름] = [테이블 B 이름].[컬럼 B이름]
*/

# 예시
SELECT * 
FROM mypokemon 
LEFT JOIN ability 
ON mypokemon.number = ability.number
UNION
SELECT * 
FROM mypokemon 
RIGHT JOIN ability 
ON mypokemon.number = ability.number ; 


/*
CROSS JOIN : 두 테이블에 있는 모든 값을 각각 합치기
# nrow(table A) = n1, nrow(tableB) = n2 -> n1xn2

# 문법 
SELECT [컬럼 이름] 
FROM [테이블 A 이름] 
CROSS JOIN [테이블 B 이름]
WHERE 조건식 ;
*/

# 예시
SELECT * 
FROM mypokemon 
CROSS JOIN ability  ; 

/*
SELF JOIN : 같은 테이블에 있는 값 합치기
# nrow(table A) = n1, nrow(tableB) = n2 -> n1xn2

# 문법 
SELECT [컬럼 이름] 
FROM [테이블 A 이름] AS t1 
INNER JOIN [테이블 A 이름] AS t2
ON t1.[컬럼 A 이름] = t2.[컬럼 B 이름]
WHERE 조건식 ;
*/

# 예시
SELECT * 
FROM mypokemon AS t1
INNER JOIN mypokemon AS t2
ON t1.number = t2.number  ; 


## PRACTICE 
# MISSION 1. 포켓몬 테이블과 능력치 테이블을 합쳐서 포켓몬 이름, 공격력, 방어력 한 번에 가져오기 
# 	이 때, 포켓몬 테이블에 있는 모든 포켓몬의 데이터 가져오기(구할 수 없다면 NULL)
SELECT mypokemon.name, attack, defense 
FROM mypokemon 
LEFT JOIN ability 
ON mypokemon.number = ability.number ; 

# MISSION 2. 포켓몬 테이블과 능력치 테이블을 합쳐서 포켓몬 번호와 이름을 한 번에 가져오기 
# 	이 때, 능력치 테이블에 있는 모든 포켓몬의 데이터 가져오기(구할 수 없다면 NULL)
SELECT ability.number, name 
FROM mypokemon
RIGHT JOIN ability 
ON mypokemon.number = ability.number ; 