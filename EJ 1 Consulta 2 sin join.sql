#consulta 2 sin join: ¿Cuáles son los nombres de los barcos y sus cuotas de aquellos barcos cuyo socio se llama 'Juan Pérez'?
SELECT nombre, cuota FROM Barcos
WHERE id_socio in (
	SELECT id_socio FROM Socios
	WHERE nombre = 'Juan Pérez'
);