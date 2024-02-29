-- For CS 4750, Spring 2024
-- Santa workshop activity (ER -> schema -> SQL)

-- Elf(badge, name, wname)   
--  - PK: badge 
--  - FK: wname references Workshop(wname)
-- is_supervised(badge, sbadge)   
--  - PK: badge, an elf can have at most one supervisor
--  - a supervisor can supervise many elves
--  - FK: badge references Elf(badge)
--  - FK: sbadge references Elf(badge)  // supervisor's badge
-- Workshop(wname, location)
--  - PK: wname
-- Toy(toy_id, toy_name)
--  - PK: toy_id
-- Built_in(toy_id, wname) 
--  - PK: (toy_id, wname)               // many-to-many relationship
--  - FK: toy_id references Toy(toy_id)
--  - FK: wname references Workshop(wname)
-- Evaluation(badge, rater, rate_date, rating)
--  - PK: (badge, rater, rate_date)    // weak entity
--  - FK: badge references Elf(badge)
--  - FK: rater references Elf(badge)
--  - assume each rater rates this elf only once on rater_date 
--  - assume rating is of type INT

-- Normalization
-- Elf(badge, name, wname)   
--    FD = { badge -> name, wname }
-- is_supervised(badge, sbadge)   
--    FD = { badge -> sbadge }
-- Workshop(wname, location)
--    FD = { wname -> location } 
--    assume a location may be a building / business complex and thus cannot imply a specific workshop
-- Toy(toy_id, toy_name)
--    FD = { toy_id -> toy_name }
--    assume multiple toys may have the same name 
-- Built_in(toy_id, wname) 
--    FD = { toy_id, wname -> toy_id, wname }
-- Evaluation(badge, rater, rate_date, rating)
--    FD = { badge, rater, rate_date -> badge, rater, rate_date, rating }
-- Assume 3NF, no violation. Thus, no need to normalize the relations. 

-- ------

CREATE TABLE Workshop(wname VARCHAR(255), 
                    location VARCHAR(255),
                    PRIMARY KEY (wname));
CREATE TABLE Toy(toy_id VARCHAR(30), 
                    toy_name VARCHAR(255),
                    PRIMARY KEY (toy_id));
CREATE TABLE Built_in(toy_id VARCHAR(30), 
                    wname VARCHAR(255),
                    PRIMARY KEY (toy_id, wname),
                    FOREIGN KEY (toy_id) references Toy(toy_id),
                    FOREIGN KEY (wname) references Workshop(wname));
CREATE TABLE Elf (badge VARCHAR(10), 
                    name VARCHAR(60), 
                    wname VARCHAR(255),
                    PRIMARY KEY (badge),                 
                    FOREIGN KEY (wname) REFERENCES Workshop(wname));
CREATE TABLE is_supervised (badge VARCHAR(10), 
                    sbadge VARCHAR(10),
                    PRIMARY KEY (badge), 
                    FOREIGN KEY (badge) REFERENCES Elf(badge));
CREATE TABLE Evaluation(badge VARCHAR(10), 
                    rater VARCHAR(10), 
                    rate_date DATE,
                    rating INT,
                    PRIMARY KEY (badge, rater, rate_date),
                    FOREIGN KEY (rater) REFERENCES Elf(badge));   

-- (note the order of creation â€“ due to foreign keys)

-- To test, inserts some data

INSERT INTO Workshop VALUES ('NorthStar', '123 North St.');
INSERT INTO Workshop VALUES ('EastStar', '123 East St.');
INSERT INTO Workshop VALUES ('WestStar', '123 West St.');
INSERT INTO Workshop VALUES ('SouthStar', '123 South St.');

INSERT INTO Toy VALUES ('111', 'Car');
INSERT INTO Toy VALUES ('222', 'Book');
INSERT INTO Toy VALUES ('333', 'Doll');
INSERT INTO Toy VALUES ('444', 'Ball');
INSERT INTO Toy VALUES ('555', 'Bike');
INSERT INTO Toy VALUES ('666', 'Board game');

INSERT INTO Built_in VALUES ('111', 'NorthStar');
INSERT INTO Built_in VALUES ('222', 'SouthStar');
INSERT INTO Built_in VALUES ('222', 'WestStar');
INSERT INTO Built_in VALUES ('333', 'NorthStar');
INSERT INTO Built_in VALUES ('333', 'EastStar');
INSERT INTO Built_in VALUES ('444', 'EastStar');
INSERT INTO Built_in VALUES ('444', 'WestStar');
INSERT INTO Built_in VALUES ('444', 'NorthStar');
INSERT INTO Built_in VALUES ('555', 'EastStar');
INSERT INTO Built_in VALUES ('666', 'WestStar');

INSERT INTO Elf VALUES ('1111111111', 'Humpty', 'NorthStar');
INSERT INTO Elf VALUES ('1111111112', 'Dumpty', 'NorthStar');
INSERT INTO Elf VALUES ('1111111113', 'Wacky', 'EastStar');
INSERT INTO Elf VALUES ('1111111114', 'Duh', 'NorthStar');
INSERT INTO Elf VALUES ('1111111115', 'Huh', 'SouthStar');
INSERT INTO Elf VALUES ('1111111116', 'Duhhuh', 'SouthStar');
INSERT INTO Elf VALUES ('1111111117', 'Mickey', 'SouthStar');
INSERT INTO Elf VALUES ('1111111118', 'Minnie', 'WestStar');
INSERT INTO Elf VALUES ('1111111119', 'Goofy', 'SouthStar');
INSERT INTO Elf VALUES ('1111111120', 'Donald', 'SouthStar');
INSERT INTO Elf VALUES ('1111111121', 'Daisy', 'EastStar');
INSERT INTO Elf VALUES ('1111111122', 'Pluto', 'EastStar');

