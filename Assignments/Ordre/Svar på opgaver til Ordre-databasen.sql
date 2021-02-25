# Først laver vi schemaet
CREATE SCHEMA ordrestyring;

# Indsætter værdierne
create table postnummer (
  postnummer_id numeric(4) not null,
  bynavn char(20) not null,
  primary key (postnummer_id)
); 

create table kunde (
  kunde_id numeric(3) not null,
  navn char(20) not null,  
  adresse char(20) not null, 
  postnr numeric(4) not null,  
  primary key (kunde_id),
  foreign key (postnr) references postnummer(postnummer_id)
); 

create table ordre (
  ordre_id numeric(4) not null,
  ordredato date not null,
  kunde_id numeric(3) not null,
  primary key (ordre_id), 
  foreign key (kunde_id) references kunde(kunde_id)
); 

create table vare(
  vare_id numeric(5) not null,
  betegnelse char(20) not null, 
  pris numeric(3) not null,
  primary key (vare_id)  
); 

create table ordrelinje(
  ordrelinje_id numeric(2) not null,
  antal numeric(2) not null,
  ordre_id numeric(4) not null,
  vare_id numeric(5) not null,
  primary key (ordrelinje_id),
  foreign key (ordre_id) references ordre(ordre_id),
  foreign key (vare_id) references vare(vare_id)
);	

insert into postnummer values
 (5000, 'Odense C'),
 (3070, 'Snekkersten'),
 (9510, 'Arden');

insert into kunde values
 (101, 'Kurt Poulsen','Strandvejen 17',3070),
 (102, 'Torben Jensen', 'Louiselund 73',5000),
 (103, 'Hans Nielsen', 'Toftevej 2',3070);

insert into ordre values 
 (3001,'2019-01-12', 103),
 (3002,'2019-01-14', 102),
 (3003,'2019-01-06', 101);

insert into vare values 
 (10001,'Gipsplade', 23),
 (10002,'Stolpe 2,4 m', 48),
 (10003,'Skruetvinge', 159),
 (10004,'Boltsaks', 206); 

insert into ordrelinje values 
 (1,25,3001,10001),
 (2,1,3001,10004),
 (3,4,3002,10002),
 (4,2,3002,10003),
 (5,10,3003,10001),
 (6,5,3003,10002),
 (7,1,3003,10003),
 (8,1,3003,10004);	
 		
#Q1 - Skriv en forespørgsel, som kan angive det samlede antal gipsplader i ordre med overskriften Gipsplader i ordre. 
SELECT ordrelinje.antal AS 'Gipsplader i ordre'
FROM ordrelinje, vare
WHERE ordrelinje.vare_id = vare.vare_id AND vare.betegnelse = 'Gipsplade';

#Q2 - Skriv en forespørgsel som kan udskrive det samlede beløb i ordre (dvs. pris gange antal for samtlige ordrelinjer).
#     Hint: det korrekte svar for de givne testdata er 2.126 kr. 
SELECT SUM(vare.pris * ordrelinje.antal) AS 'Samlet pris for samtlige ordrelinjer'
FROM vare, ordrelinje
WHERE vare.vare_id = ordrelinje.vare_id;

#Q3 - Udskriv antallet af ordrer fra kunder med bopæl i Snekkersten.
SELECT COUNT(*) AS 'Ordrer fra kunder med bopæl i Snekkersten'
FROM ordre, kunde, postnummer
WHERE ordre.kunde_id = kunde.kunde_id 
	  AND kunde.postnr = postnummer.postnummer_id 
      AND postnummer.bynavn = 'Snekkersten';

#Q4 - Udskriv navnene på de kunder, som har mindst én boltsaks i ordre.
SELECT kunde.navn
FROM kunde, ordre, ordrelinje, vare
WHERE ordre.ordre_id = ordrelinje.ordre_id AND ordre.kunde_id = kunde.kunde_id
	  AND ordrelinje.vare_id = vare.vare_id AND vare.betegnelse = 'Boltsaks' AND ordrelinje.antal > 0;
      
#Q5 - Udskriv navnene på den/de by(er) som ikke har kunder. Hint: det korrekte svar for de givne data er Arden
SELECT DISTINCT postnummer.bynavn
FROM postnummer, kunde
WHERE postnummer.postnummer_id NOT IN (SELECT postnr FROM kunde);









