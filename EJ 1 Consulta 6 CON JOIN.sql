#Consulta 6 con join: ¿Qué patrones (nombre y dirección) han llevado un barco cuyo socio vive en 'Barcelona'?
SELECT patron_nombre as Patrones, patron_direccion as direccion
FROM Salidas
join Barcos on Salidas.matricula = Barcos.matricula
join Socios on Socios.id_socio =  Barcos.id_socio
where Socios.direccion LIKE '%Barcelona%';