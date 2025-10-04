#Consulta 4 con join: Lista los barcos que tienen una cuota mayor a 500 y sus respectivos socios.
select Barcos.nombre as nombre_Barco, Socios.nombre as nombre_Socio
from Barcos
join Socios on Barcos.id_socio = Socios.id_socio
where Barcos.cuota > 500;