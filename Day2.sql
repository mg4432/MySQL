/*
# CREATE TABLE : 테이블 만들기 
# CREATE TABLE [테이블 이름] (
		[컬럼 이름] [데이터 타입],
		[컬럼 이름] [데이터 타입],
		...
		) ;
*/

/*
# ALTER TABLE : 테이블 변경
# ALTER TABLE [테이블 이름] RENAME [새로운 테이블 이름] ;  테이블 이름 변경
# ex. ALTER TABLE costomer RENAME customers ; 

# ALTER TABLE [테이블 이름] ADD COLUMN [컬럼 이름] [데이터 타입] ;  새로운 컬럼 추가
# ex. ALTER TABLE customers ADD COLUMN age INT; 

# ALTER TABLE [테이블 이름] MODIFY [컬럼 이름] [새로운 데이터 타입] ;  컬럼 타입 변경
# ex. ALTER TABLE customers ADD COLUMN age FLOAT; 

## 컬럼 이름과 데이터 타입 모두 바꾸는 경우는 컬럼 전체를 바꾸는 것이기 때문에 CHANGE COLUMN
# ALTER TABLE [테이블 이름] 
  CHANGE COLUMN [컬럼 이름] [새로운 컬럼 이름] [새로운 데이터 타입] ;  컬럼 이름과 타입 변경
# ex. ALTER TABLE customers 
	  CHANGE COLUMN age new_age FLOAT;  컬럼 이름과 타입 변경
      
# ALTER TABLE [테이블 이름] DROP COLUMN [컬럼 이름] ;  컬럼 삭제
# ex. ALTER TABLE customers DROP COLUMN new_age ;
*/

/*
# TRUNCATE TABLE [테이블 이름] : 해당 테이블의 값 삭제(테이블 자체는 남아있음)
*/

/*
# DROP DATABASE [데이터 베이스 이름] : 데이터베이스 삭제
# DROP DATABASE IF EXISTS [데이터 베이스 이름] : 데이터베이스 삭제 (존재한다면)
# DROP TABLE IF EXISTS [데이터 베이스 이름] : 데이터베이스 삭제 (존재한다면)
*/

/*
# INSERT INTO [테이블 이름] ([컬럼1 이름], [컬럼2 이름], ...)
  VALUES([컬럼1 값], [컬럼2 값], ...) : 데이터 삽입하기
# ex. INSERT INTO idol (name, age, group)
	  VALUES ('제니', 27, '블랙핑크') ;

# DELETE FROM [테이블 이름]	
  WHERE [조건 값] : 데이터 삭제하기

# UPDATE [테이블 이름]
  SET [컬럼 이름] = [새 값]
  WHERE [조건 값] ; : 데이터 수정하기
*/


/*
# DROP DATABASE [데이터 베이스 이름] : 데이터베이스 삭제
# DROP DATABASE IF EXISTS [데이터 베이스 이름] : 데이터베이스 삭제 (존재한다면)
# DROP TABLE IF EXISTS [데이터 베이스 이름] : 데이터베이스 삭제 (존재한다면)
*/


# PRACTICE 1
/* MISSION 1
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

/* MISSION 2
MISSION 1에서 만든 포켓몬 데이터베이스에 '나의 새로운 포켓몬(mynewpokemon) 테이블을 만들고 포니타, 메타몽, 뮤의 포켓몬 번호, 이름, 타입 데이터 삽입
STEP 1. 포켓몬 데이터베이스 안에 새로운 포켓몬 테이블 생성(mynewpokemon)
		컬럼은 (1) 포켓몬 번호, (2) 포켓몬 영문 이름, (3) 포켓몬 타입 3가지 (number : INT, name : VARCHAR(20), type : VARCHAR(10))
	
STEP 2. mynewpokemon 테이블 안에 포켓몬 데이터를 각각의 로우로 삽입
STEP 3. 포켓몬 번호 영문이름    타입
		캐퍼티 10  caterpie  bug
        피카츄 25  pikachu   electric
        이브이 133 eevee     normal
*/

# STEP 1 
USE pokemon ;

CREATE TABLE mynewpokemon (
	number INT,
    name VARCHAR(20),
    type VARCHAR(10)
    ) ;
    
# STEP 2 
INSERT INTO mynewpokemon (number, name, type)
VALUES (77, '포니타', '불꽃'),
	   (132, '메타몽', '노말'),
       (151, '뮤', '에스퍼') ;
SELECT *
FROM mynewpokemon;

# PRACTICE 2
/* MISSION 1 
포켓몬 데이터베이스 안에 있는 mypokemon테이블과 mynewpokemon 테이블 변경 

STEP 1. mypokemon 테이블의 이름을 myoldpokemon으로 변경
STEP 2. myoldpokemon 테이블의 'name'컬럼의 이름을 'eng_nm'으로 변경 (VARCHAR(20))
STEP 3. mynewpokemon 테이블의 'name'컬럼의 이름을 'kor_nm'으로 변경 (VARCHAR(20))
*/

# STEP 1. mypokemon 테이블의 이름을 myoldpokemon으로 변경
ALTER TABLE mypokemon
RENAME myoldpokemon ; 

# STEP 2. myoldpokemon 테이블의 'name'컬럼의 이름을 'eng_nm'으로 변경 (VARCHAR(20))
ALTER TABLE myoldpokemon
CHANGE COLUMN name eng_nm VARCHAR(20) ; 

# STEP 3. mynewpokemon 테이블의 'name'컬럼의 이름을 'kor_nm'으로 변경 (VARCHAR(20))
ALTER TABLE mynewpokemon
CHANGE COLUMN name kor_nm VARCHAR(20) ; 

/* MISSION 2
포켓몬 데이터베이스 안에 있는 myoldpokemon 테이블은 값만 지우고 mynewpokemon 테이블은 전부 삭제
*/

TRUNCATE TABLE myoldpokemon ; 
DROP TABLE mynewpokemon;

