#Consulta 5 sin join: ¿Qué barcos han salido con destino a 'Mallorca'?
SELECT nombre FROM Barcos
Where matricula in (
	SELECT matricula FROM Salidas
    WHERE (destino = "Mallorca")
);