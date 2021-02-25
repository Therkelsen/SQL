# Først laver vi SCHEMA'et
CREATE SCHEMA fugleobservationer;

# Så smider vi alle værdierne ind
create table familie (
  familie_id int not null,
  navn char(50) not null,
  latinsknavn char(50) not null,
  primary key (familie_id)
); 

create table fugl (
  fugl_id int not null,
  navn char(50) not null,
  latinsknavn char(50) not null,
  familie_id int not null,
  primary key(fugl_id),
  foreign key (familie_id) references familie(familie_id)
);

create table lokation(
  lokation_id int not null,
  navn char(40) not null,
  primary key (lokation_id)
);

create table observation(
  observation_id int not null,
  dato date not null,
  antal int not null,	
  lokation_id int not null,
  fugl_id int not null,
  primary key (observation_id),
  foreign key (lokation_id) references lokation(lokation_id),
  foreign key (fugl_id) references fugl(fugl_id)
);

insert into familie values
 (1,'Kragefugle','Corvidae'),
 (2,'Brokfugle','Charadriidae'),
 (3,'Mejser','Paridae');
insert into fugl values
 (1,'Skovskade','Garralus glandarius',1),
 (2,'Allike','Corvus monedula',1),
 (3,'Vibe','Vanellus vanellus',2),
 (4,'Stor præstekrave','Charadrius hiaticula',2),
 (5,'Musvit','Parus major',3),
 (6,'Blåmejse','Cyanistes caeruleus',3);
insert into lokation values
 (1,'Enebærodde'),
 (2,'Knudshoved'),
 (3,'Vresen'),
 (4,'Gamborg Fjord'),
 (5,'Fyns Hoved');
insert into observation values
 (1,'2014-10-18',7,2,2),
 (2,'2012-09-23',64,5,3),
 (3,'1996-02-01',1,1,1),
 (4,'2002-11-17',7,3,4),
 (5,'2018-12-29',5,1,6); 	 
 
# Q1 - Vis navnene på de fugle som er blevet observeret på lokationen Vresen. 
SELECT fugl.navn
FROM fugl, lokation, observation
WHERE lokation.navn = 'Vresen' AND lokation.lokation_id = observation.lokation_id AND observation.fugl_id = fugl.fugl_id;

#Q2 - Vis det samlede observerede antal fugle, som tilhører familien brokfugle.
SELECT SUM(observation.antal)
FROM observation, familie, fugl
WHERE familie.navn = 'Brokfugle' AND observation.fugl_id = fugl.fugl_id AND fugl.familie_id = familie.familie_id;

#Q3 - Vis navnene på de fugle, som er blevet observeret i december måned.
#	  Hvert navn må kun forekomme én gang.
SELECT DISTINCT(fugl.navn)
FROM fugl, observation
WHERE observation.dato LIKE '%-12-%' AND fugl.fugl_id = observation.fugl_id;

#Q4 - Vis navnene på de lokationer, hvor der er observeret fugle af familien corvidae.
SELECT lokation.navn
FROM fugl, familie, observation, lokation
WHERE familie.latinsknavn = 'Corvidae' AND fugl.familie_id = familie.familie_id 
	  AND fugl.fugl_id = observation.fugl_id AND observation.lokation_id = lokation.lokation_id;

#Q5 - Vis datoen for databasens ældste observation.
SELECT observation.dato
FROM observation
ORDER BY observation.dato ASC
LIMIT 1;

#Q6 - Vis navnene på de lokationer, som ikke har observationer.
SELECT DISTINCT lokation.navn
FROM lokation, observation
WHERE lokation.lokation_id NOT IN (SELECT lokation_id FROM observation);