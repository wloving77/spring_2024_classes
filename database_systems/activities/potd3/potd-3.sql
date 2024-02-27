# 1.) 
select sname, Reserves.bid 
from Sailors 
join Reserves on Sailors.sid = Reserves.sid 
where Reserves.bid=103;

# 2.)
select Sailors.sname, color, Boats.bid 
from Boats 
join Reserves on Reserves.bid = Boats.bid 
join Sailors on Reserves.sid = Sailors.sid
where Sailors.sname = "Guppy";

# 3.) 
select Sailors.sname
from Sailors
join Reserves on Reserves.sid = Sailors.sid
join Boats on Reserves.bid = Boats.bid
where Boats.color = "red";

# 4.)
select Sailors.sname 
from Sailors
left join Reserves on Sailors.sid = Reserves.sid
where Reserves.bid IS NULL;

# 5.)
select Sailors.sid, Sailors.sname, Boats.bname
from Sailors
join Reserves on Sailors.sid = Reserves.sid
join Boats on Reserves.bid = Boats.bid
where Boats.bname like "M%";

# 6.)
select Sailors.sid, Sailors.sname, count(*) as reservation_count, Boats.bname
from Sailors
join Reserves on Sailors.sid = Reserves.sid
join Boats on Reserves.bid = Boats.bid
where Boats.bname like "M%"
group by Sailors.sid, Sailors.sname;

