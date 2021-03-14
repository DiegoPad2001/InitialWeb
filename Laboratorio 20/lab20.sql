

--Mostrar los datos de la tabla materiales--
select * from materiales


--Mostrar solamente los materiales que tengan la clave 1000--
select * from materiales
where clave=1000

--Mostrar la clave, rfc y fecha de la tabla entregan--
select clave,rfc,fecha from entregan

--Mostrar todos los campos de las tablas materiales y entregan con su relacion correspondiente--
select * from materiales,entregan
where materiales.clave = entregan.clave

--Mostrar todos los campos de la tabla entregan y proyecto, con una relacion condicional--
select * from entregan,proyectos
where entregan.numero < = proyectos.numero

--Mostrar todo los registros de la tabla entregan que tengan como clave 1450 o 1300--
select * from entregan where clave=1450
union
select * from entregan where clave=1300

--Lo mismo que el anterior pero sin union--
select * from entregan where clave=1450 or clave=1300

--Producto cartesiano--
select * from entregan,materiales

--�C�mo est� definido el n�mero de tuplas de este resultado en t�rminos del n�mero de tuplas de entregan y de materiales?--
--Es la multiplicacion de el numero de tuplas de la tabla entregan por el numero de tuplas de la tabla materiales--

--Plantea ahora una consulta para obtener las descripciones de los materiales entregados en el a�o 2000.--

set dateformat dmy
SELECT descripcion
FROM Materiales, Entregan
WHERE Materiales.clave=Entregan.Clave
AND Fecha>'31/12/1999' AND Fecha<'01/01/2001'

--�Por qu� aparecen varias veces algunas descripciones de material?
--Porque se hizo varias veces la entrega de ese mismo material

--Uso del calificador distinct
set dateformat dmy
SELECT DISTINCT descripcion
FROM Materiales, Entregan
WHERE Materiales.clave=Entregan.Clave
AND Fecha>'31/12/1999' AND Fecha<'01/01/2001'

--�Qu� resultado obtienes en esta ocasi�n?
--El mismo resultado de la anterior busqueda solo que ahora sin repeticion

--Obt�n los n�meros y denominaciones de los proyectos con las fechas y cantidades de sus entregas, ordenadas por n�mero de proyecto, presentando las fechas de la m�s reciente a la m�s antigua.

SELECT Proyectos.Numero, Denominaci�n, fecha, Cantidad
FROM Proyectos, Entregan
WHERE Proyectos.Numero=Entregan.Numero
ORDER BY Proyectos.Numero, Fecha DESC

--Operadores de cadena
SELECT * FROM Materiales where Descripcion LIKE 'Si%'

--�Qu� resultado obtienes?
--Todos las tuplas en donde su descripcion inicia con "Si"

--Explica que hace el s�mbolo '%'.
--Es algo que se�aliza que despues de sus caracteres predecesores hay mas caracteres

--�Qu� sucede si la consulta fuera : LIKE 'Si' ?
SELECT * FROM Materiales where Descripcion LIKE 'Si'

--�Qu� resultado obtienes?
--Ninguno

--Explica a qu� se debe este comportamiento.
--Sin el signo de % solo mostrara las que coincide completamente con esa cadena de de caracteres


DECLARE @foo varchar(40);
DECLARE @bar varchar(40);
SET @foo = '�Que resultado';
SET @bar = ' ���??? '
SET @foo += ' obtienes?';
PRINT @foo + @bar;

--�Qu� resultado obtienes de ejecutar el siguiente c�digo?
--�Que resultado obtienes? ���??? 

--�Para qu� sirve DECLARE?
--Para declarar una variable tipo

--�Cu�l es la funci�n de @foo?
--Guardar un valor

--�Que realiza el operador SET?
--Darle el valor a la variable

--Ahora explica el comportamiento, funci�n y resultado de cada una de las siguientes consultas:

--Los rfc de la tabla entregan que comienzen con alguna de las letras de la A a la D
SELECT RFC FROM Entregan WHERE RFC LIKE '[A-D]%';

--Los rfc de la tabla entregan que no comienzen con la letra A
SELECT RFC FROM Entregan WHERE RFC LIKE '[^A]%';

--Los Numeros de la tabla entregan cuando contengan al final el numero 6
SELECT Numero FROM Entregan WHERE Numero LIKE '___6';

--Operadores L�gicos

--BETWEEN
SELECT Clave,RFC,Numero,Fecha,Cantidad
FROM Entregan
WHERE Numero Between 5000 and 5010;

--�C�mo filtrar�as rangos de fechas?
--Con un Between 'dd/mm/yy' and ''dd/mm/yy'

--EXIST
SELECT RFC,Cantidad, Fecha,Numero
FROM [Entregan]
WHERE [Numero] Between 5000 and 5010 AND
Exists ( SELECT [RFC]
FROM [Proveedores]
WHERE RazonSocial LIKE 'La%' and [Entregan].[RFC] = [Proveedores].[RFC] )

--�Qu� hace la consulta?
--Regresar rfc, cantidad, fecha y numero de la tabla entregan siempre y cuando el numero este entre 5000 y 5010, ademas de que la razon social debe de iniciar con 'La'

--�Qu� funci�n tiene el par�ntesis ( ) despu�s de EXISTS?
--Realizar una subconsulta

--�Qu� hace la siguiente sentencia? Explica por qu�.
SELECT TOP 2 * FROM Proyectos
--Devuelve los primeros valores de la tabla proyectos, esto gracias a la funcion top

--�Qu� sucede con la siguiente consulta? Explica por qu�
--SELECT TOP Numero FROM Proyectos
--Marca error de sintaxix
--La funcion top solo acepta valores numericos

