# Query 1:
select color, count(*) as num_vehicles, year from Car_specs
where year > 2012
group by year, color
order by year asc;


#Query 2:
select brand, year, state from Car_specs
join Car_priceloc on Car_priceloc.vin = Car_specs.vin
where Car_priceloc.state = "Virginia"
and year between 2018 and 2020
group by brand, year
order by year;


#Query 3:
select cs.vin, cp.price from Car_specs as cs
join Car_priceloc as cp on cp.vin = cs.vin
join Car_condition as cc on cc.vin = cp.vin
where cp.price between 3000 and 5000
and cc.title_status="clean vehicle" 
and cc.condition <> "Listing Expired" 
and cp.state="virginia"
order by cp.price;


#Query 4:
select cp.state, count(cp.vin) as num_vehicles_below_avg_price, avg(cc.mileage) as avg_mileage_below_avg_price
from Car_priceloc as cp
join Car_condition as cc on cc.vin = cp.vin
join (
	select state, avg(price) as avg_price
    from Car_priceloc
    group by state
) as state_avg
on cp.state = state_avg.state
where cp.price < state_avg.avg_price
group by cp.state
order by cp.state;


#Query 5:
select cs.year, (avg(cp.price) / avg(cc.mileage)) as avg_ratio_price_to_mileage
from Car_specs as cs
join Car_priceloc as cp on cp.vin = cs.vin
join Car_condition as cc on cc.vin = cs.vin
group by year
having (avg(cp.price) / avg(cc.mileage)) > 0.1
order by year;


#Query 6:
select cp.state, count(*) as num_vehicles_price_greater_than_avg
from Car_priceloc as cp
join (
	select state, avg(price) as avg_price
    from Car_priceloc
    group by state
) as state_avg
on cp.state = state_avg.state
where cp.price > state_avg.avg_price
group by cp.state
order by cp.state;


#Query 7:
select cs.brand, cc.title_status
from Car_specs as cs
join Car_condition as cc on cc.vin = cs.vin
join Car_priceloc as cp on cp.vin = cs.vin
where cc.title_status="clean vehicle"
and (cp.state = "Virginia" or cp.state = "Michigan")
and cc.condition <> "Listing Expired"
group by cs.brand, cc.title_status
order by cs.brand;


#Query 8:
select cs.brand, avg(cp.price) as avg_price
from Car_specs as cs
join Car_priceloc as cp on cp.vin = cs.vin
join Car_condition as cc on cc.vin = cs.vin
where cc.title_status = "salvage insurance"
group by cs.brand
having avg_price > 2000
order by cs.brand;


#Query 9:
select cp.state, max(cp.price) as max_price, min(cp.price) as min_price, (max(cp.price) - min(cp.price)) as price_difference
from Car_priceloc as cp
group by state
order by price_difference desc;


#Query 10:
select distinct cs.brand
from Car_specs as cs
where not exists (
	select 1
    from Car_priceloc as cp
    where cp.vin = cs.vin and cp.state = 'virginia'
);