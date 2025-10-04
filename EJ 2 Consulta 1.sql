#Consulta 1: ¿Cuál es el nombre y la dirección de los procuradores que han trabajado en un asunto abierto?
select Procuradores.nombre, Procuradores.direccion 
From Procuradores
join Asuntos_Procuradores on Asuntos_Procuradores.id_procurador = Procuradores.id_procurador
join Asuntos ON Asuntos.numero_expediente = Asuntos_Procuradores.numero_expediente
where Asuntos.estado = 'abierto';