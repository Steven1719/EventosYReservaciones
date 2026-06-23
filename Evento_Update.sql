use EVENTOSDB;
-- Trigger para UPDATE
CREATE TRIGGER TR_Evento_Update
ON Evento
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditoriaEvento (Accion, Fecha, RegistroAfectado, Usuario)
    SELECT 
        'UPDATE', 
        GETDATE(), 
        i.IDEvento, 
        USER_NAME()
    FROM inserted i;
END;

