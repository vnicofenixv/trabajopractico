-- Tabla cliente
CREATE TABLE cliente (
    cli_cod SERIAL PRIMARY KEY,
    cli_nom VARCHAR,
    cli_email VARCHAR,
    cli_tel VARCHAR
);

-- Tabla aduana
CREATE TABLE aduana (
    adu_cod SERIAL PRIMARY KEY,
    adu_nom VARCHAR,
    adu_apell VARCHAR,
    adu_email VARCHAR,
    adu_tel VARCHAR
);

-- Tabla operativa
CREATE TABLE operativa (
    op_cod SERIAL PRIMARY KEY,
    op_nom VARCHAR,
    op_fecha DATE,
    op_inicio TIME,
    op_termino TIME,
    cli_cod INTEGER REFERENCES cliente(cli_cod) ON DELETE RESTRICT ON UPDATE CASCADE,
    adu_cod INTEGER REFERENCES aduana(adu_cod) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla atc
CREATE TABLE atc (
    atc_cod SERIAL PRIMARY KEY,
    atc_nom VARCHAR,
    atc_apell VARCHAR,
    atc_email VARCHAR,
    atc_tel VARCHAR,
    op_cod INTEGER REFERENCES operativa(op_cod) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla encargado
CREATE TABLE encargado (
    enc_cod SERIAL PRIMARY KEY,
    enc_nom VARCHAR,
    enc_apell VARCHAR,
    enc_email VARCHAR,
    enc_tel VARCHAR,
    atc_cod INTEGER REFERENCES atc(atc_cod) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla deposito
CREATE TABLE deposito (
    dep_cod SERIAL PRIMARY KEY,
    dep_zona VARCHAR,
    enc_cod INTEGER REFERENCES encargado(enc_cod) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla asistente
CREATE TABLE asistente (
    as_cod SERIAL PRIMARY KEY,
    as_nom VARCHAR,
    as_apell VARCHAR,
    as_tel VARCHAR,
    dep_cod INTEGER REFERENCES deposito(dep_cod) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla cfs
CREATE TABLE cfs (
    cfs_cod SERIAL PRIMARY KEY,
    cfs_nom VARCHAR,
    cfs_obs TEXT,
    as_cod INTEGER REFERENCES asistente(as_cod) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla montacarga
CREATE TABLE montacarga (
    mont_cod SERIAL PRIMARY KEY,
    mont_nom VARCHAR,
    mont_tipo VARCHAR,
    mont_cap VARCHAR
);

-- Tabla operador
CREATE TABLE operador (
    op_cod SERIAL PRIMARY KEY,
    op_nom VARCHAR,
    op_apell VARCHAR,
    op_tel VARCHAR,
    mont_cod INTEGER,
    dep_cod INTEGER REFERENCES deposito(dep_cod) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla operador_montacarga
CREATE TABLE operador_montacarga (
    op_cod SERIAL PRIMARY KEY,
    mont_cod INTEGER REFERENCES montacarga(mont_cod) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla auxiliar
CREATE TABLE auxiliar (
    aux_cod SERIAL PRIMARY KEY,
    aux_nom VARCHAR,
    aux_apell VARCHAR,
    aux_tel VARCHAR,
    dep_cod INTEGER REFERENCES deposito(dep_cod) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla documento
CREATE TABLE documento (
    doc_cod SERIAL PRIMARY KEY,
    doc_nom VARCHAR,
    atc_cod INTEGER REFERENCES atc(atc_cod) ON DELETE RESTRICT ON UPDATE CASCADE
);
--tiene relacion de N a M
-- Relaciones adicionales
ALTER TABLE operador_montacarga
    ADD CONSTRAINT fk_operador_montacarga_op_cod_operador
    FOREIGN KEY (op_cod) REFERENCES operador(op_cod) ON DELETE RESTRICT ON UPDATE CASCADE;
