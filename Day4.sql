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

  