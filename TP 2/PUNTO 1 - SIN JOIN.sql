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
