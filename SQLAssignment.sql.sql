1) List all the columns of the Salespeople table.
mysql> SELECT SNUM,SNAME,CITY,COMM FROM Salespeople;
+------+---------+-----------+------+
| SNUM | SNAME   | CITY      | COMM |
+------+---------+-----------+------+
| 1001 | Peel    | London    |   12 |
| 1002 | Serres  | SanJose   |   13 |
| 1004 | Motika  | London    |   11 |
| 1007 | Rifkin  | Barcelona |   15 |
| 1003 | AxelRod | New York  |   10 |
| 1008 | Fran    | London    |   25 |
+------+---------+-----------+------+
2) List all customers with a rating of 100.
 mysql> SELECT CNUM,CNAME,CITY,RATING,SNUM FROM customers WHERE RATING = 100;
+------+---------+--------+--------+------+
| CNUM | CNAME   | CITY   | RATING | SNUM |
+------+---------+--------+--------+------+
| 2001 | Hoffman | London |    100 | 1001 |
| 2006 | Clemens | London |    100 | 1001 |
| 2007 | Pereira | Rome   |    100 | 1004 |
+------+---------+--------+--------+------+
3) Find the largest order taken by each salesperson on each date.

mysql> SELECT Orders.SNUM,Salespeople.SNAME ,Orders.ODATE,MAX(AMT) AS MAX_AMT FROM ORDERS,Salespeople  GROUP BY ODATE,SNUM;
+------+-------+------------+---------+
| SNUM | SNAME | ODATE      | MAX_AMT |
+------+-------+------------+---------+
| 1007 | Fran  | 1990-10-03 | 1098.16 |
| 1001 | Fran  | 1990-10-03 |  767.19 |
| 1004 | Fran  | 1990-10-03 | 1900.10 |
| 1002 | Fran  | 1990-10-03 | 5160.45 |
| 1003 | Fran  | 1990-10-04 | 1713.23 |
| 1002 | Fran  | 1990-10-04 |   75.75 |
| 1001 | Fran  | 1990-10-05 | 4723.00 |
| 1002 | Fran  | 1990-10-06 | 1309.95 |
| 1001 | Fran  | 1990-10-06 | 9891.88 |
+------+-------+------------+---------+
4) Arrange the Order table by descending customer number.

mysql> SELECT CNUM,ONUM,AMT,ODATE,SNUM FROM ORDERS ORDER BY CNUM DESC;
+------+------+---------+------------+------+
| CNUM | ONUM | AMT     | ODATE      | SNUM |
+------+------+---------+------------+------+
| 2008 | 3001 |   18.69 | 1990-10-03 | 1007 |
| 2008 | 3006 | 1098.16 | 1990-10-03 | 1007 |
| 2007 | 3002 | 1900.10 | 1990-10-03 | 1004 |
| 2006 | 3008 | 4723.00 | 1990-10-05 | 1001 |
| 2006 | 3011 | 9891.88 | 1990-10-06 | 1001 |
| 2004 | 3007 |   75.75 | 1990-10-04 | 1002 |
| 2004 | 3010 | 1309.95 | 1990-10-06 | 1002 |
| 2003 | 3005 | 5160.45 | 1990-10-03 | 1002 |
| 2002 | 3009 | 1713.23 | 1990-10-04 | 1003 |
| 2001 | 3003 |  767.19 | 1990-10-03 | 1001 |
+------+------+---------+------------+------+
5) Find which salespeople currently have orders in the order table.
mysql> SELECT DISTINCT  SNAME FROM salespeople NATURAL JOIN Orders;
+---------+
| SNAME   |
+---------+
| Peel    |
| Serres  |
| AxelRod |
| Motika  |
| Rifkin  |
+---------+
6) List names of all customers matched with the salespeople serving them.

mysql> SELECT c.CNAME,s.SNAME FROM Customers c, Salespeople s WHERE  c.SNUM = s.SNUM;
+----------+---------+
| CNAME    | SNAME   |
+----------+---------+
| Hoffman  | Peel    |
| Clemens  | Peel    |
| Liu      | Serres  |
| Grass    | Serres  |
| Giovanni | AxelRod |
| Pereira  | Motika  |
| Cisneros | Rifkin  |
+----------+---------+
7) Find the names and numbers of all salespeople who have more than one customer.

mysql> SELECT Customers.SNUM,Salespeople.SNAME,COUNT(Customers.SNUM) AS Customers_NO  
       FROM Customers , Salespeople 
       WHERE  Customers.SNUM = Salespeople.SNUM  
       GROUP BY Customers.SNUM 
       HAVING COUNT(Customers.SNUM)>1 ;
+------+--------+--------------+
| SNUM | SNAME  | Customers_NO |
+------+--------+--------------+
| 1001 | Peel   |            2 |
| 1002 | Serres |            2 |
+------+--------+--------------+
8) Count the orders of each of the salespeople and output the results in descending order.

mysql> SELECT o.SNUM,s.SNAME,COUNT(*) AS ORDER_NO FROM Orders o, Salespeople s WHERE  o.SNUM = s.SNUM GROUP By o.SNUM ORDER BY ORDER_NO DESC;
+------+---------+----------+
| SNUM | SNAME   | ORDER_NO |
+------+---------+----------+
| 1001 | Peel    |        3 |
| 1002 | Serres  |        3 |
| 1007 | Rifkin  |        2 |
| 1003 | AxelRod |        1 |
| 1004 | Motika  |        1 |
+------+---------+----------+
9) List the customer table if and only if one or more of the customers in the Customer table are located in SanJose.
mysql> SELECT DISTINCT c1.CNUM, c1.CNAME, c1.CITY, c1.RATING, c1.SNUM 
       FROM Customers AS c1,Customers AS c2 
       WHERE c1.CITY='Sanjose' AND c2.CITY ='Sanjose';
+------+----------+---------+--------+------+
| CNUM | CNAME    | CITY    | RATING | SNUM |
+------+----------+---------+--------+------+
| 2008 | Cisneros | SanJose |    300 | 1007 |
| 2003 | Liu      | SanJose |    200 | 1002 |
+------+----------+---------+--------+------+
10) Match salespeople to customers according to what city they live in.
mysql> SELECT s.SNAME,c.CNAME,s.CITY FROM Customers c,Salespeople s WHERE s.CITY = c.CITY;
+--------+----------+---------+
| SNAME  | CNAME    | CITY    |
+--------+----------+---------+
| Fran   | Hoffman  | London  |
| Motika | Hoffman  | London  |
| Peel   | Hoffman  | London  |
| Serres | Liu      | SanJose |
| Fran   | Clemens  | London  |
| Motika | Clemens  | London  |
| Peel   | Clemens  | London  |
| Serres | Cisneros | SanJose |
+--------+----------+---------+
11) Find all the customers in SanJose who have a rating above 200.

