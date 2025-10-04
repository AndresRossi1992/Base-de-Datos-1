#Consulta 1: ¿Cuál es el nombre y la dirección de los procuradores que han trabajado en un asunto abierto?
select Procuradores.nombre, Procuradores.direccion 
From Procuradores
join Asuntos_Procuradores on Asuntos_Procuradores.id_procurador = Procuradores.id_procurador
join Asuntos ON Asuntos.numero_expediente = Asuntos_Procuradores.numero_expediente
where Asuntos.estado = 'abierto';

#Consulta 2: ¿Qué clientes han tenido asuntos en los que ha participado el procurador Carlos López?
SELECT Clientes.nombre FROM Clientes
join Asuntos on Asuntos.dni_cliente = Clientes.dni
join Asuntos_Procuradores on Asuntos_Procuradores.numero_expediente = Asuntos.numero_expediente
join Procuradores on Procuradores.id_procurador = Asuntos_Procuradores.id_procurador
where Procuradores.nombre ='Carlos López';

#Consulta 3: ¿Cuántos asuntos ha gestionado cada procurador?
SELECT (Procuradores.nombre), Procuradores.id_procurador , COUNT(*) FROM Procuradores
left join Asuntos_Procuradores on
Procuradores.id_procurador =  Asuntos_Procuradores.id_procurador
GROUP BY Procuradores.id_procurador;

#Consulta 4: Lista los números de expediente y fechas de inicio de los asuntos de los clientes que viven en Buenos Aires.
Select Asuntos.numero_expediente as Num_Expediente, Asuntos.fecha_inicio as Fecha_Inicio
from Asuntos
join Clientes on Clientes.dni = Asuntos.dni_cliente
where direccion like "%Buenos Aires%";