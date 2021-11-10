--1.--
create view ppt_information as
select po.*
from propertyforrent pf, privateowner po
where pf.ownerno = po.ownerno
and pf.city = 'Glasgow';

--2.--
create view profile_staff_view as
select staffno, fname, lname, dob
from staff
where position = 'Manager';

--3.--
create view branch_staff_work as
select s.staffno, s.fname, s.lname, b.street || ' ' || b.city || ' ' || b.postcode as branch_address
from staff s, branch b
where s.branchno = b.branchno;

--4.--
create view all_value_salary as
select position, max(salary) as max_salary, min(salary) as min_salary, avg(salary) as avg_salary
from staff
group by position;

--5.--
create view ppt_client_view as
select pf.propertyno, pf.type, pf.rooms, pf.street|| ' ' ||pf.city|| ' ' ||pf.postcode as address, count(v.clientno) as number_of_view
from propertyforrent pf, viewing v
where pf.propertyno = v.propertyno
group by pf.propertyno, pf.type, pf.rooms, pf.street || ' ' || pf.city || ' ' || pf.postcode;

--6.--
create view salary_more_avg_staff as
select *
from staff
where salary > (select avg(salary)
                from staff);

--7.--
update staff
set fname = 'Peter'
where fname = 'John';
--change--

--8.--
update profile_staff_view
set fname = 'Chai'
where staffno = 'SL21';
--change--

--9.--
update profile_staff_view
set fname = 'Bob'
where staffno = 'SA9';
--not change--

--10.--
update staff
set salary = '27000'
where staffno = 'SA9';
--change--

--11.--
update all_value_salary
set max_salary = '40000'
where position = 'Manager';
--cannot run--

--12.--
update all_value_salary
set position = 'Consultant'
where position = 'Manager';
--cannot run--

--13.--
insert into ppt_information (ownerno, fname, lname, address, telno, email, password)
values ('CO99', 'Supichaya', 'Kanaraksanti', '46 Prachauthit91/1, thungkru, thungkru, Bangkok, 10140', '097-219-0935', 'supichaya.jb@mail.kmutt.ac.th', null);

--14.--
insert into profile_staff_view(staffno, fname, lname, dob)
vaules('99', 'Supichaya', 'Kanaraksanti','23-FEB-44 12.35.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'));