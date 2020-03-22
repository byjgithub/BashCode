# 一、MySQL入门

## 1、 数据库介绍

1.1关系型数据库

Oracle：甲骨文公司，收费，大型网站使用

Mysql：开源免费，被sun公司收购后开始收费，中小型企业优选

  DB2：银行企业

  SQLserver：政府网站asp.net，大学教学通常采用SqlServer，图形化工具做的不错。

1.2 非关系型数据库 key:value

  Mongodb：

  Redis：

 

## 2、E-R关系

  E-R关系图主要是用来描述实体与实体之间的关系。

  方框：代表实体

  椭圆：代表实体的属性

  菱形：代表实体与实体之间的关系

## 3、Mysql服务器

  Mysql数据库：数据库管理软件

  服务器：就是一台电脑，这些电脑会安装一些软件，这些软件会监听不同的端口号，根据用户访问的端口号，提供不同的服务。

 



 

# 二、MySQL的安装与卸载

## 1、MySQL卸载

1.1 打开控制面板，卸载MySQL服务器。

1.2 删除MySQL安装目录的所有文件： C:\Program Files\MySQL

1.3 删除MySQL数据库存放文件： C:\ProgranData\MySQL

 

## 2、安装

查看安装教程：https://www.cnblogs.com/liuzengzhi/p/11704069.html

