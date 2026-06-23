-- Trigger para INSERT
use EVENTOSDB;

CREATE TRIGGER TR_Evento_Insert
ON Evento
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditoriaEvento (Accion, Fecha, RegistroAfectado, Usuario)
    SELECT 
        'INSERT', 
        GETDATE(), 
        i.IDEvento, 
        USER_NAME()
    FROM inserted i;
END;
