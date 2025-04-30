CREATE TABLE cliente (
    cedula INTEGER PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL
);

CREATE TABLE sucursal (
    idSucursal SERIAL,
    ciudad VARCHAR(30) NOT NULL,
    direccion VARCHAR(30) NOT NULL,
    telefono VARCHAR(7) NOT NULL,
	CONSTRAINT pk_sucursal PRIMARY KEY (idSucursal),
    CONSTRAINT telefono_longitud CHECK (LENGTH(telefono) = 7)
);

CREATE TABLE vehiculo (
	marca VARCHAR(50) NOT NULL,
	placa VARCHAR(6) PRIMARY KEY CHECK(LENGTH(placa) = 6),
    vidsucursal INT,
    modelo INT CHECK(modelo BETWEEN 2000 AND 2025),
    color VARCHAR(20),
    FOREIGN KEY (vidsucursal) REFERENCES sucursal(idSucursal)
        ON UPDATE CASCADE
		ON DELETE SET NULL
);

CREATE TABLE alquiler (
	fechaInicio DATE NOT NULL,
	fechaFinal DATE NOT NULL,
    id_alquiler SERIAL PRIMARY KEY,
    aplaca VARCHAR(6),
    acedula INTEGER,
    FOREIGN KEY (aplaca) REFERENCES vehiculo(placa)
        ON DELETE SET NULL,
    FOREIGN KEY (acedula) REFERENCES cliente(cedula)
        ON DELETE CASCADE
);

CREATE TABLE pago (
	idpago SERIAL PRIMARY KEY,
    precio NUMERIC(10,2) NOT NULL,
    pid_alquiler INT,
    fecha TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (pid_alquiler) REFERENCES alquiler(id_alquiler)
		ON UPDATE CASCADE
        ON DELETE SET NULL
);
