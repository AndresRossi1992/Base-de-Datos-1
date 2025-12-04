import mysql.connector 
# ==================== CONEXIÓN A LA BASE DE DATOS ====================

def conectar():
    try:
        mybd = mysql.connector.connect(
            host="localhost",               
            port='3306',                       
            user="usuario",                      
            password="test1234",      
            database="HOSPITAL"  
        )
        if mybd.is_connected():
            print("Conexión exitosa a la base de datos")
            return mybd
        
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return None
    return None

mybd = conectar()
curs = mybd.cursor()
# ==================== FUNCIONES CRUD PACIENTES ====================

def crear_paciente(nombre):    
    try:
        consulta = "INSERT INTO pacientes (nombre) VALUES (%s)"
        curs.execute(consulta, (nombre,))
        mybd.commit()
        return True
    except mysql.connector.Error as err:
        print(f"Error al registrar paciente: {err}")
        return False

def actualizar_paciente(id, nombre):
    try:
        sql = "UPDATE pacientes SET nombre=%s WHERE id_paciente=%s"
        valores = (nombre, id)
        curs.execute(sql, valores)
        mybd.commit()
        print("Usuario modificado con éxito.")
    except mysql.connector.Error as err:
        print(f"Error al modificar paciente: {err}")
        return False


def ver_pacientes():
    try:
        consulta = "SELECT id_paciente, nombre FROM pacientes ORDER BY id_paciente"
        curs.execute(consulta)
    except mysql.connector.Error as err:
        print(f"Error al obtener pacientes: {err}")
        return None

def eliminar_paciente(id_paciente):
    try:
        sql = f'SELECT COUNT(*) FROM turnos WHERE id_paciente = {id_paciente}'
        curs.execute(sql)
        tur = curs.fetchall()
        if tur[0][0] > 0:
            sn = input("Este paciente tiene turnos programados, eliminarlo borrara tambien todos los turnos relacionados. Continuar? (s/n):")
            if sn.lower() == 'n':
                return False
            elif sn.lower() == 's' or tur[0][0] == 0:
                sql = f'DELETE FROM pacientes WHERE id_paciente = {id_paciente}'
                curs.execute(sql)
                mybd.commit()
                return True
            else:
                print("Respuesta invalida. Operación cancelada.")
                return False
    except mysql.connector.Error as err:
        print(f"Error al eliminar paciente: {err}")
        return False
#==================== FUNCIONES CRUD DOCTORES ====================

def agregar_doctor(nombre, especialidad):
    try:
        consulta = "INSERT INTO medicos (nombre, especialidad) VALUES (%s, %s)"
        curs.execute(consulta, (nombre, especialidad))
        mybd.commit()
        return True
    except mysql.connector.Error as err:
        print(f"Error al agregar el doctor: {err}")
        return False
    
def actualizar_doctor(id_medico, especialidad: str | None = None, nombre: str | None = None):
    try:
        if especialidad:
            consulta = "UPDATE medicos SET especialidad = %s WHERE id_medico = %s"
            curs.execute(consulta, (especialidad, id_medico))
            mybd.commit()
        if nombre:
            consulta = "UPDATE medicos SET nombre = %s WHERE id_medico = %s"
            curs.execute(consulta, (nombre, id_medico))
            mybd.commit()
        return True
    except mysql.connector.Error as err:
        print(f"Error al actualizar el doctor: {err}")
    return False
    
def ver_doctores():
    try:
        consulta = "SELECT * FROM medicos"
        curs.execute(consulta)
        resultados = curs.fetchall()
        return resultados
    except mysql.connector.Error as err:
        print(f"Error al obtener los medicos: {err}")
        return []
    
def eliminar_doctor(id_medico):
    try:
        sql = f'SELECT COUNT(*) FROM turnos WHERE id_medico = {id_medico}'
        curs.execute(sql)
        tur = curs.fetchall()
        if tur[0][0] > 0:
            sn = input("Este medico tiene turnos programados, eliminarlo borrara tambien todos los turnos relacionados. Continuar? (s/n):")
            if sn.lower() == 'n':
                return False
            elif sn.lower() == 's' or tur[0][0] == 0:
                sql = f'DELETE FROM medicos WHERE id_medico = {id_medico}'
                curs.execute(sql)
                mybd.commit()
                return True
            else:
                print("Respuesta invalida. Operación cancelada.")
                return False
    except mysql.connector.Error as err:
        print(f"Error al eliminar el doctor: {err}")
        return False

