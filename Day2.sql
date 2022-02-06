# MISSION : 포켓몬 데이터베이스와 나의 포켓몬 테이블을 만들고, 캐터피, 피카츄, 이브이의 포켓몬 번호, 영문 이름, 타입 데이터 삽임 

/*
STEP 1. 포켓몬 데이터베이스 생성(이름 : pokemon)
STEP 2. 포켓몬 데이터베이스 안에 나의 포켓몬 테이블 생성(테이블 이름 : mypokemon)
	    이 때, Column은 (1) 포켓몬 번호, (2) 포켓몬 영문 이름, (3) 포켓몬 타입 총 3가지로 하고 이름과 데이터 타입 지정 
		컬럼 이름 및 데이터 타입 : (1) number : INT, (2) name : VARCHAR(20), (3) type : VARCHAR(10)
STEP 3. 포켓몬 번호 영문이름    타입
		캐퍼티 10  caterpie  bug
        피카츄 25  pikachu   electric
        이브이 133 eevee     normal
*/

CREATE DATABASE pokemon ; 

SHOW DATABASES ; 

USE pokemon ; 

CREATE TABLE mypokemon(
	number INT,
    name VARCHAR(20),
    type VARCHAR(10)
    );
    
INSERT INTO mypokemon (number, name, type)
VALUES (10, 'caterpie', 'bug'),
	   (25, 'pikachu', 'electric'),
       (133, 'eevee', 'normal') ;
       
SELECT *
FROM mypokemon;
