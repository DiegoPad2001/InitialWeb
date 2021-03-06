

/*
Materiales(Clave,Descripción,Costo)
Proveedores(RFC,RazonSocial)
Proyectos(Numero,Denominacion)
Entregan(Clave,RFC,Numero,Fecha,Cantidad)
*/

CREATE TABLE Materiales(
	Clave NUMERIC (5),
	Descripcion VARCHAR(50),
	Costo numeric(8,2)
);

CREATE TABLE Proveedores(
	RFC CHAR(13),
	RazonSocial VARCHAR(50)

);

CREATE TABLE Proyectos(
	Numero NUMERIC(5),
	Denominación VARCHAR(50)

);

CREATE TABLE Entregan(
	Clave NUMERIC (5),
	RFC CHAR(13),
	Numero NUMERIC(5),
	Fecha DATETIME,
	Cantidad NUMERIC(8,2)
);

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


