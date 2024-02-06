select * from restaurants;
select * from hpfilminglocations order by locationname asc;

drop view if exists RestaurantView;

create or replace view RestaurantView as

select r.restaurantpk, hp.ogc_fid, hp.movie, hp.locationname,r.rname, r.rgeom,
st_distance(hp.wkb_geometry, r.rgeom) as distance, 
rank() over (partition by hp.locationname order by st_distance(hp.wkb_geometry, r.rgeom) asc ) as Ranking
from hpfilminglocations as hp, restaurants as r 
where hp.locationname = r.locationname 
and st_distance(hp.wkb_geometry, r.rgeom)<=800 order by locationname asc;

select * from restaurantview;



drop view if exists RestaurantViewFinal;

create or replace view RestaurantViewFinal as

select * from RestaurantView where ranking =1; 



select * from RestaurantViewFinal;