#================ FUNCIÓN CRUD MANEJO DE TURNOS =========================
def programar_turnos(id_medico, id_paciente, fecha, horario):
    try:
        sql = '''
            INSERT INTO turnos (fecha, horario, id_paciente, id_medico)
            VALUES (%s, %s, %s, %s)
        '''
        valores = (id_medico, id_paciente, fecha, horario)
        curs.execute(sql, valores)
        mybd.commit()
        print("Turno programado correctamente")
        return True
    except mysql.connector.Error as err:
        print(f"Error al programar turno: {err}")
        return False
def ver_turnos():
    try:
        sql = '''
            SELECT t.id_turno, t.fecha, t.horario, p.nombre AS paciente, m.nombre AS medico
            FROM turnos AS t
            JOIN pacientes p ON t.id_paciente = p.id_paciente
            JOIN medicos m ON t.id_medico = m.id_medico
            ORDER BY t.fecha, t.horario
        '''
        curs.execute(sql)
        resultados = curs.fetchall()
        return resultados
    except mysql.connector.Error as err:
        print(f"Error al obtener los turnos: {err}")
        return []
    
def cancelar_turno(id_turno):
    try:
        sql = 'DELETE FROM turnos WHERE id_turno = %s'
        valor = (id_turno,)
        curs.execute(sql, valor)
        mybd.commit()
        print("Turno cancelado correctamente")
        return True
    except mysql.connector.Error as err:
        print(f"Error al cancelar turno: {err}")
        return False
    
def actualizar_turno(id_turno, nueva_fecha, nuevo_horario):
    try:
        sql = '''
            UPDATE turnos
            SET fecha = %s, horario = %s
            WHERE id_turno = %s
        '''
        valores = (nueva_fecha, nuevo_horario, id_turno)
        curs.execute(sql, valores)
        mybd.commit()
        print("Turno actualizado correctamente")
        return True
    except mysql.connector.Error as err:
        print(f"Error al actualizar turno: {err}")
        return False
#================== BÚSQUEDA CON ÍNDICES ========================

def busqueda_con_index(nombre: str | None = None, especialidad: str | None = None, id: str | None = None, tipo: str = ''):

        # Crea indices a menos que ya existan
        try:
            curs.execute("CREATE INDEX idx_paciente_nombre ON pacientes(nombre)")
        except mysql.connector.Error:
            pass
        try:
            curs.execute("CREATE INDEX idx_paciente_id ON pacientes(id_paciente)")
        except mysql.connector.Error:
            pass
        try:
            curs.execute("CREATE INDEX idx_medico_nombre ON medicos(nombre)")
        except mysql.connector.Error:
            pass
        try:
            curs.execute("CREATE INDEX idx_medico_especialidad ON medicos(especialidad)")
        except mysql.connector.Error:
            pass
        try:
            curs.execute("CREATE INDEX idx_medico_id ON medicos(id_medico)")
        except mysql.connector.Error:
            pass

        consulta = ""
        parametros = []
        t = tipo.lower()

        if t in ('m'):
            consulta = "SELECT * FROM medicos WHERE 1=1"
            if nombre:
                consulta += " AND nombre LIKE %s"
                parametros.append(f"%{nombre}%")
            if especialidad:
                consulta += " AND especialidad LIKE %s"
                parametros.append(f"%{especialidad}%")
            if id:
                consulta += " AND id_medico = %s"
                parametros.append(id)

        elif t in ('p'):
            consulta = "SELECT * FROM pacientes WHERE 1=1"
            if nombre:
                consulta += " AND nombre LIKE %s"
                parametros.append(f"%{nombre}%")
            if id:
                consulta += " AND id_paciente = %s"
                parametros.append(id)

        curs.execute(consulta, tuple(parametros))
        resultados = curs.fetchall()

        if resultados:
            print(f"Resultados encontrados:")
            for fila in resultados:
                print(f"  {fila}")
        else:
            print("No se encontraron resultados")

        return resultados
#===============================================================================
# REPORTE DE TURNOS POR MÉDICO =========================

