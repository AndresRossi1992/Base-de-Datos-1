#Consulta 3 con join: ¿Cuántas salidas ha realizado el barco con matrícula 'ABC123'?
SELECT COUNT(Salidas.matricula) as Salidas, Salidas.matricula as matricula
FROM Salidas
inner Join Barcos on Barcos.matricula = Salidas.matricula
WHERE Salidas.matricula = 'ABC123';