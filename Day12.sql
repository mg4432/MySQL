USE fastcampus ; 

SELECT * FROM tbl_customer ;  # customer_id, created_at, gender, age
SELECT * FROM tbl_purchase ; # id, customer_id, purchased_at, category, product_id, price
SELECT * FROM tbl_visit ; # id, customer_id, visited_at

# Q1. 2020년 7월의 Ruvenue 
SELECT SUM(price) 
FROM tbl_purchase
WHERE YEAR(purchased_at) = 2020 AND MONTH(purchased_at) = 7;

SELECT SUM(price) 
FROM tbl_purchase
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01' ; 

#######################################################################################################################################################

# Q2. 2020년 7월의 MAU(Monthly Active Users)
SELECT *
FROM tbl_visit 
limit 1 ; 

SELECT COUNT(A.customer_id)
FROM tbl_customer AS A  LEFT JOIN tbl_purchase AS B 
ON A.customer_id = B.customer_id
WHERE price IS NULL ;

SELECT COUNT(DISTINCT customer_id) # DISTINCT를 써야 유저 중복을 피할 수 있음, 사용하지 않으면 유저들의 방문 수의 총합이 됨(한 명이 여러 번 방문한 경우도 포함됨) 
FROM tbl_visit 
WHERE visited_at >= '2020-07-01' AND visited_at < '2020-08-01'
LIMIT 10 ; 
 
SELECT COUNT(customer_id) # DISTINCT를 사용하지 않은 경우
FROM tbl_visit 
WHERE visited_at >= '2020-07-01' AND visited_at < '2020-08-01'
LIMIT 10 ; 

#######################################################################################################################################################

# Q3. 7월에 우리 Active 유저의 구매율(Paying Rate) : 구매유저 수 / 전체 활성 유저
# 구매 유저 
SELECT count(DISTINCT customer_id) 
FROM tbl_purchase
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01'
LIMIT 10 ; 

# 전체 활성 유저 
SELECT COUNT(DISTINCT customer_id)
FROM tbl_visit
WHERE visited_at >= '2020-07-01' AND visited_at < '2020-08-01'
limit 10 ; 

SELECT ROUND(11174/16414*100, 2) AS 'Paying Rate';
#######################################################################################################################################################
# Q4. 7월에 구매 유저의 월 평균 구매금액은?
# ARPPU(Average Revenue Per Paying User)
SELECT * 
FROM tbl_purchase 
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01' AND customer_id = 48412; 

SELECT customer_id, sum(price) AS price
FROM tbl_purchase 
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01' 
GROUP BY customer_id ; 

SELECT AVG(revenue) AS ARRPU 
FROM (SELECT customer_id, sum(price) AS revenue 
FROM tbl_purchase 
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01' 
GROUP BY customer_id) AS A ;  
#######################################################################################################################################################
# Q5. 7월에 가장 많이 구매한 고객 Top3와 Top11~15 고객 뽑기
SELECT customer_id,  SUM(price) AS revenue
FROM tbl_purchase 
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01' 
GROUP BY customer_id 
ORDER BY revenue DESC
LIMIT 3; 

SELECT customer_id,  SUM(price) AS revenue
FROM tbl_purchase 
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01' 
GROUP BY customer_id 
ORDER BY revenue DESC
LIMIT 5 OFFSET 10 ;  # OFFSET n 을 사용하면 첫 번째 n개의 행은 제외 


SELECT customer_id, revenue, rank() OVER (ORDER BY revenue DESC) AS ranking 
FROM (SELECT customer_id,  SUM(price) AS revenue
FROM tbl_purchase 
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01' 
GROUP BY customer_id 
ORDER BY revenue DESC) AS A  ;

