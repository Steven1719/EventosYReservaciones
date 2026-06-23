-- Trigger para UPDATE

use EVENTOSDB;

CREATE TRIGGER TR_Cliente_Update
ON Cliente
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditoriaCliente (Accion, Fecha, RegistroAfectado, Usuario)
    SELECT 
        'UPDATE', 
        GETDATE(), 
        i.IDCliente, 
        USER_NAME()
    FROM inserted i;
END;
