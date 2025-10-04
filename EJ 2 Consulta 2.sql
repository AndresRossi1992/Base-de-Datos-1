#Consulta 2: ¿Qué clientes han tenido asuntos en los que ha participado el procurador Carlos López?
SELECT Clientes.nombre FROM Clientes
join Asuntos on Asuntos.dni_cliente = Clientes.dni
join Asuntos_Procuradores on Asuntos_Procuradores.numero_expediente = Asuntos.numero_expediente
join Procuradores on Procuradores.id_procurador = Asuntos_Procuradores.id_procurador
where Procuradores.nombre ='Carlos López';
