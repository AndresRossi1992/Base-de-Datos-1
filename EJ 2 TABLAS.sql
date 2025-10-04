DROP DATABASE IF EXISTS BDI;
CREATE DATABASE BDI;
USE BDI;

Create table Clientes (
    dni INT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(255)
);

Create table Asuntos (
    numero_expediente INT PRIMARY KEY,
    dni_cliente INT,
    foreign key (dni_cliente) references Clientes (dni),
    fecha_inicio date not null,
    fecha_fin date,
    estado ENUM ("Abierto","Cerrado") not null
    
);

Create table Procuradores (
    id_procurador INT PRIMARY KEY,
    nombre VARCHAR(100) ,
    direccion varchar (255)    
);

Create table Asuntos_Procuradores (
    numero_expediente int,
    foreign key (numero_expediente) references Asuntos (numero_expediente),
    id_procurador int,
    foreign key (id_procurador) references Procuradores (id_procurador)
);