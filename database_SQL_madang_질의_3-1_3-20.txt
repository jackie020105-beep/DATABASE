--마당서점 P.153~P.170오후 12:48 2026-04-29

--SELECT문
--질의 3-1
select bookname, price
from book;

select price, bookname
from book;

--질의 3-2
select bookid, bookname, publisher, price
from book;

select *
from book

--질의 3-3
select publisher
from book;

select distinct publisher
from book;

--질의 3-4
select *
from book
where price < 20000;

--질의 3-5
select *
from book
where price between 10000 and 20000;

select *
from book
where price >= 10000 and price <= 20000;

--질의 3-6
select *
from book
where publisher in ('굿스포츠','대한미디어');

select *
from book
where publisher not in ('굿스포츠','대한미디어');

--질의 3-7
select bookname, publisher
from book
where bookname like '축구의 역사';

--질의 3-8
select bookname, publisher
from book
where bookname like '%축구%';

--질의 3-9
select *
from book
where bookname like '_구%';

--질의 3-10
select *
from book
where bookname like '%축구%' and price >=20000;

--질의 3-11
select *
from book
where publisher = '굿스포츠' or publisher = '대한미디어';

select *
from book
where publisher in ('굿스포츠', '대한미디어');

--ORDER BY
--질의 3-12
select *
from book
order by bookname;

--질의 3-13
select *
from book
order by price, bookname;

--질의 3-14
select *
from book
order by price desc, publisher asc;


--집계 함수
--집계함수: SUM(열):합계, AVG(열):평균, MAX(열):최댓값, MIN(열): 최솟값, COUNT(열 또는 *): 개수
--질의 3-15
select sum(saleprice)
from orders;

select sum(saleprice) as 총매출
from orders;

--질의 3-16
select sum(saleprice) as 총매출
from orders
where custid = 2;

--질의 3-17
select sum(saleprice) as total,
avg(saleprice) as average,
min(saleprice) as minimum,
max(saleprice) as maxium
from orders;

--질의 3-18
select count(*)
from orders;

--GROUP BY
--질의 3-19
select custid, count(*) as 도서수량,sum(saleprice) as 도서총액
from orders
group by custid;

--질의 3-20
select custid, count(*) as 도서수량
from orders
where saleprice>=8000
group by custid
having count(*) >= 2
order by custid;