-- Tabla: cliente
CREATE TABLE cliente (
    cli_cod SERIAL PRIMARY KEY,
    cli_nom VARCHAR,
    cli_email VARCHAR,
    cli_tel VARCHAR,
    UNIQUE (cli_cod)
);

-- Tabla: cfs
CREATE TABLE cfs (
    cfs_cod SERIAL PRIMARY KEY,
    cfs_nom VARCHAR,
    cfs_obs TEXT,
    UNIQUE (cfs_cod)
);

-- Tabla: documento
CREATE TABLE documento (
    doc_cod SERIAL PRIMARY KEY,
    doc_nom VARCHAR,
    doc_sello BOOLEAN,
    UNIQUE (doc_cod)
);

-- Tabla: atc
CREATE TABLE atc (
    atc_cod SERIAL PRIMARY KEY,
    atc_nom VARCHAR,
    atc_apell VARCHAR,
    atc_email VARCHAR,
    atc_tel VARCHAR,
    doc_cod INTEGER,
    UNIQUE (atc_cod),
    CONSTRAINT fk_atc_doc_cod_documento FOREIGN KEY (doc_cod)
        REFERENCES documento (doc_cod)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Tabla: encargado
CREATE TABLE encargado (
    enc_cod SERIAL PRIMARY KEY,
    enc_nom VARCHAR,
    enc_apell VARCHAR,
    enc_email VARCHAR,
    enc_tel VARCHAR,
    atc_cod INTEGER,
    UNIQUE (enc_cod),
    CONSTRAINT fk_encargado_atc_cod_atc FOREIGN KEY (atc_cod)
        REFERENCES atc (atc_cod)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla: asistente
CREATE TABLE asistente (
    as_cod SERIAL PRIMARY KEY,
    as_nom VARCHAR,
    as_apell VARCHAR,
    as_tel VARCHAR,
    cfs_cod INTEGER,
    UNIQUE (as_cod),
    CONSTRAINT fk_asistente_cfs_cod FOREIGN KEY (cfs_cod)
        REFERENCES cfs (cfs_cod)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla: montacarga
CREATE TABLE montacarga (
    mont_cod SERIAL PRIMARY KEY,
    mont_nom VARCHAR,
    mont_tipo VARCHAR,
    mont_cap VARCHAR,
    UNIQUE (mont_cod)
);

-- Tabla: operador
CREATE TABLE operador (
    op_cod SERIAL PRIMARY KEY,
    op_nom VARCHAR,
    op_apell VARCHAR,
    op_tel VARCHAR,
    mont_cod INTEGER,
    UNIQUE (op_cod),
    CONSTRAINT fk_operador_mont_cod_montacarga FOREIGN KEY (mont_cod)
        REFERENCES montacarga (mont_cod)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Tabla: auxiliar
CREATE TABLE auxiliar (
    aux_cod SERIAL PRIMARY KEY,
    aux_nom VARCHAR,
    aux_apell VARCHAR,
    aux_tel VARCHAR,
    UNIQUE (aux_cod)
);

-- Tabla: deposito
CREATE TABLE deposito (
    dep_cod SERIAL PRIMARY KEY,
    dep_zona VARCHAR,
    enc_cod INTEGER,
    as_cod INTEGER,
    op_cod INTEGER,
    aux_cod INTEGER,
    UNIQUE (dep_cod),
    CONSTRAINT fk_deposito_enc_cod_encargado FOREIGN KEY (enc_cod)
        REFERENCES encargado (enc_cod)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_deposito_as_cod_asistente FOREIGN KEY (as_cod)
        REFERENCES asistente (as_cod)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_deposito_op_cod_operador FOREIGN KEY (op_cod)
        REFERENCES operador (op_cod)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_deposito_aux_cod_auxiliar FOREIGN KEY (aux_cod)
        REFERENCES auxiliar (aux_cod)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla: operativa
CREATE TABLE operativa (
    op_cod SERIAL PRIMARY KEY,
    op_nom VARCHAR,
    op_fecha DATE,
    op_inicio TIME,
    op_termino TIME,
    cli_cod INTEGER,
    atc_cod INTEGER,
    UNIQUE (op_cod),
    CONSTRAINT fk_operativa_cli_cod_cliente FOREIGN KEY (cli_cod)
        REFERENCES cliente (cli_cod)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_operativa_atc_cod_atc FOREIGN KEY (atc_cod)
        REFERENCES atc (atc_cod)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla: aduana
CREATE TABLE aduana (
    adu_cod SERIAL PRIMARY KEY,
    adu_nom VARCHAR,
    adu_apell VARCHAR,
    adu_email VARCHAR,
    adu_tel VARCHAR,
    op_cod INTEGER,
    UNIQUE (adu_cod),
    CONSTRAINT fk_aduana_op_cod_operativa FOREIGN KEY (op_cod)
        REFERENCES operativa (op_cod)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
--hola