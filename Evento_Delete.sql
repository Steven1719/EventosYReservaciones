-- Trigger para DELETE



CREATE TRIGGER TR_Evento_Delete
ON Evento
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditoriaEvento (Accion, Fecha, RegistroAfectado, Usuario)
    SELECT 
        'DELETE', 
        GETDATE(), 
        d.IDEvento, 
        USER_NAME()
    FROM deleted d;
END;