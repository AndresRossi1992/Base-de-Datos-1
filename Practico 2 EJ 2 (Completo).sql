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


-- Poblar la tabla Clientes
INSERT INTO Clientes (dni, nombre, direccion)
VALUES
('123456789', 'Juan Pérez', 'Calle Pueyrredón 3498, Buenos Aires'),
('987654321', 'Ana García', 'Calle 5 323, La Plata'),
('456123789', 'Luis Fernández', 'Avenida de Gral. Paz 1056, Bahía Blanca');

-- Poblar la tabla Asuntos
INSERT INTO Asuntos (numero_expediente, dni_cliente, fecha_inicio, fecha_fin, estado)
VALUES
(1, '123456789', '2023-01-15', '2023-07-20', 'Cerrado'),
(2, '987654321', '2023-05-10', NULL, 'Abierto'),
(3, '456123789', '2023-06-01', '2023-09-10', 'Cerrado');

-- Poblar la tabla Procuradores
INSERT INTO Procuradores (id_procurador, nombre, direccion)
VALUES
(1, 'Laura Sánchez', 'Calle Soler 3765, Buenos Aires'),
(2, 'Carlos López', 'Calle Estrellas 8, Mar del Plata'),
(3, 'Marta Díaz', 'Calle Estación 12, Olavarria');

-- Poblar la tabla Asuntos_Procuradores
INSERT INTO Asuntos_Procuradores (numero_expediente, id_procurador)
VALUES
(1, 1),
(2, 2),
(3, 3),
(2, 1);  -- Un asunto puede tener varios procuradores

#Consulta 1: ¿Cuál es el nombre y la dirección de los procuradores que han trabajado en un asunto abierto?
select Procuradores.nombre, Procuradores.direccion 
From Procuradores
join Asuntos_Procuradores on Asuntos_Procuradores.id_procurador = Procuradores.id_procurador
join Asuntos ON Asuntos.numero_expediente = Asuntos_Procuradores.numero_expediente
where Asuntos.estado = 'abierto';

#Consulta 2: ¿Qué clientes han tenido asuntos en los que ha participado el procurador Carlos López?
SELECT Clientes.nombre FROM Clientes
join Asuntos on Asuntos.dni_cliente = Clientes.dni
join Asuntos_Procuradores on Asuntos_Procuradores.numero_expediente = Asuntos.numero_expediente
join Procuradores on Procuradores.id_procurador = Asuntos_Procuradores.id_procurador
where Procuradores.nombre ='Carlos López';

#Consulta 3: ¿Cuántos asuntos ha gestionado cada procurador?
SELECT (Procuradores.nombre), Procuradores.id_procurador , COUNT(*) FROM Procuradores
left join Asuntos_Procuradores on
Procuradores.id_procurador =  Asuntos_Procuradores.id_procurador
GROUP BY Procuradores.id_procurador;

#Consulta 4: Lista los números de expediente y fechas de inicio de los asuntos de los clientes que viven en Buenos Aires.
Select Asuntos.numero_expediente as Num_Expediente, Asuntos.fecha_inicio as Fecha_Inicio
from Asuntos
join Clientes on Clientes.dni = Asuntos.dni_cliente
where direccion like "%Buenos Aires%";


