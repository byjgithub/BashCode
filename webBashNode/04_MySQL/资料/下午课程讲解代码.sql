- 交叉连接查询  笛卡尔积
SELECT * FROM product;
SELECT * FROM category;

笛卡尔积 ,查出来是两张表的乘积 ,查出来的结果没有意义
SELECT * FROM product,category;

--过滤出有意义的数据
SELECT * FROM product,category WHERE cno=cid;

SELECT * FROM product AS p,category AS c WHERE p.cno=c.cid;
SELECT * FROM product p,category c WHERE p.cno=c.cid;


--数据准备
INSERT INTO product VALUES(NULL,'耐克帝',10,NULL);

- 内连接查询
-- 隐式内链接
  SELECT * FROM product p,category c WHERE p.cno=c.cid;
-- 显示内链接
  SELECT * FROM product p INNER JOIN category c ON p.cno=c.cid;	
-- 区别:
	隐式内链接: 在查询出结果的基础上去做的WHERE条件过滤
	显示内链接: 带着条件去查询结果, 执行效率要高

- 左外连接
  左外连接,会将左表中的所有数据都查询出来, 如果右表中没有对应的数据,用NULL代替
  SELECT * FROM product p LEFT OUTER JOIN category c ON p.cno=c.cid;

- 准备工作
  INSERT INTO category VALUES(100,'电脑办公','电脑叉叉差');
- 右外连接: 会将右表所有数据都查询出来, 如果左表没有对应数据的话, 用NULL代替
  
  SELECT * FROM product p RIGHT OUTER JOIN category c ON p.cno=c.cid;
  
  
  
-- 查询分类名称为手机数码的所有商品
   1.查询分类名为手机数码的ID
   SELECT cid FROM category WHERE cname='手机数码';
   2.得出ID为1的结果
   SELECT * FROM product WHERE cno = (SELECT cid FROM category WHERE cname='手机数码');
   
-- 查询出(商品名称,商品分类名称)信息
   --左连接
   SELECT p.pname,c.cname FROM product p LEFT OUTER JOIN category c ON p.cno = c.cid;
   
   --子查询
   SELECT pname ,(SELECT cname FROM category c WHERE  p.cno=c.cid ) AS 商品分类名称  FROM product p;
   
	

CREATE TABLE emp(
	empno INT,
	ename VARCHAR(50),
	job VARCHAR(50),
	mgr	INT,
	hiredate DATE,
	sal	DECIMAL(7,2),
	comm DECIMAL(7,2),
	deptno INT
) ;

