-- to check the tables in mintclassics
use mintclassics;
show tables;

-- to check which warehouse stores what?
select count(productCode), sum(quantityinstock) , warehousecode 
from products
group by warehouseCode;

-- identify products with high stock and less sales
select p.productCode , p.productName, p.quantityInStock , sum(od.quantityOrdered) as 'ts'
from products p
left join orderdetails od
on p.productcode = od.productcode
group by productCode
having ts < quantityInStock*0.5;

-- count of the products with high stock and less sales
select count(*) as 'Products with less sales high QIS'
from (select p.productCode , p.productName, p.quantityInStock , sum(od.quantityOrdered) as 'ts'
from products p
left join orderdetails od
on p.productcode = od.productcode
group by productCode
having ts < quantityInStock*0.5) as subquery;


-- top 10 best selling products
select p.productCode , sum(od.quantityOrdered) as 'sales'
from products p
join orderdetails od
on p.productCode = od.productCode
group by p.productCode
order by sum(od.quantityOrdered) desc
limit 10;

-- Bottom 10 products by sales
select p.productCode , sum(od.quantityOrdered) as 'sales'
from products p
join orderdetails od
on p.productCode = od.productCode
group by p.productCode
order by sum(od.quantityOrdered) asc
limit 10;

-- top 3 selling product lines
select   p.productLine , sum(od.quantityOrdered) as 'sales'
from products p
join productlines pl
on p.productLine = pl.productLine
join orderdetails od
on p.productCode = od.productCode
group by pl.productLine
order by sales desc
limit 3;


-- Bottom 3 products line by sales
select   p.productLine , sum(od.quantityOrdered) as 'sales'
from products p
join productlines pl
on p.productLine = pl.productLine
join orderdetails od
on p.productCode = od.productCode
group by pl.productLine
order by sales asc
limit 3;

-- warehouse with the list quantity in stock 
select w.warehouseCode  , sum(p.quantityInStock) as 'QIS'
from warehouses w
join products p
on w.warehouseCode = p.warehouseCode
group by warehouseCode
order by QIS asc
limit 1;