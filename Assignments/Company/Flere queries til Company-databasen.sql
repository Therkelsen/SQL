# Query 24: For hver afdeling vises afdelingsnummer, antal ansatte i afdelingen og deres gennemsnitlige løn.
SELECT		Dno, COUNT(*), AVG(Salary)
FROM		EMPLOYEE
GROUP BY	Dno;

# Query 25: For hvert projekt vis nummer, navn og antal medarbejdere på projektet.
SELECT		Pnumber, Pname, COUNT(*)
FROM		PROJECT, WORKS_ON
WHERE		Pnumber = Pno
GROUP BY	Pnumber, Pname
ORDER BY	Pnumber ASC;

#Der kan opstå behov for at begrænse antallet af resultater. Hertil kan anvendes keywordet HAVING.
#Query 26: For hvert projekt med mere end to medarbejdere vis nummer, navn og antal medarbejdere.
SELECT		Pnumber, Pname, COUNT(*)
FROM		PROJECT, WORKS_ON
WHERE		Pnumber = Pno
GROUP BY	Pnumber, Pname
HAVING		COUNT(*) > 2
ORDER BY	Pnumber ASC;

#Query 27: Vis projektnummer og –navn og antal ansatte fra afdeling 5, som arbejder på projektet.
SELECT		Pnumber, Pname, COUNT(*)
FROM		PROJECT, WORKS_ON, EMPLOYEE
WHERE		Pnumber=Pno AND Ssn=Essn AND Dno=5
GROUP BY	Pnumber, Pname
ORDER BY	Pnumber ASC;

#Query 28: Find antal medarbejdere med mere i løn end $ 40.000 i afdelinger med mere end fem medarbejdere.
SELECT		Dnumber, COUNT(*)
FROM		DEPARTMENT, EMPLOYEE
WHERE		Dnumber = Dno AND Salary > 40000 AND
		(SELECT		Dno
		 FROM		EMPLOYEE
		 GROUP BY	Dname
		 HAVING		COUNT(*) > 5);

#Join - Vis navn og adresse på ansatte i Research-afdelingen.
SELECT		Fname, Lname, Address
FROM		Employee, Department
WHERE 		Dno = Dnumber AND Dname = 'Research';

SELECT		Fname, Lname, Address
FROM		(EMPLOYEE JOIN DEPARTMENT ON Dno=Dnumber)
WHERE		Dname = 'Research';

# NATURAL JOIN - Dette er til fiskedatabasen, virker ikke i company
SELECT navn, tid 
FROM fisk NATURAL JOIN fangst;

SELECT navn, tid 
FROM fisk, fangst
WHERE fangst.fisk_id = fisk.fisk_id;

