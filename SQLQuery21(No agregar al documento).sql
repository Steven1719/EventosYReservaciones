USE EVENTOSDB;
GO

-- =======================================================
-- 1. LIMPIEZA DE DATOS Y REINICIO DE CONTADORES
-- =======================================================
-- Borramos de hijos a padres para no romper relaciones
DELETE FROM Factura;
DELETE FROM Reservacion_Servicio;
DELETE FROM Reservacion;
DELETE FROM Evento;
DELETE FROM ServicioExtra;
DELETE FROM Ubicacion;
DELETE FROM TipoEvento;
DELETE FROM Cliente;
GO

-- Reiniciamos todos los IDs a 0 para que el próximo registro sea el 1
DBCC CHECKIDENT ('Factura', RESEED, 0);
DBCC CHECKIDENT ('Reservacion', RESEED, 0);
DBCC CHECKIDENT ('Evento', RESEED, 0);
DBCC CHECKIDENT ('ServicioExtra', RESEED, 0);
DBCC CHECKIDENT ('Ubicacion', RESEED, 0);
DBCC CHECKIDENT ('TipoEvento', RESEED, 0);
DBCC CHECKIDENT ('Cliente', RESEED, 0);
GO

-- =======================================================
-- 2. INSERCIÓN LIMPIA DE DATOS
-- =======================================================
EXECUTE AS USER = 'FreddyR';
GO

INSERT INTO Cliente (DNI, Nombres, Apellidos, Telefono, Email) VALUES
('001-010190-1000A', 'Mario', 'Gomez', '88881111', 'mario.gomez@mail.com'),
('001-020292-1001B', 'Lucia', 'Fernandez', '88882222', 'lucia.f@mail.com'),
('001-030385-1002C', 'Roberto', 'Davila', '88883333', 'roberto.d@mail.com'),
('001-040495-1003D', 'Sofia', 'Reyes', '88884444', 'sofia.reyes@mail.com'),
('001-050588-1004E', 'Marcos', 'Silva', '88885555', 'marcos.s@mail.com'),
('001-060699-1005F', 'Elena', 'Torres', '88886666', 'elena.t@mail.com');

INSERT INTO TipoEvento (NombreTipo) VALUES
('Boda'), ('Conferencia Corporativa'), ('Concierto'), ('Fiesta de 15 Años'), ('Seminario');

INSERT INTO Ubicacion (Nombre, CapacidadMaxima, CostoBase) VALUES
('Salon Principal Zafiro', 200, 1500.00),
('Jardin Botanico Central', 150, 1200.00),
('Auditorio Los Arcos', 300, 2000.00),
('Terraza VIP', 50, 800.00),
('Centro de Convenciones', 1000, 5000.00);

INSERT INTO ServicioExtra (NombreServicio, Precio) VALUES
('Catering Premium', 500.00), ('DJ y Sonido Profesional', 300.00), 
('Fotografia y Video', 400.00), ('Decoracion Floral', 250.00), ('Seguridad Privada', 200.00);

INSERT INTO Evento (NombreEvento, FechaEvento, CantidadAsistentes, IDTipo, IDUbicacion) VALUES
('Boda de Mario y Lucia', '2026-08-15', 120, 1, 1),
('Tech Conf 2026', '2026-09-20', 500, 2, 5),
('Rock Fest Nacional', '2026-10-10', 250, 3, 3),
('Fiesta de 15 de Ana', '2026-07-25', 100, 4, 2),
('Seminario de Liderazgo', '2026-11-05', 40, 5, 4);

INSERT INTO Reservacion (FechaReservacion, Estado, IDCliente, IDEvento) VALUES
('2026-06-01', 'Confirmada', 1, 1),
('2026-06-05', 'Confirmada', 3, 2),
('2026-06-10', 'Pendiente', 5, 3),
('2026-06-12', 'Confirmada', 2, 4),
('2026-06-15', 'Cancelada', 4, 5);

INSERT INTO Reservacion_Servicio (IDReservacion, IDServicio, Cantidad) VALUES
(1, 1, 1), (1, 3, 1), (2, 2, 1), (3, 5, 2), (4, 4, 1); 

INSERT INTO Factura (IDReservacion, FechaEmision, Total) VALUES
(1, '2026-06-02', 2400.00),
(2, '2026-06-06', 5300.00),
(3, '2026-06-11', 2400.00),
(4, '2026-06-13', 1450.00),
(5, '2026-06-16', 100.00); 

REVERT;
GO