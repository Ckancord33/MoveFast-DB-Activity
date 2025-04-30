-- Clientes
INSERT INTO cliente (cedula, nombre, apellido) VALUES
(1107844430, 'Ana', 'García'),
(1107844431, 'Luis', 'Martínez'),
(1107844432, 'Carlos', 'Pérez'),
(1107844433, 'Laura', 'Rodríguez'),
(1107844434, 'Pedro', 'Gómez'),
(1107844435, 'Sofía', 'López'),
(1107844436, 'Andrés', 'Ramírez'),
(1107844437, 'Camila', 'Torres'),
(1107844438, 'Diego', 'Morales'),
(1107844439, 'Isabella', 'Ruiz');

-- Sucursales
INSERT INTO sucursal (ciudad, direccion, telefono) VALUES
('Bogotá', 'Cra 7 #123', '3214567'),
('Medellín', 'Cl 45 #67', '3117890'),
('Cali', 'Av 3N #56', '3123456');

-- Vehículos
INSERT INTO vehiculo (marca, placa, vidsucursal, modelo, color) VALUES
('Mazda', 'ABC123', 1, 2022, 'Rojo'),
('Toyota', 'BCD456', 2, 2021, 'Negro'),
('Renault', 'CDE789', 3, 2020, 'Gris'),
('Chevrolet', 'DEF012', 1, 2023, 'Blanco'),
('Kia', 'EFG345', 2, 2019, 'Azul'),
('Hyundai', 'FGH678', 3, 2022, 'Plateado'),
('Ford', 'GHI901', 1, 2020, 'Verde'),
('Volkswagen', 'HIJ234', 2, 2021, 'Amarillo'),
('Nissan', 'IJK567', 3, 2024, 'Negro'),
('BMW', 'JKL890', 1, 2025, 'Gris');

-- Alquileres (20)
INSERT INTO alquiler (id_alquiler, fechaInicio, fechaFinal, aplaca, acedula) VALUES
(1,  '2025-04-26', '2025-05-04', 'FGH678', 1107844430),
(2,  '2025-05-03', '2025-05-10', 'FGH678', 1107844437),
(3,  '2025-05-01', '2025-05-08', 'DEF012', 1107844431),
(4,  '2025-05-02', '2025-05-09', 'FGH678', 1107844435),
(5,  '2025-05-08', '2025-05-15', 'CDE789', 1107844436),
(6,  '2025-04-01', '2025-04-08', 'DEF012', 1107844432),
(7,  '2025-03-20', '2025-03-27', 'CDE789', 1107844433),
(8,  '2025-05-10', '2025-05-17', 'CDE789', 1107844434),
(9,  '2025-04-15', '2025-04-22', 'JKL890', 1107844439),
(10, '2025-04-05', '2025-04-12', 'BCD456', 1107844438),
(11, '2025-05-05', '2025-05-12', 'DEF012', 1107844430),
(12, '2025-04-10', '2025-04-17', 'ABC123', 1107844435),
(13, '2025-05-01', '2025-05-08', 'HIJ234', 1107844431),
(14, '2025-05-07', '2025-05-14', 'IJK567', 1107844432),
(15, '2025-05-02', '2025-05-09', 'BCD456', 1107844433),
(16, '2025-03-10', '2025-03-17', 'CDE789', 1107844437),
(17, '2025-04-25', '2025-05-02', 'JKL890', 1107844438),
(18, '2025-05-09', '2025-05-16', 'GHI901', 1107844439),
(19, '2025-05-04', '2025-05-11', 'HIJ234', 1107844436),
(20, '2025-05-06', '2025-05-13', 'ABC123', 1107844434);

-- Pagos (uno por alquiler)
INSERT INTO pago (precio, pid_alquiler, fecha) VALUES
(850000, 1, '2025-04-26'),
(760000, 2, '2025-05-03'),
(900000, 3, '2025-05-01'),
(720000, 4, '2025-05-02'),
(830000, 5, '2025-05-08'),
(600000, 6, '2025-04-01'),
(610000, 7, '2025-03-20'),
(820000, 8, '2025-05-10'),
(670000, 9, '2025-04-15'),
(690000, 10, '2025-04-05'),
(870000, 11, '2025-05-05'),
(700000, 12, '2025-04-10'),
(710000, 13, '2025-05-01'),
(690000, 14, '2025-05-07'),
(750000, 15, '2025-05-02'),
(650000, 16, '2025-03-10'),
(740000, 17, '2025-04-25'),
(930000, 18, '2025-05-09'),
(700000, 19, '2025-05-04'),
(800000, 20, '2025-05-06');
  
SELECT * FROM cliente
SELECT * FROM vehiculo
SELECT * FROM alquiler
SELECT * FROM pago
SELECT * FROM sucursal

-- 4. Obtener los vehículos disponibles en una ciudad específica (por ejemplo, Cali)
-- Se filtran los vehículos que no están alquilados actualmente en esa ciudad
SELECT v.marca, v.modelo, v.placa, s.ciudad 
FROM vehiculo v
JOIN sucursal s ON s.idsucursal = v.vidsucursal
JOIN alquiler a ON v.placa = a.aplaca
WHERE current_date NOT BETWEEN a.fechaInicio AND a.fechaFinal 
  AND ciudad = 'Cali';

-- 5. Listar los alquileres activos con información del cliente y del vehículo
-- Se muestran solo los alquileres que están en curso hoy
SELECT c.nombre, c.apellido, c.cedula, v.marca, v.modelo
FROM cliente c 
JOIN alquiler a ON c.cedula = a.acedula
JOIN vehiculo v ON v.placa = a.aplaca
WHERE current_date BETWEEN a.fechaInicio AND a.fechaFinal;

-- 6. Calcular los ingresos totales por sucursal
-- Solo se consideran pagos de vehículos que hayan sido alquilados más de 3 veces
SELECT s.ciudad, SUM(p.precio) AS ingresos_totales
FROM pago p
JOIN alquiler a ON p.pid_alquiler = a.id_alquiler
JOIN vehiculo v ON v.placa = a.aplaca
JOIN sucursal s ON v.vidsucursal = s.idSucursal
WHERE v.placa IN (
    SELECT aplaca
    FROM alquiler
    GROUP BY aplaca
    HAVING COUNT(*) > 3
)
GROUP BY s.ciudad;

-- 7. Filtrar solo vehículos con más de 5 alquileres (mediante subconsulta)
-- Se listan vehículos cuya placa aparece más de 5 veces en la tabla de alquiler
SELECT *
FROM vehiculo
WHERE placa IN (
    SELECT aplaca
    FROM alquiler
    GROUP BY aplaca
    HAVING COUNT(*) > 5
);

-- 8. Sumar los montos de todos los pagos realizados
-- Muestra el total global pagado por todos los alquileres
SELECT SUM(precio) AS total_pagado
FROM pago;



