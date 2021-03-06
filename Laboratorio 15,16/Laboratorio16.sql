
--BORRADO DE TABLAS--
drop TABLE entregan
drop TABLE materiales
drop TABLE proyectos
drop TABLE Proveedores


/*Crear tablas*/
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Materiales')
DROP TABLE Materiales

CREATE TABLE Materiales(
	Clave NUMERIC (5) NOT NULL,
	Descripcion VARCHAR(50),
	Costo numeric(8,2)
);

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Proveedores')
DROP TABLE Proveedores
CREATE TABLE Proveedores(
	RFC CHAR(13) NOT NULL,
	RazonSocial VARCHAR(50)

);

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Proyectos')
DROP TABLE Proyectos
CREATE TABLE Proyectos(
	Numero NUMERIC(5) NOT NULL,
	Denominación VARCHAR(50)

);

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Entregan')
DROP TABLE Entregan
CREATE TABLE Entregan(
	Clave NUMERIC (5) NOT NULL,
	RFC CHAR(13) NOT NULL,
	Numero NUMERIC(5) NOT NULL,
	Fecha DATETIME NOT NULL,
	Cantidad NUMERIC(8,2)
);


/*Datos de las tablas*/

SET DATEFORMAT dmy

BULK INSERT a1552594.a1552594.[Materiales]
   FROM 'e:\wwwroot\rcortese\materiales.csv'
   WITH
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '\n'
      )

BULK INSERT a1552594.a1552594.[Proveedores]
   FROM 'e:\wwwroot\rcortese\Proveedores.csv'
   WITH
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '\n'
      )

BULK INSERT a1552594.a1552594.[Proyectos]
   FROM 'e:\wwwroot\rcortese\Proyectos.csv'
   WITH
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '\n'
      )

BULK INSERT a1552594.a1552594.[Entregan]
   FROM 'e:\wwwroot\rcortese\Entregan.csv'
   WITH
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '\n'
      )





/*
	Inconsistencia: Ya se tiene un dato con esa llave
*/
 INSERT INTO Materiales values(1000, 'xxx', 1000)
 Delete from Materiales where Clave = 1000 and Costo = 1000

/*Declaración de llaves primarias*/

 ALTER TABLE Materiales add constraint llaveMateriales PRIMARY KEY (Clave)
 ALTER TABLE Proveedores add constraint llaveProveedores PRIMARY KEY (RFC)
 ALTER TABLE Proyectos add constraint llaveProyectos PRIMARY KEY (Numero)
 ALTER TABLE Entregan add constraint llaveEntregan PRIMARY KEY (Clave, RFC, Numero, Fecha)

 /*
	Que ocurrió: no se puende agrgar nuevos datos si la llave primaria esta repetida
*/
 INSERT INTO Materiales values(1000, 'xxx', 1000)


 /*
 ¿Qué información muestra esta consulta?
	Muestra la información del constraint de las llaves primarias que ya creamos

 ¿Qué sentencias utilizaste para definir las llaves primarias?
	PRIMARY KEY

 ¿Qué sentencias utilizaste para definir este constrait?
	Alter table
*/
 sp_helpconstraint Materiales
 sp_helpconstraint Proveedores
 sp_helpconstraint Proyectos
 sp_helpconstraint Entregan

 --BORRAR LLAVE PRIMARIA (CONSTRAINT)--
 ALTER TABLE Materiales drop constraint llaveMateriales

 

 --CHECAR TABLAS--
SELECT * FROM Materiales
SELECT * FROM Proveedores
SELECT * FROM Proyectos
SELECT * FROM Entregan


 /*
	¿Qué particularidad observas en los valores para clave, rfc y numero?
	Que no tinen un formato correcto para las personas pero sí para el sistema

	¿Cómo responde el sistema a la inserción de este registro?
	Lo acepta correctamente
*/
INSERT INTO entregan values (0, 'xxx', 0, '1-jan-02', 0) ;
Delete from Entregan where Clave = 0


--LLAVES FORANEAS--

 /*
¿Qué significa el mensaje que emite el sistema?
Que no permite agregar esa columna

¿Qué significado tiene la sentencia anterior?
Que no permite gracias a que debe ser una clave existente en la tabla materiales
*/
 ALTER TABLE entregan add constraint cfentreganclave foreign key (clave) references materiales(clave);
 ALTER TABLE entregan add constraint cfentreganRFC foreign key (RFC) references Proveedores(RFC);
 ALTER TABLE entregan add constraint cfentregannumero foreign key (Numero) references Proyectos(Numero);

 sp_helpconstraint Entregan

 ------------------------------------------------------------EJERCICIO 4--------------------------------------------------------------------

/*
¿Qué uso se le está dando a GETDATE()?
	Se óne la fecha y el tiempo en el que se agrega la información

¿Tiene sentido el valor del campo de cantidad?
	no
*/
 INSERT INTO entregan values (1000, 'AAAA800101', 5000, GETDATE(), 0);
 Delete from Entregan where Cantidad = 0


 /*
¿Cómo responde el sistema?
	The INSERT statement conflicted with the CHECK constraint "cantidad". The conflict occurred in database "a1552594", table "a1552594.Entregan", column 'Cantidad'.

¿Qué significa el mensaje?
	Que no se puede gracias a que ya pusimos una restricción
*/
 ALTER TABLE entregan add constraint cantidad check (cantidad > 0) ;

 /*
¿Que ssignifica integridad referencial?
	que la clave externa de una tabla de referencia siempre debe aludir a una fila válida de la tabla a la que se haga referencia*/