#######################################################################################################################################################
# Date Format 함수 
SELECT NOW(); # 현재 날짜 & 시간 
SELECT CURRENT_DATE(); # 현재 날짜(시간 제외)
SELECT EXTRACT(MONTH FROM '2021-01-01'); # 월을 추출
SELECT DAY('2020-01-13'); # 날짜
SELECT EXTRACT(DAY FROM '2020-01-13') ; # 날짜 
SELECT DATE_ADD('2020-01-13', INTERVAL 7 DAY); # 해당 날짜에 날짜를 더함 
SELECT DATE_SUB('2021-01-13', INTERVAL 7 DAY); # 해당 날짜에 날짜를 빼기 
SELECT DATEDIFF('2021-01-13', '2020-12-24'); # 두 날짜의 차이 일수 계산 
SELECT TIMEDIFF('2021-01-25 12:10:00', '2021-01-03 10:10:00'); # 시간의 차이 계산 
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %T'); # 현재 날짜 & 시간 
#######################################################################################################################################################

#######################################################################################################################################################
# Q6. 2020년 7월의 평균 DAU, Active User수가 증가하는 추세인가? 
# DAU : Daily Active User 
SELECT day, COUNT(DISTINCT customer_id)
FROM (SELECT customer_id, visited_at, DAY(visited_at) as day
FROM tbl_visit 
WHERE visited_at >= '2020-07-01' AND visited_at < '2020-08-01') AS A 
GROUP BY day;

