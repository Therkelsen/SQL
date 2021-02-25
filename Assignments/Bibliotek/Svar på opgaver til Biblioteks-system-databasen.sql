#Først skal vi have et schema
create schema librarysystem;

#Så skal vi lige have tre tables med de givne attributes
create table book (
  btitle char(75) not null,
  releasedate char(11) not null,
  wname char(50) not null,
  isbn int not null,
  ldate char(11) not null,
  lcpr bigint not null,
  
  primary key (btitle),
  unique (btitle)
);

create table writer (
  wname char(50) not null,
  nationality char(50) not null,
  byear int not null,
  dyear int not null,
  
  primary key (wname),
  unique (wname)
);

create table loaner (
  lname char(50) not null,
  laddress char(75) not null,
  lcpr bigint not null,
  
  primary key (lcpr),
  unique (lname)
);

#Så sætter vi nogle værdier ind i tabellerne
insert into writer values
	('Joanne Kathleen Rowling','Yate, Gloucestershire, England', 1965, 0000),
    ('John Ronald Reuel Tolkien', 'Bloemfontein, Orange Free State', 1892, 1973),
    ('George Raymond Richard Martin', 'Bayonne, Hudson County, New Jersey, U.S.', 1948, 0000);

insert into loaner values
	('Tonni', 'Rosengaardscenteret', 1234567890),
    ('Not Tonni', 'Not Rosengaardscenteret', 0123456789),
    ('Marianne', 'Gamerstreet', 9876543210);

insert into book values
	(btitle, releasedate, wname, isbn, ldate, lcpr),
    ('Harry Potter and the Philosopher\'s Stone', 1997-06-26, 'Joanne Kathleen Rowling', 0747532699, 2021-01-01, 1234567890),
    ('The Lord of the Rings', 1954-07-29, 'John Ronald Reuel Tolkien', 0000000000, 2021-01-02, 0123456789),
    ('A Game of Thrones', 1996-08-01, 'George Raymond Richard Martin', 	0-553-10354-7, 2021-01-03, 9876543210);

#Q1 - Lav en liste over titlerne på samtlige bøger.
select book.btitle
from book;

#Q2 - Lav en liste over samtlige forfattere.
select writer.wname
from writer;

#Q3 - Lav en liste indeholdende bogtitel og forfatternavn.
select book.btitle, book.wname
from book;

#Q4 - Lav en liste over bogtitler med forfatter og udgivelsesår i stigende orden.
select book.btitle, book.wname, book.releasedate
from book
order by book.releasedate asc;

#Q5 - Lav en liste over navne på lånere, som bor i Odense.
select loaner.lname
from loaner
where loaner.laddress like '%Odense%';

#Q6 - Vis låners navn, forfatter og titel på alle udlånte bøger.
select loaner.lname, book.wname, book.btitle
from loaner, book
where loaner.lcpr = book.lcpr;

#Q7 - Vis antallet af udlånte bøger til en navngiven låner.
select loaner.lname, book.btitle
from loaner, book
where loaner.lcpr = book.lcpr AND loaner.lname = 'Marianne';

#Q8 - Vis navnene på de forfattere, som har udlånt bøger.
select book.wname
from loaner, book
where loaner.lcpr = book.lcpr;
