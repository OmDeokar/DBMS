/*update salary of customer table by 10% and store it in customer dump table*/
delimiter //
create procedure proc_copy()
begin
	declare vfinished int default 0;
	declare i int;
	declare n varchar(25);
	declare dn int;
	declare gr varchar(50);
	
declare cust_cursor cursor for select * from customer;
declare continue handler for not found set vfinished=1;

open cust_cursor;
getdata:loop
     fetch  cust_cursor into i,n,dn,gr;
     if vfinished=1 then
     leave getdata;
     end if;
     set dn=dn+dn*0.1;
    insert into cust_dump values(i,n,dn,gr);
   
    end loop getdata;
    close cust_cursor;
    end;
    //
    
   
    
/*mysql> truncate cust_dump;
Query OK, 0 rows affected (1.14 sec)

mysql> select * from cust_dump;
Empty set (0.01 sec)

mysql> select * from customer;
+-----+-------+---------+--------+
| cid | cname | camount | clevel |
+-----+-------+---------+--------+
|   1 | a     |   54000 | first  |
|   2 | b     |   35000 | first  |
|   3 | c     |   23000 | second |
|   4 | d     |    2000 | second |
|   5 | f     |   57000 | third  |
+-----+-------+---------+--------+
5 rows in set (0.00 sec)

mysql> call proc_copy();
ERROR 1305 (42000): PROCEDURE sy.proc_copy does not exist
mysql> source /home/student/ass7_38.sql
Query OK, 0 rows affected (0.14 sec)

mysql> call proc_copy();
    -> //
Query OK, 0 rows affected (0.67 sec)

mysql> select * from cust_dump;
    -> //
+-----+-------+---------+--------+
| cid | cname | camount | clevel |
+-----+-------+---------+--------+
|   1 | a     |   59400 | first  |
|   2 | b     |   38500 | first  |
|   3 | c     |   25300 | second |
|   4 | d     |    2200 | second |
|   5 | f     |   62700 | third  |
+-----+-------+---------+--------+
5 rows in set (0.00 sec)

*/
    
    
    
