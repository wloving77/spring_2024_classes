
# 1.)
select maker
from S24_Product
where model in (
	select model 
    from S24_PC
    where price >= 3.0
);

# 2.)
select model, price
from S24_Printer
where price = (
	select MAX(price)
    from S24_Printer
);


# 3.)
select L.model, L.speed 
from S24_Laptop as L
where L.speed < ALL (
	select speed
    from S24_PC
);

# 4.)
select maker
from S24_Product
join S24_Printer on S24_Product.model = S24_Printer.model
where S24_Printer.color = 1 and S24_Printer.price = (
	select MIN(price)
    from S24_Printer
    where color = 1
);

# 5.)
select AVG(hd) as avg_hd_size
from S24_PC
join S24_Product on S24_Product.model = S24_PC.model
where S24_Product.maker in (
	select maker
    from S24_Product
    where `type` = "Printer"
);

# 6.)
select * 
from S24_Laptop
where price > (
	select AVG(price)
    from S24_PC
);
    
# 7.)
select "PC" as product_type, avg(price) as avg_price
from S24_PC
where model in (
	select model
    from S24_Product
    where maker = "EEE" and `type`="pc"
)
union all
select "Laptop" as product_type, avg(price)
from S24_Laptop
where model in (
	select model
    from S24_Product
    where maker = "EEE" and `type`="laptop"
);
    