--Agrega a la tabla materiales la columna PorcentajeImpuesto con la instrucci�n:
ALTER TABLE materiales ADD PorcentajeImpuesto NUMERIC(6,2);

--A fin de que los materiales tengan un impuesto, les asignaremos impuestos ficticios basados en sus claves con la instrucci�n:
--UPDATE materiales SET PorcentajeImpuesto= 2*clave/1000;

--Creaci�n de vistas

--CREATE VIEW materialesSi AS SELECT * FROM Materiales where Descripcion LIKE 'Si'
select * from Entregan

-- Los materiales (clave y descripci�n) entregados al proyecto "M�xico sin ti no estamos completos".
SELECT Materiales.clave, descripcion
from Materiales, Proyectos, Entregan
WHERE Materiales.clave=Entregan.clave AND Entregan.Numero=Proyectos.Numero
AND Denominaci�n='Mexico sin ti no estamos completos'

--Los materiales (clave y descripci�n) que han sido proporcionados por el proveedor "Acme tools".

SELECT Materiales.clave, descripcion
from Materiales, Proveedores, Entregan
WHERE Materiales.clave=Entregan.clave AND Entregan.RFC=Proveedores.RFC
AND RazonSocial='Acme tools'

-- El RFC de los proveedores que durante el 2000 entregaron en promedio cuando menos 300 materiales.
SELECT* FROM Entregan

set dateformat dmy
SELECT Proveedores.RFC, AVG(cantidad) as PromedioEntrega
from Proveedores, Entregan
WHERE Proveedores.RFC=Entregan.RFC
AND Fecha>'31/12/1999' AND Fecha<'01/01/2001'
GROUP BY proveedores.RFC
HAVING AVG(cantidad)>300

--      El Total entregado por cada material en el a�o 2000.

SELECT descripcion, SUM(Cantidad) as CantidadTotal
FROM Materiales, Entregan
WHERE Materiales.clave=Entregan.Clave
AND Fecha>'31/12/1999' AND Fecha<'01/01/2001'
Group By Descripcion

-- Productos que contienen el patr�n 'ub' en su nombre.
SELECT * from Entregan
SELECT descripcion from Materiales WHERE Descripcion LIKE '%ub%'

--   Denominaci�n y suma del total a pagar para todos los proyectos.
--SELECT Denominaci�n, (cantidad*costo) as total
--FROM Proyectos, Entregan, Materiales
--WHERE Proyectos.Numero=Entregan.Numero AND Entregan.Clave=Materiales.Clave
--ORDER BY Denominaci�n

CREATE VIEW CostosMaterialProyecto as SELECT Denominaci�n, (cantidad*costo) as total
FROM Proyectos, Entregan, Materiales
WHERE Proyectos.Numero=Entregan.Numero AND Entregan.Clave=Materiales.Clave

SElECT Denominaci�n, SUM(total) as CostoProyecto
FROM CostosMaterialProyecto
GROUP BY Denominaci�n

--Costo de los materiales y los Materiales que son entregados al proyecto Televisa en acci�n cuyos proveedores tambi�n suministran materiales al proyecto Educando en Coahuila.

CREATE VIEW ProveedoresTelevisa as (SELECT Denominaci�n, Entregan.RFC, RazonSocial
FROM Proyectos, Proveedores, Entregan
WHERE Denominaci�n LIKE '%Televisa%' And Entregan.RFC=Proveedores.RFC 
AND Proyectos.Numero=Entregan.Numero )

CREATE VIEW ProveedoresCoahuila as (SELECT RazonSocial
FROM Proyectos, Proveedores, Entregan
WHERE Proyectos.Numero=Entregan.Numero And Entregan.RFC=Proveedores.RFC
AND Denominaci�n LIKE '%Educando en Coahuila%')

 --drop view ProveedoresCoahuila

SELECT ProveedoresTelevisa.Denominaci�n, ProveedoresTelevisa.RFC, ProveedoresTelevisa.RazonSocial FROM ProveedoresTelevisa, ProveedoresCoahuila
WHERE ProveedoresTelevisa.RazonSocial in(ProveedoresCoahuila.RazonSocial)

-- Denominaci�n, RFC y RazonSocial de los proveedores que se suministran materiales al proyecto Televisa en acci�n que no se encuentran apoyando al proyecto Educando en Coahuila (Solo usando vistas).
--Denominaci�n, RFC y RazonSocial de los proveedores que se suministran materiales al proyecto Televisa en acci�n que no se encuentran apoyando al proyecto Educando en Coahuila (Sin usar vistas, utiliza not in, in o exists).
SELECT Distinct ProveedoresTelevisa.Denominaci�n, ProveedoresTelevisa.RFC, ProveedoresTelevisa.RazonSocial FROM ProveedoresTelevisa, Proveedores
WHERE ProveedoresTelevisa.RazonSocial=Proveedores.RazonSocial and ProveedoresTelevisa.RazonSocial not in(SELECT RazonSocial
FROM Proyectos, Proveedores, Entregan
WHERE Proyectos.Numero=Entregan.Numero And Entregan.RFC=Proveedores.RFC
AND Denominaci�n LIKE '%Educando en Coahuila%')

--Nombre del material, cantidad de veces entregados y total del costo de dichas entregas por material de todos los proyectos.
SELECT Denominaci�n, Descripcion, (cantidad*costo) as total, COUNT(descripcion) as Entregado
FROM Proyectos, Entregan, Materiales
WHERE Proyectos.Numero=Entregan.Numero AND Entregan.Clave=Materiales.Clave
GROUP BY  Denominaci�n, Descripcion, (cantidad*costo)
ORDER BY Denominaci�n






