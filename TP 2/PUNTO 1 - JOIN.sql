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