mysql> SELECT CNUM,CNAME,CITY,RATING,SNUM FROM Customers WHERE CITY='SanJose'AND RATING>=200;
+------+----------+---------+--------+------+
| CNUM | CNAME    | CITY    | RATING | SNUM |
+------+----------+---------+--------+------+
| 2003 | Liu      | SanJose |    200 | 1002 |
| 2008 | Cisneros | SanJose |    300 | 1007 |
+------+----------+---------+--------+------+
12) List the names and commissions of all salespeople in London.
mysql> SELECT DISTINCT SNUM,CITY,COMM FROM Salespeople WHERE CITY ='London';
+------+--------+------+
| SNUM | CITY   | COMM |
+------+--------+------+
| 1001 | London |   12 |
| 1004 | London |   11 |
| 1008 | London |   25 |
+------+--------+------+
13) List all the orders of Salesperson Motika from the orders table.
mysql> SELECT o.ONUM,o.AMT,o.ODATE,o.CNUM,s.SNUM,s.SNAME FROM Orders o,Salespeople s WHERE s.SNAME = 'Motika'AND s.SNUM = o.SNUM;
+------+---------+------------+------+------+--------+
| ONUM | AMT     | ODATE      | CNUM | SNUM | SNAME  |
+------+---------+------------+------+------+--------+
| 3002 | 1900.10 | 1990-10-03 | 2007 | 1004 | Motika |
+------+---------+------------+------+------+--------+

14) Find all customers who booked orders on October 3.



mysql>  SELECT c.CNUM,c.CNAME,c.CITY,c.RATING,c.SNUM,o.ODATE FROM Customers c,Orders o WHERE o.ODATE='1990/10/03' AND c.CNUM = O.CNUM;
+------+----------+---------+--------+------+------------+
| CNUM | CNAME    | CITY    | RATING | SNUM | ODATE      |
+------+----------+---------+--------+------+------------+
| 2001 | Hoffman  | London  |    100 | 1001 | 1990-10-03 |
| 2003 | Liu      | SanJose |    200 | 1002 | 1990-10-03 |
| 2008 | Cisneros | SanJose |    300 | 1007 | 1990-10-03 |
| 2008 | Cisneros | SanJose |    300 | 1007 | 1990-10-03 |
| 2007 | Pereira  | Rome    |    100 | 1004 | 1990-10-03 |
+------+----------+---------+--------+------+------------+


15) Give the sums of the amounts from the Orders table, grouped by date, eliminating all those dates where the SUM was not at least 2000 above
the maximum Amount.

mysql>  SELECT ODATE,SUM(AMT) AS Total_AMT FROM Orders GROUP BY ODATE HAVING SUM(AMT)>2000;
+------------+-----------+
| ODATE      | Total_AMT |
+------------+-----------+
| 1990-10-03 |   8944.59 |
| 1990-10-05 |   4723.00 |
| 1990-10-06 |  11201.83 |
+------------+-----------+
16) Select all orders that had amounts that were greater than at least one of the orders from October 6.


mysql> SELECT ONUM,AMT,ODATE,CNUM,SNUM FROM Orders WHERE AMT > ANY  (SELECT AMT FROM Orders WHERE ODATE = '1990-10-06');
+------+---------+------------+------+------+
| ONUM | AMT     | ODATE      | CNUM | SNUM |
+------+---------+------------+------+------+
| 3002 | 1900.10 | 1990-10-03 | 2007 | 1004 |
| 3005 | 5160.45 | 1990-10-03 | 2003 | 1002 |
| 3009 | 1713.23 | 1990-10-04 | 2002 | 1003 |
| 3008 | 4723.00 | 1990-10-05 | 2006 | 1001 |
| 3011 | 9891.88 | 1990-10-06 | 2006 | 1001 |
+------+---------+------------+------+------+
  
17) Write a query that uses the EXISTS operator to extract all salespeople who have customers with a rating of 300.

 SELECT SNUM,SNAME,CITY,COMM 
 FROM Salespeople s WHERE EXISTS (SELECT SNUM,RATING  
                                  FROM Customers c WHERE c.SNUM = s.SNUM AND RATING = 300);
+------+--------+-----------+------+
| SNUM | SNAME  | CITY      | COMM |
+------+--------+-----------+------+
| 1002 | Serres | SanJose   |   13 |
| 1007 | Rifkin | Barcelona |   15 |
+------+--------+-----------+------+
18) Find all customers whose cnum is 1000 above the snum of Serres.

mysql> SELECT Customers.CNUM,Customers.CNAME 
	   FROM Customers,Salespeople 
       WHERE Customers.SNUM = Salespeople.SNUM AND Customers.CNUM > Salespeople.SNUM+1000;
+------+----------+
| CNUM | CNAME    |
+------+----------+
| 2006 | Clemens  |
| 2003 | Liu      |
| 2004 | Grass    |
| 2007 | Pereira  |
| 2008 | Cisneros |
+------+----------+
19) Give the salespeople’s commissions as percentages instead of decimal numbers.
mysql> SELECT CONCAT (COMM,'%') AS PERCENTAGE FROM Salespeople;
+------------+
| PERCENTAGE |
+------------+
| 12%        |
| 13%        |
| 10%        |
| 11%        |
| 15%        |
| 25%        |
+------------+
20) Find the largest order taken by each salesperson on each date, eliminating those Maximum orders, which are less than 3000.

mysql>  SELECT Salespeople.SNAME,Orders.SNUM,Orders.ODATE,SUM(Orders.AMT) AS Largest_Orders 
        FROM Orders ,Salespeople  
        WHERE  Orders.SNUM =Salespeople.SNUM AND Orders.AMT > 3000 GROUP BY Orders.ODATE;
+--------+------+------------+----------------+
| SNAME  | SNUM | ODATE      | Largest_Orders |
+--------+------+------------+----------------+
| Serres | 1002 | 1990-10-03 |        5160.45 |
| Peel   | 1001 | 1990-10-05 |        4723.00 |
| Peel   | 1001 | 1990-10-06 |        9891.88 |
+--------+------+------------+----------------+
21) List all the largest orders for October 3, for each salesperson.

