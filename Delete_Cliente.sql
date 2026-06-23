use EVENTOSDB;
-- Trigger para DELETE
CREATE TRIGGER TR_Cliente_Delete
ON Cliente
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditoriaCliente (Accion, Fecha, RegistroAfectado, Usuario)
    SELECT 
        'DELETE', 
        GETDATE(), 
        d.IDCliente, 
        USER_NAME()
    FROM deleted d;
END;
