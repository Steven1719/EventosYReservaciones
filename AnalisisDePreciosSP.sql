USE EVENTOSDB;
GO

CREATE PROCEDURE SP_AnalisisPreciosServicios
AS
BEGIN
    SELECT 
        MAX(Precio) AS ServicioMasCaro,
        MIN(Precio) AS ServicioMasBarato,
        AVG(Precio) AS PrecioPromedio
    FROM ServicioExtra;
END;
GO