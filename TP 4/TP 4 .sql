DROP DATABASE IF EXISTS `Banco`;
CREATE DATABASE IF NOT EXISTS `Banco`;
USE `Banco`;

CREATE TABLE clientes (
  numero_cliente INT PRIMARY KEY NOT NULL,
  dni INT NOT NULL,
  apellido VARCHAR(60),
  nombre VARCHAR(60)
);

CREATE TABLE cuentas(
numero_cuenta INT PRIMARY KEY NOT NULL,
numero_cliente INT,
saldo DECIMAL(10,2),
FOREIGN KEY (numero_cliente) REFERENCES clientes(numero_cliente)
);

CREATE TABLE movimientos(
numero_movimiento INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
numero_cuenta INT,
fecha DATE,
tipo ENUM("CREDITO", "DEBITO"),
importe DECIMAL(10,2),
FOREIGN KEY (numero_cuenta) REFERENCES cuentas(numero_cuenta)
);

CREATE TABLE historial_movimientos(
id INT PRIMARY KEY,
numero_cuenta INT,
numero_movimiento INT,
saldo_anterior DECIMAL(10,2),
saldo_actual DECIMAL(10,2),
FOREIGN KEY (numero_cuenta) REFERENCES cuentas(numero_cuenta),
FOREIGN KEY (numero_movimiento) REFERENCES movimientos(numero_movimiento)
);

INSERT INTO Clientes (numero_cliente, dni, apellido, nombre) VALUES
(1, 20345678, 'Pérez', 'Carlos'),
(2, 21456789, 'Gómez', 'Ana'),
(3, 22567890, 'Torres', 'Luis'),
(4, 23678901, 'Fernández', 'Carla'),
(5, 24789012, 'Ramos', 'Sofía'),
(6, 25890123, 'Alvarez', 'Diego'),
(7, 26901234, 'Martínez', 'Lucía'),
(8, 27912345, 'García', 'Mariano');

INSERT INTO Cuentas (numero_cuenta, numero_cliente, saldo) VALUES
(1001, 1, 1500.00),
(1002, 2, 3200.00),
(1003, 3, 800.00),
(1004, 4, 5000.00),
(1005, 5, 2500.00),
(1006, 6, 1200.00),
(1007, 7, 950.00),
(1008, 8, 4000.00),
(1009, 1, 700.00),   -- Carlos Pérez tiene dos cuentas
(1010, 5, 1500.00);  -- Sofía Ramos tiene dos cuentas

INSERT INTO movimientos (numero_cuenta, fecha, tipo, importe) VALUES
(1001, '2025-01-05', 'CREDITO', 500.00),
(1001, '2025-01-10', 'DEBITO', 200.00),
(1002, '2025-01-12', 'CREDITO', 1000.00),
(1003, '2025-01-15', 'DEBITO', 100.00),
(1004, '2025-02-01', 'CREDITO', 1500.00),
(1004, '2025-02-10', 'DEBITO', 300.00),
(1005, '2025-02-05', 'CREDITO', 700.00),
(1006, '2025-02-15', 'DEBITO', 100.00),
(1007, '2025-03-01', 'CREDITO', 250.00),
(1008, '2025-03-02', 'DEBITO', 500.00),
(1009, '2025-03-10', 'CREDITO', 200.00),
(1010, '2025-03-12', 'DEBITO', 150.00),
(1002, '2025-03-15', 'DEBITO', 400.00),
(1005, '2025-03-16', 'CREDITO', 300.00),
(1008, '2025-10-20', 'CREDITO', 600.00),
(1002, '2025-10-21', 'credito', 1000),
(1002, '2025-10-21', 'debito', 900),
(1001, '2025-10-05', 'CREDITO', 500.00),
(1001, '2025-10-10', 'DEBITO', 200.00),
(1002, '2025-10-12', 'CREDITO', 1000.00),
(1003, '2025-10-15', 'DEBITO', 100.00),
(1004, '2025-10-01', 'CREDITO', 1500.00),
(1004, '2025-10-10', 'DEBITO', 300.00),
(1005, '2025-10-05', 'CREDITO', 700.00),
(1006, '2025-10-15', 'DEBITO', 100.00),
(1007, '2025-10-01', 'CREDITO', 250.00),
(1008, '2025-10-02', 'DEBITO', 500.00),
(1009, '2025-10-10', 'CREDITO', 200.00),
(1010, '2025-10-12', 'DEBITO', 150.00),
(1002, '2025-10-15', 'DEBITO', 400.00),
(1005, '2025-10-16', 'CREDITO', 300.00),
(1008, '2025-10-20', 'CREDITO', 600.00),
(1002, '2025-10-21', 'credito', 3000),
(1002, '2025-10-21', 'debito', 1000);

