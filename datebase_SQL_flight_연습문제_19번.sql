-- 1)도착지가 제주인 항공편에 대한 정보를 보이시오
SELECT *
FROM Flight
WHERE dest = '제주';
-- 2)출발지가 김포(src)이고 도착지가 제주(dest)인 항공편에 대한 정보를 보이시오
SELECT *
FROM Flight
WHERE src = '김포'
AND dest = '제주';
-- 3)고객번호가 100번인 승객이 2025년1월 1일 이후에 탑승한 비행기 번호(fid)를 보이시오
SELECT DISTINCT b.fid
FROM Booking b
WHERE b.pid = 100
AND b.fdate > TO_DATE('2025-01-01', 'YYYY-MM-DD');
-- 4)예약을 한 적이 있는 고객의 이름(pname)을 보이시오


-- 검증 쿼리
-- 1) 항공편 100번인 승객이 2025년 1월 1일 이후 탑승한 데이터
SELECT p.pid, p.pname, f.fid, f.src, f.dest, b.fdate
FROM Passenger p
JOIN Booking b ON p.pid = b.pid
JOIN Flight f ON b.fid = f.fid
WHERE f.fid = 100
AND b.fdate > TO_DATE('2025-01-01', 'YYYY-MM-DD');
-- 2) 승객 100번이 2025년 1월 1일 이후 탑승한 데이터
SELECT p.pid, p.pname, f.fid, f.src, f.dest, b.fdate
FROM Passenger p
JOIN Booking b ON p.pid = b.pid
JOIN Flight f ON b.fid = f.fid
WHERE p.pid = 100
AND b.fdate > TO_DATE('2025-01-01', 'YYYY-MM-DD');


-- 1)도착지가 제주인 항공편에 대한 정보를 보이시오
SELECT *
FROM Flight
WHERE dest = '제주';

-- 2)출발지가 김포(src)이고 도착지가 제주(dest)인 항공편에 대한 정보를 보이시오
SELECT *
FROM Flight
WHERE src = '김포'
AND dest = '제주';

-- 3)고객번호가 100번인 승객이 2025년1월 1일 이후에 탑승한 비행기 번호(fid)를 보이시오
SELECT DISTINCT b.fid
FROM Booking b
WHERE b.pid = 100
AND b.fdate > TO_DATE('2025-01-01', 'YYYY-MM-DD');

-- 4)예약을 한 적이 있는 고객의 이름(pname)을 보이시오
SELECT DISTINCT p.pname
FROM Passenger p
WHERE EXISTS (
SELECT 1
FROM Booking b
WHERE b.pid = p.pid );

-- 5)예약을 한 적이 없는 고객의 이름(pname)을 보이시오
SELECT DISTINCT p.pname
FROM Passenger p
WHERE NOT EXISTS (
SELECT 1
FROM Booking b
WHERE b.pid = p.pid );

-- 6)고객번호가 100번인 승객이 거주하는 도시(pcity)와 같은 도시에 위치한 여행사(aname)의 이름을 보이시오
SELECT a.aname
FROM Agency a
WHERE a.acity = (
SELECT p.pcity
FROM Passenger p
WHERE p.pid = 100 );

-- 7)2025년 1월 1일부터 1월 30일 사이에 출발시각이 16:00이후인 항공편 정보를 보이시오
SELECT *
FROM Flight
WHERE fdate BETWEEN TO_DATE('2025-01-01', 'YYYY-MM-DD')
AND TO_DATE('2025-01-30', 'YYYY-MM-DD')
AND time >= '16:00';

-- 8)고객번호가 100번인 승객이 한 번도 예약하지 않은 여행사의 이름(aname)을 보이시오
SELECT a.aname
FROM Agency a
WHERE NOT EXISTS (
SELECT 1
FROM Booking b
WHERE b.aid = a.aid
AND b.pid = 100 );

-- 9)마당여행사(aname)를 통해 예약한 남자 승객(pgender)의 정보를 보이시오
SELECT DISTINCT p.*
FROM Passenger p
JOIN Booking b ON p.pid = b.pid
JOIN Agency a ON b.aid = a.aid
WHERE a.aname = '마당여행사'
AND p.pgender = '남';