mysql>  SELECT Salespeople.SNAME,Orders.SNUM,Orders.ODATE,SUM(Orders.AMT) AS Largest_Orders 
        FROM Orders ,Salespeople  
        WHERE  Orders.SNUM = Salespeople.SNUM AND Orders.ODATE = ' 1990-10-03 ' GROUP BY Orders.SNUM;
+--------+------+------------+----------------+
| SNAME  | SNUM | ODATE      | Largest_Orders |
+--------+------+------------+----------------+
| Rifkin | 1007 | 1990-10-03 |        1116.85 |
| Peel   | 1001 | 1990-10-03 |         767.19 |
| Motika | 1004 | 1990-10-03 |        1900.10 |
| Serres | 1002 | 1990-10-03 |        5160.45 |
+--------+------+------------+----------------+

22) Find all customers located in cities where Serres has customers.

mysql> SELECT CNUM,CNAME,CITY
       FROM Customers 
       WHERE SNUM IN (SELECT SNUM 
					  FROM Salespeople 
					  WHERE SNAME = 'Serres');
+------+-------+---------+
| CNUM | CNAME | CITY    |
+------+-------+---------+
| 2003 | Liu   | SanJose |
| 2004 | Grass | Berlin  |
+------+-------+---------+
23) Select all customers with a rating above 200.

mysql> SELECT CNUM,CNAME,CITY,RATING,SNUM FROM Customers WHERE RATING >=200;
+------+----------+---------+--------+------+
| CNUM | CNAME    | CITY    | RATING | SNUM |
+------+----------+---------+--------+------+
| 2002 | Giovanni | Rome    |    200 | 1003 |
| 2003 | Liu      | SanJose |    200 | 1002 |
| 2004 | Grass    | Berlin  |    300 | 1002 |
| 2008 | Cisneros | SanJose |    300 | 1007 |
+------+----------+---------+--------+------+
24) Count the number of salespeople currently having orders in the orders table.
mysql> SELECT  COUNT(DISTINCT SNUM) AS No_Of_Salespeople FROM Orders;
+-------------------+
| No_Of_Salespeople |
+-------------------+
|                 5 |
+-------------------+
25) Write a query that produces all customers serviced by salespeople with a commission above 12%. Output the customer’s name,
salesperson’s name and the salesperson’s rate of commission.
mysql> SELECT Customers.CNAME,Salespeople.SNAME,Customers.RATING,Salespeople.COMM 
       FROM Customers,Salespeople 
	   WHERE Customers.SNUM=Salespeople.SNUM AND Salespeople.COMM>12;
+----------+--------+--------+------+
| CNAME    | SNAME  | RATING | COMM |
+----------+--------+--------+------+
| Liu      | Serres |    200 |   13 |
| Grass    | Serres |    300 |   13 |
| Cisneros | Rifkin |    300 |   15 |
+----------+--------+--------+------+
26) Find salespeople who have multiple customers.
mysql> SELECT SNUM, COUNT(SNUM) AS Total_Customers FROM Customers GROUP BY SNUM HAVING COUNT(SNUM)>1;
+------+-----------------+
| SNUM | Total_Customers |
+------+-----------------+
| 1001 |               2 |
| 1002 |               2 |
+------+-----------------+
27) Find salespeople with customers located in their own cities.

mysql> SELECT Salespeople.SNAME,Customers.CNAME,Salespeople.CITY 
       FROM Salespeople,Customers  
       WHERE Salespeople.SNUM = Customers.SNUM AND Salespeople.CITY = Customers.CITY;
+--------+---------+---------+
| SNAME  | CNAME   | CITY    |
+--------+---------+---------+
| Peel   | Hoffman | London  |
| Serres | Liu     | SanJose |
| Peel   | Clemens | London  |
+--------+---------+---------+
28) Find all salespeople whose name starts with ‘P’ and fourth character is ‘I’.
mysql> SELECT SNAME FROM Salespeople  WHERE   SNAME  LIKE   'p__l%' ;
+-------+
| SNAME |
+-------+
| Peel  |
+-------+
29) Write a query that uses a subquery to obtain all orders for the customer named ‘Cisneros’. Assume you do not know his customer number.

mysql> SELECT ONUM FROM Orders WHERE SNUM =(SELECT SNUM FROM Customers WHERE CNAME = 'Cisneros');
+------+
| ONUM |
+------+
| 3001 |
| 3006 |
+------+
30) Find the largest orders for Serres and Rifkin.
mysql> SELECT  SNUM,MAX(AMT) 
       FROM Orders GROUP BY SNUM  HAVING  SNUM IN (SELECT SNUM FROM Salespeople  
												   WHERE SNAME ='serres' OR  SNAME = 'Rifkin');
+------+----------+
| SNUM | MAX(AMT) |
+------+----------+
| 1002 |  5160.45 |
| 1007 |  1098.16 |
+------+----------+
31) Sort the salespeople table in the following order: snum, sname, commission, city.
mysql> SELECT SNUM,SNAME,COMM,CITY FROM Salespeople;
+------+---------+------+-----------+
| SNUM | SNAME   | COMM | CITY      |
+------+---------+------+-----------+
| 1001 | Peel    |   12 | London    |
| 1002 | Serres  |   13 | SanJose   |
| 1003 | AxelRod |   10 | New York  |
| 1004 | Motika  |   11 | London    |
| 1007 | Rifkin  |   15 | Barcelona |
| 1008 | Fran    |   25 | London    |
+------+---------+------+-----------+
32) Select all customers whose names fall in between ‘A’ and ‘G’ alphabetical range.
mysql> SELECT CNAME FROM Customers WHERE CNAME BETWEEN 'A' AND 'G' ORDER BY CNAME ;
+----------+
| CNAME    |
+----------+
| Cisneros |
| Clemens  |
+----------+
33) Select all the possible combinations of customers you can assign.
mysql> SELECT c.CNAME,s.SNAME FROM Customers c join Salespeople s on  c.SNUM=s.SNUM ORDER BY s.SNUM;
+----------+---------+
| CNAME    | SNAME   |
+----------+---------+
| Hoffman  | Peel    |
| Clemens  | Peel    |
| Liu      | Serres  |
| Grass    | Serres  |
| Giovanni | AxelRod |
| Pereira  | Motika  |
| Cisneros | Rifkin  |
+----------+---------+
34) Select all orders that are greater than the average for October 4.
mysql> SELECT ONUM,AMT,ODATE,CNUM,SNUM FROM Orders WHERE AMT >(SELECT AVG(AMT) FROM Orders WHERE ODATE =' 1990-10-04');
+------+---------+------------+------+------+
| ONUM | AMT     | ODATE      | CNUM | SNUM |
+------+---------+------------+------+------+
| 3002 | 1900.10 | 1990-10-03 | 2007 | 1004 |
| 3005 | 5160.45 | 1990-10-03 | 2003 | 1002 |
| 3006 | 1098.16 | 1990-10-03 | 2008 | 1007 |
| 3009 | 1713.23 | 1990-10-04 | 2002 | 1003 |
| 3008 | 4723.00 | 1990-10-05 | 2006 | 1001 |
| 3010 | 1309.95 | 1990-10-06 | 2004 | 1002 |
| 3011 | 9891.88 | 1990-10-06 | 2006 | 1001 |
+------+---------+------------+------+------+
35) Write a select command using correlated subquery that selects the names and numbers of all customers with ratings equal to the maximum
for their city.