INSERT INTO historial_movimientos(id,numero_cuenta,numero_movimiento,saldo_anterior,saldo_actual) VALUES
(1,1001,1,1500.00,2000.00),
(2,1001,2,2000.00,1800.00),
(3,1002,3,3200.00,4200.00),
(4,1003,4,800.00,700.00),
(5,1004,5,5000.00,6500.00),
(6,1004,6,6500.00,6200.00),
(7,1005,7,2500.00,3200.00),
(8,1006,8,1200.00,1100.00),
(9,1007,9,950.00,1200.00),
(10,1008,10,4000.00,3500.00),
(11,1009,11,700.00,900.00),
(12,1010,12,1500.00,1350.00),
(13,1002,13,4200.00,3800.00),
(14,1005,14,3200.00,3500.00),
(15,1008,15,3500.00,4100.00),
(16,1002,16,3800.00,4800.00),
(17,1002,17,4800.00,3900.00),
(18,1001,18,1800.00,2300.00),
(19,1001,19,2300.00,2100.00),
(20,1002,20,3900.00,4900.00),
(21,1003,21,700.00,600.00),
(22,1004,22,6200.00,7700.00),
(23,1004,23,7700.00,7400.00),
(24,1005,24,3500.00,4200.00),
(25,1006,25,1100.00,1000.00),
(26,1007,26,1200.00,1450.00),
(27,1008,27,4100.00,3600.00),
(28,1009,28,900.00,1100.00),
(29,1010,29,1350.00,1200.00),
(30,1002,30,4900.00,4500.00),
(31,1005,31,4200.00,4500.00),
(32,1008,32,3600.00,4200.00),
(33,1002,33,4500.00,7500.00),
(34,1002,34,7500.00,6500.00);

DELIMITER $$

#--Punto 3--

CREATE PROCEDURE VerCuentas()
BEGIN
SELECT numero_cuenta, saldo FROM cuentas;
END$$

DELIMITER ;
DELIMITER $$

#--Punto 4--
CREATE PROCEDURE CuentasConSaldoMayorQue(IN limite DECIMAL(10,2))
BEGIN
SELECT numero_cuenta, saldo FROM cuentas
WHERE (saldo > limite)
;
END$$
DELIMITER ;
DELIMITER $$
#--Punto 5--
CREATE PROCEDURE TotalMovimientosDelMes(IN cuenta INT, OUT total DECIMAL(10,2))
BEGIN
    SELECT
        SUM(
            CASE
                WHEN tipo = 'CREDITO' AND MONTH(fecha) = MONTH(curdate()) AND YEAR(fecha) = YEAR(CURDATE()) THEN 1
                WHEN tipo = 'DEBITO' AND MONTH(fecha) = MONTH(curdate()) AND YEAR(fecha) = YEAR(CURDATE()) THEN -1
                ELSE 0 
            END
        )
    INTO total
    FROM movimientos
    WHERE numero_cuenta = cuenta;  # Suma/resta el número resultante según los movimientos de la cuenta en el mes y año actual
END $$
DELIMITER ;

DELIMITER $$
#--Punto 6--
CREATE PROCEDURE Depositar(IN cuenta INT, IN monto DECIMAL(10,2))
BEGIN
INSERT INTO movimientos (numero_cuenta, fecha, tipo, importe) VALUES
(cuenta, curdate(), 'CREDITO', monto); #Registra el deposito en la tabla de movimientos, el saldo en si es actualizado por el trigger
END$$
DELIMITER ;

-- punto 7
DELIMITER $$
CREATE PROCEDURE Extraer(IN cuenta DECIMAL(10.2), IN monto DECIMAL(10.2))
BEGIN
	DECLARE saldo_actual DECIMAL(10.2);
    SELECT saldo INTO saldo_actual FROM cuentas WHERE numero_cuenta = cuenta;
    IF saldo_actual >= monto THEN
        INSERT INTO movimientos (numero_cuenta, fecha, tipo, importe) VALUES (cuenta, curdate(), 'DEBITO', monto);
	END IF;
END$$

DELIMITER ;

#--Punto 8--
DELIMITER $$
DROP TRIGGER IF EXISTS actualizar_saldo;
DELIMITER $$

CREATE TRIGGER actualizar_saldo
AFTER INSERT ON movimientos
FOR EACH ROW
BEGIN
   IF NEW.tipo = 'CREDITO' THEN
      UPDATE cuentas SET saldo = saldo + NEW.importe WHERE numero_cuenta = NEW.numero_cuenta;
   ELSEIF NEW.tipo = 'DEBITO' THEN
      UPDATE cuentas SET saldo = saldo - NEW.importe WHERE numero_cuenta = NEW.numero_cuenta;
   END IF;
