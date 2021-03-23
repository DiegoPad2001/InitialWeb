/*Diego Arturo Padilla Domínguez A01552594*/

--1 La suma de las cantidades e importe total de todas las entregas realizadas durante el 97.

SELECT SUM(cantidad) as 'Total Unidades' , SUM(cantidad* (costo + costo * PorcentajeImpuesto)) as 'Importe total'
FROM Entregan E, Materiales M
WHERE E.Clave = M.Clave

/*
Total Unidades   Importe total
48262.00		36705084.740000
*/

--2 code Para cada proveedor, obtener la razón social del proveedor, 
--número de entregas e importe total de las entregas realizadas.
SELECT RazonSocial, COUNT(Numero) as 'Numero de entregas', SUM(Cantidad * (Costo + (Costo*PorcentajeImpuesto/100))) as 'Importe total de entregas'
FROM Proveedores P, Entregan E, Materiales M
WHERE P.RFC=E.RFC AND E.Clave=M.Clave
GROUP BY RazonSocial

/* Resultados consulta 1 
Alvin	15	794295.2064000000
Cecoferre	18	860441.9770000000
Comex	15	801930.5980000000
La Ferre	18	919531.4300000000
La fragua	18	2301675.6920000000
Oviedo	18	1059888.7370000000
Tabiquera del centro	15	1937798.7240000000
Tubasa	15	2278398.9930000000
*/


--3 code Por cada material obtener la clave y descripción del material, la cantidad total entregada, 
--la mínima cantidad entregada, la máxima cantidad entregada, el importe total de las entregas de aquellos 
--materiales en los que la cantidad promedio entregada sea mayor a 400.
SELECT * from Materiales
SELECT * FROM Entregan
-- El alias de material es M


SELECT E.Clave, AVG( Cantidad) as 'PromedioEntregas'
from Entregan as E, Materiales as M 
GROUP by E.Clave
HAVING AVG(Cantidad) > 400


SELECT E.Clave, descripcion, SUM(cantidad) as 'Cantidad total entregada', MIN(cantidad) as 'Minima cantidad agregada' , MAX(cantidad) as 'Maxima cantidad entrega',  SUM(cantidad* (costo + costo * PorcentajeImpuesto)) as 'Importe total'
FROM Entregan E, Materiales M
WHERE E.Clave = M.Clave  
GROUP BY E.Clave, Descripcion 
HAVING AVG(E.Cantidad) > 400
/*

1100	Block	1688.00	466.00	699.00	162048.000000
1140	Cantera blanca	1453.00	219.00	651.00	953168.000000
1250	Grava	1452.00	71.00	691.00	508200.000000
*/



--HAVING AVG(  SUM(cantidad* (costo + costo * PorcentajeImpuesto))) 

--4 code Para cada proveedor, indicar su razón social y mostrar la cantidad promedio de cada material entregado, 
--detallando la clave y descripción del material, excluyendo aquellos proveedores para los que la cantidad promedio sea menor a 500.

SELECT RazonSocial, M.Clave, descripcion, AVG(Cantidad) as 'Promedio de entrega'
FROM Entregan E, Proveedores P, Materiales M
WHERE P.RFC=E.RFC AND E.Clave=M.Clave
GROUP BY RazonSocial, M.Clave, descripcion
HAVING AVG(Cantidad)>500
ORDER BY RazonSocial DESC, [Promedio de entrega] DESC

/*
Oviedo	1010	Varilla 4/32	572.666666
Oviedo	1410	Pintura B1021	509.666666
La Ferre	1100	Block	562.666666
*/

--5 code Mostrar en una solo consulta los mismos datos que en la consulta anterior pero para dos
--grupos de proveedores: aquellos para los que la cantidad promedio entregada es menor a 370 
--y aquellos para los que la cantidad promedio entregada sea mayor a 450.
SELECT RazonSocial, M.Clave, descripcion, AVG(Cantidad) as 'Promedio de entrega'
FROM Entregan E, Proveedores P, Materiales M
WHERE P.RFC=E.RFC AND E.Clave=M.Clave
GROUP BY RazonSocial, M.Clave, descripcion
HAVING AVG(Cantidad) not between 370 and 450
ORDER BY RazonSocial DESC, [Promedio de entrega] DESC

/*
Tubasa	1070	Varilla 4/35	340.333333
Tubasa	1230	Cemento 	319.000000
Tubasa	1310	Tubería 3.6	244.666666
Tabiquera del centro	1140	Cantera blanca	484.333333
Tabiquera del centro	1300	Tubería 4.3	365.666666
Tabiquera del centro	1380	Pintura C1011	364.666666
Tabiquera del centro	1060	Varilla 3/19	354.333333
Oviedo	1010	Varilla 4/32	572.666666
*/

