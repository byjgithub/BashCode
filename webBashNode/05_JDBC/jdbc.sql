























#c3p0测试SQL代码


UPDATE `user` SET username = "李四",`password` = "123123",phone="12899006756" WHERE uid=1;


#向商品中添加数据
INSERT INTO product SET pid=9,pname='雀巢咖啡',price=35.9,cno=5;

#根据id查询商品信息
DELETE  FROM product WHERE pid = 9;

#根据id查询用户信息
SELECT * FROM `user` WHERE uid=1;

#查看表结构
DESC `user`;

# 查询商品信息及分类信息
SELECT 
	p.`pid` 商品ID,
	p.`pname` 商品名称,
	p.`price` 商品价格,
	p.`cno` 商品分类,
	c.`cname` 分类名称,
	c.`cdesc` 分类名称 
FROM 
	product p 
LEFT JOIN 
	category c 
ON 
	p.`cno`=c.`cid`;

#根据id删除商品信息
DELETE FROM `product` WHERE pid=8;
DELETE FROM orderitem WHERE pno=8;

#删除外键
ALTER TABLE product DROP FOREIGN KEY product_fk;
ALTER TABLE orderitem DROP FOREIGN KEY orderitem_fk_2;
# 添加外键
ALTER TABLE product ADD CONSTRAINT`product_fk` FOREIGN KEY(cno) REFERENCES category(cid);
ALTER TABLE orderitem ADD CONSTRAINT`orderitem_fk_2` FOREIGN KEY(pno) REFERENCES product(pid);

SHOW CREATE TABLE product;

SHOW CREATE TABLE orderitem;


UPDATE `user` SET username=? WHERE uid=?;




# dbcp 测试SQL语句

# 根据id查询用户信息

SELECT * FROM `user` WHERE uid=1;
 

















