--[단순질의]
--1. Passenger 테이블에서 모든 승객의 pid, pname, pcity를 조회하시오.
--(풀이)
select pid, pname, pcity
from f_passenger;
--2. Passenger 테이블에서 pgender가 '남'인 승객의 pname과 pcity를 조회하시오.
--(풀이)
select pname, pcity
from f_passenger
where pgender = '남';
--3. Flight 테이블에서 출발지(src)가 '김포'인 항공편의 fid, fdate, dest를 조회하시오.
--(풀이)
select fid, fdate, dest
from f_flight
where src = '김포';
--4. Booking 테이블에서 pid별 예약 건수를 조회하시오.
--(풀이)
select pid, count(*) as 예약건수
from f_booking
group by pid;
--5. Agency 테이블에서 모든 여행사의 aid, aname, acity를 조회하시오.
--(풀이)
select aid, aname, acity
from f_agency;
--6. Flight 테이블에서 목적지(dest)가 '제주'인 항공편 수를 조회하시오.
--(풀이)
select count(fid) as 제주로가는항공편수
from f_flight
where dest = '제주';
--7. Booking 테이블에서 fdate가 '2025-01-01' 이후인 예약의 pid, aid, fid를 조회하시오.
--(풀이)
select pid, aid, fid
from f_booking
where fdate > '20250101';
--8. Booking 테이블에서 aid별 예약 건수를 내림차순으로 조회하시오.
--(풀이)
select aid, count(aid) as 예약건수
from f_booking
group by aid
order by 예약건수 desc;
--9. Flight 테이블에서 fdate가 가장 최근인 항공편의 fid와 src, dest를 조회하시오.
--(풀이)
select fid, src, dest
from f_flight
where fdate = (select max(fdate) from f_flight);
--10. Passenger 테이블에서 pcity가 '서울시 강남구' 또는 '서울시 강동구'인 승객의 pname
--을 조회하시오.
--(풀이)
select pname
from f_passenger
where pcity = '서울시 강남구' 
or pcity = '서울시 강동구';


--[조인질의]
--11. Passenger와 Booking 테이블을 조인하여 승객 이름(pname)과 예약한 fid를 조회하시
--오.
--(풀이)
select pname as 이름, fid
from f_passenger, f_booking
where f_passenger.pid = f_booking.pid;
--12. Agency와 Booking 테이블을 조인하여 여행사 이름(aname)과 예약 건수를 조회하시오.
--(풀이)
select aname as 여행사이름, count(pid) as 예약건수
from f_agency, f_booking
where f_agency.aid = f_booking.aid
group by aname;
--13. Passenger, Booking, Flight 테이블을 조인하여 승객 이름, 출발지(src), 목적지(dest)를
--조회하시오.
--(풀이)
select pname, src, dest
from f_passenger, f_booking, f_flight
where f_passenger.pid = f_booking.pid
and f_booking.fid = f_flight.fid;
--14. Passenger, Booking, Agency 테이블을 조인하여 승객 이름과 이용한 여행사 이름을 조
--회하시오. (중복 제거)
--(풀이)
select distinct pname, aname
from f_passenger, f_booking, f_agency
where f_Agency.aid = f_booking.aid
and f_passenger.pid = f_booking.pid;
--15. Passenger와 Booking 테이블을 LEFT JOIN하여 예약이 한 건도 없는 승객의 pname을 조회하시오.
--(풀이)
select pname as 예약이없는승객
from f_passenger
left join f_booking on f_passenger.pid = f_booking.pid
where f_booking.pid is null;
--16. Flight와 Booking 테이블을 조인하여 2025년 이후 항공편의 목적지(dest)별 예약 건수를
--조회하시오.
--(풀이)
select dest, count(*) as 예약건수
from f_flight, f_booking
where f_flight.fid = f_booking.fid 
and f_flight.fdate >= date '2025-01-01'
group by dest;
--17. Passenger, Booking, Flight 테이블을 조인하여 '제주'행 항공편을 예약한 승객 이름을
--중복 없이 조회하시오.
--(풀이)
select distinct pname
from f_passenger, f_booking, f_flight
where f_passenger.pid = f_booking.pid 
  and f_booking.fid = f_flight.fid 
  and dest = '제주';
