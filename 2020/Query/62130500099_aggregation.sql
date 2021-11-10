--1.	Write SQL statements to answer the following questions.


    --1.1	How many employees report to 'Patterson' (EMPLOYEE's LASTNAME).
        SELECT COUNT(*)
        FROM EMPLOYEES E1, EMPLOYEES E2
        WHERE E1.REPORTSTO = E2.EMPLOYEENUMBER AND E2.LASTNAME = 'Patterson';

    --1.2  How many countries that 'Jones' (EMPLOYEE's LASTNAME) 's CUSTOMERS located in. 
        SELECT COUNT(DISTINCT C.COUNTRY)
        FROM CUSTOMERS C, EMPLOYEES E
        WHERE E.LASTNAME = 'Jones' AND C.SALESREPEMPLOYEENUMBER = E.EMPLOYEENUMBER;
        
    --1.3.	List the ORDERNUMBER and the total cost (summation of all QUANTITYORDER * PRICEEACH) of each ORDER that its STATUS is 'Shipped'.
        SELECT O.ORDERNUMBER, SUM(O.QUANTITYORDERED*O.PRICEEACH)
        FROM ORDERDETAILS O, ORDERS OD
        WHERE OD.STATUS = 'Shipped' AND O.ORDERNUMBER = OD.ORDERNUMBER
        GROUP BY O.ORDERNUMBER;
    --1.4.	How many pieces that each product is ordered? Show the PRODUCTCODE, PRODUCTNAME, and the numbers that it is ordered.
        SELECT P.PRODUCTCODE, P.PRODUCTNAME, COUNT(*)
        FROM PRODUCTS P, ORDERDETAILS O
        WHERE P.PRODUCTCODE = O.PRODUCTCODE
        GROUP BY P.PRODUCTCODE, P.PRODUCTNAME;
    --1.5	Show the average BUYPRICE of all products in PRODUCTLINES that have more than 3 products. 
        SELECT AVG(BUYPRICE)
        FROM PRODUCTS
        GROUP BY PRODUCTLINE
        HAVING COUNT (PRODUCTLINE)>3;
    --1.6.	What is the PRODUCTNAME of the highest BUYPRICE product? (optional)
        SELECT PRODUCTNAME 
        FROM PRODUCTS
        WHERE (SELECT MAX(BUYPRICE)FROM PRODUCTS)=BUYPRICE;