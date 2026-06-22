CREATE DATABASE EVENTOSDB
USE EVENTOSDB
GO


-- Tabla: Cliente
CREATE TABLE Cliente (
    IDCliente INT IDENTITY(1,1) PRIMARY KEY,
    DNI VARCHAR(16) UNIQUE NOT NULL, -- Uso de UNIQUE y NOT NULL
    Nombres VARCHAR(50) NOT NULL,
    Apellidos VARCHAR(50) NOT NULL,
    Telefono VARCHAR(20),
    Email VARCHAR(100) UNIQUE
);

-- Tabla: TipoEvento (Ej. Boda, Conferencia, Concierto)
CREATE TABLE TipoEvento (
    IDTipo INT IDENTITY(1,1) PRIMARY KEY,
    NombreTipo VARCHAR(50) UNIQUE NOT NULL
);

-- Tabla: Ubicacion (Lugar del evento)
CREATE TABLE Ubicacion (
    IDUbicacion INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    CapacidadMaxima INT CHECK (CapacidadMaxima > 0), -- Uso de CHECK
    CostoBase DECIMAL(10,2) CHECK (CostoBase >= 0)
);

-- Tabla: ServicioExtra (Catálogo de servicios como Catering, Música, etc.)
CREATE TABLE ServicioExtra (
    IDServicio INT IDENTITY(1,1) PRIMARY KEY,
    NombreServicio VARCHAR(50) UNIQUE NOT NULL,
    Precio DECIMAL(10,2) CHECK (Precio >= 0)
);



-- Tabla: Evento (Relaciones 1:N con TipoEvento y Ubicacion)
CREATE TABLE Evento (
    IDEvento INT IDENTITY(1,1) PRIMARY KEY,
    NombreEvento VARCHAR(100) NOT NULL,
    FechaEvento DATE NOT NULL,
    CantidadAsistentes INT CHECK (CantidadAsistentes > 0),
    IDTipo INT NOT NULL,
    IDUbicacion INT NOT NULL,
    FOREIGN KEY (IDTipo) REFERENCES TipoEvento(IDTipo),
    FOREIGN KEY (IDUbicacion) REFERENCES Ubicacion(IDUbicacion)
);

-- Tabla: Reservacion (Relación 1:N con Cliente y Evento)
CREATE TABLE Reservacion (
    IDReservacion INT IDENTITY(1,1) PRIMARY KEY,
    FechaReservacion DATE DEFAULT GETDATE(), -- Uso de DEFAULT
    Estado VARCHAR(20) DEFAULT 'Pendiente' CHECK (Estado IN ('Pendiente', 'Confirmada', 'Cancelada')),
    IDCliente INT NOT NULL,
    IDEvento INT NOT NULL,
    FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCliente),
    FOREIGN KEY (IDEvento) REFERENCES Evento(IDEvento)
);

-- Tabla: Reservacion_Servicio (Relación M:M entre Reservacion y ServicioExtra)
CREATE TABLE Reservacion_Servicio (
    IDReservacion INT NOT NULL,
    IDServicio INT NOT NULL,
    Cantidad INT DEFAULT 1 CHECK (Cantidad > 0),
    PRIMARY KEY (IDReservacion, IDServicio), -- Llave primaria compuesta
    FOREIGN KEY (IDReservacion) REFERENCES Reservacion(IDReservacion),
    FOREIGN KEY (IDServicio) REFERENCES ServicioExtra(IDServicio)
);


-- Tabla: Factura (Relación 1:1 con Reservacion)
CREATE TABLE Factura (
    IDFactura INT IDENTITY(1,1) PRIMARY KEY,
    IDReservacion INT UNIQUE NOT NULL,
    FechaEmision DATE DEFAULT GETDATE(),
    Total DECIMAL(10,2) NOT NULL CHECK (Total >= 0),
    FOREIGN KEY (IDReservacion) REFERENCES Reservacion(IDReservacion)
);
