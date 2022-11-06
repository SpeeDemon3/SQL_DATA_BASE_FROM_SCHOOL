/*Muestra el nombre y la edad de los alumnos que han aprobado sociales 
pero no han aprobado matemáticas*/

USE ESCUELA;

SELECT * FROM ASIGNATURAS;

SELECT A.NOMBRE, A.EDAD FROM ALUMNOS A 
	INNER JOIN NOTAS N ON A.numexp = N.numexp
	INNER JOIN ASIGNATURAS ASIG ON ASIG.CODIASIG = N.CODIASIG
WHERE  (N.NOTA >= 5 AND ASIG.NOMBRE = 'SOCIALES') 
AND A.NUMEXP=ANY(SELECT N.NUMEXP FROM NOTAS N
				INNER JOIN ASIGNATURAS ASI ON ASI.codiasig = N.codiasig
				WHERE N.NOTA < 5 AND ASI.CIDIASIG='MAT1E');


/*Devuelve el nombre de los alumnos que su media de notas es superior a 
la media de Matemáticas y menor que la media de Sociales*/

SELECT A.NOMBRE, AVG(NOTA) AS 'NOTA MEDIA' FROM ALUMNOS A 
INNER JOIN NOTAS N ON A.NUMEXP = N.NUMEXP 
GROUP BY A.NOMBRE
HAVING AVG(N.NOTA) > (SELECT AVG(NOTA) FROM NOTAS N
				INNER JOIN  ASIGNATURAS A 
                ON N.CODIASIG = A.CODIASIG
                WHERE A.NOMBRE = 'MATEMATICAS')
                AND AVG(N.NOTA) < ( SELECT AVG(N.NOTA) FROM NOTAS N
							  INNER JOIN ASIGNATURAS A 
                              ON N.CODIASIG = A.CODIASIG
                              WHERE A.NOMBRE = 'SOCIALES');

/*Muestra el nombre y la cantidad de asignaturas aprobadas de los alumnos que 
han aprobado más asignaturas que "Llamas Rocasolano, Isabel"*/

SELECT * FROM ALUMNOS;

SELECT A.NOMBRE, COUNT(N.NOTA) AS 'NOTA' FROM ALUMNOS A
INNER JOIN NOTAS N ON A.NUMEXP = N.NUMEXP
INNER JOIN ASIGNATURAS ASI ON N.CODIASIG = ASI.CODIASIG
WHERE N.NOTA > 5
GROUP BY A.NOMBRE
HAVING COUNT(N.NOTA) > (SELECT COUNT(NOTA) FROM NOTAS
				INNER JOIN ALUMNOS ON ALUMNOS.NUMEXP = NOTAS.NUMEXP
                WHERE ALUMNOS.NOMBRE = 'LLAMAS ROCASOLANO, ISABEL'
                AND NOTA >= 5);

/*Cuenta de cuántos profesores es jefe cada profesor.*/

SELECT X.NOMBRE, COUNT(X.DNIPROFE) AS 'ES JEFE DE' 
FROM PROFESORES X
INNER JOIN PROFESORES Y ON X.DNIPROFE = Y.JEFEDPTO
GROUP BY X.NOMBRE;


