-- Trigger para UPDATE

use EVENTOSDB;

CREATE TRIGGER TR_Reservacion_Update
ON Reservacion
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditoriaReservacion (Accion, Fecha, RegistroAfectado, Usuario)
    SELECT 
        'UPDATE', 
        GETDATE(), 
        i.IDReservacion, 
        USER_NAME()
    FROM inserted i;
END;
