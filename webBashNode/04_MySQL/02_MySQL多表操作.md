# 一、添加外键约束

## 1、方式1：建表时创建外键

​		创建学生表，属性有 id、姓名、性别、年龄、成绩、班级：

		CREATE TABLE student(
			# 列名 数据类型(长度) 约束
			-- 添加外键
			FOREIGN KEY(grade) REFERENCES 主表(主键)
		);
## 2、方式2：建表后增加字段

| ALTER TABLE 从表 ADD 【constraint `外键名`】 FOREIGN KEY 【外键字段】 reference 主表【主键】; |
| ------------------------------------------------------------ |
|                                                              |



## 3、多表之间如何维护外键？

### 3.1 使用外键约束：foreign key

### 3.2 添加一个外键

​	方式1：建表后添加外键

​		语法：alter table 从表 add foreign key (外键） references 主表(主键);

​					从表：即多表

​					主表：即一表

​					外键：从表中的外键

​					主键：主表中的一键

​	方式2：建表时添加外键

​		语法： foreign key(外键) references 主表（主键）;

### 3.3 删除外键

删除带有外键的数据时，要先删除外键关联的从表所有数据，才能删除主表的数据。











# 二、多表查询分析

## 1.外键

### 1.1 建表时添加外键

语法：FOREIGN KEY(grade) REFERENCES 主表(主键)

### 1.2 建表后添加外键字段

​	语法：ALTER TABLE 从表 ADD 【constraint `外键名`】 FOREIGN KEY 【外键字段】 reference 主表【主键】;

1.3



## 2.建数据库原则

原则上来说，一个项目/应用 建立一个数据库。

## 3.建表原则

### 3.1 一对多

原则：在 "多" 的一方添加一个外键指向 "一" 的一方的主键；

###  3.2 多对多

#原则：建立一张中间表，将多对多的关系拆成一对多的关系，中间表至少要有两个外键，分别指向两张表的主键。

###  3.3 一对一

原则1：将一对一当成多对一处理,在任意一张表中添加一个外键，这个外键指向另一张表的主键。

原则2：直接将两张表合并成一张表

原则3：将两张表的主键建立起连接，让两张表的主键相等。

注意：一对一实际用途不是很多，一般用于拆表操作。将表的常用信息和不常用信息拆分开来，减少表的臃肿(例如：个人信息)

### 3.4 在实际开发中，多对多和一对多是常用的方式，一对一很少用	



#  三、商城案例所有表

-- 数据库 shop

-- 用户表(用户ID、用户名、密码、手机号)

-- 订单表(订单编号、总价、订单时间、地址、外键用户的ID)--  商品表(商品ID、商品名称、价格、外键(cno))

-- 订单项：中间表，订单表与商品表的多对多关系（订单ID、商品ID、商品数量、订单项总价）

-- 商品分类表(分类ID、分类名称、分类描述)



##   4.1 表关系

- 用户表与订单表：一对多

- 商品表与商品分类表：多对一

- 订单表与商品表：多对多

- 订单项(中间表)：关联订单表与商品表

##  4.2 创建数据库

	CREATE DATABASE shop;

##  4.3 创建表

###   4.3.1 用户表user

属性：用户ID、用户名、密码、手机号

	CREATE TABLE `user`(
		uid INT PRIMARY KEY AUTO_INCREMENT COMMENT'用户ID',
		username VARCHAR(31) COMMENT'用户名',
		PASSWORD VARCHAR(31) COMMENT'密码',
		phone VARCHAR(11) COMMENT'手机号'
	);

- 用户表数据

	INSERT INTO `user` VALUES(1,'张三','123456','13903333322');

###  	   4.3.2 订单表orders

属性：订单编号、总价、订单时间、地址、外键用户的ID

	CREATE TABLE orders(
		oid INT PRIMARY KEY AUTO_INCREMENT COMMENT'订单编号',
		`sum` DOUBLE(15,2)COMMENT'总价',
		otime TIMESTAMP COMMENT'订单时间',
		address VARCHAR(100) COMMENT'地址',
		uno INT COMMENT'外键(user表主键)',
		FOREIGN KEY(uno) REFERENCES `user`(uid) 
	);

- 订单表数据

	INSERT INTO `orders` VALUES(1,'9987.3',NULL,'黑马前台旁边小黑屋',1);
	INSERT INTO `orders` VALUES(2,'9987.3',NULL,'黑马后台旁边1703',1);

###    4.3.3 商品分类表

属性：分类ID、分类名称、分类描述

	CREATE TABLE category(
		cid INT PRIMARY KEY AUTO_INCREMENT COMMENT'分类id',
		cname VARCHAR(15)COMMENT'分类名称',
		cdesc VARCHAR(100)COMMENT'分类描述'
	);

- 商品分类表数据

	INSERT INTO category VALUES (NULL,'手机数码','电子产品,黑马生产');
	INSERT INTO category VALUES (NULL,'鞋靴箱包','江南皮鞋厂倾情打造');
	INSERT INTO category VALUES (NULL,'香烟酒水','黄銷被,茅台,二锅头');
	INSERT INTO category VALUES (NULL,'酸奶饼干','娃哈哈,票牛酸酸乳');
	INSERT INTO category VALUES (NULL, '馋嘴嘴零食','瓜子花生,八宝粥,辣条');



###    4.3.4 商品表

属性：商品ID、商品名称、价格、外键(cno)

	CREATE TABLE product( 
		pid INT PRIMARY KEY AUTO_INCREMENT COMMENT '商品ID',
		pname VARCHAR (10) COMMENT '商品名称',
		price DOUBLE COMMENT'商品价格',
		cno INT COMMENT'外键',
		FOREIGN KEY(cno) REFERENCES category(cid)
	);

- 商品表数据

	INSERT INTO product VALUES (NULL,'小米mix4',998,1);
	INSERT INTO product VALUES (NULL,'锤子',2888,1);
	INSERT INTO product VALUES (NULL,'阿迪王',99,2);
	INSERT INTO product VALUES (NULL,'老村长',88,3);
	INSERT INTO product VALUES (NULL,'劲酒',35,3);
	INSERT INTO product VALUES  (NULL,'小熊拼干',1,4);
	INSERT INTO product VALUES (NULL,'卫龙辣条',1,5);
	INSERT INTO product VALUES (NULL,'旺旺大饼',1,5);

###   4.3.5 订单项(中间表)

属性：订单ID、商品ID、商品数量、订单项总价

	CREATE TABLE orderitem(
		ono INT COMMENT'订单ID',
		pno INT COMMENT'商品ID',
		FOREIGN KEY(ono) REFERENCES orders(oid),
		FOREIGN KEY(pno) REFERENCES product(pid),
		`count` INT COMMENT '商品数量',
		subsum DOUBLE COMMENT '订单项总价'
	);

- 订单项表数据

	-- 给1号订单添加商品
	INSERT INTO orderitem VALUES (1,7,100,100);
	INSERT INTO orderitem VALUES (1,8,101,100);
	
	-- 给二号订单添加商品
	INSERT INTO orderitem VALUES (2,5,1,35);
	INSERT INTO orderitem VALUES (2,3,3,99);




# 四、主键约束和唯一约束

## 1.主键约束 primary key

- 主键约束默认就 必须唯一、不能为空
- 主键在一张表中只能有一个
- 表的主键指向多表的外键



## 2、唯一约束 unique

- 列的内容必须是唯一的，不能出现重复情况，可以为空
- 唯一约束不能作为其他表的外键
- 可以有多个唯一约束





# 五、连接查询

<img src="E:\JavaTools\有道云文件\baiyinjie520@163.com\cf0470d3f5494d9bbca20af5762706cc\clipboard.png" alt="img" style="zoom:80%;" />



## 1、交叉连接查询 笛卡尔积

- 语法： select * from 表1,表2;

- 笛卡尔积： 查出来的结果是两个表的乘积，查出来的结果是没有意义的。

  ​					但是我们可以在笛卡尔积中过滤出有意义的数据。

  ​	例如： select * from 表1，表2 where  表1.id = 表2.id;

  ​				select * from product p,category c where p.con = c.cid;

  

## 2、内连接查询 INNER JOIN ON



###   2.1 隐式内连接

​	SELECT * FROM product p,category c WHERE p.cno = c.cid;

###   2.2 显示内连接

​	SELECT * FROM product p INNER JOIN category c ON p.cno = c.cid;
  -- 区别
​	隐式内连接：在查询出笛卡尔积结果的基础上，去做where条件过滤。
​	显示内连接：带有条件去查询结果，执行效率要高。

## 3、左外连接查询 LEFT JOIN ON

 左外连接查询，会将左表中所有的数据和右表中和左表重合的部分查询出来，如果右表中没有对应的数据，用null代替
		SELECT * FROM product p LEFT JOIN category c ON p.cno = c.cid;

## 4、右外连接查询 RIGHT JOIN ON

右外连接查询，会将右表中所有的数据和左表中和右表重合的部分查询出来，如果左表中没有对应的数据，用null代替
		SELECT * FROM  product p RIGHT JOIN category c ON p.cno = c.cid;

## 5、语法

关键字：on 与 using

在连接查询中，使用关键字 on 来进行条件筛选。如果左右两表存在相同的字段，会全部显示出来

在连接查选中，使用关键字using来代替on进行条件匹配，如果左右两表有相同的字段，最终结果只会保留一个。



# 六、分页查询 limit(m,n)

## 6.1 查询语句顺序及说明

- **select**  **字段列表 from 表名** where 条件 group by 分组 having 条件 order by 排序 limit 限制；

select  字段列表1  from 表名 where 条件1 group by(字段列表2) having 条件2 order by 字段3  desc|asc limit(m,n);

参数说明：

​	字段列表1： 最终显示的查询结果项

​	where 条件1：根据条件1从表中查询出结果

​	group by(字段列表2)： 根据字段列表2对 where 条件查询的结果进行分组

​	having 条件2： 对分组后的查询结果再次按照条件2进行筛选

​	order by 字段3 desc|asc： 对 having 筛选后的结果按字段3进行 降序|升序 排序

​	limit(m,n)：对最终查询排序后的结果，进行分页显示。

​			m：表示开始显示的记录下标（从零开始）

​			n： 表示每页显示的记录数

## 6.2 分页查询

**limit(m,n**)：对最终查询排序后的结果，进行分页显示。

​			m：表示开始显示的记录下标（从零开始）

​			n： 表示每页显示的记录数

在实际开发中，计算每页的起始索引值的方式：

​		index：代表要显示的是第几页

​		startIndex：表示的是每页的起始值，即 m 的值

​		**startIndex = （index-1）*n；**



# 七、子查询

1、什么是子查询

​	就是将一个SQL语句的查询结果当做另一个SQL语句的查询条件。

​	举例：

			SELECT 
				Sname,Sage 
			FROM 
				Student
	 		WHERE 
	 			Sage<(SELECT Sage FROM Student WHERE Sdept='IS') 
	  		AND 
	  			Sdept<>'IS'
2、any、all关键字

​	与比较运算符连用：

​		any：查询结果中的任意一个值

​			例如： >any(select age from student);  表示大于查询结果中的任意一个值就符合查询条件

​		all：查询结果中的所有值

​			例如： <any(select age from student); 表示小于查询结果中的所有值才符合查询条件。



3、any 、all 与函数集关系

​		事实上，用集函数来实现子查询通常比直接用ANY或ALL查询效率要高，

​	ANY与ALL与集函数的对应关系如下所示

|      | =    | <>或!= | <    | <=    | >    | >=    |
| ---- | ---- | ------ | ---- | ----- | ---- | ----- |
| ANY  | IN   | -      | <MAX | <=MAX | >MIN | >=MIN |
| ALL  | --   | NOT IN | <MIN | <=MIN | >MAX | >=MAX |


