USE EVENTOSDB;
GO


-- PRUEBAS DE SP DE CONSULTA
-- Estas solo devuelven tablas con información resumida.
EXEC SP_ConsultarIngresosMensuales;
EXEC SP_EstadisticasUbicacion;
EXEC SP_AnalisisPreciosServicios;

-- PRUEBAS DE SP DE MANIPULACIÓN (Éxito y Error)
EXECUTE AS USER = 'KevinB';

-- Prueba ÉXITO: Insertar un cliente nuevo
EXEC SP_InsertarCliente '001-999999-9999Z', 'Carlos', 'Mejia', '88880000', 'carlos.m@mail.com';

-- Prueba ERROR: Intentar insertar el mismo cliente (se activa el ROLLBACK)
EXEC SP_InsertarCliente '001-999999-9999Z', 'Carlos', 'Mejia', '88880000', 'carlos.m@mail.com';

-- Prueba ÉXITO: Actualizar el costo de la Ubicación 1
EXEC SP_ActualizarCostoUbicacion 1, 1600.00;

-- Prueba ERROR: Intentar poner un costo negativo
EXEC SP_ActualizarCostoUbicacion 1, -500.00;

-- Prueba ERROR: Intentar eliminar un servicio que ya está contratado en una reservación
EXEC SP_EliminarServicioExtra 1;

-- Prueba ÉXITO: Agregar un servicio extra a la Reservación 2 (Relación M:M)
EXEC SP_AgregarServicioAReservacion 2, 4, 1; 

REVERT;
GO