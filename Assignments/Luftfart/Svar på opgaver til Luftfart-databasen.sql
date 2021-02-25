# Først laver vi schema'et
CREATE SCHEMA luftfart;

# Så indsætter vi dataene
create table land (
  land_id int not null,
  navn char(25) not null,
  primary key (land_id)
); 

create table city (
  city_id int not null,
  navn char(25) not null,
  land_id int not null,	
  primary key(city_id),
  foreign key (land_id) references land(land_id)
);

create table lufthavn(
  lufthavn_id int not null,
  navn char(25) not null,
  city_id int not null,
  primary key (lufthavn_id),
  foreign key (city_id) references city(city_id)
);

create table flyselskab(
  flyselskab_id int not null,
  navn char(25) not null,
  land_id int not null,
  primary key (flyselskab_id),
  foreign key (land_id) references land(land_id)
);

create table operererfra(
  operererfra_id int not null,
  flyselskab_id int not null,
  lufthavn_id int not null,
  primary key (operererfra_id),
  foreign key (flyselskab_id) references flyselskab(flyselskab_id),
  foreign key (lufthavn_id) references lufthavn(lufthavn_id)
);

insert into land values
 (1,'Danmark'),
 (2,'Norge'),
 (3,'Tyskland'),
 (4,'USA');
 
insert into city values
 (1,'København',1),
 (2,'Oslo',2),
 (3,'Berlin',3),
 (4,'New York',4),
 (5,'Los Angeles',4);

insert into lufthavn values
 (1,'Kastrup Lufthavn',1),
 (2,'Gardermoen',2),
 (3,'Tegel',3),
 (4,'LaGuardia',4),
 (5,'Kennedy Airport',4),
 (6,'Los Angeles Intl. Airport',5);

insert into flyselskab values
 (1,'SAS',1),
 (2,'Norweigian',2),
 (3,'Lufthansa',3),
 (4,'Delta Airlines',4),
 (5,'American Airlines',4);

insert into operererfra values
 (1,1,1),
 (2,1,2),
 (3,2,2),
 (4,3,3), 
 (5,3,5),
 (6,4,4),
 (7,4,5),
 (8,4,6),
 (9,5,1),
 (10,5,6);
 
#Q1 - 










