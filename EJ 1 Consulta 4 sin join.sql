#consulta 4 sin join: Lista los barcos que tienen una cuota mayor a 500 y sus respectivos socios.
SELECT 
    Barcos.nombre AS nombre_barco,
    (SELECT nombre FROM Socios WHERE Socios.id_socio = Barcos.id_socio LIMIT 1) AS nombre_socio
FROM Barcos
WHERE Barcos.id_socio IN (
    SELECT id_socio FROM Barcos WHERE cuota > 500
);