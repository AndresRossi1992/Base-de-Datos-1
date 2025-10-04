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


-- Populación de las tablas
INSERT INTO Socios (id_socio, nombre, direccion)
VALUES
(1, 'Juan Pérez', 'Calle Mayor 1, Madrid'),
(2, 'Ana García', 'Calle Luna 5, Barcelona'),
(3, 'Luis Fernández', 'Avenida del Sol 10, Valencia'),
(4, 'Laura Sánchez', 'Plaza del Mar 3, Alicante'),
(5, 'Carlos López', 'Calle Río 8, Sevilla'),
(6, 'Marta Díaz', 'Calle de la Sierra 12, Zaragoza'),
(7, 'Pedro Gómez', 'Calle Nueva 20, Bilbao'),
(8, 'Lucía Jiménez', 'Calle Real 30, Madrid'),
(9, 'María Torres', 'Calle Verde 15, Málaga'),
(10, 'Fernando Martín', 'Calle Azul 25, Murcia');

INSERT INTO Barcos (matricula, nombre, numero_amarre, cuota, id_socio)
VALUES
('ABC123', 'El Viento', 12, 600.50, 1),
('DEF456', 'La Brisa', 8, 450.00, 2),
('GHI789', 'El Sol', 15, 700.00, 3),
('JKL012', 'El Mar', 10, 550.75, 4),
('MNO345', 'La Luna', 18, 620.30, 5),
('PQR678', 'El Horizonte', 20, 780.90, 6),
('STU901', 'El Amanecer', 5, 400.00, 7),
('VWX234', 'La Estrella', 7, 520.50, 8),
('YZA567', 'La Marea', 14, 480.75, 9),
('BCD890', 'El Océano', 6, 630.80, 10);

INSERT INTO Salidas (id_salida, matricula, fecha_salida, hora_salida, destino, patron_nombre, patron_direccion)
VALUES
(1, 'ABC123', '2023-07-15', '10:30:00', 'Mallorca', 'Patrón 1', 'Calle de la Playa 1, Palma'),
(2, 'DEF456', '2023-07-20', '09:00:00', 'Ibiza', 'Patrón 2', 'Avenida del Puerto 3, Valencia'),
(3, 'GHI789', '2023-07-22', '08:45:00', 'Menorca', 'Patrón 3', 'Calle de la Costa 10, Alicante'),
(4, 'JKL012', '2023-07-25', '11:15:00', 'Mallorca', 'Patrón 4', 'Plaza del Faro 5, Barcelona'),
(5, 'MNO345', '2023-08-01', '14:00:00', 'Formentera', 'Patrón 5', 'Calle del Puerto 20, Ibiza'),
(6, 'PQR678', '2023-08-05', '07:30:00', 'Mallorca', 'Patrón 6', 'Calle de las Olas 15, Palma'),
(7, 'STU901', '2023-08-10', '12:00:00', 'Ibiza', 'Patrón 7', 'Avenida de la Marina 7, Barcelona'),
(8, 'VWX234', '2023-08-12', '09:30:00', 'Cabrera', 'Patrón 8', 'Calle del Mar 12, Alicante'),
(9, 'YZA567', '2023-08-15', '10:00:00', 'Formentera', 'Patrón 9', 'Calle del Sol 4, Ibiza'),
(10, 'BCD890', '2023-08-20', '08:00:00', 'Menorca', 'Patrón 10', 'Plaza del Faro 2, Palma');

#consulta 1 sin join: ¿Qué socios tienen barcos amarrados en un número de amarre mayor que 10?
SELECT nombre FROM Socios
WHERE id_socio in (
	SELECT id_socio FROM Barcos
    WHERE (numero_amarre > 10)
    );
    
#consulta 2 sin join: ¿Cuáles son los nombres de los barcos y sus cuotas de aquellos barcos cuyo socio se llama 'Juan Pérez'?
SELECT nombre, cuota FROM Barcos
WHERE id_socio in (
	SELECT id_socio FROM Socios
	WHERE nombre = 'Juan Pérez'
);
    
#consulta 3 sin join: ¿Cuántas salidas ha realizado el barco con matrícula 'ABC123'?
SELECT (matricula), count(*) FROM Salidas
WHERE matricula = 'ABC123'
GROUP BY matricula;
    
#consulta 4 sin join: Lista los barcos que tienen una cuota mayor a 500 y sus respectivos socios.
SELECT 
    Barcos.nombre AS nombre_barco,
    (SELECT nombre FROM Socios WHERE Socios.id_socio = Barcos.id_socio LIMIT 1) AS nombre_socio
FROM Barcos
WHERE Barcos.id_socio IN (
    SELECT id_socio FROM Barcos WHERE cuota > 500
);

#Consulta 5 sin join: ¿Qué barcos han salido con destino a 'Mallorca'?
SELECT nombre FROM Barcos
Where matricula in (
	SELECT matricula FROM Salidas
    WHERE (destino = "Mallorca")
);

#Consulta 6 sin join: ¿Qué patrones (nombre y dirección) han llevado un barco cuyo socio vive en 'Barcelona'?
SELECT 
	Salidas.patron_nombre AS nombre, Salidas.patron_direccion as direccion
FROM Salidas
WHERE Salidas.matricula IN (
	SELECT matricula FROM Barcos
		WHERE id_socio IN(
			SELECT id_socio FROM Socios WHERE direccion LIKE "%Barcelona%"
    )
	);
    
    
#CONSULTAS CON JOIN

#Consulta 1 con join: ¿Qué socios tienen barcos amarrados en un número de amarre mayor que 10?
SELECT Socios.nombre
FROM Socios
JOIN Barcos ON Socios.id_socio = Barcos.id_socio
WHERE Barcos.numero_amarre > 10;

#Consulta 2 con join:  ¿Cuáles son los nombres de los barcos y sus cuotas de aquellos barcos cuyo socio se llama 'Juan Pérez'?
SELECT Barcos.cuota as cuota, Barcos.nombre as nombre 
FROM Barcos
JOIN Socios ON Socios.id_socio = Barcos.id_socio
WHERE Socios.nombre LIKE "%Juan Pérez%";

#Consulta 3 con join: ¿Cuántas salidas ha realizado el barco con matrícula 'ABC123'?
SELECT COUNT(Salidas.matricula) as Salidas, Salidas.matricula as matricula
FROM Salidas
inner Join Barcos on Barcos.matricula = Salidas.matricula
WHERE Salidas.matricula = 'ABC123';


#Consulta 4 con join: Lista los barcos que tienen una cuota mayor a 500 y sus respectivos socios.
select Barcos.nombre as nombre_Barco, Socios.nombre as nombre_Socio
from Barcos
join Socios on Barcos.id_socio = Socios.id_socio
where Barcos.cuota > 500;

#consulta 5 con join: ¿Qué barcos han salido con destino a 'Mallorca'?
SELECT Barcos.nombre FROM Barcos
INNER JOIN Salidas ON Salidas.matricula = Barcos.matricula
WHERE Salidas.destino = 'Mallorca';

#Consulta 6 con join: ¿Qué patrones (nombre y dirección) han llevado un barco cuyo socio vive en 'Barcelona'?
SELECT patron_nombre as Patrones, patron_direccion as direccion
FROM Salidas
join Barcos on Salidas.matricula = Barcos.matricula
join Socios on Socios.id_socio =  Barcos.id_socio
where Socios.direccion LIKE '%Barcelona%';


