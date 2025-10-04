#consulta 1 sin join: ¿Qué socios tienen barcos amarrados en un número de amarre mayor que 10?
SELECT nombre FROM Socios
WHERE id_socio in (
	SELECT id_socio FROM Barcos
    WHERE (numero_amarre > 10)
    );