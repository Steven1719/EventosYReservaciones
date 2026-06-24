USE EVENTOSDB;
GO

-- 1. Consultar Ingresos Mensuales
EXEC SP_ConsultarIngresosMensuales;

-- 2. Estadísticas de Ubicación
EXEC SP_EstadisticasUbicacion;

-- 3. Análisis de Precios de Servicios Extra
EXEC SP_AnalisisPreciosServicios;






EXECUTE AS USER = 'KevinB';
GO

-- Prueba ÉXITO: Insertar un cliente nuevo
EXEC SP_InsertarCliente '001-999999-9999Z', 'Carlos', 'Mejia', '88880000', 'carlos.m@mail.com';

-- Prueba ERROR: Intentar insertar el mismo cliente (DNI duplicado)
EXEC SP_InsertarCliente '001-999999-9999Z', 'Carlos', 'Mejia', '88880000', 'carlos.m@mail.com';

-- Prueba ÉXITO: Actualizar el costo de la Ubicación 1
EXEC SP_ActualizarCostoUbicacion 1, 1600.00;

-- Prueba ERROR: Intentar poner un costo negativo
EXEC SP_ActualizarCostoUbicacion 1, -500.00;

-- Prueba ERROR: Intentar eliminar un servicio que ya está contratado (Aplica Guard Clause)
EXEC SP_EliminarServicioExtra 1;

-- Prueba ÉXITO: Agregar un servicio extra a la Reservación 2
EXEC SP_AgregarServicioAReservacion 2, 4, 1; 

REVERT;
GO



--PRUEBAS DE TRIGGERS ....

-- Simulamos que Hilcias hace movimientos en Cliente
EXECUTE AS USER = 'HilciasC';
GO
INSERT INTO Cliente (DNI, Nombres, Apellidos, Telefono, Email) VALUES ('002-123456-7890X', 'Prueba', 'Trigger', '1234', 'test@mail.com');
UPDATE Cliente SET Telefono = '9999' WHERE DNI = '002-123456-7890X';
DELETE FROM Cliente WHERE DNI = '002-123456-7890X';
REVERT;
GO

-- Simulamos que Andrea hace movimientos en Evento
EXECUTE AS USER = 'AndreaI';
GO
INSERT INTO Evento (NombreEvento, FechaEvento, CantidadAsistentes, IDTipo, IDUbicacion) VALUES ('Evento Trigger', '2026-12-01', 50, 1, 1);
UPDATE Evento SET CantidadAsistentes = 60 WHERE NombreEvento = 'Evento Trigger';
DELETE FROM Evento WHERE NombreEvento = 'Evento Trigger';
REVERT;
GO

-- Simulamos que Juan hace movimientos en Reservacion
EXECUTE AS USER = 'JuanP';
GO
INSERT INTO Reservacion (FechaReservacion, Estado, IDCliente, IDEvento) VALUES (GETDATE(), 'Pendiente', 1, 1);
UPDATE Reservacion SET Estado = 'Cancelada' WHERE IDReservacion = (SELECT MAX(IDReservacion) FROM Reservacion);
DELETE FROM Reservacion WHERE IDReservacion = (SELECT MAX(IDReservacion) FROM Reservacion);
REVERT;
GO


--EVIDENCIAS FINALES ...
SELECT * FROM AuditoriaCliente;
SELECT * FROM AuditoriaEvento;
SELECT * FROM AuditoriaReservacion;