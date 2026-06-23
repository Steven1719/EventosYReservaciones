USE EVENTOSDB;
GO

CREATE PROCEDURE SP_ActualizarCostoUbicacion
    @IDUbicacion INT,
    @NuevoCosto DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validaciones
        IF NOT EXISTS (SELECT 1 FROM Ubicacion WHERE IDUbicacion = @IDUbicacion)
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT 'Error: La ubicación especificada no existe.' AS Resultado;
            RETURN;
        END

        IF @NuevoCosto < 0
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT 'Error: El costo base no puede ser un número negativo.' AS Resultado;
            RETURN;
        END

        UPDATE Ubicacion
        SET CostoBase = @NuevoCosto
        WHERE IDUbicacion = @IDUbicacion;

        COMMIT TRANSACTION;
        SELECT 'Costo de ubicación actualizado correctamente.' AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS Resultado;
    END CATCH
END;
GO