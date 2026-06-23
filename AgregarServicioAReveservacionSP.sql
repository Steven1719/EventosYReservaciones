USE EVENTOSDB;
GO

CREATE PROCEDURE SP_AgregarServicioAReservacion
    @IDReservacion INT,
    @IDServicio INT,
    @Cantidad INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar si la reservación y el servicio existen
        IF NOT EXISTS (SELECT 1 FROM Reservacion WHERE IDReservacion = @IDReservacion)
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT 'Error: La reservación indicada no existe.' AS Resultado;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM ServicioExtra WHERE IDServicio = @IDServicio)
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT 'Error: El servicio extra indicado no existe.' AS Resultado;
            RETURN;
        END

        -- Validar cantidad lógica
        IF @Cantidad <= 0
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT 'Error: Debe agregar al menos 1 unidad del servicio.' AS Resultado;
            RETURN;
        END

        -- Validar que el servicio no haya sido agregado previamente a la misma reservación
        IF EXISTS (SELECT 1 FROM Reservacion_Servicio WHERE IDReservacion = @IDReservacion AND IDServicio = @IDServicio)
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT 'Error: Este servicio ya fue agregado a esta reservación anteriormente.' AS Resultado;
            RETURN;
        END

        INSERT INTO Reservacion_Servicio (IDReservacion, IDServicio, Cantidad)
        VALUES (@IDReservacion, @IDServicio, @Cantidad);

        COMMIT TRANSACTION;
        SELECT 'Servicio agregado a la reservación exitosamente.' AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS Resultado;
    END CATCH
END;
GO