SELECT * FROM restaurant_review.google;
SELECT * FROM restaurant_review.yelp;
SELECT * FROM restaurant_review.zomato;

SELECT * FROM restaurant_review.yelp ORDER BY name;
SELECT * FROM restaurant_review.zomato ORDER BY name;
SELECT * FROM restaurant_review.google order by name;

-- Matching with phone number. == 
use restaurant_review;
select yelp.*, zomato.*
FROM yelp
INNER JOIN zomato ON yelp.phone_number = zomato.phone_number
INNER JOIN table3 ON table3.col = yelp.col;

-- yelp and Zomato
create table `yelp_zomato`
select y.name as yelp_name, y.phone_number as yelp_phone, y.postal_code, y.address as yelp_address, y.rating as yelp_rating , y.cost as y_cost, z.name as zomato_name, z.rating as zomato_rating, z.address as zomato_address 
FROM yelp y
LEFT JOIN zomato z ON REPLACE(y.name,' ','') =  REPLACE(z.name,' ','');

-- Google and Zomato
select google.*, zomato.*
FROM google
RIGHT JOIN zomato ON REPLACE(google.name,' ','') =  REPLACE(zomato.name,' ','');

-- Google and Yelp
select google.*, yelp.*
FROM google
RIGHT JOIN yelp ON REPLACE(google.name,' ','') =  REPLACE(yelp.name,' ','');

-- outer join 
SELECT yelp.*, zomato.*
FROM yelp
LEFT JOIN zomato ON  REPLACE(yelp.name,' ','') =  REPLACE(zomato.name,' ','')
UNION ALL
SELECT yelp.*, zomato.*
FROM yelp
RIGHT JOIN zomato ON yelp.name = zomato.name;


-- all three join
create table `Combined`
select yz.*, g.name as google_name, g.rating as google_rating, g.address as google_address, g.price as google_price
FROM yelp_zomato yz
LEFT JOIN google g ON REPLACE(yz.yelp_name,' ','') =  REPLACE(g.name,' ','');

select * from yelp_zomato;
select * from Combined;
