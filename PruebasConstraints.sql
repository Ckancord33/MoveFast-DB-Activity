------------------------------------------------------------
------------- CASO 1 ON DELETE CASCADE-------------------------

-- Paso 1: Insertar cliente temporal
INSERT INTO cliente (cedula, nombre, apellido)
VALUES (999999999, 'Temporal', 'Cliente');

-- Paso 2: Insertar alquiler asociado
INSERT INTO alquiler (id_alquiler, fechaInicio, fechaFinal, aplaca, acedula)
VALUES (1234, '2025-06-01', '2025-06-07', 'ABC123', 999999999);

-- Verificar que el alquiler fue insertado
SELECT * FROM alquiler WHERE acedula = 999999999;

-- Paso 3: Eliminar cliente
DELETE FROM cliente WHERE cedula = 999999999;

-- Verificar que el alquiler también fue eliminado
SELECT * FROM alquiler WHERE acedula = 999999999;

------------------------------------------------------------------
--------------- CASO 2 ON DELETE UPDATE -------------------------

-- Paso 1: Ver vehículos asociados a la sucursal 1
SELECT * FROM vehiculo WHERE vidsucursal = 1;

-- Paso 2: Actualizar idSucursal de 1 a 99
UPDATE sucursal SET idSucursal = 99 WHERE idSucursal = 1;

-- Paso 3: Verificar que los vehículos ahora apuntan a sucursal 99
SELECT * FROM vehiculo WHERE vidsucursal = 99;


-----------------------------------------------------------------
------------- CASO 3 CHECK -----------------------------------

-- Intentar insertar vehículo con modelo inválido
INSERT INTO vehiculo (marca, placa, vidsucursal, modelo, color)
VALUES ('Prohibido', 'ZZZ999', 2, 1999, 'Negro');