mysql> SELECT CNUM,CNAME,RATING FROM Customers WHERE RATING IN (SELECT MAX(RATING) FROM Customers GROUP BY CITY);
+------+----------+--------+
| CNUM | CNAME    | RATING |
+------+----------+--------+
| 2001 | Hoffman  |    100 |
| 2002 | Giovanni |    200 |
| 2003 | Liu      |    200 |
| 2004 | Grass    |    300 |
| 2006 | Clemens  |    100 |
| 2008 | Cisneros |    300 |
| 2007 | Pereira  |    100 |
+------+----------+--------+
36) Write a query that totals the orders for each day and places the results in descending order.
mysql> SELECT ODATE,SUM(AMT) AS Total_Amount FROM Orders GROUP BY ODATE ORDER BY Total_Amount;
+------------+--------------+
| ODATE      | Total_Amount |
+------------+--------------+
| 1990-10-04 |      1788.98 |
| 1990-10-05 |      4723.00 |
| 1990-10-03 |      8944.59 |
| 1990-10-06 |     11201.83 |
+------------+--------------+
37) Write a select command that produces the rating followed by the name of each customer in SanJose.
mysql>  SELECT c.CNAME,c.RATING FROM Salespeople s,customers c WHERE s.SNUM = c.SNUM AND s.CITY = 'SanJose';
+-------+--------+
| CNAME | RATING |
+-------+--------+
| Liu   |    200 |
| Grass |    300 |
+-------+--------+
38) Find all orders with amounts smaller than any amount for a customer in SanJose.
mysql> SELECT ONUM,AMT,ODATE,CNUM,SNUM 
       FROM Orders WHERE AMT <(SELECT MAX(AMT) 
                               FROM Orders WHERE SNUM = (SELECT SNUM 
														FROM Salespeople WHERE CITY ='SanJose'));
+------+---------+------------+------+------+
| ONUM | AMT     | ODATE      | CNUM | SNUM |
+------+---------+------------+------+------+
| 3001 |   18.69 | 1990-10-03 | 2008 | 1007 |
| 3003 |  767.19 | 1990-10-03 | 2001 | 1001 |
| 3002 | 1900.10 | 1990-10-03 | 2007 | 1004 |
| 3006 | 1098.16 | 1990-10-03 | 2008 | 1007 |
| 3009 | 1713.23 | 1990-10-04 | 2002 | 1003 |
| 3007 |   75.75 | 1990-10-04 | 2004 | 1002 |
| 3008 | 4723.00 | 1990-10-05 | 2006 | 1001 |
| 3010 | 1309.95 | 1990-10-06 | 2004 | 1002 |
+------+---------+------------+------+------+
39) Find all orders with above average amounts for their customers.
mysql> select onum,AMT,ODATE,CNUM,SNUM from orders where amt >(select avg(amt) from orders);
+------+---------+------------+------+------+
| onum | AMT     | ODATE      | CNUM | SNUM |
+------+---------+------------+------+------+
| 3005 | 5160.45 | 1990-10-03 | 2003 | 1002 |
| 3008 | 4723.00 | 1990-10-05 | 2006 | 1001 |
| 3011 | 9891.88 | 1990-10-06 | 2006 | 1001 |
+------+---------+------------+------+------+
40) Write a query that selects the highest rating in each city.
mysql> SELECT CITY, MAX(RATING) FROM Customers GROUP BY CITY;
+---------+-------------+
| CITY    | MAX(RATING) |
+---------+-------------+
| London  |         100 |
| Rome    |         200 |
| SanJose |         300 |
| Berlin  |         300 |
+---------+-------------+
41) Write a query that calculates the amount of the salesperson’s commission on each order by a customer with a rating above 100.00.

mysql> SELECT SNAME,COMM*AMT AS Amount 
       FROM Salespeople,Customers,Orders 
	   WHERE Salespeople.SNUM=Customers.SNUM AND Customers.CNUM=Orders.CNUM AND Customers.RATING>100;
+---------+----------+
| SNAME   | Amount   |
+---------+----------+
| Rifkin  |   280.35 |
| Serres  | 67085.85 |
| Rifkin  | 16472.40 |
| AxelRod | 17132.30 |
| Serres  |   984.75 |
| Serres  | 17029.35 |
+---------+----------+
42) Count the customers with ratings above SanJose’s average.
mysql> SELECT COUNT(Cnum) FROM Customers WHERE RATING >(SELECT AVG(RATING) FROM Customers WHERE CITY ='SanJose');
+-------------+
| COUNT(Cnum) |
+-------------+
|           2 |
+-------------+
43) Find all salespeople that are located in either Barcelona or London.
mysql> SELECT SNUM,SNAME,CITY,COMM FROM Salespeople WHERE CITY IN("Barcelona","London");
+------+--------+-----------+------+
| SNUM | SNAME  | CITY      | COMM |
+------+--------+-----------+------+
| 1001 | Peel   | London    |   12 |
| 1004 | Motika | London    |   11 |
| 1007 | Rifkin | Barcelona |   15 |
| 1008 | Fran   | London    |   25 |
+------+--------+-----------+------+
44) Find all salespeople with only one customer.
mysql> SELECT SNUM,SNAME,COUNT(SNUM) AS Customers FROM Salespeople GROUP BY SNUM HAVING COUNT(SNUM)<=1;
+------+---------+-----------+
| SNUM | SNAME   | Customers |
+------+---------+-----------+
| 1001 | Peel    |         1 |
| 1002 | Serres  |         1 |
| 1003 | AxelRod |         1 |
| 1004 | Motika  |         1 |
| 1007 | Rifkin  |         1 |
| 1008 | Fran    |         1 |
+------+---------+-----------+
45) Write a query that joins the Customer table to itself to find all pairs or customers served by a single salesperson.
46) Write a query that will give you all orders for more than $1000.00.
mysql> SELECT ONUM
    -> FROM Orders
    -> WHERE AMT>1000;