SELECT date_format(visited_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at, COUNT(DISTINCT customer_id)  as count
FROM tbl_visit
WHERE visited_at >= '2020-07-01' AND visited_at < '2020-08-01'
GROUP BY DAY(date_at)
ORDER BY count DESC
;
#######################################################################################################################################################
# Q7. 2020년 7월의 평균 WAU
# WAU : Weekly Active User
# 총 5개의 주차가 7월에 존재하는데 처음과 마지막 주는 7일이 다 채워져있지 않을 가능성이 높음
SELECT AVG(count) # 3주간 평균 WAU는 8717.67
FROM (
SELECT date_format(visited_at - INTERVAL 9 HOUR, '%Y-%m-%U') AS date_at, COUNT(DISTINCT customer_id)  as count # %U 이용하면 주차별로 확인 가능 
FROM tbl_visit
WHERE visited_at >= '2020-07-05' AND visited_at < '2020-07-26'
GROUP BY DAY(date_at)
ORDER BY count DESC
) foo
;

# WAU가 증가추세에 있다고 볼 수 있음 
SELECT date_format(visited_at - INTERVAL 9 HOUR, '%Y-%m-%U') AS date_at, COUNT(DISTINCT customer_id)  as count # %U 이용하면 주차별로 확인 가능 
FROM tbl_visit
WHERE visited_at >= '2020-07-05' AND visited_at < '2020-07-26'
GROUP BY DAY(date_at)
ORDER BY count DESC
; 

#######################################################################################################################################################
# Q8-1. 2020년 7월의 Daily Revenue는 증가하는 추세인가? 평균 Daily Revenue도 구하기 
# 평균 Daily Revenue
SELECT AVG(revenue) 
FROM (SELECT date_at, SUM(price) AS revenue  
FROM (SELECT *, date_format(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') as date_at 
FROM tbl_purchase
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01') foo
GROUP BY date_at) foo
;

# Daily Revenue 
SELECT date_at, SUM(price) AS revenue  
FROM (SELECT *, date_format(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') as date_at 
FROM tbl_purchase
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01') foo
GROUP BY date_at
;

#######################################################################################################################################################
# Q9. 2020년 7월의 평균 Weekly Revenue 구하기 
SELECT date_format(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%U') as date_at
		,SUM(price) AS revenue
FROM tbl_purchase 
WHERE purchased_at >= '2020-07-05' AND purchased_at < '2020-07-26'
GROUP BY date_at
;
#######################################################################################################################################################
# Q10. 2020년 7월 요일별 Revenue 구하고, 어느 요일이 가장 높고 어느 요일이 가장 낮은지 구하기 
SELECT date_format(date_at, '%W') AS weekday, AVG(revenue) AS revenue_weekday
FROM (
SELECT date_format(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at, SUM(price) AS revenue 
FROM tbl_purchase 
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01' 
GROUP BY 1
) AS foo 
GROUP BY weekday 
ORDER BY revenue_weekday DESC; 
#############################################################################################################################################
# Q11. 2020년 7월 시간대별 Revenue 구하고, 어느 시간대가 가장 높고 어느 시간대가 가장 낮은지 구하기 
SELECT hour_at, AVG(revenue)
FROM (SELECT date_format(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at
	,  date_format(purchased_at - INTERVAL 9 HOUR, '%H') AS hour_at
    ,  SUM(price) AS revenue
FROM tbl_purchase 
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01' 
GROUP BY date_at, hour_at ) foo
GROUP BY hour_at
ORDER BY 2 DESC
; 
#######################################################################################################################################################
# Q12. 2020년 7월 요일 및 시간대별 Revenue 구하기. 어느 요일 및 시간대가 가장 높고 어느 요일 및 시간대가 가장 낮은지 구하기 
SELECT weekday, hour_at, AVG(revenue) 
FROM (
SELECT date_format(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at
	,  date_format(purchased_at - INTERVAL 9 HOUR, '%H') AS hour_at	
    ,  date_format(purchased_at - INTERVAL 9 HOUR, '%W') AS weekday
    , SUM(price) AS revenue 
FROM tbl_purchase 
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01' 
GROUP BY date_at, hour_at, weekday ) foo 
GROUP BY weekday, hour_at 
ORDER BY 3 DESC
;
#######################################################################################################################################################
# Q13. 전체 유저의 Demographic을 알고싶다. 성, 연령별로 유저 숫자 구하기
SELECT  CASE WHEN LENGTH(gender) < 1 THEN 'Others'
			 ELSE gender end as gender
		, CASE  WHEN age <= 15 THEN '15세 이하'
				WHEN age <= 20 THEN '16-20세'
				WHEN age <= 25 THEN '21-25세'
				WHEN age <= 30 THEN '26-30세'
				WHEN age <= 35 THEN '31-35세'
				WHEN age <= 40 THEN '36-40세'
				WHEN age <= 45 THEN '41-45세'
				WHEN age > 45 THEN '46세 이상'
				WHEN age  THEN '<=15'
                END AS AGE
		, COUNT(*) AS count
FROM tbl_customer
GROUP BY 1, 2 ;

#######################################################################################################################################################
# 어느 세그먼트가 가장 숫자가 많은지?(남녀 제외한 기타 성별은 하나로, 연령은 5세 단위로 적당히 묶어서 내림차순으로 계산)
SELECT  CASE WHEN LENGTH(gender) < 1 THEN 'Others'
			 ELSE gender end as gender
		, CASE  WHEN age <= 15 THEN '15세 이하'
				WHEN age <= 20 THEN '16-20세'
				WHEN age <= 25 THEN '21-25세'
				WHEN age <= 30 THEN '26-30세'
				WHEN age <= 35 THEN '31-35세'
				WHEN age <= 40 THEN '36-40세'
				WHEN age <= 45 THEN '41-45세'
				WHEN age > 45 THEN '46세 이상'
				WHEN age  THEN '<=15'
                END AS AGE
		, COUNT(*) AS count
FROM tbl_customer
GROUP BY 1, 2 
ORDER BY count DESC;

#######################################################################################################################################################
# Q14. Q13 결과의 성, 연령을 성별(연령) 예를 들어 남성(25-29세)로 묶어서 전체 고객에서 얼마나 차지하는지 퍼센트 계산. 내림차순으로 
SELECT  CONCAT(CASE WHEN LENGTH(gender) < 1 THEN '기타'
			WHEN gender = 'Others' THEN '기타'
            WHEN gender = 'M' THEN '남성'
            WHEN gender = 'F' THEN '여성'  END
		,'(', CASE  WHEN age <= 15 THEN '15세 이하'
				WHEN age <= 20 THEN '16-20세'
				WHEN age <= 25 THEN '21-25세'
				WHEN age <= 30 THEN '26-30세'
				WHEN age <= 35 THEN '31-35세'
				WHEN age <= 40 THEN '36-40세'
				WHEN age <= 45 THEN '41-45세'
				WHEN age > 45 THEN '46세 이상'
				WHEN age  THEN '<=15'
                END, ')') AS gender_age
		, ROUND(COUNT(*) / (SELECT COUNT(*) FROM tbl_customer)*100, 2) AS percent
FROM tbl_customer
GROUP BY 1 
ORDER BY percent DESC;

SELECT COUNT(*) FROM tbl_customer;
#######################################################################################################################################################
# Q15. 2020년 7월의 성별에 따른 구매 건수와 총 Revenue 계산(남녀 이외의 성별은 하나로 묶기) 
SELECT CASE WHEN LENGTH(B.gender) < 1 THEN '기타'
			WHEN B.gender = 'Others' THEN '기타'
            WHEN B.gender = 'M' THEN '남성'
            WHEN B.gender = 'F' THEN '여성'  END AS gender,
            COUNT(*),
            SUM(price) AS revenue 
FROM tbl_purchase AS A 
LEFT JOIN tbl_customer AS B 
ON A.customer_id = B.customer_id
WHERE A.purchased_at >= '2020-07-01' AND A.purchased_at < '2020-08-01'
GROUP BY 1 
; 

#######################################################################################################################################################
# Q16. 2020년 7월의 성별/연령대에 따라 구매 건수와 총 Revenue 계산(기타 성별은 하나로) 
SELECT CONCAT(CASE WHEN LENGTH(gender) < 1 THEN '기타'
			WHEN gender = 'Others' THEN '기타'
            WHEN gender = 'M' THEN '남성'
            WHEN gender = 'F' THEN '여성'  END
		,'(', CASE  WHEN age <= 15 THEN '15세 이하'
				WHEN age <= 20 THEN '16-20세'
				WHEN age <= 25 THEN '21-25세'
				WHEN age <= 30 THEN '26-30세'
				WHEN age <= 35 THEN '31-35세'
				WHEN age <= 40 THEN '36-40세'
				WHEN age <= 45 THEN '41-45세'
				WHEN age > 45 THEN '46세 이상'
				WHEN age  THEN '<=15'
                END, ')') AS gender_age,
            COUNT(*),
            SUM(price) AS revenue 
FROM tbl_purchase AS A 
LEFT JOIN tbl_customer AS B 
ON A.customer_id = B.customer_id
WHERE A.purchased_at >= '2020-07-01' AND A.purchased_at < '2020-08-01'
GROUP BY 1 
ORDER BY 3 DESC
; 

#######################################################################################################################################################
# Q17. 2020년 7월 일별 매출과 증감폭, 증감률 계산
WITH tbl_revenue AS (
SELECT date_format(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS d_date
	,  SUM(price) AS revenue
FROM tbl_purchase 
WHERE purchased_at >= '2020-07-01' AND purchased_at <'2020-08-01' 
GROUP BY d_date 
)

SELECT *, LAG(revenue) OVER (ORDER BY d_date ASC),  revenue - LAG(revenue) OVER (ORDER BY d_date ASC) AS diff_revenue 
		, (revenue - LAG(revenue) OVER (ORDER BY d_date ASC))/ LAG(revenue) OVER (ORDER BY d_date ASC) * 100 AS change_revenue 
FROM tbl_revenue ; 

#######################################################################################################################################################
# Q18. 2020년 7월 일별로 많이 구매한 고객들에게 소정의 선물을 주려고 한다. 일별로 구매 금액 기준 가장 많이 지출한 고객 Top3 
WITH daily_top3 AS (SELECT  date_format(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at , 
		customer_id, SUM(price) AS revenue,
		DENSE_RANK() OVER (PARTITION BY date_format(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') ORDER BY SUM(price) DESC) AS ranking
FROM tbl_purchase
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01' 
GROUP BY date_at, customer_id )
 
SELECT date_at, customer_id
FROM daily_top3
WHERE ranking <= 3 ;
#######################################################################################################################################################
# Q19. 2020년 7월 우리 신규 유저가 하루 안에 결제로 넘어가는 비율이 어떻게 되는가? 또한 결제까지 보통 몇 분 정도가 소요되는가?
WITH rt_tbl AS (SELECT A.customer_id,
		A.created_at, 
        B.customer_id AS paying_user, 
        B.purchased_at,
        TIME_TO_SEC(TIMEDIFF(B.purchased_at, A.created_at)) / 3600 AS diff_hour
FROM tbl_customer AS A 
LEFT JOIN (
SELECT customer_id, MIN(purchased_at) AS purchased_at 
FROM tbl_purchase
GROUP BY customer_id ) AS B 
ON A.customer_id = B.customer_id  
AND B.purchased_at < A.created_at + INTERVAL 1 DAY

WHERE A.created_at >= '2020-07-01' AND A.created_at < '2020-08-01' 
)

SELECT ROUND(COUNT(paying_user)/COUNT(customer_id)*100,2)  
FROM rt_tbl
UNION ALL 
SELECT AVG(diff_hour)
FROM rt_tbl 
;

#######################################################################################################################################################
# Q20. 2020년 7월 우리 서비스는 유저의 재방문율이 높은 서비스인가? 이를 파악하기 위해 7월 기준 Day1 Retention이 어떤지 구해보고 주세를 보기 위해 Daily로 추출 
SELECT date_format(A.visited_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS d_date
	,  COUNT(DISTINCT A.customer_id) AS active_user
    ,  COUNT(DISTINCT B.customer_id) AS retained_user
    ,  COUNT(DISTINCT B.customer_id) / COUNT(DISTINCT A.customer_id) AS retention
FROM tbl_visit AS A
LEFT JOIN tbl_visit AS B 
ON A.customer_id = B.customer_id 
AND date_format(A.visited_at - INTERVAL 9 HOUR, '%Y-%m-%d') = date_format(B.visited_at - INTERVAL 9 HOUR - INTERVAL 1 DAY, '%Y-%m-%d')  # A : 당일, B : 다음날로 이용
WHERE A.visited_at >= '2020-07-01' AND A.visited_at < '2020-08-01' 
GROUP BY 1 ; 

#######################################################################################################################################################
# Q21. 우리 서비스는 신규 유저가 많은가? 기존 유저가 많은가? 가입 기간별로 고객 분포는 어떤가(DAU 기준)
# tbl_visit에서 일자별로 고객의 last visit 구하고 created_at을 구해서 두 날짜의 차이를 구하면 service age가 된다 
WITH tbl_visit_by_joined AS (
SELECT date_format(A.visited_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS d_date
	,  A.customer_id 
    ,  B.created_at
    ,  MAX(A.visited_at) AS last_visit 
    ,  DATEDIFF(MAX(A.visited_at), B.created_at) AS date_diff 
FROM tbl_visit A
LEFT JOIN tbl_customer AS B 
ON A.customer_id = B.customer_id 

WHERE A.visited_at >= '2020-07-01' AND A.visited_at < '2020-08-01'
GROUP BY 1, 2, 3
)

SELECT A.d_date, 
       CASE WHEN A.date_diff >= 730 THEN '2년 이상'
			WHEN A.date_diff >= 365 THEN '1년 이상'
			WHEN A.date_diff >= 180 THEN '6개월 이상'
			WHEN A.date_diff >= 90 THEN '3개월 이상'
			WHEN A.date_diff >= 30 THEN '1개월 이상'
			ELSE '1개월 미만' END AS segment
    , B.all_users # 전체 user
    , COUNT(A.customer_id) AS users # 일자별, segment별 user
    , ROUND(COUNT(A.customer_id) / B.all_users * 100, 2) AS percent

FROM tbl_visit_by_joined AS A   
LEFT JOIN (SELECT d_date,
				 COUNT(customer_id) AS all_users 
		   FROM tbl_visit_by_joined
           GROUP BY 1) AS B 
ON A.d_date = B.d_date

GROUP BY 1, 2, 3
ORDER BY 1, 2
; 

#######################################################################################################################################################
