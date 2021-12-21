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

mysql> SELECT SNUM ,ODATE,MAX(AMT) AS MAX_AMT FROM ORDERS GROUP BY ODATE,SNUM;
+------+------------+---------+
| SNUM | ODATE      | MAX_AMT |
+------+------------+---------+
| 1007 | 1990-10-03 | 1098.16 |
| 1001 | 1990-10-03 |  767.19 |
| 1004 | 1990-10-03 | 1900.10 |
| 1002 | 1990-10-03 | 5160.45 |
| 1003 | 1990-10-04 | 1713.23 |
| 1002 | 1990-10-04 |   75.75 |
| 1001 | 1990-10-05 | 4723.00 |
| 1002 | 1990-10-06 | 1309.95 |
| 1001 | 1990-10-06 | 9891.88 |
+------+------------+---------+
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

mysql> SELECT c.SNUM,s.SNAME,COUNT(*) AS Customer_NO FROM Customers c, Salespeople s WHERE  c.SNUM = s.SNUM GROUP BY c.SNUM;
+------+---------+-------------+
| SNUM | SNAME   | Customer_NO |
+------+---------+-------------+
| 1001 | Peel    |           2 |
| 1002 | Serres  |           2 |
| 1003 | AxelRod |           1 |
| 1004 | Motika  |           1 |
| 1007 | Rifkin  |           1 |
+------+---------+-------------+
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
mysql> SELECT DISTINCT c1.CNUM, c1.CNAME, c1.CITY, c1.RATING, c1.SNUM FROM Customers AS c1,Customers AS c2 WHERE c1.CITY='Sanjose' AND c2.CITY ='Sanjose';
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
mysql> SELECT ODATE,SUM(AMT) AS Total_AMT FROM Orders GROUP BY ODATE;
+------------+-----------+
| ODATE      | Total_AMT |
+------------+-----------+
| 1990-10-03 |   8944.59 |
| 1990-10-04 |   1788.98 |
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

 SELECT SNUM,SNAME,CITY,COMM FROM Salespeople s WHERE EXISTS (SELECT SNUM,RATING  FROM Customers c WHERE c.SNUM = s.SNUM AND RATING = 300);
+------+--------+-----------+------+
| SNUM | SNAME  | CITY      | COMM |
+------+--------+-----------+------+
| 1002 | Serres | SanJose   |   13 |
| 1007 | Rifkin | Barcelona |   15 |
+------+--------+-----------+------+
18) Find all customers whose cnum is 1000 above the snum of Serres.

mysql> SELECT Customers.CNUM,Customers.CNAME FROM Customers,Salespeople WHERE Customers.SNUM = Salespeople.SNUM AND Customers.CNUM > Salespeople.SNUM+1000;
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
mysql> SELECT o.SNUM,o.ODATE,SUM(O.AMT) AS Largest_Orders FROM Orders o,Salespeople s WHERE  o.SNUM =s.SNUM AND o.AMT > 3000 GROUP BY o.ODATE;
+------+------------+----------------+
| SNUM | ODATE      | Largest_Orders |
+------+------------+----------------+
| 1002 | 1990-10-03 |        5160.45 |
| 1001 | 1990-10-05 |        4723.00 |
| 1001 | 1990-10-06 |        9891.88 |
+------+------------+----------------+
21) List all the largest orders for October 3, for each salesperson.
mysql> SELECT o.SNUM,o.ODATE,SUM(O.AMT) AS Largest_Orders FROM Orders o,Salespeople s WHERE  o.SNUM =s.SNUM AND o.ODATE = ' 1990-10-03 ' GROUP BY o.SNUM;
+------+------------+----------------+
| SNUM | ODATE      | Largest_Orders |
+------+------------+----------------+
| 1007 | 1990-10-03 |        1116.85 |
| 1001 | 1990-10-03 |         767.19 |
| 1004 | 1990-10-03 |        1900.10 |
| 1002 | 1990-10-03 |        5160.45 |
+------+------------+----------------+

22) Find all customers located in cities where Serres has customers.
mysql> SELECT CNUM,CNAME,CITY FROM Customers WHERE SNUM IN (SELECT SNUM FROM Salespeople WHERE SNUM = 1002);
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
26) Find salespeople who have multiple customers.
27) Find salespeople with customers located in their own cities.
mysql> SELECT s.SNAME,c.CNAME,s.CITY FROM Salespeople s JOIN  Customers c ON s.CITY = c.CITY ORDER BY  c.city;
+--------+----------+---------+
| SNAME  | CNAME    | CITY    |
+--------+----------+---------+
| Fran   | Hoffman  | London  |
| Motika | Hoffman  | London  |
| Peel   | Hoffman  | London  |
| Fran   | Clemens  | London  |
| Motika | Clemens  | London  |
| Peel   | Clemens  | London  |
| Serres | Liu      | SanJose |
| Serres | Cisneros | SanJose |
+--------+----------+---------+
mysql> SELECT s.SNAME,c.CNAME,s.CITY FROM Salespeople s,Customers c WHERE s.SNUM = c.SNUM AND s.CITY = c.CITY;
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
mysql> SELECT  SNUM,MAX(AMT) FROM Orders GROUP BY SNUM  HAVING  SNUM IN (SELECT SNUM FROM Salespeople  WHERE SNAME ='serres' OR  SNAME = 'Rifkin');
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
mysql> SELECT ONUM,AMT,ODATE,CNUM,SNUM FROM Orders WHERE AMT <(SELECT MAX(AMT) FROM Orders WHERE SNUM = (SELECT SNUM FROM Salespeople WHERE CITY ='SanJose'));
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
47) Write a query that lists each order number followed by the name of the customer who made that order.
48) Write a query that selects all the customers whose ratings are equal to or greater than ANY(in the SQL sense) of ‘Serres’.
49) Write two queries that will produce all orders taken on October 3 or October 4.
50) Find only those customers whose ratings are higher than every customer in Rome.
51) Write a query on the Customers table whose output will exclude all customers with a rating<= 100.00, unless they are located in Rome.
52) Find all rows from the customer’s table for which the salesperson number is 1001.
53) Find the total amount in orders for each salesperson where their total of amounts are greater than the amount of the largest order in the table.
54) Write a query that selects all orders save those with zeroes or NULL in the amount file.
55) Produce all combinations of salespeople and customer names such that the former precedes the latter alphabetically, and the latter has a
rating of less than 200.
56) Find all salespeople name and commission.
57) Write a query that produces the names and cities of all customers with the same rating as Hoffman. Write the query using Hoffman’s cnum
rather than his rating, so that it would still be usable if his rating is changed.
58) Find all salespeople for whom there are customers that follow them in alphabetical order.
59) Write a query that produces the names and ratings of all customers who have average orders.
60) Find the SUM of all Amounts from the orders table.