END$$

DELIMITER ;
DELIMITER ;

#--Punto 9--
DROP TRIGGER IF EXISTS actualizar_saldo;
DELIMITER $$
CREATE TRIGGER actualizar_saldo
AFTER INSERT ON movimientos
FOR EACH ROW
BEGIN
   DECLARE num INT;
   DECLARE saldo_anterior DECIMAL(10,2);
   SET num = (SELECT COUNT(*) FROM movimientos);
   SET saldo_anterior = (SELECT saldo FROM cuentas WHERE numero_cuenta = NEW.numero_cuenta); # El saldo anterior debe estar almacenado como variable para poder ser insertado en otra tabla
IF NEW.tipo = 'CREDITO' THEN
      UPDATE cuentas SET saldo = saldo + NEW.importe WHERE numero_cuenta = NEW.numero_cuenta;
      INSERT INTO historial_movimientos(id, numero_cuenta, numero_movimiento, saldo_anterior, saldo_actual)
   VALUES (num, NEW.numero_cuenta, num, saldo_anterior, saldo_anterior + NEW.importe);
   ELSEIF NEW.tipo = 'DEBITO' THEN
      UPDATE cuentas SET saldo = saldo - NEW.importe WHERE numero_cuenta = NEW.numero_cuenta;
      INSERT INTO historial_movimientos(id, numero_cuenta, numero_movimiento, saldo_anterior, saldo_actual)
   VALUES (num, NEW.numero_cuenta, num, saldo_anterior, saldo_anterior - NEW.importe);
   END IF;
END$$

DELIMITER ;

-- punto 10
DROP PROCEDURE IF EXISTS TotalMovimientosDelMes;
DELIMITER $$
CREATE PROCEDURE TotalMovimientosDelMes(
    IN p_cuenta INT,
    OUT total DECIMAL(10,2)
)
BEGIN

    DECLARE v_tipo VARCHAR(10);
    DECLARE v_importe DECIMAL(10,2);
    DECLARE fin INT DEFAULT 0;


    DECLARE curMovimientos CURSOR FOR
        SELECT tipo, importe
        FROM movimientos
        WHERE numero_cuenta = p_cuenta
          AND MONTH(fecha) = MONTH (CURDATE())
          AND YEAR(fecha) = YEAR (CURDATE());


    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

    SET total = 0;


    OPEN curMovimientos;

    leer: LOOP
        FETCH curMovimientos INTO v_tipo, v_importe;
        IF fin = 1 THEN
            LEAVE leer;
        END IF;

        IF UPPER(v_tipo) = 'CREDITO' THEN
            SET total = total + v_importe;
        ELSEIF UPPER(v_tipo) = 'DEBITO' THEN
            SET total = total - v_importe;
        END IF;
    END LOOP leer;


    CLOSE curMovimientos;
END$$

DELIMITER ;

-- verificación punto 10
SET @totalMes = 0;
CALL TotalMovimientosDelMes(1005, @totalMes);
SELECT @totalMes AS TotalDelMes;

-- Punto 11
DROP PROCEDURE IF EXISTS PorcentajeInteres;
DELIMITER $$
CREATE PROCEDURE PorcentajeInteres (IN porcentaje DECIMAL(10,2), IN minimo DECIMAL (10,2))
BEGIN
	DECLARE fin INT DEFAULT 0;
    DECLARE var_cuenta INT;
    DECLARE var_saldo DECIMAL (10,2);
    DECLARE nuevo_saldo DECIMAL (10,2);
    
    DECLARE Cuentas CURSOR FOR
		SELECT numero_cuenta, saldo
        FROM cuentas
        WHERE saldo > minimo;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin =1;
    
    OPEN Cuentas;
    
    leer: LOOP
		FETCH Cuentas INTO var_cuenta, var_saldo;
        if fin = 1 THEN
			LEAVE LEER;
		END IF;
        
		SET nuevo_saldo = var_saldo + (var_saldo * (porcentaje / 100));
        
        UPDATE cuentas
        SET saldo = nuevo_saldo
        WHERE numero_cuenta = var_cuenta;
	END LOOP leer;
    
    CLOSE Cuentas;
END $$

DELIMITER ;


#Verificación del trigger
CALL TotalMovimientosDelMes(1005, @total);
SELECT @total;
CALL VerCuentas();
CALL Depositar(1006, 10000.00);
CALL VerCuentas();
CALL Extraer(1006, 5000.00);
CALL VerCuentas();
SELECT * FROM historial_movimientos;