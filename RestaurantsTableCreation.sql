--RName,Rating,Category,Address,PhoneNumber,Latitude,Longitude,LocationName

--create table Restaurants

DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants(

	RestaurantPK SERIAL PRIMARY KEY NOT NULL,
	RName VARCHAR(200),Rating VARCHAR(50),Category VARCHAR(50),Address VARCHAR(200),PhoneNumber VARCHAR(50),Latitude REAL,Longitude REAL, LocationName VARCHAR(100),
	RGeom GEOMETRY DEFAULT ST_GeomFromText('POINT(-6.4 56.7)', 4326)
);

--create a spacial index
CREATE INDEX "Restaurants_geom_index" ON Restaurants USING gist (RGeom);

BEGIN;

UPDATE Restaurants
SET RGeom = ST_GeomFromText('POINT('||Longitude||' '||Latitude||')',4326);
select *, st_astext(RGeom) from Restaurants;

COMMIT;
ROLLBACK;