+------+
| ONUM |
+------+
| 3002 |
| 3005 |
| 3006 |
| 3009 |
| 3008 |
| 3010 |
| 3011 |
+------+
47) Write a query that lists each order number followed by the name of the customer who made that order.
mysql> SELECT Orders.ONUM,Customers.CNAME
    -> FROM Orders JOIN Customers
    -> ON Orders.CNUM = Customers.CNUM;
+------+----------+
| ONUM | CNAME    |
+------+----------+
| 3001 | Cisneros |
| 3003 | Hoffman  |
| 3002 | Pereira  |
| 3005 | Liu      |
| 3006 | Cisneros |
| 3009 | Giovanni |
| 3007 | Grass    |
| 3008 | Clemens  |
| 3010 | Grass    |
| 3011 | Clemens  |
+------+----------+
48) Write a query that selects all the customers whose ratings are equal to or greater than ANY(in the SQL sense) of ‘Serres’.
49) Write two queries that will produce all orders taken on October 3 or October 4.
mysql> SELECT ONUM,AMT,ODATE,CNUM,SNUM
    -> FROM Orders
    -> WHERE ODATE = '1990-10-03' OR  ODATE = '1990-10-04';
+------+---------+------------+------+------+
| ONUM | AMT     | ODATE      | CNUM | SNUM |
+------+---------+------------+------+------+
| 3001 |   18.69 | 1990-10-03 | 2008 | 1007 |
| 3003 |  767.19 | 1990-10-03 | 2001 | 1001 |
| 3002 | 1900.10 | 1990-10-03 | 2007 | 1004 |
| 3005 | 5160.45 | 1990-10-03 | 2003 | 1002 |
| 3006 | 1098.16 | 1990-10-03 | 2008 | 1007 |
| 3009 | 1713.23 | 1990-10-04 | 2002 | 1003 |
| 3007 |   75.75 | 1990-10-04 | 2004 | 1002 |
+------+---------+------------+------+------+
50) Find only those customers whose ratings are higher than every customer in Rome.
mysql> SELECT CNUM,CNAME,CITY,RATING
    -> FROM Customers
    -> WHERE RATING >(SELECT MAX(RATING)
				    ->FROM Customers
				    -> WHERE CITY ='Rome');
+------+----------+---------+--------+
| CNUM | CNAME    | CITY    | RATING |
+------+----------+---------+--------+
| 2004 | Grass    | Berlin  |    300 |
| 2008 | Cisneros | SanJose |    300 |
+------+----------+---------+--------+
51) Write a query on the Customers table whose output will exclude all customers with a rating<= 100.00, unless they are located in Rome.
52) Find all rows from the customer’s table for which the salesperson number is 1001.
mysql> SELECT CNUM,CNAME,CITY,RATING,SNUM
    -> FROM Customers
    -> WHERE SNUM =(SELECT SNUM  
				  ->FROM Salespeople
				  -> WHERE SNUM = 1001);
+------+---------+--------+--------+------+
| CNUM | CNAME   | CITY   | RATING | SNUM |
+------+---------+--------+--------+------+
| 2001 | Hoffman | London |    100 | 1001 |
| 2006 | Clemens | London |    100 | 1001 |
+------+---------+--------+--------+------+
53) Find the total amount in orders for each salesperson where their total of amounts are greater than the amount of the largest order in the table.
mysql> SELECT SNUM, SUM(AMT) AS Total_AMT FROM Orders GROUP  BY SNUM HAVING SUM(AMT)>MAX(AMT);
+------+-----------+
| SNUM | Total_AMT |
+------+-----------+
| 1001 |  15382.07 |
| 1002 |   6546.15 |
| 1007 |   1116.85 |
+------+-----------+
54) Write a query that selects all orders save those with zeroes or NULL in the amount file.
mysql> SELECT ONUM FROM Orders WHERE AMT =0 OR AMT IS NULL;
Empty set (0.00 sec)
55) Produce all combinations of salespeople and customer names such that the former precedes the latter alphabetically, and the latter has a
rating of less than 200.

mysql> SELECT Salespeople.SNUM,Customers.CNAME,Customers.RATING    FROM Salespeople,Customers        WHERE Customers.SNUM=Salespeople.SNUM AND Customers.RATING<200;
+------+---------+--------+
| SNUM | CNAME   | RATING |
+------+---------+--------+
| 1001 | Hoffman |    100 |
| 1001 | Clemens |    100 |
| 1004 | Pereira |    100 |
+------+---------+--------+
56) Find all salespeople name and commission.
mysql> SELECT SNAME,COMM
    -> FROM Salespeople;
+---------+------+
| SNAME   | COMM |
+---------+------+
| Peel    |   12 |
| Serres  |   13 |
| AxelRod |   10 |
| Motika  |   11 |
| Rifkin  |   15 |
| Fran    |   25 |
+---------+------+
57) Write a query that produces the names and cities of all customers with the same rating as Hoffman. Write the query using Hoffman’s cnum
rather than his rating, so that it would still be usable if his rating is changed.
58) Find all salespeople for whom there are customers that follow them in alphabetical order.

59) Write a query that produces the names and ratings of all customers who have average orders.
mysql> SELECT CNAME,RATING FROM Customers WHERE RATING > (SELECT AVG(RATING) FROM Customers);
+----------+--------+
| CNAME    | RATING |
+----------+--------+
| Giovanni |    200 |
| Liu      |    200 |
| Grass    |    300 |
| Cisneros |    300 |
+----------+--------+
60) Find the SUM of all Amounts from the orders table.
mysql> SELECT SUM(AMT) AS Total_Amount FROM Orders;
+--------------+
| Total_Amount |
+--------------+
|     26658.40 |
+--------------+

61) Write a SELECT command that produces the order number, amount, and the date from rows in the order table.
mysql> SELECT ONUM,AMT,ODATE FROM Orders ;
+------+---------+------------+
| ONUM | AMT     | ODATE      |
+------+---------+------------+
| 3001 |   18.69 | 1990-10-03 |
| 3003 |  767.19 | 1990-10-03 |
| 3002 | 1900.10 | 1990-10-03 |
| 3005 | 5160.45 | 1990-10-03 |
| 3006 | 1098.16 | 1990-10-03 |
| 3009 | 1713.23 | 1990-10-04 |
| 3007 |   75.75 | 1990-10-04 |
| 3008 | 4723.00 | 1990-10-05 |
| 3010 | 1309.95 | 1990-10-06 |
| 3011 | 9891.88 | 1990-10-06 |
+------+---------+------------+
62) Count the number of non NULL rating fields in the Customers table (including repeats).

