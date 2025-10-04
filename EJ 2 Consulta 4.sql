#Consulta 4: Lista los números de expediente y fechas de inicio de los asuntos de los clientes que viven en Buenos Aires.
Select Asuntos.numero_expediente as Num_Expediente, Asuntos.fecha_inicio as Fecha_Inicio
from Asuntos
join Clientes on Clientes.dni = Asuntos.dni_cliente
where direccion like "%Buenos Aires%";