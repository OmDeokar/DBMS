/*update salary of customer table by 10% and store it in customer dump table and also count the age of employee by date of birth*/
delimiter //
create procedure proc_copy()
begin
	declare vfinished int default 0;
	declare i int;
	declare n varchar(25);
	declare dn int;
	declare gr varchar(50);
	declare d date;
	declare a int;
	
declare cust_cursor cursor for select * from customer;
declare continue handler for not found set vfinished=1;

open cust_cursor;
getdata:loop
     fetch  cust_cursor into i,n,dn,gr,d,a;
     if vfinished=1 then
     leave getdata;
     end if;
     set dn=dn+dn*0.1;
     set a=year(curdate())-year(d);
    insert into cust_dump values(i,n,dn,gr,d,a);
   
    end loop getdata;
    close cust_cursor;
    end;
    //
 
/* Database changed
mysql> source /home/student/ass7_38.sql
Query OK, 0 rows affected (0.13 sec)

mysql> select * from customer;
    -> //
+-----+-------+---------+--------+------------+------+
| cid | cname | camount | clevel | dob        | age  |
+-----+-------+---------+--------+------------+------+
|   1 | a     |   54000 | first  | 2003-05-07 | NULL |
|   2 | b     |   35000 | first  | 2004-08-09 | NULL |
|   3 | c     |   23000 | second | 2005-07-09 | NULL |
|   4 | d     |    2000 | second | 2001-01-09 | NULL |
|   5 | f     |   57000 | third  | 2008-01-09 | NULL |
+-----+-------+---------+--------+------------+------+
5 rows in set (0.00 sec)

mysql> select * from cust_dump;
    -> //
Empty set (0.00 sec)

mysql> call proc_copy();
    -> //
Query OK, 0 rows affected (0.48 sec)

mysql> select * from cust_dump;
    -> //
+-----+-------+---------+--------+------------+------+
| cid | cname | camount | clevel | dob        | age  |
+-----+-------+---------+--------+------------+------+
|   1 | a     |   59400 | first  | 2003-05-07 |   20 |
|   2 | b     |   38500 | first  | 2004-08-09 |   19 |
|   3 | c     |   25300 | second | 2005-07-09 |   18 |
|   4 | d     |    2200 | second | 2001-01-09 |   22 |
|   5 | f     |   62700 | third  | 2008-01-09 |   15 |
+-----+-------+---------+--------+------------+------+
5 rows in set (0.00 sec)
  */ 
    
