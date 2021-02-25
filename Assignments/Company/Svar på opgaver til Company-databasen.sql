/*Opgaver til Company-databasen
Q1: Vis navn og adresse på samtlige medarbejdere i ‘research’-afdelingen.
Svar:*/
SELECT employee.fname, employee.lname, employee.address FROM employee, department 
		WHERE department.dname = 'Research' AND employee.dno = department.dnumber;

/*Q2: Vis fornavn og fødselsdag på John Smiths kone.
Svar:*/
SELECT dependent.dependent_name, dependent.bdate FROM dependent, employee
		WHERE dependent.essn = employee.ssn AND employee.fname = 'John' AND employee.lname = 'Smith' AND dependent.relationship = 'Spouse';

/*Q3: Vis navn på alle chefer.
Svar:*/
SELECT employee.fname, employee.lname FROM employee, department
		WHERE employee.ssn = department.mgrssn;

/*Q4: Vis ansattes navn og fødselsdag sorteret efter alder.
Svar:*/
SELECT employee.fname, employee.bdate FROM employee
	ORDER BY employee.bdate ASC;

/*Q5: Opret ny dependent, som hedder Joe, er født den 12. december 1992 og søn af 555777222.
Svar:*/
insert into dependent values 
 (555777222,'Joe','M','1992-12-12','Son');

/*Q6: Opret ny ansat Harold S. Viehman født den 18. oktober 1947. Han bor på adressen 840 Belfry Drive, Lansdale, Pa. 
og har social security number 569123456. Han skal have arbejdsplads i Stafford og Jennifer Wallace som chef. Løn: $ 45.000.

Kan ikke laves da der ikke er en employee med ssn 555777222, men hvis der var, så var svaret:*/
insert into employee values ('Harold S.','Viehman',569123456,'1947-10-18','840 Belfry Drive, Lansdale, Pa','M',45000,987654321,4);

/*Q7: Joyce English er flyttet til adressen 211 Chalon Street, Austin, Texas.
Del 1: Find Joyces ssn*/
SELECT employee.ssn FROM employee 
WHERE employee.fname = 'Joyce' AND employee.lname = 'English' AND employee.ssn = '453453453';x  

/*Del 2:*/
UPDATE employee
SET
	address = '211 Chalon Street, Austin, TX'
WHERE
	WHERE employee.fname = 'Joyce' AND employee.lname = 'English';

/*Q8: Jennifer Wallaces mand er afgået ved døden.
Del 1: Find konens ssn*/
SELECT employee.ssn FROM employee 
WHERE employee.fname = 'Jennifer' AND employee.lname = 'Wallace';

/*Del 2:*/
DELETE FROM dependent
WHERE employee.fname = 'Jennifer' AND employee.lname = 'Wallace'
WHERE employee.ssn = dependent.essn AND dependent.relationship = 'Spouse';

/*Q9: Vis navn og adresse på ansatte, som ikke bor i Texas.
Svar:*/
SELECT employee.fname, employee.lname, employee.address FROM employee
		WHERE employee.address NOT LIKE '%TX%';

/*Q10: Vis navnene på de ansatte, som tjener over $ 40.000.
Svar:*/
SELECT employee.fname, employee.lname, employee.salary FROM employee
		WHERE employee.salary > 40000
			ORDER BY employee.salary DESC;