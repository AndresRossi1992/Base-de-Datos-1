#Consulta 2 con join:  ¿Cuáles son los nombres de los barcos y sus cuotas de aquellos barcos cuyo socio se llama 'Juan Pérez'?
SELECT Barcos.cuota as cuota, Barcos.nombre as nombre 
FROM Barcos
JOIN Socios ON Socios.id_socio = Barcos.id_socio
WHERE Socios.nombre LIKE "%Juan Pérez%";