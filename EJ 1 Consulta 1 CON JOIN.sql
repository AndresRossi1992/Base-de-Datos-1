#Consulta 1 con join: ¿Qué socios tienen barcos amarrados en un número de amarre mayor que 10?
SELECT Socios.nombre
FROM Socios
JOIN Barcos ON Socios.id_socio = Barcos.id_socio
WHERE Barcos.numero_amarre > 10;