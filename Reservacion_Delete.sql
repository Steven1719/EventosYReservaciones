
-- Trigger para DELETE

use EVENTOSDB;

CREATE TRIGGER TR_Reservacion_Delete
ON Reservacion
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditoriaReservacion (Accion, Fecha, RegistroAfectado, Usuario)
    SELECT 
        'DELETE', 
        GETDATE(), 
        d.IDReservacion, 
        USER_NAME()
    FROM deleted d;
END;