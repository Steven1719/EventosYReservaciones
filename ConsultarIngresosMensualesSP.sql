USE EVENTOSDB;
GO

CREATE PROCEDURE SP_ConsultarIngresosMensuales
AS
BEGIN
    SELECT 
        YEAR(FechaEmision) AS Anio,
        MONTH(FechaEmision) AS Mes,
        SUM(Total) AS IngresoTotal,
        COUNT(IDFactura) AS CantidadFacturasEmitidas
    FROM Factura
    GROUP BY YEAR(FechaEmision), MONTH(FechaEmision)
    ORDER BY Anio DESC, Mes DESC;
END;
GO