![img](file:///C:\Users\ADMINI~1\AppData\Local\Temp\msohtmlclip1\01\clip_image001.png)

## 3、重置root密码

  方法1:   

​		在my.ini的[mysqld]字段加入：  skip-grant-tables  重启mysql服务，这时的mysql不需要密码即可登录数据库   

​		然后进入mysql  mysql>use  mysql;   

​		mysql>更新 update user set  password=password('新密码') WHERE  User='root';  

​		mysql>flush  privileges;   

​		运行之后最后去掉my.ini中的skip-grant-tables，重启mysqld即可。       

 

方法2:   

​		不使用修改my.ini重启服务的方法，通过非服务方式加skip-grant-tables运行mysql来修改mysql密码   

​		停止mysql服务   

​		打开命令行窗口，在bin目录下使用mysqld-nt.exe启动，

​		即在命令行窗口执行: mysqld-nt  --skip-grant-tables   

​		然后另外打开一个命令行窗口，登录mysql，此时无需输入mysql密码即可进入。   

​		按以上方法修改好密码后,关闭命令行运行mysql的那个窗口，此时即关闭了mysql，

​		如果发现mysql仍在运行   的话可以结束掉对应进程来关闭。   

​		启动mysql服务  



## 4、命令行下插入中文乱码问题

  4.1临时解决方案

   Set names gbk;相当于是告诉Mysql服务软件，我们当前在命令行输入的是GBK编码，当命令窗口关闭后，在输入中文还是会存在问题。

  4.2永久解决方案

修改my.in配置文件(在mysql安装路径中)：

l 暂停mysql服务

l 在mysql安装路径中找到my.in配置文件

# 三、Mysql语句

## 1、SQL分类

1.1 SQL：structure query language 结构化查询语言

1.2 DDL：数据定义语言：定义数据库、数据表的结构，关键字：创建(create)、修改(alter)、删除（drop）

1.3 DML：数据操纵语言：主要是用来操纵表中的数据(记录)，关键字：插入(insert)、更新(update)、删除(delete)

1.4 DCL：数据控制语言：定义访问权限，取消访问权限，安全设置，grant

1.5 DQL：数据查询语言：主要是用来查询表中数据(记录)，select(查询)、from(表)、where(条件)

 

 

## 2、登录和退出MySQL服务器

2.1 启动与关闭mysql服务

  启动mysql服务：net start msyql

  关闭mysql服务：net stop mysql 

2.2登录与退出mysql服务器

  登录mysql服务器： mysql –h –uroot –proot

  退出mysql服务器：exit; 或 \q 或 quit;

 



 

# 四、数据库的CRUD操作

## 1、创建数据库

1.1 创建数据库

  CREATE DATABASE 数据库名;

CREATE DATABASE day06;

1.2 创建数据库 并指定字符编码

CREATE DATABASE 数据库名  CHARACTER SET 字符集编码;

CREATE DATABASE day06_1 CHARACTER SET utf8;

1.3 创建数据库 并指定字符编码 并指定校对规则

CREATE DATABASE 数据库名 CHARACTER SET 字符集编码 COLLATE 校对规则;

CREATE DATABASE day06_2 CHARACTER SET utf8 COLLATE utf8_bin;

 

 

## 2、查看数据库

2.1 查看所有数据库

  SHOW DATABASES;

![img](file:///C:\Users\ADMINI~1\AppData\Local\Temp\msohtmlclip1\01\clip_image003.jpg)

2.2 查看数据库定义语句(创建语句)

  SHOW CREATE DATABASE 数据库名;

SHOW CREATE DATABASE day06_2;

 

## 3、修改数据库操作

3.1 修改数据库字符集

  ALTER DATABASE 数据库名 CHARACTER SET 字符集;

  ALTER DATABASE day06_1 CHARACTER SET gbk;

 

 

## 4、删除数据库操作

4.删除数据库

  DROP DATABASE 数据库名字;

  DROP DATABASE day06;

 

 

# 五、表的CRUD操作

## 1、创建表

### 1.1 语法：

create table 表名(

列名1 数据类型(长度) 约束,

列名2 数据长度(长度) 约束,

......

)engine=innodb auto_increment=1 default character = utf8;

### 1.2 案例实现

  CREATE  TABLE student(      

​		sid  INT PRIMARY KEY AUTO_INCREMENT COMMENT'学号',      

​		sname  VARCHAR(31) COMMENT'姓名',      

​		age  INT COMMENT'年龄',      

​		sex  INT COMMENT'性别：1男,2女'  

​	)ENGINE=INNODB  AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;  

 

### 1.3 参数说明

 engine=innodb 表的引擎类型，MySQL5.6开始默认使用innodb引擎

 auto_increment=1 自增键的起始序列号从1开始自增

 default charset=utf8 默认字符集是utf8

### 1.4 列的数据类型

  JAVA								MySQL

  int           						int  

  char/String					char/varchar

​              									 char：固定长度

​               									varcahr：可变长度

​                									char(3)  	一   	一空格空格

​               									 varchar 	一   	一

​                									长度代表的是字符的个数，不是数值。

  double       					 double(m,n) m代表共几位数(整数+小数)，n代表小数点后是几位数

  float         						float

  boolean       					boolean

  date          						date：YYYY-MM-DD

​             								time: HH:MM:SS

​             								datetime：YYYY-MM-DD HH:MM:SS （默认值是 null）

​             								timestamp：YYYY-MM-DD HH:MM:SS（默认使用 当前时间）

### 1.5 列的约束

  主键约束 primary key      唯一非空，标识该字段为表的主键

  唯一约束 unique       标识该字段的值是唯一的

  非空约束 not null      标识该字段不能为空

  默认值约束 default      为该字段设置默认值

  自增长约束 auto_increment    标识该字段的值自动增长，(整数类型，并且是主键，与主键约束结合使用)

  外键约束 foreign         标识该字段为该表的外键

  无符号的 unsigned      无符号的

  用零填充 Zerofill      使用0填充不足的位数

  字段属性注释 comment      用来对字段进行说明

 

## 2、查看表结构

### \# 2.1 查看所有表

​    SHOW TABLES;

### \# 2.2 查看表的定义(创建表的命令)

​    SHOW CREATE TABLE 表名;

​    SHOW CREATE TABLE student;

​    \# 查看结果

​     CREATE TABLE `student` (

​      `sid` INT(11) NOT NULL AUTO_INCREMENT COMMENT '学号',

​      `sname` VARCHAR(31) DEFAULT NULL COMMENT '姓名',

​      `age` INT(11) DEFAULT NULL COMMENT '年龄',

​      `sex` INT(11) DEFAULT NULL COMMENT '性别：1男,2女',

​      PRIMARY KEY (`sid`)

​     ) ENGINE=INNODB DEFAULT CHARSET=utf8

 

### \# 2.3 查看表结构

  DESC 表名;

  DESC student;

 

## 3、修改表结构

添加列(add) 修改列(modify) 删除列(drop) 修改表名(rename) 修改表的字符集(character set)

 

### \# 3.1 添加字段（add）

  ALTER TABLE 表 ADD 字段 数据类型(长度) 约束 [COMMENT 说明];

  ALTER TABLE student ADD score DOUBLE(4,1) COMMENT'成绩';

### \# 3.2 修改字段属性(modify)

  ALTER TABLE student MODIFY 字段 数据类型(长度) [COMMENT'说明'];

  ALTER TABLE student MODIFY sname VARCHAR(21) COMMENT'姓名';

### \# 3.3 修改字段名(change)

  ALTER TABLE student CHANGE sex gender INT COMMENT'性别';

### \# 3.4 修改表名(rename)

  RENAME TABLE 旧表名 TO 新表名; 

  RENAME TABLE heima TO student; 

### \# 3.5 修改标的字符集编码 

  ALTER TABLE 表 CHARACTER SET 字符编码;

  ALTER TABLE student CHARACTER SET gbk;

 

 

## 4、插入数据(insert into)

### \# 4.1 向表中部分字段插入数据 

​    INSERT INTO 表(字段1,字段2,...)VALUES(值1,值2,...);

​    INSERT INTO student(sname,age,gender,score)VALUES('小白',28,1,98);

### \# 4.2 简单写法：如果插入时全部列名的数据，表名后边的字段名可以省略。 

​    INSERT INTO 表 VALUES(值1,值2,...);

​    INSERT INTO student VALUES(2,'小呆',27,2,100);

\# 注意：如果是向部分字段插入数据的话，字段名不能省略

  

### \# 4.3 批量插入

  4.3.1语法： 

​     INSERT INTO 

表(字段1,字段2,...)

VALUES

(值1,值2,...),

(值1,值2,...);

  

  4.3.2案例实现

​     INSERT INTO 

​        student (sname,age,gender,score)

​      VALUES

​        ('狐狸',24,1,77),

​        ('狗子',25,2,45),

​        ('小胖',28,1,99),

​        ('猴子',24,1,98),

​        ('山鸡',25,2,90);

 

4.3.3 插入效率问题

  批量插入效率更高。

 

 

## 5. 删除表中数据

### \# 5.1 清空(删除)表中所有数据

​    DELETE FROM 表;

​    DELETE FROM student;

### \# 5.2 根据条件删除数据

​    DELETE FROM 表 WHERE 条件;

​    DELETE FROM student WHERE id=1;  #删除id=1的数据

### \# 5.3 truncate 删除

​	作用相当于没有where条件的delete语句。但是有些许不同

​    语法：TRUNCATE TABLE 表；

### \# 5.4 面试题 ：runcate、delete、drop的区别？

1. delete 一条一条的删除，不会重置auto_increment的记录数，如果在同一事务中，可以被找回。

2. uncate 是先删除整张表再重新建立新的表，auto_increment会被重置，删除的数据找不回。

3. Drop是将表彻底删除

  4.执行效率：drop最高，数据量大用truncate，数据量小用delete

 

 

## 6. 更新表记录(update)   

  UPDATE 表 SET 列=值,列2=值2 [WHERE 条件];

  UPDATE student SET age=27,score=100 WHERE sname='小白';

\# 注意：如果参数是字符串(char/varchar)或日期(date\time\datetime\timestamp)要加上单引号

 

 

## \#7. 查询表记录 

###   #  7.1 关键字：

​    Distinct 去重

​    As 别名，可作用与表和列

### \# 7.2 简单查询 

  SELECT DISTINCT 字段 FROM 表 WHERE 条件;

  SELECT DISTINCT * FROM student;

## 8.复杂查询 

### \# 8.1 运算查询：

​	仅仅在查询结果上做运算（+ — * /）查询，不影响表中本身的数据 

  	SELECT * ,age*2  双倍年龄 FROM student;

### \# 8.2 比较运算符：

​	

| **>**  |          **大于**           |
| :----: | :-------------------------: |
| **>=** |        **大于等于**         |
| **<**  |          **小于**           |
| **<=** |        **小于等于**         |
| **=**  |          **等于**           |
| **!=** | **不等于（非标准SQL写法）** |
| **<>** |    不等于（标准SQL写法）    |

​    *等于(!=): 非标准SQL写法*

​    *等于(<>)：标准SQL写法* 

### \# 8.3 逻辑运算符：and or not

  SELECT * FROM student WHERE age=24 OR age>27;

  SELECT * FROM student WHERE age>24 AND gender=1;

### \# 8.4 范围查询(in)：在某个范围中获取值

​    ELECT * FROM student WHERE age IN(24,25,26);

### \# 8.5 模糊查询(like)：

  _：代表一个字符

  %：代表多个字符

  SELECT * FROM student WHERE sname LIKE '%黑%';

### \# 8.6 排序查询(order by)    

​    asc：升序

​    desc：降序

  SELECT * FROM student ORDER BY age; # 默认升序(asc)排序

  SELECT * FROM student ORDER BY age DESC;

 

### \# 8.7 分组(group by)

#### \# 8.7.1 根据学生分数进行分组，分组后显示当前分数的人数

  SELECT score,COUNT(*) FROM student GROUP BY score;

#### \# 8.7.2 根据学生年龄进行分组，并且学生平均成绩大于90;

  SELECT age 年龄,AVG(score) 平均分 FROM student GROUP BY age HAVING AVG(score)>90; 

#### \# 8.7.3 根据学生的年龄和性别进行分组，性别是男的学生并且平均成绩大于90的年龄

  SELECT age 年龄,gender 性别,AVG(score) 平均分 FROM student GROUP BY age,gender HAVING AVG(score)>80; 

\# 关键字：having，当having单独使用时与where用法相同，当having与group by结合使用时，会对分组后的数据进行筛选。

\# where 不可以接聚合函数，作用在group by之前的；having 可以接聚合函数，作用在group by之后的。

 

 

## 9. 聚合函数   

\# sum()：求和

\# avg() ：平均值

\# count() ：统计数量

\# max() ：最大值

\# min()：最小值

 

 

### \# 9.1 求和 sum()

  SELECT SUM(score) 总分数 FROM student; 

### \# 9.2 求平均值 avg()

  SELECT AVG(score) 平均值 FROM student; 

### \# 9.3 统计数量 count()

  SELECT COUNT(*) FROM student;

### \# 9.4 求最大值 max()

  SELECT MAX(score) FROM student;

### \# 9.5 求最小值

  SELECT MIN(score) FROM student;

### \# 9.6 符合查询：查看所有分数大于平均分数的学生信息

  SELECT * FROM student WHERE score > (SELECT AVG(score) FROM student);

 

## 10.SQL的编写顺序与执行顺序

\#  编写顺序 S..F..W..G..H..O..

  SELECT .. FROM .. WHERE .. GROUP BY .. HAVING .. ORDER BY ..

 

\#  执行顺序 F..W..G..H..S..O..

  FROM .. WHERE .. GROUP BY .. HAVING .. SELECT .. ORDER BY ..

