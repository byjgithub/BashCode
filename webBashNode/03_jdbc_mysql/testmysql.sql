#DDL 数据库定义语言
#1.创建数据库: CREATE DATABASE 数据库名;
	CREATE DATABASE testmysql;
#2.删除数据库： DROP DATABASE 数据库名;
	DROP DATABASE testmysql;
#3,。查看服务器中所有数据库： SHOW DATABASES;
	SHOW DATABASES;
#4.查看某个数据库的定义信息： SHOW CREATE DATABASE 数据库名;
	SHOW CREATE DATABASE testmysql;
#5.切换数据库： USE 数据库名;
	USE mysql;
#6.查看正在使用的数据库：select database();
	SELECT DATABASE();

#DML 数据操作语言(表操作)
#1.创建表
-- 	create table `表名`(
--		字段 类型(长度) 约束,
--		字段 类型(长度) 约束
-- 	)[表选项];
--	单表约束：primary key（主键约束）、unique（唯一约束）、not null（非空约束）
--	表选项：【charset=字符集】
	CREATE TABLE `user`(
		`uid` TINYINT(3) PRIMARY KEY,	 # 字段 uid，varchar类型，最大18位，主键（唯一非空）
		`uname` varchar(20) not null,	 # 字段 uname，varchar类型，最大20位，非空
		`password` varchar(20) not null  # 字段 password，varchar类型，最大20位，非空
	);

#2. 查看表
#2.1 查看数据库中的所有表： show tables；
	show tables;
#2.2 查看数据库中部分表： show tables like '匹配模式';
	show tables like '%user%';
#2.2. 查看表结构(3种方式)： desc 表名;   DESCRIBE 表名;   SHOW COLUMNS FROM 表名;
	DESC `user`;
	DESCRIBE `user`;
	show columns from `user`;	
#2.3 查看创建表信息: SHOW CREATE TABLE 表名;
	show create table `copyuser`;

#3. 删除表： drop table 表名1,表名2...；(可同时删除多个表)
	DROP TABLE `user`,`copyuser`;

#4. 修改表
#4.1 添加列： alter table 表名 add column 列名 类型(长度) 约束 位置;
#参数解析：column关键字可省略	位置：first（第一位）、after 字段名（放在字段后）、默认放到最后一位(不写)
	alter table `user` add uage varchar(3); 
#4.2 修改表的类型长度及约束： ALTER TABLE 表名 MODIFY 字段 类型(长度) 约束;
	alter table `user` modify uage varchar(4);
#4.3 修改列名：  ALTER TABLE 表名 change 旧字段名 新字段名 类型(长度) 约束;
	alter table `user` change `password` `upassword` varchar(30) not null;
#4.4 删除列： 	 ALTER TABLE 表名 drop 列名;
	alter table `copyUser` drop `uage`;
#4.5 修改表名: RENAME TABLE 旧表名 to 新表名;
	rename table `copyUser` to `copyuser`;
#4.6 修改字符集：
	alter table `copyuser` character set 'utf8'; 
#4.7 为字段添加约束条件： alter table 表 add 约束(字段);
# 约束条件共六个：主键(primary key)、唯一(unique)、非空(not null)、
# 		  自动增长(auto_increment)、默认值(defualt)、字段描述(comment)
	alter table `user` add auto_increment(uid);
	
#5.复制表，只能复制表结构，不能复制表中数据： create table 新表名 like 数据库.表名;
	create table copyuser like testmysql.`user`;


#DDL表数据操作语言
#1.插入数据insert
#1.1 插入部分数据： insert into 表(column1,column2,...)values(value1,value2,...); 
	insert into `user`(uid,uname,`password`)values(1,"小明",'111111');
#1.2 插入表字段全部数据： insert into 表 values(字段值); 字段值按字段顺序依次全部输入
	insert into `user` values("2","小白","123456");

#2更新记录update
#2.1 无条件更新，系统会将所有数据设置为统一的值：update 表 set column1=newValue1,column2=newValue2,...;
	update `user` set `password`='123456789';	#将所有用户的密码设置为诶123456789
#2.2 根据条件更新某一条数据： update 表 set column1=newValue1,column2=newValue2,...where 条件;
	update `user` set `password`='111111',uname='小呆' where uid=1;

#3.删除数据
#3.1 delete 删除数据： DELETE FROM 表 WHERE 条件;
	delete from `user` where uid =1;
#3.2 truncate 删除数据： 









































