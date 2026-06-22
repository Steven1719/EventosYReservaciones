-- Auditoría para Cliente
CREATE TABLE AuditoriaCliente (
    IDAuditoria INT IDENTITY(1,1) PRIMARY KEY,
    Accion VARCHAR(20),
    Fecha DATETIME DEFAULT GETDATE(),
    RegistroAfectado INT, -- Guardará el IDCliente
    Usuario VARCHAR(50)
);

-- Auditoría para Evento
CREATE TABLE AuditoriaEvento (
    IDAuditoria INT IDENTITY(1,1) PRIMARY KEY,
    Accion VARCHAR(20),
    Fecha DATETIME DEFAULT GETDATE(),
    RegistroAfectado INT, -- Guardará el IDEvento
    Usuario VARCHAR(50)
);

-- Auditoría para Reservacion
CREATE TABLE AuditoriaReservacion (
    IDAuditoria INT IDENTITY(1,1) PRIMARY KEY,
    Accion VARCHAR(20),
    Fecha DATETIME DEFAULT GETDATE(),
    RegistroAfectado INT, -- Guardará el IDReservacion
    Usuario VARCHAR(50)
);