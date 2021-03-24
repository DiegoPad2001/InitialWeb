IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'creaMaterial' AND type = 'P')
           DROP PROCEDURE creaMaterial
GO

CREATE PROCEDURE creaMaterial
    @uclave NUMERIC(5,0),
    @udescripcion VARCHAR(50),
    @ucosto NUMERIC(8,2),
    @uimpuesto NUMERIC(6,2)
AS
    INSERT INTO Materiales VALUES(@uclave, @udescripcion, @ucosto, @uimpuesto)
GO

/*¿Qué hace el primer bloque del código (bloque del IF)?
Verifica si hay algun procedimiento con el nombre 'crearMaterial', y en caso de lo que lo haya borra el procedimiento*/

/*¿Para qué sirve la instrucción GO?
Porque solo se puede realizar un procedimiento por ejecucion, el sistema te muestra el siguiente error
'CREATE/ALTER PROCEDURE' must be the first statement in a query batch.*/

/*¿Explica que recibe como parámetro este Procedimiento y qué tabla modifica?
recibe 4 parametros, los mismos que se necesitan para crear un nuevo registro, dentro de la tabla que desea modificar,
en este caso es la de materiales*/

/*Para ejecutar el stored procedure, se utiliza la sintaxis mostrada en el siguiente ejemplo:*/

EXECUTE creaMaterial 5000,'Martillos Acme',250,15

select * from Materiales



/*Procedimiento modificaMaterial*/

IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'modificaMaterial' AND type = 'P')
           DROP PROCEDURE modificaMaterial
GO

CREATE PROCEDURE modificaMaterial
    @uclave NUMERIC(5,0),
    @udescripcion VARCHAR(50),
    @ucosto NUMERIC(8,2),
    @uimpuesto NUMERIC(6,2)
AS
    UPDATE Materiales set Descripcion=@udescripcion, Costo=@ucosto, PorcentajeImpuesto=@uimpuesto
	where clave=@uclave
GO

EXECUTE modificaMaterial 5000,'Martillos Acme2',50,10

/*Procedimiento eliminaMaterial*/
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'eliminaMaterial' AND type = 'P')
           DROP PROCEDURE eliminaMaterial
GO

CREATE PROCEDURE eliminaMaterial
    @uclave NUMERIC(5,0)
AS
    DELETE Materiales where clave=@uclave
GO

EXECUTE eliminaMaterial 5000



/*Procedures proyectos*/

SELECT * FROM Proyectos

/* creaProyecto*/
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'creaProyecto' AND type = 'P')
           DROP PROCEDURE creaProyecto
GO

CREATE PROCEDURE creaProyecto
    @unumero NUMERIC(5,0),
    @udenominacion VARCHAR(50)

AS
    INSERT INTO Proyectos VALUES(@unumero, @udenominacion)
GO

/*modificaProyecto*/
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'modificaProyecto' AND type = 'P')
           DROP PROCEDURE modificaProyecto
GO


CREATE PROCEDURE modificaProyecto
    @unumero NUMERIC(5,0),
    @udenominacion VARCHAR(50)

AS
    UPDATE Proyectos set Numero=@unumero, Denominación=@udenominacion
	where Numero=@unumero
GO

/*Elmina Proyecto*/
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'eliminaProyecto' AND type = 'P')
           DROP PROCEDURE eliminaProyecto
GO

CREATE PROCEDURE eliminaProyecto
    @unumero NUMERIC(5,0)
AS
    DELETE Proyectos where Numero=@unumero
GO

/*Procedures proveedores*/

SELECT * FROM Proveedores

/* creaproveedor*/
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'creaProveedor' AND type = 'P')
           DROP PROCEDURE creaProveedor
GO

CREATE PROCEDURE creaProveedor
    @urfc NUMERIC(10,0),
    @urazonsocial VARCHAR(50)

AS
    INSERT INTO Proveedores VALUES(@urfc, @urazonsocial)
GO

/*modificaProveedor*/
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'modificaProveedor' AND type = 'P')
           DROP PROCEDURE modificaProveedor
GO


CREATE PROCEDURE modificaProveedor
    @urfc NUMERIC(10,0),
    @urazonsocial VARCHAR(50)
AS
    UPDATE Proveedores set RFC=@urfc, RazonSocial=@urazonsocial
	where RFC=@urfc
GO

/*Elmina Proyecto*/
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'eliminaProveedor' AND type = 'P')
           DROP PROCEDURE eliminaProveedor
GO

CREATE PROCEDURE eliminaProveedor
    @urfc NUMERIC(10,0)
AS
    DELETE Proveedores where RFC=@urfc
GO


/*Define el siguiente stored procedure en tu base de datos:*/

IF EXISTS (SELECT name FROM sysobjects
            WHERE name = 'queryMaterial' AND type = 'P')
    DROP PROCEDURE queryMaterial
GO

CREATE PROCEDURE queryMaterial
    @udescripcion VARCHAR(50),
    @ucosto NUMERIC(8,2)

AS
    SELECT * FROM Materiales WHERE descripcion
    LIKE '%'+@udescripcion+'%' AND costo > @ucosto
GO

EXECUTE queryMaterial 'Lad',20

/*¿Qué ventajas tienen el utilizar Stored Procedures en una aplicación cliente-servidor?
El no tener tanto codigo sql dentro del codigo de la pagina web, dandole asi una mayor facilidad de lectura
¿Qué ventajas tiene utilizar SP en un proyecto?
Es como usar funciones en otro lenguaje, te ayuda a no repetir codigo*/

/*Para reforzar el entendimiento de los SP, crea un SP que sea de utilidad en tu proyecto (en caso de usar otra tecnología, se deberá asumir). 
Incorpora dicho SP en tu reporte.*/

/*Procedure para crear un nuevo proyecto*/
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'creaProyecto' AND type = 'P')
           DROP PROCEDURE creaProyecto
GO

CREATE PROCEDURE creaProyecto
	@uIdProyecto char(4) ,
	@unombre varchar(20) ,
	@ufechaPlaneada date ,
	@ufechaLimite date ,
	@udecripcion varchar(60) 

AS
    INSERT INTO Proyecto VALUES(@uIdProyecto, @unombre, @ufechaPlaneada, @ufechaLimite, @udecripcion)
GO

