USE EVENTOSDB;
GO

CREATE PROCEDURE SP_EstadisticasUbicacion
AS
BEGIN
    SELECT 
        U.Nombre AS NombreUbicacion,
        COUNT(E.IDEvento) AS TotalEventosRealizados,
        ISNULL(AVG(E.CantidadAsistentes), 0) AS PromedioAsistentes
    FROM Ubicacion U
    LEFT JOIN Evento E ON U.IDUbicacion = E.IDUbicacion
    GROUP BY U.Nombre;
END;
GO