USE EVENTOSDB;
GO

-- 1. Crear las tablas de auditoría (solo si no existen)
IF OBJECT_ID('AuditoriaCliente', 'U') IS NULL 
    CREATE TABLE AuditoriaCliente (IDAuditoria INT IDENTITY(1,1) PRIMARY KEY, Accion VARCHAR(20), Fecha DATETIME DEFAULT GETDATE(), RegistroAfectado INT, Usuario VARCHAR(50));
IF OBJECT_ID('AuditoriaEvento', 'U') IS NULL 
    CREATE TABLE AuditoriaEvento (IDAuditoria INT IDENTITY(1,1) PRIMARY KEY, Accion VARCHAR(20), Fecha DATETIME DEFAULT GETDATE(), RegistroAfectado INT, Usuario VARCHAR(50));
IF OBJECT_ID('AuditoriaReservacion', 'U') IS NULL 
    CREATE TABLE AuditoriaReservacion (IDAuditoria INT IDENTITY(1,1) PRIMARY KEY, Accion VARCHAR(20), Fecha DATETIME DEFAULT GETDATE(), RegistroAfectado INT, Usuario VARCHAR(50));
GO

-- 2. Desactivar los triggers temporalmente para que nos dejen borrar en paz
DISABLE TRIGGER ALL ON Cliente;
DISABLE TRIGGER ALL ON Evento;
DISABLE TRIGGER ALL ON Reservacion;
GO

-- 3. Limpiar las tablas (ahora sí, sin interrupciones)
DELETE FROM Factura;
DELETE FROM Reservacion_Servicio;
DELETE FROM Reservacion;
DELETE FROM Evento;
DELETE FROM ServicioExtra;
DELETE FROM Ubicacion;
DELETE FROM TipoEvento;
DELETE FROM Cliente;
GO

-- 4. Reiniciar contadores a cero
DBCC CHECKIDENT ('Factura', RESEED, 0);
DBCC CHECKIDENT ('Reservacion', RESEED, 0);
DBCC CHECKIDENT ('Evento', RESEED, 0);
DBCC CHECKIDENT ('ServicioExtra', RESEED, 0);
DBCC CHECKIDENT ('Ubicacion', RESEED, 0);
DBCC CHECKIDENT ('TipoEvento', RESEED, 0);
DBCC CHECKIDENT ('Cliente', RESEED, 0);
GO

-- 5. Volver a activar los triggers para que funcionen las pruebas
ENABLE TRIGGER ALL ON Cliente;
ENABLE TRIGGER ALL ON Evento;
ENABLE TRIGGER ALL ON Reservacion;
GO