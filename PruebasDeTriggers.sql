USE EVENTOSDB;
GO

-- DISPARAR TRIGGERS DE LA TABLA CLIENTE
EXECUTE AS USER = 'HilciasC';

-- Dispara TR_Cliente_Insert
INSERT INTO Cliente (DNI, Nombres, Apellidos, Telefono, Email) 
VALUES ('002-123456-7890X', 'Usuario', 'Temporal', '12345678', 'temp@mail.com');

-- Dispara TR_Cliente_Update
UPDATE Cliente SET Telefono = '87654321' WHERE DNI = '002-123456-7890X';

-- Dispara TR_Cliente_Delete
DELETE FROM Cliente WHERE DNI = '002-123456-7890X';

REVERT;
GO

-- DISPARAR TRIGGERS DE LA TABLA EVENTO
EXECUTE AS USER = 'AndreaI';

-- Dispara TR_Evento_Insert
INSERT INTO Evento (NombreEvento, FechaEvento, CantidadAsistentes, IDTipo, IDUbicacion) 
VALUES ('Evento de Prueba', '2026-12-01', 50, 1, 1);

-- Dispara TR_Evento_Update
UPDATE Evento SET CantidadAsistentes = 60 WHERE NombreEvento = 'Evento de Prueba';

-- Dispara TR_Evento_Delete
DELETE FROM Evento WHERE NombreEvento = 'Evento de Prueba';

REVERT;
GO

-- DISPARAR TRIGGERS DE LA TABLA RESERVACION
EXECUTE AS USER = 'JuanP';

-- Dispara TR_Reservacion_Insert
INSERT INTO Reservacion (FechaReservacion, Estado, IDCliente, IDEvento) 
VALUES (GETDATE(), 'Pendiente', 1, 1);

-- Dispara TR_Reservacion_Update (Asumiendo que la nueva reservación es el ID 6)
UPDATE Reservacion SET Estado = 'Cancelada' WHERE IDReservacion = 6;

-- Dispara TR_Reservacion_Delete
DELETE FROM Reservacion WHERE IDReservacion = 6;

REVERT;
GO

-- VERIFICAR LAS TABLAS DE AUDITORÍA
-- Ejecuta estos SELECT para tomar tus capturas de pantalla de que todo funcionó:
SELECT * FROM AuditoriaCliente;
SELECT * FROM AuditoriaEvento;
SELECT * FROM AuditoriaReservacion;