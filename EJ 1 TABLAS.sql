DROP DATABASE IF EXISTS BDI;
CREATE DATABASE BDI;
USE BDI;

Create table Socios (
    id_socio INT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(255)
);

Create table Barcos (
    matricula VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100),
    numero_amarre INT,
    cuota DECIMAL (10, 2),
    id_socio INT,
    FOREIGN KEY  (id_socio) REFERENCES Socios(id_socio)
);

Create table Salidas (
    id_salida INT PRIMARY KEY,
    matricula VARCHAR(20) ,
    fecha_salida DATE,
    hora_salida TIME,
    destino VARCHAR(100),
    patron_nombre VARCHAR(100),
    patron_direccion VARCHAR(255)
);