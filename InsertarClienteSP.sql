USE EVENTOSDB;
GO

CREATE PROCEDURE SP_InsertarCliente
    @DNI VARCHAR(16),
    @Nombres VARCHAR(50),
    @Apellidos VARCHAR(50),
    @Telefono VARCHAR(20),
    @Email VARCHAR(100)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validaciones
        IF EXISTS (SELECT 1 FROM Cliente WHERE DNI = @DNI)
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT 'Error: El DNI ya está registrado en el sistema.' AS Resultado;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM Cliente WHERE Email = @Email)
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT 'Error: El correo electrónico ya pertenece a otro cliente.' AS Resultado;
            RETURN;
        END


        INSERT INTO Cliente (DNI, Nombres, Apellidos, Telefono, Email)
        VALUES (@DNI, @Nombres, @Apellidos, @Telefono, @Email);

        COMMIT TRANSACTION;
        SELECT 'Cliente registrado con éxito.' AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS Resultado;
    END CATCH
END;
GO