mysql> SELECT COUNT(RATING) FROM Customers WHERE RATING IS NOT NULL;
+---------------+
| COUNT(RATING) |
+---------------+
|             7 |
+---------------+
63) Write a query that gives the names of both the salesperson and the customer for each order after the order number.
mysql> SELECT ONUM,CNAME,SNAME FROM Salespeople,Customers, Orders WHERE Salespeople.SNUM = Customers.SNUM AND Orders.CNUM = Customers.CNUM;
+------+----------+---------+
| ONUM | CNAME    | SNAME   |
+------+----------+---------+
| 3003 | Hoffman  | Peel    |
| 3011 | Clemens  | Peel    |
| 3008 | Clemens  | Peel    |
| 3005 | Liu      | Serres  |
| 3010 | Grass    | Serres  |
| 3007 | Grass    | Serres  |
| 3009 | Giovanni | AxelRod |
| 3002 | Pereira  | Motika  |
| 3006 | Cisneros | Rifkin  |
| 3001 | Cisneros | Rifkin  |
+------+----------+---------+
64) List the commissions of all salespeople servicing customers in London.

mysql> SELECT Salespeople.SNUM,Salespeople.COMM,Customers.CITY,Customers.CNAME 
       FROM Salespeople,Customers 
       WHERE Salespeople.SNUM = Customers.SNUM AND Customers.CITY ='LonDon';
+------+------+--------+---------+
| SNUM | COMM | CITY   | CNAME   |
+------+------+--------+---------+
| 1001 |   12 | London | Hoffman |
| 1001 |   12 | London | Clemens |
+------+------+--------+---------+
65) Write a query using ANY or ALL that will find all salespeople who have no customers located in their city.
mysql> SELECT SNUM,SNAME
       FROM Salespeople 
       WHERE SNAME NOT IN (SELECT SNAME 
                           FROM Salespeople 
                           WHERE CITY = ANY (SELECT CITY 
											FROM Customers));
+------+---------+
| SNUM | SNAME   |
+------+---------+
| 1003 | AxelRod |
| 1007 | Rifkin  |
+------+---------+
66) Write a query using the EXISTS operator that selects all salespeople with customers located in their cities who are not assigned to them.
67) Write a query that selects all customers serviced by Peel or Motika. (Hint: The snum field relates the 2 tables to one another.)
68) Count the number of salespeople registering orders for each day. (If a salesperson has more than one order on a given day, he or she should
be counted only once.)
69) Find all orders attributed to salespeople who live in London.
mysql> SELECT ONUM FROM Orders WHERE SNUM in(SELECT SNUM FROM Salespeople WHERE CITY = 'London');
+------+
| ONUM |
+------+
| 3003 |
| 3008 |
| 3011 |
| 3002 |
+------+
70) Find all orders by customers not located in the same cities as their salespeople.
mysql> SELECT ONUM,AMT,ODATE 
       FROM Orders 
       WHERE SNUM  IN (SELECT Customers.SNUM 
                       FROM Customers,Salespeople 
                       WHERE Customers.CITY !=Salespeople.CITY);
+------+---------+------------+
| ONUM | AMT     | ODATE      |
+------+---------+------------+
| 3003 |  767.19 | 1990-10-03 |
| 3008 | 4723.00 | 1990-10-05 |
| 3011 | 9891.88 | 1990-10-06 |
| 3009 | 1713.23 | 1990-10-04 |
| 3005 | 5160.45 | 1990-10-03 |
| 3007 |   75.75 | 1990-10-04 |
| 3010 | 1309.95 | 1990-10-06 |
| 3001 |   18.69 | 1990-10-03 |
| 3006 | 1098.16 | 1990-10-03 |
| 3002 | 1900.10 | 1990-10-03 |
+------+---------+------------+
71) Find all salespeople who have customers with more than one current order.

mysql> SELECT DISTINCT SNUM 
       FROM Orders 
       WHERE CNUM IN (SELECT CNUM 
                      FROM Orders GROUP BY CNUM HAVING COUNT(ONUM)>1);
+------+
| SNUM |
+------+
| 1001 |
| 1002 |
| 1007 |
+------+
72) Write a query that extracts from the customer’s table every customer assigned to a salesperson, who is currently having at least one another
customer(besides the customer being selected) with orders in the Orders Table.
73) Write a query on the customer’s table that will find the highest rating in each city. Put the output in this form: for the city (city), the highest
rating is (rating).
mysql> SELECT CITY,MAX(RATING) AS Highest_Rating FROM Customers GROUP BY CITY;
+---------+----------------+
| CITY    | Highest_Rating |
+---------+----------------+
| London  |            100 |
| Rome    |            200 |
| SanJose |            300 |
| Berlin  |            300 |
+---------+----------------+
74) Write a query that will produce the snum values of all salespeople with orders, having amt greater than 1000 in the Orders Table(without
repeats).
mysql> SELECT Salespeople.SNUM,Orders.ONUM,Orders.AMT FROM Salespeople,Orders WHERE Salespeople.SNUM=Orders.SNUM AND Orders.AMT>1000;
+------+------+---------+
| SNUM | ONUM | AMT     |
+------+------+---------+
| 1004 | 3002 | 1900.10 |
| 1002 | 3005 | 5160.45 |
| 1007 | 3006 | 1098.16 |
| 1003 | 3009 | 1713.23 |
| 1001 | 3008 | 4723.00 |
| 1002 | 3010 | 1309.95 |
| 1001 | 3011 | 9891.88 |
+------+------+---------+
75) Write a query that lists customers in a descending order of rating. Output the rating field first, followed by the customer’s names and numbers.
mysql> SELECT RATING,CNUM,CNAME FROM Customers ORDER BY RATING DESC;
+--------+------+----------+
| RATING | CNUM | CNAME    |
+--------+------+----------+
|    300 | 2004 | Grass    |
|    300 | 2008 | Cisneros |
|    200 | 2002 | Giovanni |
|    200 | 2003 | Liu      |
|    100 | 2001 | Hoffman  |
|    100 | 2006 | Clemens  |
|    100 | 2007 | Pereira  |
+--------+------+----------+
76) Find the average commission for salespeople in London.
mysql> SELECT CITY,AVG(COMM) AS COMMISSION FROM Salespeople WHERE CITY = 'LonDon';
+--------+------------+
| CITY   | COMMISSION |
+--------+------------+
| London |    16.0000 |
+--------+------------+
77) Find all orders credited to the same salesperson who services Hoffman.(cnum 2001).
mysql> SELECT Orders.ONUM,Customers.SNUM FROM Orders,Customers WHERE Orders.SNUM=Customers.SNUM AND Customers.CNAME='Hoffman';
+------+------+
| ONUM | SNUM |
+------+------+
| 3003 | 1001 |
| 3008 | 1001 |
| 3011 | 1001 |
+------+------+
78) Find all salespeople whose commission is in between 0.10 and 0.12(both inclusive).
mysql> SELECT SNUM,SNAME,CITY,COMM FROM Salespeople WHERE COMM BETWEEN 10 AND 12;
+------+---------+----------+------+
| SNUM | SNAME   | CITY     | COMM |
+------+---------+----------+------+
| 1001 | Peel    | London   |   12 |
| 1003 | AxelRod | New York |   10 |
| 1004 | Motika  | London   |   11 |
+------+---------+----------+------+
79) Write a query that will give you the names and cities of all salespeople in London with a commission above 0.10.
mysql> SELECT SNAME,CITY,COMM FROM Salespeople WHERE CITY ='LonDon' and COMM>10;
+--------+--------+------+
| SNAME  | CITY   | COMM |
+--------+--------+------+
| Peel   | London |   12 |
| Motika | London |   11 |
| Fran   | London |   25 |
+--------+--------+------+
80) Write a query that selects each customer’s smallest order.

