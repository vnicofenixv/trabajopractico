-- Eliminar tablas si ya existen (para pruebas limpias)
DROP TABLE IF EXISTS operador_montacarga, operador, montacarga, asistente, auxiliar, deposito, cliente, despachante, documento, aduana, operativa, atc, encargado, cfs CASCADE;

-- Deposito
CREATE TABLE deposito (
    dep_cod SERIAL PRIMARY KEY,
    dep_zona VARCHAR(20) NOT NULL
);

-- Asistente
CREATE TABLE asistente (
    as_cod SERIAL PRIMARY KEY,
    as_nom VARCHAR(45) NOT NULL,
    as_apellido VARCHAR(45) NOT NULL,
    as_ci INTEGER NOT NULL,
    as_tel VARCHAR(20),
    dep_cod INTEGER,
    FOREIGN KEY (dep_cod) REFERENCES deposito(dep_cod)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Auxiliar
CREATE TABLE auxiliar (
    aux_cod SERIAL PRIMARY KEY,
    aux_nom VARCHAR(45) NOT NULL,
    aux_apellido VARCHAR(45) NOT NULL,
    aux_ci INTEGER NOT NULL,
    aux_tel VARCHAR(20) NOT NULL,
    dep_cod INTEGER,
    FOREIGN KEY (dep_cod) REFERENCES deposito(dep_cod)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Montacarga
CREATE TABLE montacarga (
    mont_cod SERIAL PRIMARY KEY,
    mont_nom VARCHAR(20) NOT NULL,
    mont_tipo VARCHAR(20) NOT NULL,
    mont_cap VARCHAR(20) NOT NULL
);

-- Operador
CREATE TABLE operador (
    op_cod SERIAL PRIMARY KEY,
    op_nom VARCHAR(45) NOT NULL,
    op_apellido VARCHAR(45) NOT NULL,
    op_ci INTEGER NOT NULL,
    op_tel VARCHAR(20) NOT NULL,
    dep_cod INTEGER,
    FOREIGN KEY (dep_cod) REFERENCES deposito(dep_cod)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Relación muchos a muchos operador ↔ montacarga
CREATE TABLE operador_montacarga (
    op_cod INTEGER NOT NULL,
    mont_cod INTEGER NOT NULL,
    PRIMARY KEY (op_cod, mont_cod),
    FOREIGN KEY (op_cod) REFERENCES operador(op_cod)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (mont_cod) REFERENCES montacarga(mont_cod)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Cliente
CREATE TABLE cliente (
    cli_cod SERIAL PRIMARY KEY,
    cli_nom VARCHAR(45) NOT NULL,
    cli_email VARCHAR(45) NOT NULL,
    cli_tel VARCHAR(45) NOT NULL
);

-- Despachante
CREATE TABLE despachante (
    desp_cod SERIAL PRIMARY KEY,
    desp_nom VARCHAR(45) NOT NULL,
    desp_apellido VARCHAR(45) NOT NULL,
    desp_ci INTEGER NOT NULL,
    desp_tel VARCHAR(20) NOT NULL,
    desp_email VARCHAR(45) NOT NULL,
    cli_cod INTEGER,
    FOREIGN KEY (cli_cod) REFERENCES cliente(cli_cod)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Documento
CREATE TABLE documento (
    doc_cod SERIAL PRIMARY KEY,
    doc_nom VARCHAR(20) NOT NULL,
    desp_cod INTEGER NOT NULL,
    FOREIGN KEY (desp_cod) REFERENCES despachante(desp_cod)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Aduana
CREATE TABLE aduana (
    adu_cod SERIAL PRIMARY KEY,
    adu_nom VARCHAR(45) NOT NULL,
    adu_apellido VARCHAR(45) NOT NULL,
    adu_ci INTEGER NOT NULL,
    adu_divis VARCHAR(20) NOT NULL,
    adu_tel VARCHAR(20),
    adu_email VARCHAR(45)
);

-- Operativa
CREATE TABLE operativa (
    op_cod SERIAL PRIMARY KEY,
    op_nom VARCHAR(20) NOT NULL,
    op_fecha DATE NOT NULL,
    op_inicio TIME NOT NULL,
    op_termino TIME NOT NULL,
    adu_cod INTEGER,
    FOREIGN KEY (adu_cod) REFERENCES aduana(adu_cod)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ATC
CREATE TABLE atc (
    atc_cod SERIAL PRIMARY KEY,
    atc_nom VARCHAR(45) NOT NULL,
    atc_apellido VARCHAR(45) NOT NULL,
    atc_ci INTEGER NOT NULL,
    atc_tel VARCHAR(20) NOT NULL,
    atc_email VARCHAR(45) NOT NULL,
    op_cod INTEGER,
    doc_cod INTEGER,
    FOREIGN KEY (op_cod) REFERENCES operativa(op_cod)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (doc_cod) REFERENCES documento(doc_cod)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Encargado
CREATE TABLE encargado (
    enc_cod SERIAL PRIMARY KEY,
    enc_nom VARCHAR(45) NOT NULL,
    enc_apellido VARCHAR(45) NOT NULL,
    enc_ci INTEGER NOT NULL,
    enc_tel VARCHAR(20) NOT NULL,
    enc_email VARCHAR(45) NOT NULL,
    atc_cod INTEGER,
    dep_cod INTEGER,
    FOREIGN KEY (atc_cod) REFERENCES atc(atc_cod)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (dep_cod) REFERENCES deposito(dep_cod)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- CFS
CREATE TABLE cfs (
    cfs_cod SERIAL PRIMARY KEY,
    cfs_nom VARCHAR(20) NOT NULL,
    cfs_obs TEXT,
    as_cod INTEGER,
    FOREIGN KEY (as_cod) REFERENCES asistente(as_cod)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
