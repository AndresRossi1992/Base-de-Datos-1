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