--6 code Clave y descripción de los materiales que nunca han sido entregados.
SELECT Clave, Descripcion
FROM Materiales
WHERE clave not in(SELECT clave FROM Entregan)

/* Con el modelo original no se muestra ningun resultado debido a que todos los materiales han sido entregados al menos una vez*/
/*Asi que agregaremos un nuevo material*/
INSERT INTO Materiales values(1440, 'Pintura C1013', 125, 2.88)
INSERT INTO Materiales values(1450, 'Pintura D1015', 130, 2.90)
INSERT INTO Materiales values(1460, 'Pintura E1016', 140, 2.92)
INSERT INTO Materiales values(1470, 'Pintura F1017', 150, 2.94)
INSERT INTO Materiales values(1480, 'Pintura G1018', 160, 2.96)

/* Volviendo a ejecutar la consulta despues de agregar el nuevo registro se muestra*/
/*1440	Pintura C1013
1450	Pintura D1015
1460	Pintura E1016
1470	Pintura F1017
1480	Pintura G1018*/

--7 code Razón social de los proveedores que han realizado entregas 
--tanto al proyecto 'Vamos México' como al proyecto 'Querétaro Limpio'.
SELECT * FROM Entregan

CREATE VIEW Prov_VamosMexico as SELECT Denominación, E.RFC, RazonSocial
FROM Proyectos AS PY, Proveedores AS PO, Entregan as E
WHERE Denominación LIKE '%Vamos %' And E.RFC=PO.RFC 
AND PY.Numero=E.Numero 


 
SELECT * FROM Prov_VamosMexico

CREATE VIEW Prov_QueretaroLimpio as (SELECT Denominación, E.RFC, RazonSocial
FROM Proyectos AS PY, Proveedores AS PO, Entregan as E
WHERE Denominación LIKE '%Queretaro %' And E.RFC=PO.RFC 
AND PY.Numero=E.Numero )

SELECT RazonSocial FROM Prov_QueretaroLimpio
Intersect
SELECT RazonSocial FROM Prov_VamosMexico

/*
La fragua
*/


--8 code Descripción de los materiales que nunca
--han sido entregados al proyecto 'CIT Yucatán'.
SELECT Clave, Descripcion
FROM Materiales
WHERE clave not in(SELECT clave
FROM Entregan, Proveedores
WHERE Entregan.RFC=Proveedores.RFC and RazonSocial='CIT Yucatán')

/*Se muestran todo los materiales debido a que *CIT Yucatan' nunca a hecho una entrega, ademas de que no existe el proveedor*/

--9code Razón social y promedio de cantidad entregada de los proveedores cuyo 
--promedio de cantidad entregada es mayor al promedio de la cantidad 
--entregada por el proveedor con el RFC 'VAGO780901'.
SELECT RazonSocial, AVG(Cantidad) as 'Promedio de entrega'
FROM Entregan E, Proveedores P
WHERE P.RFC=E.RFC 
GROUP BY RazonSocial
HAVING AVG(Cantidad)> (SELECT AVG(Cantidad) FROM Entregan E, Proveedores P WHERE P.RFC = E.RFC AND P.RFC='VAGO780901' )
ORDER BY RazonSocial DESC, [Promedio de entrega] DESC

/* No muestra ningun resultado porque el proveedor con el rfc solicitado no existe*/

--10 code RFC, razón social de los proveedores que participaron en el proyecto 
--'Infonavit Durango' y cuyas cantidades totales entregadas en el 2000 
--fueron mayores a las cantidades totales entregadas en el 2001.
CREATE VIEW C2001 AS SELECT Prv.RFC, RazonSocial, SUM(cantidad) as 'Cantidad entregada 2001'
FROM Proyectos Pyt, Proveedores Prv, Entregan E
WHERE Pyt.Numero=E.Numero and Prv.RFC=E.RFC and Fecha>'31/12/2000' and Fecha<'01/01/2002' and Denominación='Infonavit Durango'
group by RazonSocial, Prv.RFC


CREATE VIEW C2000 AS SELECT Prv.RFC, RazonSocial, SUM(cantidad) as 'Cantidad entregada 2000'
FROM Proyectos Pyt, Proveedores Prv, Entregan E
WHERE Pyt.Numero=E.Numero and Prv.RFC=E.RFC and Fecha>'31/12/1999' and Fecha<'01/01/2001' and Denominación='Infonavit Durango'
group by RazonSocial, Prv.RFC

set dateformat dmy
select C2000.RFC, C2000.RazonSocial from C2001, C2000
WHERE C2000.RFC=C2001.RFC AND [Cantidad entregada 2000]>[Cantidad entregada 2001]

/* La consulta no muesta ningun resultado debido a que no hubo un proveedor que particiapara en el proyecto Infonavit Durango en ambos años*/