def reporte_turnos ():
    try:
        sql = "SELECT COUNT(turnos.id_turno) as cantidad_turnos, medicos.nombre FROM medicos JOIN turnos ON turnos.id_medico = medicos.id_medico GROUP BY medicos.nombre ORDER BY cantidad_turnos DESC LIMIT 3;"
        curs.execute(sql)
        resultados = curs.fetchall()
        return resultados
    except mysql.connector.Error as err:
        print("Error al generar el reporte de turnos: {}".format(err))
#==============================================================================
# Cancelar turnos para un medico =================================================

def cancelar_turno_medico(id_medico):
    try:
        fecha_principio = input ("Ingrese la fecha de inicio (AAAA-MM-DD): ")
        fecha_final = input ("Ingrese la fecha final (AAAA-MM-DD): ")
        sql = '''
            DELETE FROM turnos
            WHERE id_medico = %s AND fecha >= %s AND fecha <= %s'''
        curs.execute(sql, (id_medico, fecha_principio, fecha_final))
        mybd.commit()
    except mysql.connector.Error as err:
        print("Error al cancelar turnos del médico: {}".format(err))

#================== MENÚ PRINCIPAL ========================

def menu_gestion_pacientes():
    print("\n--- Gestión de Pacientes ---")
    print("1. Registrar Paciente")
    print("2. Actualizar Paciente")
    print("3. Ver Pacientes")
    print("4. Eliminar Paciente")
    print("0. Volver al Menú Principal")
    opcion = input("Seleccione una opción: ")
    return opcion

def menu_gestion_doctores():
    print("\n--- Gestión de Doctores ---")
    print("1. Registrar Doctor")
    print("2. Actualizar Doctor")
    print("3. Ver Doctores")
    print("4. Eliminar Doctor")
    print("0. Volver al Menú Principal")
    opcion = input("Seleccione una opción: ")
    return opcion

def menu_manejo_turnos():
    print("\n--- Manejo de Turnos ---")
    print("1. Programar Turno")
    print("2. Actualizar Turno")
    print("3. Ver Turnos")
    print("4. Cancelar Turno")
    print("0. Volver al Menú Principal")
    opcion = input("Seleccione una opción: ")
    return opcion

def menu():
    print("\n--- Sistema de Gestión de Hospital ---")
    print("1. Gestion de Pacientes")
    print("2. Gestion de Doctores")
    print("3. Manejo de Turnos")
    print("4. Búsquedas Avanzadas")
    print("5. Reporte de turnos")
    print("6. Cancelación de turnos")
    print("0. Salir")
    opcion = input("Seleccione una opción: ")
    return opcion
