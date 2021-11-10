--1.	List staffs who manage properties with three rooms.
select s.fname || ' ' || s.lname as name
from staff s
where s.staffno in (select s.staffno 
                    from staff s, propertyforrent pr 
                    where s.staffno = pr.staffno 
                    and pr.rooms = '3');

--2.	List properties that owner�s telephone number starts with 012.
select pr.propertyno
from propertyforrent pr
where pr.ownerno in (select pr.ownerno
                     from propertyforrent pr, privateowner po
                     where pr.ownerno = po.ownerno 
                     and po.telno like '012%');

--3.	List staffs whose salary is less than the average salary of all staffs and staffs who work in the branch located in Glasgow city.
select s.fname || ' ' || s.lname as name, s.salary
from staff s, branch b
where s.salary < (select avg(salary) 
                  from staff s, branch b 
                  where s.branchno = b.branchno 
                  and b.city = 'Glasgow')
      and s.branchno = b.branchno 
      and b.city = 'Glasgow';

--4.	List clients who registered in the branch at 163 Main Street.
select c.clientno, c.fname || ' ' || c.lname as name
from client c
where c.clientno in (select c.clientno
                     from client c, registration r, branch b
                     where c.clientno = r.clientno 
                     and r.branchno = b.branchno 
                     and b.street = '163 Main Street');
                     
--5.	In each branch, list staffs whose salary is greater than the average salary in their branch.
select b.branchno, s.staffno, s.fname || ' ' || s.lname as name, s.salary
from staff s, branch b
where s.salary > (select avg(salary) 
                  from staff s, branch b 
                  where s.branchno = b.branchno)
      and s.branchno = b.branchno;

select staffno,salary,branchno
from (select * from staff s where EXISTS (  select *
                                            from branch b
                                            where s.branchno = b.branchno) ) 
where salary > ( select AVG(salary) from staff );
--6.	Find the number of staff working in each branch and the sum of their salaries.
select b.branchno, c.count_staff, s.salary_staff
from branch b, 
     (select s.branchno, count(s.staffno) as count_staff 
      from staff s 
      group by s.branchno) c,
     (select s.branchno, sum(s.salary) as salary_staff
      from staff s
      group by s.branchno) s
where b.branchno = s.branchno
      and b.branchno = c.branchno
      and c.branchno = s.branchno;
     
--7.	List all staff whose salary is greater than the average salary of all staffs and show by how much their salary is greater than the average.
select s.staffno, s.fname || ' ' || s.lname as name, s.salary, (s.salary - (select avg(salary) from staff) ) as salary_diff
from staff s
where s.salary > (select avg(salary)
                  from staff);
                  
--8.	List the properties that are handled by staff who work in the branch at �163 Main Street�.
select pr.propertyno, pr.street, pr.staffno
from propertyforrent pr
where pr.propertyno in (select pr.propertyno
                        from propertyforrent pr, staff s, branch b
                        where pr.staffno = s.staffno 
                        and s.branchno = b.branchno 
                        and b.street = '163 Main Street');

--9.	Find all staff whose salary is higher than the salary of at least one member of staff at branch B003.                  
select s.staffno, s.branchno, s.fname || ' ' || s.lname as name, s.salary
from staff s
where s.salary > (select min(salary) 
                  from staff 
                  where branchno = 'B003');

--10.	Find all staff who work in a London branch office.           
select staffno, fname || ' ' || lname as name
from staff 
where staffno in (select s.staffno 
                  from staff s, branch b 
                  where s.branchno = b.branchno 
                  and b.city = 'London');

--11.	Construct a list of all cities where there is both a branch office and a property.
select distinct(b.city)
from branch b
where b.city in (select b.city 
                 from branch b, propertyforrent pr 
                 where b.city = pr.city);
                 
--12.	Construct a list of all cities where there is a branch office but no properties.
select distinct(b.city)
from branch b
where b.city not in (select b.city 
                 from branch b, propertyforrent pr 
                 where b.city = pr.city);