mysql> SELECT CNUM,MIN(AMT) AS MIN FROM Orders GROUP BY CNUM;
+------+---------+
| CNUM | MIN     |
+------+---------+
| 2008 |   18.69 |
| 2001 |  767.19 |
| 2007 | 1900.10 |
| 2003 | 5160.45 |
| 2002 | 1713.23 |
| 2004 |   75.75 |
| 2006 | 4723.00 |
+------+---------+
81) Write a query that selects the first customer in alphabetical order whose name begins with ‘G’.
mysql> SELECT MIN(CNAME) FROM Customers WHERE CNAME LIKE 'G%';
+------------+
| MIN(CNAME) |
+------------+
| Giovanni   |
+------------+
82) Write a query that counts the number of different non NULL city values in the customers table.
83) Find the average amount from the Orders Table.
mysql> SELECT AVG(AMT) AS AMOUNT FROM Orders;
+-------------+
| AMOUNT      |
+-------------+
| 2665.840000 |
+-------------+
84) Find all customers who are not located in SanJose and whose rating is above 200.
mysql> SELECT CNUM,CNAME,CITY,RATING FROM Customers WHERE CITY!='SanJose' AND RATING>200;
+------+-------+--------+--------+
| CNUM | CNAME | CITY   | RATING |
+------+-------+--------+--------+
| 2004 | Grass | Berlin |    300 |
+------+-------+--------+--------+
85) Give a simpler way to write this query.SELECT snum, sname, city, comm FROM salespeople WHERE (comm > + 0.12 OR comm < 0.14);
mysql> SELECT SNUM,SNAME,CITY,COMM FROM Salespeople WHERE (COMM > + 12 OR COMM < 14);
+------+---------+-----------+------+
| SNUM | SNAME   | CITY      | COMM |
+------+---------+-----------+------+
| 1001 | Peel    | London    |   12 |
| 1002 | Serres  | SanJose   |   13 |
| 1003 | AxelRod | New York  |   10 |
| 1004 | Motika  | London    |   11 |
| 1007 | Rifkin  | Barcelona |   15 |
| 1008 | Fran    | London    |   25 |
+------+---------+-----------+------+
86) Which salespersons attend to customers not in the city they have been assigned to?
87) Which salespeople get commission greater than 0.11 are serving customers rated less than 250?
mysql> SELECT SNUM,SNAME 
       FROM Salespeople 
       WHERE COMM > 11 AND SNUM IN (SELECT SNUM 
                                    FROM Customers 
                                    WHERE RATING < 250);
+------+--------+
| SNUM | SNAME  |
+------+--------+
| 1001 | Peel   |
| 1002 | Serres |
+------+--------+
88) Which salespeople have been assigned to the same city but get different commission percentages?
mysql> SELECT DISTINCT  T1.SNUM,T1.SNAME,T1.CITY,T1.COMM 
       FROM Salespeople T1,Salespeople T2 
       WHERE T1.CITY = T2.CITY AND T1.COMM<>T2.COMM;
+------+--------+--------+------+
| SNUM | SNAME  | CITY   | COMM |
+------+--------+--------+------+
| 1008 | Fran   | London |   25 |
| 1004 | Motika | London |   11 |
| 1001 | Peel   | London |   12 |
+------+--------+--------+------+
89) Which salesperson has earned the maximum commission?

mysql> SELECT SNUM,SNAME,COMM 
	   FROM Salespeople  
       WHERE COMM IN (SELECT MAX(COMM) 
                      FROM Salespeople);
+------+-------+------+
| SNUM | SNAME | COMM |
+------+-------+------+
| 1008 | Fran  |   25 |
+------+-------+------+
90) Does the customer who has placed the maximum number of orders have the maximum rating?
91) List all customers in descending order of customer rating.
mysql> SELECT CNUM,CNAME,CITY,RATING,SNUM FROM Customers ORDER BY RATING DESC;
+------+----------+---------+--------+------+
| CNUM | CNAME    | CITY    | RATING | SNUM |
+------+----------+---------+--------+------+
| 2004 | Grass    | Berlin  |    300 | 1002 |
| 2008 | Cisneros | SanJose |    300 | 1007 |
| 2002 | Giovanni | Rome    |    200 | 1003 |
| 2003 | Liu      | SanJose |    200 | 1002 |
| 2001 | Hoffman  | London  |    100 | 1001 |
| 2006 | Clemens  | London  |    100 | 1001 |
| 2007 | Pereira  | Rome    |    100 | 1004 |
+------+----------+---------+--------+------+
92) On which days has Hoffman placed orders?
mysql> SELECT Customers.CNUM,Customers.CNAME,Orders.ONUM,Orders.ODATE 
	   FROM Customers, Orders 
       WHERE Customers.SNUM=Orders.SNUM AND Customers.CNAME='Hoffman';
