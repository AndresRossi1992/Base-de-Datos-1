#consulta 5 con join: ¿Qué barcos han salido con destino a 'Mallorca'?
SELECT Barcos.nombre FROM Barcos
INNER JOIN Salidas ON Salidas.matricula = Barcos.matricula
WHERE Salidas.destino = 'Mallorca';