INSERT INTO emp VALUES(7369,'SMITH','CLERK',7902,'1980-12-17',800,NULL,20);
INSERT INTO emp VALUES(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
INSERT INTO emp VALUES(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,500,30);
INSERT INTO emp VALUES(7566,'JONES','MANAGER',7839,'1981-04-02',2975,NULL,20);
INSERT INTO emp VALUES(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,1400,30);
INSERT INTO emp VALUES(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850,NULL,30);
INSERT INTO emp VALUES(7782,'CLARK','MANAGER',7839,'1981-06-09',2450,NULL,10);
INSERT INTO emp VALUES(7788,'SCOTT','ANALYST',7566,'1987-04-19',3000,NULL,20);
INSERT INTO emp VALUES(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000,NULL,10);
INSERT INTO emp VALUES(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
INSERT INTO emp VALUES(7876,'ADAMS','CLERK',7788,'1987-05-23',1100,NULL,20);
INSERT INTO emp VALUES(7900,'JAMES','CLERK',7698,'1981-12-03',950,NULL,30);
INSERT INTO emp VALUES(7902,'FORD','ANALYST',7566,'1981-12-03',3000,NULL,20);
INSERT INTO emp VALUES(7934,'MILLER','CLERK',7782,'1982-01-23',1300,NULL,10);
INSERT INTO emp VALUES(7981,'MILLER','CLERK',7788,'1992-01-23',2600,500,20);

CREATE TABLE dept(
	deptno		INT,
	dname		VARCHAR(14),
	loc		VARCHAR(13)
);

INSERT INTO dept VALUES(10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES(20, 'RESEARCH', 'DALLAS');
INSERT INTO dept VALUES(30, 'SALES', 'CHICAGO');
INSERT INTO dept VALUES(40, 'OPERATIONS', 'BOSTON');



--最高工资
SELECT MAX(sal) FROM emp;
--最少工资
SELECT MIN(sal) FROM emp;
--最高工资的员工信息
SELECT * FROM emp WHERE sal = (SELECT MAX(sal) FROM emp);

--最低工资的员工信息
SELECT * FROM emp WHERE sal = (SELECT MIN(sal) FROM emp);



-- 单行子查询(> < >= <= = <>)
	-- 查询出高于10号部门的平均工资的员工信息
   	1.10号部门的平均工资
   	SELECT AVG(sal) FROM emp WHERE deptno = 10;
   	2. 高于上面结果员工信息 
	SELECT * FROM emp WHERE sal > (SELECT AVG(sal) FROM emp WHERE deptno = 10);
   	
	
-- 多行子查询(in  not in any all)    >any  >all
	-- 查询出比10号部门任何员工薪资高的员工信息
	1. 查询出10号部门最高工资
	SELECT MAX(sal) FROM emp WHERE deptno = 10;
	2. 得出结果
	SELECT * FROM emp WHERE sal > (SELECT MAX(sal) FROM emp WHERE deptno = 10);
	-- 查询出比10号部门任意一个员工薪资高的所有员工信息 : 只要比其中随便一个工资都可以
	SELECT sal FROM emp WHERE deptno = 10;
	
	SELECT * FROM emp WHERE sal >ANY(SELECT sal FROM emp WHERE deptno = 10) AND deptno != 10;
	
	
-- 多列子查询(实际使用较少)   in
	-- 和10号部门同名同工作的员工信息
	1. 查询出10号部门所有人 名字和工作
	SELECT ename,job FROM emp WHERE deptno=10;
	2. 得出结果
	SELECT * FROM emp WHERE (ename,job) IN (SELECT ename,job FROM emp WHERE deptno=10) AND deptno !=10;
-- Select后面接子查询
	-- 获取员工的名字和部门的名字
	SELECT ename,deptno FROM emp ;
	
	SELECT ename,(SELECT dname FROM dept d WHERE d.deptno = e.deptno ) 部门名称 FROM emp e ;
-- from后面接子查询
	-- 查询emp表中所有管理层的信息
	SELECT DISTINCT mgr FROM emp;
	
	- 得出结果
	SELECT * FROM emp e,(SELECT DISTINCT mgr FROM emp) mgrtable WHERE e.empno = mgrtable.mgr;
			
	
-- where 接子查询
	-- 薪资高于10号部门平均工资的所有员工信息
	1. 10号部门平均工资
	SELECT AVG(sal) FROM emp WHERE deptno=10;
	2. 得出结果
	SELECT * FROM emp WHERE sal > (SELECT AVG(sal) FROM emp WHERE deptno=10);
      			
	
-- having后面接子查询
	-- 有哪些部门的平均工资高于30号部门的平均工资
	1. 统计所有的部门的平均工资
	SELECT deptno, AVG(sal) FROM emp GROUP BY deptno;
	2. 30号部门的平均工资
	SELECT AVG(sal) FROM emp WHERE deptno=30;
	3.得出结果:
	SELECT deptno, AVG(sal) FROM emp GROUP BY deptno HAVING AVG(sal) > (SELECT AVG(sal) FROM emp WHERE deptno=30);



-- 列出达拉斯加工作的人中,比纽约平均工资高的人
   1. 查处达拉斯加工作的人
      1. 查询出达拉斯的部门编号
      SELECT deptno FROM dept WHERE loc ='DALLAS';
      2. SELECT * FROM emp WHERE deptno = ( SELECT deptno FROM dept WHERE loc ='DALLAS');
   
   2. 查出纽约工作的人的平均工资
      1. 查处纽约的部门编号
       SELECT deptno FROM dept WHERE loc ='NEW YORK';
      2. SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE loc ='NEW YORK');
      
   3. 得出最终结果:
     SELECT * FROM emp WHERE deptno = ( SELECT deptno FROM dept WHERE loc ='DALLAS')
      AND 
      sal > (SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE loc ='NEW YORK'));
	


  	


