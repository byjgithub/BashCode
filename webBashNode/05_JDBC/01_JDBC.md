# 一、junit单元测试

 @Test  用于修饰需要测试的方法

@Before 测试方法前执行的方法

@After 测试方法之后执行的方法

# 二、jdbc回顾

## 1、什么是jdbc？

- jdbc 是 java database connectivity 的缩写，是sun公司推出的 java 访问数据库的标准规范(接口)

- JDBC 是一种用于执行SQL语句的 java API。
- JDBC 可以为多种关系数据库提供统一的访问入口
- JDBC 是由一组工具类和接口组成。



## 2、JDBC 的原理

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20200229214538718.png" alt="image-20200229214538718" style="zoom: 67%;" />

1、SUN提供的访问数据库的规范称为JDBC，而生产厂商提供规范的实现类称为驱动。

2、JDBC是接口，驱动是接口的实现，没有驱动就没有办法连接数据库，从而无法操作数据库！

3、MySQL的驱动包是	**mysql-connector-java-5.1.28-bin.jar**

4、JDBC驱动原理：

​		应用程序根据 JDBC 连接数据库驱动，根据驱动对数据库进行操作。



## 3、JDBC开发步骤

1. 注册驱动
2. 获得连接
3. 获取语句执行者
4. 执行sql语句
5. 处理结果
6. 释放资源

<img src="E:\JavaTools\有道云文件\baiyinjie520@163.com\3e3100c3756146d4859c466cb06c54fc\clipboard.png" alt="img" style="zoom: 50%;" />



<img src="E:\JavaTools\有道云文件\baiyinjie520@163.com\fdeb26ef5a484b6a912169b31ee5313e\clipboard.png" alt="img" style="zoom: 50%;" />

# 三、JDBC API 详解

## 1、注册驱动

```java
	Class.forName("com.mysql.jdbc.Driver");
```

1.1 分析步骤1

​		jdbc规范定义的驱动接口：java.sql.Driver

​		MySQL驱动包提供了实现类：com.mysql.jdbc.Driver

1.2 分析步骤2

​		DriverManager 工具类，提供注册驱动的方法：registerDriver(java.sql.Driver),

​		方法的参数是java.sql.Driver,所以我们通过以下语句进行注册：

```java
		DriverManager.registerDriver(new com.mysql.jdbc.Driver);
```

​		但是不推荐使用以上语句进行注册，因为这存在两方面的不足：

​			1、硬编码问题，后期不利于程序的扩展和维护

​			2、驱动被注册了两次

1.3 分析步骤3

​		通常开发我们使用Class.forName()加载一个使用字符串描述的驱动类，

如果使用反射，利用Class.forName()将类加载到内存中，那么该类的静态代码将自动执行。

通过查看 com.mysql.jdbc.Driver 驱动类的源码，我们发现 Driver类将自己进行了注册。

```java
	java.sql.DriverManager.registerDriver(new Driver());
```





## 2、获取连接

代码：

```java
Connection con = DriverManager.getConnection("jdbc:mysql://172.16.16.4:3306/jdbc01","root","Admin123!");
```

2.1 获取连接需要使用方法 DriverManager.getConnection(url,username,password);

​		三个参数分别表示：

​				url：需要连接数据库的位置（网址）

​				username：数据库用户名

​				password：数据库密码

2.2  URL 解析

​	url 比较复杂，下面通过 mysql 的 url 进行说明：

```java
格式： jdbc:mysql://172.16.16.4:3306/jdbc01
JDBC 规定 url 格式由三部分组成，每个部分由分号分隔：
    	第一部分  	jdbc，这是固定的。
    	第二部分	数据库服务器名称，我们使用的是mysql，那么第二部分当然就是 mysql 了
    	第三部分	由数据库厂商固定，我们需要了解每个厂商的要求，MySQL的第三部分分别由 IP地址、端口号、以及数据库 DATABASE名称组成。即 //172.16.16.4:3306/jdbc01
```

- 扩展： URL参数

```java
	jdbc:mysql://172.16.16.4:3306/jdbc01？useUnicode=true&characterEncoding=UTF8
	// useUnicode=true：指连接数据库的过程中，字节集使用Unicode
	// characterEncoding=UTF8：指java程序连接数据库的过程中，字节集编码使用的是 UTF-8 格式
```



## 3、获取执行对象 

### 3.1 statement

- ####  代码：

```java
	String sql = insert into `user`(uid,uname)values(1,'张三');// SQL插入语句
	statement stmt = con.createStatement();// 获取SQL语句执行者对象
```

- #### 常用方法

![image-20200229232342005](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20200229232342005.png)

- #### SQL注入问题

  ​	SQL注入是指web应用程序对用户输入的数据的合法性没有进行判断或过滤不严，攻击者可以在web应用中通过输入事先定义好的SQL语句的结尾上添加额外的SQL语句，在管理员不知情的情况下，实现非法操作，以此来实现欺骗数据库服务器执行非授权的任意CRUD操作，破坏数据库的记录。





### 3.2 preparedStatement预处理对象 

- 代码：

```java
	String sql = insert into `user`(uid,uname)values(1,'张三');// SQL插入语句
	preparedStatement psmt = con.preparedStatement(sql);//获取预处理对象,并对SQL进行预处理
```

- 常用方法

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20200229234656847.png" alt="image-20200229234656847" style="zoom: 80%;" />

- 设置实际参数解析

  ```
  	方法： setXxx(int,T)
  	// 通过setter 方法将占位符 ? 设置成实际参数。
  	SetInt();		设置int类型
  	setString();	设置字符串类型
  	参数解析：
  		int：占位符的位置，第一个占位符是1，第二个占位符是2，以此类推
  		T：	实际参数，传入占位符中的实际数据。
  ```

  



## 4、处理结果集ResultSet

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20200229235557543.png" alt="image-20200229235557543" style="zoom:80%;" />

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20200229235615560.png" alt="image-20200229235615560" style="zoom:80%;" />

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20200229235642188.png" alt="image-20200229235642188" style="zoom:80%;" />

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20200229235704956.png" alt="image-20200229235704956" style="zoom:80%;" />

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20200229235736544.png" alt="image-20200229235736544" style="zoom:80%;" />

## 5、释放资源

​	释放资源与IO流一样，先开后关原则



## 6、使用JDBC进行CRUD操作

```java

```







































































































































































































































































































































































































































