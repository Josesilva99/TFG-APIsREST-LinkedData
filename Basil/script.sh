service mysql start
echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'jose';">usuario.txt
echo "CREATE DATABASE basil;">crear.sql
mysql --host=localhost --user=root --password=jose < usuario.txt
mysql --host=localhost --user=root --password=jose < crear.sql
mysql --host=localhost --user=root --password=jose --database=basil < ./tmp/basil-0.8.0/db.sql 