INSERT INTO is_supervised VALUES ('1111111112', '1111111111');
INSERT INTO is_supervised VALUES ('1111111113', '1111111111');
INSERT INTO is_supervised VALUES ('1111111114', '1111111112');
INSERT INTO is_supervised VALUES ('1111111115', '1111111112');
INSERT INTO is_supervised VALUES ('1111111116', '1111111114');
INSERT INTO is_supervised VALUES ('1111111117', '1111111114');
INSERT INTO is_supervised VALUES ('1111111118', '1111111114');
INSERT INTO is_supervised VALUES ('1111111119', '1111111116');
INSERT INTO is_supervised VALUES ('1111111120', '1111111114');
INSERT INTO is_supervised VALUES ('1111111121', '1111111115');
INSERT INTO is_supervised VALUES ('1111111122', '1111111116');

INSERT INTO Evaluation VALUES ('1111111112', '1111111111', '20221030', 3);
INSERT INTO Evaluation VALUES ('1111111113', '1111111111', '20221030', 4);
INSERT INTO Evaluation VALUES ('1111111114', '1111111112', '20221010', 2);
INSERT INTO Evaluation VALUES ('1111111115', '1111111112', '20221028', 3);
INSERT INTO Evaluation VALUES ('1111111114', '1111111112', '20221030', 3);
INSERT INTO Evaluation VALUES ('1111111116', '1111111114', '20221030', 1);
INSERT INTO Evaluation VALUES ('1111111117', '1111111114', '20221030', 2);
INSERT INTO Evaluation VALUES ('1111111118', '1111111114', '20221020', 3);
INSERT INTO Evaluation VALUES ('1111111118', '1111111114', '20221030', 4);
INSERT INTO Evaluation VALUES ('1111111119', '1111111116', '20220930', 3);
INSERT INTO Evaluation VALUES ('1111111119', '1111111116', '20221030', 3);
INSERT INTO Evaluation VALUES ('1111111120', '1111111114', '20220930', 3);
INSERT INTO Evaluation VALUES ('1111111120', '1111111114', '20220830', 3);
INSERT INTO Evaluation VALUES ('1111111120', '1111111114', '20220730', 4);
INSERT INTO Evaluation VALUES ('1111111120', '1111111114', '20221030', 4);
INSERT INTO Evaluation VALUES ('1111111121', '1111111115', '20220830', 2);
INSERT INTO Evaluation VALUES ('1111111122', '1111111116', '20220830', 3);
INSERT INTO Evaluation VALUES ('1111111122', '1111111116', '20220930', 4);
INSERT INTO Evaluation VALUES ('1111111122', '1111111116', '20221030', 4);

-- ------ 

-- Find the badges and names of all elves who work in a workshop named "NorthStar"

select * 
from Elf
join Workshop on Workshop.wname = Elf.Wname
where Workshop.wname = "NorthStar";


-- Find the badges and names of all elves who work at the "NorthStar" or "EastStar" workshops

select Elf.badge, Elf.name
from Elf
join Workshop on Workshop.wname = Elf.wname
where Workshop.wname = "NorthStar" or Workshop.wname = "EastStar";

-- Find the number of elves each supervisor supervises. Display the supervisors' badges along with the number of elves. 



-- Consider all elves who work in the "NorthStar" workshop. Find the badges of their supervisors. 

-- List the badges of all supervisors who supervise at least 3 elves 

select sbadge, Count(Elf.badge) as num_supervised
from is_supervised
join Elf on Elf.badge = is_supervised.badge
group by sbadge
having Count(Elf.badge) >=3;

-- Find the elves who work in the same workshop as their supervisors. Display the elves' badges and their supervisors' badges. 

select E1.badge, E2.badge, E1.wname
from Elf E1, Elf E2, is_supervised
where E1.badge = is_supervised.badge and E2.badge = is_supervised.sbadge
and E1.wname = E2.wname;

-- Find the information of all toys built in "NorthStar" or "EastStar" workshops

-- Find the information of all toys built in "NorthStar" and "EastStar" workshops

-- Find the information of all toys built in "NorthStar" workshop but not in "EastStar" workshop

select Distinct Toy.* 
from Toy
join Built_in on Built_in.toy_id = Toy.toy_id
where Built_in.wname = "NorthStar"
and not exists (
	select 1
    from Built_in
    where Built_in.toy_id = Toy.toy_id
    and Built_in.wname = "EastStar"
);


-- Consider all elves who work in the "NorthStar" workshop. Find their supervisors' badges and names

select E2.badge, E2.name, E2.wname
from Elf E1
inner join is_supervised on E1.badge = is_supervised.badge
inner join Elf E2 on E2.badge = is_supervised.sbadge
where E1.wname = "NorthStar";


-- Find the number of evaluations each rater has rated. List the names of the raters along with the number evaluations 