#================== MENÚ PRINCIPAL ========================
opcion = ""
while opcion != "0":
    opcion = menu()
    #================ Gestión de Pacientes ========================
    if opcion == "1":
        opcion_pacientes = ""
        while opcion_pacientes != "0":
            opcion_pacientes = menu_gestion_pacientes()
            if opcion_pacientes == "1":
                nombre = input("Ingrese el nombre del paciente: ")
                if crear_paciente(nombre):
                    print("Paciente registrado exitosamente.")
            elif opcion_pacientes == "2":
                id = input("Ingrese el ID del paciente a actualizar: ")
                nombre = input("Ingrese el nuevo nombre del paciente: ")
                actualizar_paciente(id, nombre)
            elif opcion_pacientes == "3":
                ver_pacientes()
                for (id_paciente, nombre) in curs:
                    print(f"ID: {id_paciente}, Nombre: {nombre}")
            elif opcion_pacientes == "4":
                id_paciente = input("Ingrese el ID del paciente a eliminar: ")
                if eliminar_paciente(id_paciente):
                    print("Paciente eliminado exitosamente.")
    #================ Gestión de Doctores ========================
    elif opcion == "2":
        opcion_medicos = ""
        while opcion_medicos != "0":
            opcion_medicos = menu_gestion_doctores()
            if opcion_medicos == "1":
                nombre = input("Ingrese el nombre del doctor: ")
                especialidad = input("Ingrese la especialidad del doctor: ")
                if agregar_doctor(nombre, especialidad):
                    print("Doctor agregado exitosamente.")
                else:
                    print("Error al agregar el doctor.")
            elif opcion_medicos == "2":
                id = input("Ingrese el id del doctor a actualizar: ")
                especialidad = input("Ingrese la nueva especialidad (deje vacío para omitir): ")
                nombre = input("Ingrese el nuevo nombre (deje vacío para omitir): ")
                if actualizar_doctor(id, especialidad, nombre):
                    print("Doctor actualizado exitosamente.")
                else:
                    print("Error al actualizar el doctor.")
            elif opcion_medicos == "3":
                medicos = ver_doctores()
                for (id_medico, nombre, especialidad) in medicos:
                    print(f"ID: {id_medico}, Nombre: {nombre}, Especialidad: {especialidad}")
            elif opcion_medicos == "4":
                id_medico = input("Ingrese el ID del doctor a eliminar: ")
                if eliminar_doctor(id_medico):
                    print("Doctor eliminado exitosamente.")
    #================ Manejo de Turnos ========================
    elif opcion == "3":
        opcion_turnos = ""
        while opcion_turnos != "0":
            opcion_turnos = menu_manejo_turnos()
            if opcion_turnos == "1":
                fecha = input("Ingrese la fecha del turno (AAA/MM/DD): ")
                horario = input("Ingrese el horario del turno (HH:MM:SS): ")
                id_paciente = input("Ingrese el ID del paciente: ")
                id_medico = input("Ingrese el ID del médico: ")
                programar_turnos(fecha, horario, id_paciente, id_medico)
            elif opcion_turnos == "2":
                id_turno = input("Ingrese el ID del turno a actualizar: ")
                nueva_fecha = input("Ingrese la nueva fecha del turno (AAAA/MM/DD): ")
                nuevo_horario = input("Ingrese el nuevo horario del turno (HH:MM): ")
                actualizar_turno(id_turno, nueva_fecha, nuevo_horario)
            elif opcion_turnos == "3":
                turnos = ver_turnos()
                for (id_turno, fecha, hora, paciente, medico) in turnos:
                    print(f"ID Turno: {id_turno}, Fecha: {fecha}, Hora: {hora}, Paciente: {paciente}, Médico: {medico}")
            elif opcion_turnos == "4":
                id_turno = input("Ingrese el ID del turno a cancelar: ")
                cancelar_turno(id_turno)
            elif opcion_turnos == "0":
                print("Regresando al menú principal...")
            else:
                print("Opción inválida. Por favor, intente de nuevo.")
    #================ Búsquedas Avanzadas ========================
    elif opcion == "4":
        check = True
        while check:
            tipo = input("Buscar en (p)acientes o (m)edicos? [p/m]: ").strip().lower()
            if tipo not in ('p', 'm') or tipo == '':
                print(f"Error: tipo de búsqueda '{tipo}' no válido. Use 'p' para pacientes o 'm' para medicos")
            else:
                check = False
        if tipo == 'p':
            nom = input("Ingrese el nombre a buscar (deje vacío para omitir): ").strip() or None
            id = input("Ingrese el ID del paciente a buscar (deje vacío para omitir): ").strip() or None
            busqueda_con_index(nombre=nom, id=id, tipo=tipo)
        elif tipo == 'm':
            nom = input("Ingrese el nombre a buscar (deje vacío para omitir): ").strip() or None
            esp = input("Ingrese la especialidad a buscar (deje vacío para omitir): ").strip() or None
            id = input("Ingrese el ID del médico a buscar (deje vacío para omitir): ").strip() or None
            busqueda_con_index(nombre=nom, especialidad=esp, id=id, tipo=tipo)
        volver_menu = input ("Presione enter para volver al menú principal")
        if volver_menu == "5":
            print ("Regresando al menú principal...")
    #================ Reporte de Turnos por Médico ========================
    elif opcion == "5":
        print(" \n --- Reporte de Turnos por Médico ---")
        turnos = reporte_turnos()
        for cantidad_turnos, nombre in turnos:
            print(f"Médico: {nombre}, Cantidad de Turnos: {cantidad_turnos}")
        volver_menu = input ("Presione enter para volver al menú principal")
        if volver_menu == "":
            print ("Regresando al menú principal...")
    #================ Cancelación de Turnos por Médico ========================
    elif opcion == "6":
        id_medico = input("Ingrese el ID del médico para cancelar sus turnos: ")
        cancelar_turno_medico(id_medico)
        volver_menu = input ("Presione enter para volver al menú principal")
        if volver_menu == "5":
            print ("Regresando al menú principal...")
    elif opcion == "0":
        print("Saliendo del sistema...")
        
    else:
        print("Opción no válida. Por favor, intente de nuevo.")
    

#CERRAR CONEXIÓN
curs.close()
mybd.close()

