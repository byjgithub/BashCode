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


DESC SELECT dname FROM dept WHERE deptno=10;


-- 单行子查询(> < >= <= = <>)
	-- 查询出高于10号部门的平均工资的员工信息
	1.查询出10号部门的平均工资
	SELECT AVG(sal) FROM emp WHERE deptno = 10;
	2.查询出高于10号部门平均工资的员工信息
	SELECT * FROM emp WHERE sal > (SELECT AVG(sal) FROM emp WHERE deptno = 10);
-- 多行子查询(in  not in any all)    >any  >all
	-- 查询出比10号部门任何员工薪资高的员工信息
	1. 查询出10号部门的所有工资信息
	SELECT sal FROM emp WHERE deptno=10;
	2.得出结果
	SELECT * FROM emp WHERE sal >ALL(SELECT sal FROM emp WHERE deptno=10); 

-- 多列子查询(实际使用较少)   in
	-- 和10号部门同名同工作的员工信息
	1.查出10号部门员工名字和工作信息
	SELECT ename,job FROM emp WHERE deptno=10;
	2. 得出结果:
	SELECT * FROM emp WHERE (ename,job) IN (SELECT ename,job FROM emp WHERE deptno=10) AND deptno!=10;
-- Select接子查询
	-- 获取员工的名字和部门的名字
	1.查出员工的名字和部门编号信息
	SELECT ename,deptno FROM emp;
	2.得出结果
	SELECT ename,(SELECT dname FROM dept WHERE dept.deptno=emp.deptno) FROM emp;
-- from后面接子查询
	-- 查询emp表中经理信息
	1.查询出所有经理的ID
	SELECT DISTINCT mgr FROM emp;
	2. 查出经理的信息,只要id在第一步的查询结果中就可以了
	SELECT * FROM emp,(SELECT DISTINCT mgr FROM emp) mgrs WHERE emp.empno = mgrs.mgr;
-- where 接子查询
	-- 薪资高于10号部门平均工资的所有员工信息
	1.查询出10号部门的平均工资
	SELECT AVG(sal) FROM emp WHERE deptno=10;
	2.得出结果:
	SELECT * FROM emp WHERE sal > (SELECT AVG(sal) FROM emp WHERE deptno=10);
-- having后面接子查询
	-- 有哪些部门的平均工资高于30号部门的平均工资
	1.30号部门的平均工资
	SELECT AVG(sal) FROM emp WHERE deptno=30;
	2. 统计所有部门的平均工资
	SELECT deptno,AVG(sal) FROM emp GROUP BY deptno ;
	3. 得出最终的结果
	SELECT deptno,AVG(sal) FROM emp GROUP BY deptno HAVING AVG(sal) > (SELECT AVG(sal) FROM emp WHERE deptno=30);
		
-- 工资>JONES工资的员工信息
	1.查处JONES的工资信息
	SELECT sal FROM emp WHERE ename='JONES';
	2.得出结果
	SELECT * FROM emp WHERE sal > (SELECT sal FROM emp WHERE ename='JONES');
-- 查询与SCOTT同一个部门的员工
	1.查处SCOTT的部门编号
	SELECT deptno FROM emp WHERE ename = 'SCOTT';
	2.得出结果
	SELECT * FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SCOTT');
-- 工资高于30号部门所有人的员工信息
	1.得出30号部门的最大工资
	SELECT MAX(sal) FROM emp WHERE deptno = 30;
	2.得出结果
	SELECT * FROM emp WHERE sal > (SELECT MAX(sal) FROM emp WHERE deptno = 30);
-- 查询工作和工资与MARTIN完全相同的员工信息
	1.查处MARTIN的工作和工资
	SELECT job,sal FROM emp WHERE ename='MARTIN';
	2.得出结果
	SELECT * FROM emp WHERE (job,sal) IN (SELECT job,sal FROM emp WHERE ename='MARTIN');
-- 有两个以上直接下属的员工信息
	1.查出emp表中mgr信息
	SELECT mgr FROM emp;
	2.分组统计mgr的信息
	SELECT mgr,COUNT(*) FROM emp GROUP BY mgr HAVING COUNT(*)>2;
	3.得出结果
	SELECT * FROM emp e1 WHERE e1.empno IN (SELECT e2.mgr FROM emp e2 GROUP BY e2.mgr HAVING COUNT(*)>2);
-- 查询员工编号为7788的员工名称,员工工资,部门名称,部门地址
	1.将员工表和部门表链接起来
	SELECT * FROM emp ,dept WHERE emp.deptno = dept.deptno;
	2.得出ID为7788的所有信息
	SELECT * FROM emp ,dept WHERE emp.deptno = dept.deptno AND empno=7788;
	3.只显示其中的需要的信息
	SELECT ename,sal ,dname, loc FROM emp ,dept WHERE emp.deptno = dept.deptno AND empno=7788;

-- 1. 查询出高于本部门平均工资的员工信息
	1. 分组统计每个部门的平均工资
	SELECT deptno,AVG(sal) FROM emp GROUP BY deptno;
	2. 得出相应的结果
	SELECT * FROM emp e1 WHERE e1.sal > (SELECT AVG(e2.sal) FROM emp e2 WHERE e1.deptno=e2.deptno  GROUP BY e2.deptno);
	
-- 1. 列出达拉斯加工作的人中,比纽约平均工资高的人
	0. 查处DALLAS 的部门编号
	SELECT deptno FROM dept WHERE loc='DALLAS';
	1.查处达拉斯工作的人的信息
	SELECT * FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE loc='DALLAS');
	2. 查处纽约的部门编号
	SELECT deptno FROM dept WHERE loc='NEW YORK';
	3. 查村纽约平均工资
	SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE loc='NEW YORK');
	4.得出结果:
	SELECT * FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE loc='DALLAS')
	AND sal > (SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE loc='NEW YORK'));
	
	
-- 2. 查询7369员工编号,姓名,经理编号和经理姓名
	SELECT e1.empno,e1.ename,e1.mgr,mgrtable.ename FROM emp e1,emp mgrtable WHERE e1.mgr = mgrtable.empno; 
	
-- 3. 查询出各个部门薪水最高的员工所有信息
	1.分组统计每个部门员工最高的薪资是多少
	SELECT MAX(sal),deptno FROM emp GROUP BY deptno;
	2.算出结果
	SELECT * FROM emp e1 WHERE e1.sal = (SELECT MAX(sal) FROM emp e2 WHERE e1.deptno = e2.deptno GROUP BY deptno);
	
	
CREATE TABLE test(
  NAME CHAR(20),
  kecheng CHAR(20),
  fenshu CHAR(20)
);

INSERT INTO test VALUES
('张三','语文',81),
('张三','数学',75),
('李四','语文',76),
('李四','数学',90),
('王五','语文',81),
('王五','数学',82);


SELECT NAME FROM test WHERE fenshu < 80 ;
SELECT NAME FROM test WHERE NAME NOT IN(SELECT NAME FROM test WHERE fenshu < 80 );

	
	

