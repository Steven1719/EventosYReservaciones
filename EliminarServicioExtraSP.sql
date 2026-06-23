USE EVENTOSDB;
GO

CREATE PROCEDURE SP_EliminarServicioExtra
    @IDServicio INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM ServicioExtra WHERE IDServicio = @IDServicio)
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT 'Error: El servicio extra no existe.' AS Resultado;
            RETURN;
        END

        -- Validación de llave foránea manual
        IF EXISTS (SELECT 1 FROM Reservacion_Servicio WHERE IDServicio = @IDServicio)
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT 'Error: No se puede eliminar este servicio porque ya fue contratado en una o más reservaciones.' AS Resultado;
            RETURN;
        END

        DELETE FROM ServicioExtra WHERE IDServicio = @IDServicio;

        COMMIT TRANSACTION;
        SELECT 'Servicio extra eliminado con éxito.' AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS Resultado;
    END CATCH
END;
GO