--18. Passenger, Booking, Agency 테이블을 조인하여 '마당여행사'를 통해 예약한 승객의 이
--름을 조회하시오. (중복 제거)
--(풀이)
select distinct pname
from f_passenger, f_booking, f_agency
where f_passenger.pid = f_booking.pid 
  and f_booking.aid = f_agency.aid 
  and aname = '마당여행사';
--19. Passenger, Booking, Flight, Agency 4개 테이블을 조인하여 승객 이름, 여행사 이름,
--출발지, 목적지를 조회하시오. (2025년 예약만)
--(풀이)

--20. Flight와 Booking 테이블을 LEFT JOIN하여 예약이 없는 항공편의 fid, src, dest를 조회하시오.
--(풀이)


--[부속질의]
--21. Passenger 테이블에서 Booking 테이블에 예약 기록이 있는 승객의 pname을 조회하시
--오. (IN 사용)
--(풀이)

--22. Passenger 테이블에서 2025년 이후 항공편을 예약한 승객의 pname을 조회하시오.
--(풀이)

--23. Agency 테이블에서 예약 건수가 3건 이상인 여행사의 aname을 조회하시오.
--(풀이)

--24. Flight 테이블에서 Booking 테이블에 예약된 적 없는 항공편의 fid, src, dest를 조회하
--시오. (NOT IN 사용)
--(풀이)

--25. Passenger 테이블에서 예약 건수가 가장 많은 승객의 pname을 조회하시오.
--(풀이)

--26. Passenger 테이블에서 '부산'행 항공편을 예약한 승객의 pname을 조회하시오.
--(풀이)

--27. Agency 테이블에서 예약이 한 건도 없는 여행사의 aname을 조회하시오. (NOT IN 사
--용)
--(풀이)

--28. Passenger 테이블에서 '마당여행사(aid=1)'를 통해 예약한 승객의 pname을 조회하시오.
--(풀이)

--29. Booking 테이블에서 예약 건수가 전체 승객 평균 예약 건수보다 많은 pid를 조회하시오.
--(풀이)

--30. Passenger 테이블에서 2024년에 예약한 기록이 있는 승객의 pname을 조회하시오.
--(풀이)


--연습문제 20(128page)
--[기업프로젝트 데이터베이스] 다음은 기업의 프로젝트 관리와 관련된 데이터베이스 릴레이션이다.
--[상관부속질의]
--31. Passenger 테이블에서 Booking에 본인 pid로 예약 기록이 존재하는 승객의 pname을
--조회하시오. (EXISTS 사용)
--(풀이)

--32. Passenger 테이블에서 본인의 예약 건수가 2건 이상인 승객의 pname을 조회하시오.
--(상관 서브쿼리 사용)
--(풀이)

--33. Flight 테이블에서 Booking에 예약 기록이 전혀 없는 항공편의 fid를 조회하시오. (NOT
--EXISTS 사용)
--(풀이)

--34. Passenger 테이블에서 2025년 이후 항공편을 예약한 기록이 존재하는 승객의 pname을
--조회하시오. (EXISTS 사용)
--(풀이)

--35. Passenger 테이블에서 서로 다른 여행사(aid)를 2곳 이상 이용한 승객의 pname을 조회
--하시오.
--(풀이)

--36. Agency 테이블에서 Booking에 예약이 존재하지 않는 여행사의 aname을 조회하시오.
--(NOT EXISTS 사용)
--(풀이)

--37. Passenger 테이블에서 본인이 예약한 항공편 중 '제주'행이 존재하는 승객의 pname을
--조회하시오.
--(풀이)

--38. Passenger 테이블에서 2024년에만 예약하고 2025년에는 예약이 없는 승객의 pname을
--조회하시오.
--(풀이)

--39. Flight 테이블에서 같은 목적지(dest) 항공편 중 예약 건수가 가장 많은 항공편의 fid를
--조회하시오.
--(풀이)

--40. Passenger 테이블에서 본인이 예약한 모든 항공편의 출발지가 '김포'인 승객의 pname
--을 조회하시오. (NOT EXISTS 활용)
--(풀이)