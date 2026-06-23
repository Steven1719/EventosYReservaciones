USE EVENTOSDB;
GO


-- Trigger para INSERT
CREATE TRIGGER TR_Cliente_Insert
ON Cliente
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditoriaCliente (Accion, Fecha, RegistroAfectado, Usuario)
    SELECT 
        'INSERT', 
        GETDATE(), 
        i.IDCliente, 
        USER_NAME()
    FROM inserted i;
END;
GO

