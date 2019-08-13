# mysql-utils
A utilities set for mysql.
The shell mysql-login.sh is only applied to platform wisecloud.

How to use this shell:

1. Clone the project to your local directory on linux.
   git clone https://github.com/solomonxu/mysql-utils.git
   cd mysql-utils/bin
   chmod a+x mysql-login.sh
   
2. Or, download mysql-login.sh directly.
   wget https://raw.githubusercontent.com/solomonxu/mysql-utils/master/bin/mysql-login.sh; chmod a+x mysql-login.sh
   
3. Run shell, login to MySQL.
   cd bin
   ./mysql-login.sh
  
4. Run SQL.

   Input any SQL to check data.

   select count(*) from application;

   The results as followed.

MySQL [orchestration]> select count(*) from application;
+----------+
| count(*) |
+----------+
|       31 |
+----------+
1 row in set (0.00 sec)


