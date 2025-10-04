#Consulta 3: ¿Cuántos asuntos ha gestionado cada procurador?
SELECT (Procuradores.nombre), Procuradores.id_procurador , COUNT(*) FROM Procuradores
left join Asuntos_Procuradores on
Procuradores.id_procurador =  Asuntos_Procuradores.id_procurador
GROUP BY Procuradores.id_procurador;