+------+---------+------+------------+
| CNUM | CNAME   | ONUM | ODATE      |
+------+---------+------+------------+
| 2001 | Hoffman | 3003 | 1990-10-03 |
| 2001 | Hoffman | 3008 | 1990-10-05 |
| 2001 | Hoffman | 3011 | 1990-10-06 |
+------+---------+------+------------+
93) Which salesmen have no orders between 10/03/1990 and 10/05/1990?
mysql>  SELECT SNUM,SNAME 
        FROM Salespeople 
        WHERE SNUM IN(SELECT SNUM 
					  FROM Orders 
                      WHERE ODATE NOT IN (SELECT ODATE 
										  FROM Orders 
                                          WHERE ODATE BETWEEN '1990-10-03' AND '1990-10-05'));
+------+--------+
| SNUM | SNAME  |
+------+--------+
| 1001 | Peel   |
| 1002 | Serres |
+------+--------+
94) How many salespersons have succeeded in getting orders?
95) How many customers have placed orders?
mysql> SELECT COUNT(CNUM) AS Customers 
       FROM Customers 
       WHERE CNUM IN(SELECT CNUM 
					 FROM Orders 
                     WHERE Customers.CNUM=Orders.CNUM);
+-----------+
| Customers |
+-----------+
|         7 |
+-----------+
96) On which date has each salesman booked an order of maximum value?

mysql>  SELECT  SNAME,ODATE,ONUM,AMT 
        FROM Orders,Salespeople  
        WHERE Salespeople.SNUM =Orders.SNUM AND AMT IN(SELECT MAX(AMT) 
                                                       FROM Orders GROUP BY SNUM);
+---------+------------+------+---------+
| SNAME   | ODATE      | ONUM | AMT     |
+---------+------------+------+---------+
| Motika  | 1990-10-03 | 3002 | 1900.10 |
| Serres  | 1990-10-03 | 3005 | 5160.45 |
| Rifkin  | 1990-10-03 | 3006 | 1098.16 |
| AxelRod | 1990-10-04 | 3009 | 1713.23 |
| Peel    | 1990-10-06 | 3011 | 9891.88 |
+---------+------------+------+---------+
97) Who is the most successful salesperson?
98) Which customers have the same rating?
mysql> SELECT DISTINCT T1.CNUM,T1.CNAME,T1.RATING FROM Customers T1,Customers T2 WHERE T1.SNUM = T2.SNUM AND T1.RATING=T2.RATING;
+------+----------+--------+
| CNUM | CNAME    | RATING |
+------+----------+--------+
| 2001 | Hoffman  |    100 |
| 2002 | Giovanni |    200 |
| 2003 | Liu      |    200 |
| 2004 | Grass    |    300 |
| 2006 | Clemens  |    100 |
| 2008 | Cisneros |    300 |
| 2007 | Pereira  |    100 |
+------+----------+--------+
99) Find all orders greater than the average for October 4th.
mysql> SELECT ONUM,AMT,ODATE FROM Orders WHERE AMT>(SELECT AVG(AMT) FROM Orders WHERE ODATE='1990-10-04' GROUP BY ODATE);
+------+---------+------------+
| ONUM | AMT     | ODATE      |
+------+---------+------------+
| 3002 | 1900.10 | 1990-10-03 |
| 3005 | 5160.45 | 1990-10-03 |
| 3006 | 1098.16 | 1990-10-03 |
| 3009 | 1713.23 | 1990-10-04 |
| 3008 | 4723.00 | 1990-10-05 |
| 3010 | 1309.95 | 1990-10-06 |
| 3011 | 9891.88 | 1990-10-06 |
+------+---------+------------+
100) List all customers with ratings above Grass’s average.
101) Which customers have above average orders?
102) Select the total amount in orders for each salesperson for which the total is greater than the amount of the largest order in the table.
mysql> SELECT SNUM,SUM(AMT) FROM Orders GROUP BY SNUM HAVING SUM(AMT)>(SELECT MAX(AMT) FROM Orders);
+------+----------+
| SNUM | SUM(AMT) |
+------+----------+
| 1001 | 15382.07 |
+------+----------+
103) Give names and numbers of all salespersons that have more than one customer?
mysql> SELECT SNUM,SNAME FROM Salespeople WHERE SNUM IN(SELECT SNUM FROM Customers GROUP BY SNUM HAVING COUNT(SNUM)>1);
+------+--------+
| SNUM | SNAME  |
+------+--------+
| 1001 | Peel   |
| 1002 | Serres |
+------+--------+
104) Select all salespeople by name and number who have customers in their city whom they don’t service.
mysql> SELECT Salespeople.SNUM,Salespeople.SNAME
	   FROM Salespeople,Customers 
       WHERE Salespeople.SNUM!=Customers.SNUM AND Salespeople.CITY=Customers.CITY;
+------+--------+
| SNUM | SNAME  |
+------+--------+
| 1008 | Fran   |
| 1004 | Motika |
| 1008 | Fran   |
| 1004 | Motika |
| 1002 | Serres |
+------+--------+
105) Does the total amount in orders by customer in Rome and London, exceed the commission paid to salesperson in London, and New York by
more than 5 times?
106) Which are the date, order number, amt and city for each salesperson (by name) for themaximum order he has obtained?

mysql> SELECT SNAME,ODATE,ONUM,AMT,CITY 
       FROM Orders,Salespeople  
       WHERE Orders.SNUM=Salespeople.SNUM AND AMT IN (SELECT MAX(AMT) 
                                                      FROM Orders GROUP BY SNUM);
+---------+------------+------+---------+-----------+
| SNAME   | ODATE      | ONUM | AMT     | CITY      |
+---------+------------+------+---------+-----------+
| Motika  | 1990-10-03 | 3002 | 1900.10 | London    |
| Serres  | 1990-10-03 | 3005 | 5160.45 | SanJose   |
| Rifkin  | 1990-10-03 | 3006 | 1098.16 | Barcelona |
| AxelRod | 1990-10-04 | 3009 | 1713.23 | New York  |
| Peel    | 1990-10-06 | 3011 | 9891.88 | London    |
+---------+------------+------+---------+-----------+
107) Which salesperson is having lowest commission?
mysql> SELECT SNUM,SNAME,COMM FROM Salespeople WHERE COMM IN(SELECT MIN(COMM) FROM Salespeople );
+------+---------+------+
| SNUM | SNAME   | COMM |
+------+---------+------+
| 1003 | AxelRod |   10 |
+------+---------+------+

