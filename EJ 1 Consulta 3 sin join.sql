#consulta 3 sin join: ¿Cuántas salidas ha realizado el barco con matrícula 'ABC123'?
SELECT (matricula), count(*) FROM Salidas
WHERE matricula = 'ABC123'
GROUP BY matricula;