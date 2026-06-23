-- Trigger para INSERT
use EVENTOSDB;

CREATE TRIGGER TR_Reservacion_Insert
ON Reservacion
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditoriaReservacion (Accion, Fecha, RegistroAfectado, Usuario)
    SELECT 
        'INSERT', 
        GETDATE(), 
        i.IDReservacion, 
        USER_NAME()
    FROM inserted i;
END;


