
-- =================================================
-- SCRIPTS SQL POSTGRESQL - GESTIÓN HUMANA Y NÓMINA
-- =================================================
-- TABLA 1: tab_departamentos
-- -------------------------------------------------

CREATE TABLE IF NOT EXISTS tab_departamentos
(
    id_departamento         VARCHAR         NOT NULL CHECK(LENGTH(id_departamento) = 2),
    nombre_departamento     VARCHAR         NOT NULL CHECK(LENGTH(nombre_departamento) >= 4 AND LENGTH(nombre_departamento) <= 20),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_departamento)
);

-- --------------------------------------------
-- TABLA 2: tab_ciudades
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_ciudades
(
    id_ciudad               VARCHAR         NOT NULL CHECK(LENGTH(id_ciudad) = 5),
    nombre_ciudad           VARCHAR         NOT NULL CHECK(LENGTH(nombre_ciudad) >= 3 AND LENGTH(nombre_ciudad) <= 30),
    ind_capital             BOOLEAN         NOT NULL, --TRUE = capital o FALSE = no capital
    codigo_postal           VARCHAR         NOT NULL CHECK(LENGTH(codigo_postal) = 6),
    id_departamento         VARCHAR         NOT NULL CHECK(LENGTH(id_departamento) = 2),
    val_latitud             DECIMAL(12,10)  NOT NULL CHECK(val_latitud >= -4 AND val_latitud <= 80),
    val_longitud            DECIMAL(12,10)  NOT NULL CHECK(val_longitud >= -80 AND val_longitud <= -50),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_ciudad),
    CONSTRAINT fk_ciudad_departamento FOREIGN KEY(id_departamento) REFERENCES tab_departamentos(id_departamento)
);

-- --------------------------------------------
-- TABLA 3: tab_tercero
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_tercero
(
    id_tercero              VARCHAR         NOT NULL CHECK(LENGTH(id_tercero) >= 1 AND LENGTH(id_tercero) <= 10),
    nombre_tercero          VARCHAR         NOT NULL CHECK(LENGTH(nombre_tercero) >= 3 AND LENGTH(nombre_tercero) <= 50),
    tipo_tercero            VARCHAR         NOT NULL CHECK(LENGTH(tipo_tercero) >= 3 AND LENGTH(tipo_tercero) <= 20),
    direccion               VARCHAR         CHECK(LENGTH(direccion) >= 5 AND LENGTH(direccion) <= 100),
    telefono                VARCHAR         CHECK(LENGTH(telefono) >= 7 AND LENGTH(telefono) <= 15),
    email                   VARCHAR         CHECK(LENGTH(email) >= 5 AND LENGTH(email) <= 50),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_tercero)
);

-- --------------------------------------------
-- TABLA 4: tab_areas
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_areas
(
    id_area                 VARCHAR         NOT NULL CHECK(LENGTH(id_area) >= 1 AND LENGTH(id_area) <= 10),
    nombre_area             VARCHAR         NOT NULL CHECK(LENGTH(nombre_area) >= 3 AND LENGTH(nombre_area) <= 50),
    descripcion             VARCHAR         CHECK(LENGTH(descripcion) >= 5 AND LENGTH(descripcion) <= 200),
    jefe_area               VARCHAR         CHECK(LENGTH(jefe_area) >= 3 AND LENGTH(jefe_area) <= 50),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_area)
);

-- --------------------------------------------
-- TABLA 5: tab_cargos
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_cargos
(
    id_cargo                VARCHAR         NOT NULL CHECK(LENGTH(id_cargo) >= 1 AND LENGTH(id_cargo) <= 10),
    nombre_cargo            VARCHAR         NOT NULL CHECK(LENGTH(nombre_cargo) >= 3 AND LENGTH(nombre_cargo) <= 50),
    descripcion             VARCHAR         CHECK(LENGTH(descripcion) >= 5 AND LENGTH(descripcion) <= 200),
    descripcion_cargo       VARCHAR         CHECK(LENGTH(descripcion_cargo) >= 5 AND LENGTH(descripcion_cargo) <= 200),
    salario_maximo          DECIMAL(10,2)   CHECK(salario_maximo >= 0),
    salario_minimo          DECIMAL(10,2)   CHECK(salario_minimo >= 0),
    nivel_jerargico         VARCHAR         CHECK(LENGTH(nivel_jerargico) >= 3 AND LENGTH(nivel_jerargico) <= 30),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_cargo)
);

-- --------------------------------------------
-- TABLA 6: tab_profesion
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_profesion
(
    id_profesion            VARCHAR         NOT NULL CHECK(LENGTH(id_profesion) >= 1 AND LENGTH(id_profesion) <= 10),
    nombre_profesion        VARCHAR         NOT NULL CHECK(LENGTH(nombre_profesion) >= 3 AND LENGTH(nombre_profesion) <= 50),
    nivel_educativo         VARCHAR         CHECK(LENGTH(nivel_educativo) >= 3 AND LENGTH(nivel_educativo) <= 30),
    area_conocimiento       VARCHAR         CHECK(LENGTH(area_conocimiento) >= 3 AND LENGTH(area_conocimiento) <= 50),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_profesion)
);

-- --------------------------------------------
-- TABLA 7: tab_perfil
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_perfil
(
    id_perfil               VARCHAR         NOT NULL CHECK(LENGTH(id_perfil) >= 1 AND LENGTH(id_perfil) <= 10),
    nombre_perfil           VARCHAR         NOT NULL CHECK(LENGTH(nombre_perfil) >= 3 AND LENGTH(nombre_perfil) <= 50),
    descripcion             VARCHAR         CHECK(LENGTH(descripcion) >= 10 AND LENGTH(descripcion) <= 200),
    nivel_estudio           VARCHAR         CHECK(LENGTH(nivel_estudio) >= 3 AND LENGTH(nivel_estudio) <= 30),
    exp_minima              INTEGER         CHECK(exp_minima >= 0 AND exp_minima <= 40),
    habilidades             VARCHAR         CHECK(LENGTH(habilidades) >= 5 AND LENGTH(habilidades) <= 200),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_perfil)
);

-- --------------------------------------------
-- TABLA 8: tab_convocatoria
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_convocatoria
(
    id_convocatoria         VARCHAR         NOT NULL CHECK(LENGTH(id_convocatoria) >= 1 AND LENGTH(id_convocatoria) <= 10),
    nombre_convocatoria     VARCHAR         NOT NULL CHECK(LENGTH(nombre_convocatoria) >= 3 AND LENGTH(nombre_convocatoria) <= 50),
    descripcion             VARCHAR         CHECK(LENGTH(descripcion) >= 10 AND LENGTH(descripcion) <= 200),
    fecha_inicio            DATE            NOT NULL CHECK(fecha_inicio <= CURRENT_DATE),
    fecha_fin               DATE            CHECK(fecha_fin <= CURRENT_DATE),
    estado                  VARCHAR         NOT NULL CHECK(LENGTH(estado) >= 3 AND LENGTH(estado) <= 20),
    id_perfil               VARCHAR         NOT NULL CHECK(LENGTH(id_perfil) >= 1 AND LENGTH(id_perfil) <= 10),
    id_area                 VARCHAR         NOT NULL CHECK(LENGTH(id_area) >= 1 AND LENGTH(id_area) <= 10),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_convocatoria),
    CONSTRAINT fk_convocatoria_perfil FOREIGN KEY(id_perfil) REFERENCES tab_perfil(id_perfil),
    CONSTRAINT fk_convocatoria_area FOREIGN KEY(id_area) REFERENCES tab_areas(id_area)
);

-- --------------------------------------------
-- TABLA 9: tab_candidatos
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_candidatos
(
    id_candidato            VARCHAR         NOT NULL CHECK(LENGTH(id_candidato) >= 1 AND LENGTH(id_candidato) <= 10),
    nombres                 VARCHAR         NOT NULL CHECK(LENGTH(nombres) >= 2 AND LENGTH(nombres) <= 50),
    apellidos               VARCHAR         NOT NULL CHECK(LENGTH(apellidos) >= 2 AND LENGTH(apellidos) <= 50),
    fecha_nacimiento        DATE            NOT NULL CHECK(fecha_nacimiento <= CURRENT_DATE),
    genero_biologico        VARCHAR         NOT NULL, --Masculino/Femenino
    nacionalidad            VARCHAR         NOT NULL CHECK(LENGTH(nacionalidad) >= 3 AND LENGTH(nacionalidad) <= 30),
    direccion               VARCHAR         CHECK(LENGTH(direccion) >= 5 AND LENGTH(direccion) <= 100),
    tipo_documento          VARCHAR         NOT NULL CHECK(LENGTH(tipo_documento) >= 3 AND LENGTH(tipo_documento) <= 20),
    id_ciudad               VARCHAR         NOT NULL CHECK(LENGTH(id_ciudad) = 5),
    estado_candidato        VARCHAR         NOT NULL CHECK(LENGTH(estado_candidato) >= 3 AND LENGTH(estado_candidato) <= 20),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_candidato),
    CONSTRAINT fk_candidato_ciudad FOREIGN KEY(id_ciudad) REFERENCES tab_ciudades(id_ciudad)
);

-- --------------------------------------------
-- TABLA 10: tab_experiencia_laboral
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_experiencia_laboral
(
    id_experiencia          VARCHAR         NOT NULL CHECK(LENGTH(id_experiencia) >= 1 AND LENGTH(id_experiencia) <= 10),
    id_empleado             DECIMAL(10,0)   NOT NULL CHECK(id_empleado >= 1 AND id_empleado <= 9999999999),
    empresa                 VARCHAR         NOT NULL CHECK(LENGTH(empresa) >= 3 AND LENGTH(empresa) <= 50),
    cargo                   VARCHAR         NOT NULL CHECK(LENGTH(cargo) >= 3 AND LENGTH(cargo) <= 50),
    fecha_inicio            DATE            NOT NULL CHECK(fecha_inicio <= CURRENT_DATE),
    fecha_fin               DATE            CHECK(fecha_fin <= CURRENT_DATE),
    funciones               VARCHAR         CHECK(LENGTH(funciones) >= 10 AND LENGTH(funciones) <= 200),
    logros                  VARCHAR         CHECK(LENGTH(logros) >= 10 AND LENGTH(logros) <= 200),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_experiencia)
);

-- --------------------------------------------
-- TABLA 11: tab_ref_laboral
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_ref_laboral
(
    id_referencia           VARCHAR         NOT NULL CHECK(LENGTH(id_referencia) >= 1 AND LENGTH(id_referencia) <= 10),
    id_experiencia          VARCHAR         NOT NULL CHECK(LENGTH(id_experiencia) >= 3 AND LENGTH(id_experiencia) <= 50),
    telefono                VARCHAR         NOT NULL CHECK(LENGTH(telefono) >= 7 AND LENGTH(telefono) <= 15),
    relacion                VARCHAR         NOT NULL CHECK(LENGTH(relacion) >= 3 AND LENGTH(relacion) <= 30),
    empresa                 VARCHAR         CHECK(LENGTH(empresa) >= 3 AND LENGTH(empresa) <= 50),
    cargo                   VARCHAR         CHECK(LENGTH(cargo) >= 3 AND LENGTH(cargo) <= 30),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_referencia)
);

-- --------------------------------------------
-- TABLA 12: tab_hoja_vida
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_hoja_vida
(
    id_hoja_vida            VARCHAR         NOT NULL CHECK(LENGTH(id_hoja_vida) >= 1 AND LENGTH(id_hoja_vida) <= 10),
    id_candidato            VARCHAR         NOT NULL CHECK(LENGTH(id_candidato) >= 1 AND LENGTH(id_candidato) <= 10),
    presentacion_general    VARCHAR         CHECK(LENGTH(presentacion_general) >= 10 AND LENGTH(presentacion_general) <= 200),
    datos_personales        VARCHAR         CHECK(LENGTH(datos_personales) >= 10 AND LENGTH(datos_personales) <= 200),
    perfil_profesional      VARCHAR         CHECK(LENGTH(perfil_profesional) >= 10 AND LENGTH(perfil_profesional) <= 200),
    id_experiencia_laboral  VARCHAR         CHECK(LENGTH(id_experiencia_laboral) >= 1 AND LENGTH(id_experiencia_laboral) <= 10),
    formacion_academica     VARCHAR         CHECK(LENGTH(formacion_academica) >= 5 AND LENGTH(formacion_academica) <= 200),
    formacion_complementaria VARCHAR        CHECK(LENGTH(formacion_complementaria) >= 5 AND LENGTH(formacion_complementaria) <= 200),
    certificaciones         VARCHAR         CHECK(LENGTH(certificaciones) >= 5 AND LENGTH(certificaciones) <= 200),
    habilidades             VARCHAR         CHECK(LENGTH(habilidades) >= 5 AND LENGTH(habilidades) <= 200),
    idiomas                 VARCHAR         CHECK(LENGTH(idiomas) >= 5 AND LENGTH(idiomas) <= 200),
    id_referencias_laborales VARCHAR        CHECK(LENGTH(id_referencias_laborales) >= 1 AND LENGTH(id_referencias_laborales) <= 10),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_hoja_vida),
    CONSTRAINT fk_hoja_vida_candidato FOREIGN KEY(id_candidato) REFERENCES tab_candidatos(id_candidato)
);

-- --------------------------------------------
-- TABLA 13: tab_empleados 
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_empleados
(
    id_empleado             DECIMAL(10,0)   NOT NULL CHECK(id_empleado >= 1 AND id_empleado <= 9999999999),
    nombre_empleado         VARCHAR         NOT NULL CHECK(LENGTH(nombre_empleado) >= 2 AND LENGTH(nombre_empleado) <= 50),
    apellido_empleado       VARCHAR         NOT NULL CHECK(LENGTH(apellido_empleado) >= 2 AND LENGTH(apellido_empleado) <= 50),
    fecha_nacimiento        DATE            NOT NULL CHECK(fecha_nacimiento <= CURRENT_DATE),
    genero_biologico        VARCHAR         NOT NULL, --Masculino/Femenino
    nacionalidad            VARCHAR         NOT NULL CHECK(LENGTH(nacionalidad) >= 3 AND LENGTH(nacionalidad) <= 30),
    indicador_auditor       BOOLEAN         NOT NULL, --TRUE/FALSE
    direccion_empleado      VARCHAR         NOT NULL CHECK(LENGTH(direccion_empleado) >= 5 AND LENGTH(direccion_empleado) <= 100),
    id_identificacion       DECIMAL(10,0)   NOT NULL CHECK(id_identificacion >= 1 AND id_identificacion <= 9999999999),
    id_contacto             DECIMAL(10,0)   NOT NULL CHECK(id_contacto >= 1 AND id_contacto <= 9999999999),
    id_cuenta               DECIMAL(12,0)   NOT NULL CHECK(id_cuenta >= 1 AND id_cuenta <= 999999999999),
    id_empresa              VARCHAR         NOT NULL CHECK(LENGTH(id_empresa) >= 1 AND LENGTH(id_empresa) <= 10),
    id_ciudad               VARCHAR         NOT NULL CHECK(LENGTH(id_ciudad) = 5),
    id_departamento         VARCHAR         NOT NULL CHECK(LENGTH(id_departamento) = 2),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_empleado),
    CONSTRAINT fk_empleado_empresa FOREIGN KEY(id_empresa) REFERENCES tab_empresas(id_empresa),
    CONSTRAINT fk_empleado_ciudad FOREIGN KEY(id_ciudad) REFERENCES tab_ciudades(id_ciudad),
    CONSTRAINT fk_empleado_departamento FOREIGN KEY(id_departamento) REFERENCES tab_departamentos(id_departamento)
);

-- --------------------------------------------
-- TABLA 14: cuenta_bancaria
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS cuenta_bancaria
(
    id_cuenta               DECIMAL(12,0)   NOT NULL CHECK(id_cuenta >= 1 AND id_cuenta <= 999999999999),
    tipo_cuenta             VARCHAR         NOT NULL CHECK(LENGTH(tipo_cuenta) >= 3 AND LENGTH(tipo_cuenta) <= 30),
    id_empleado             DECIMAL(10,0)   NOT NULL CHECK(id_empleado >= 1 AND id_empleado <= 9999999999),
    PRIMARY KEY(id_cuenta),
    CONSTRAINT fk_cuenta_empleado FOREIGN KEY(id_empleado) REFERENCES tab_empleados(id_empleado)
);

-- --------------------------------------------
-- TABLA 15: tab_empresas 
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_empresas
(
    id_empresa              VARCHAR         NOT NULL CHECK(LENGTH(id_empresa) >= 1 AND LENGTH(id_empresa) <= 10),
    nombre_empresa          VARCHAR         NOT NULL CHECK(LENGTH(nombre_empresa) >= 3 AND LENGTH(nombre_empresa) <= 50),
    caja_compensacion       VARCHAR         CHECK(LENGTH(caja_compensacion) >= 3 AND LENGTH(caja_compensacion) <= 50),
    tipo_caja_compensacion  VARCHAR         CHECK(LENGTH(tipo_caja_compensacion) >= 3 AND LENGTH(tipo_caja_compensacion) <= 20),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_empresa)
);

-- --------------------------------------------
-- TABLA 16: tab_contratos
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_contratos
(
    id_contrato             VARCHAR         NOT NULL CHECK(LENGTH(id_contrato) >= 1 AND LENGTH(id_contrato) <= 10),
    tipo_contrato           VARCHAR         NOT NULL CHECK(LENGTH(tipo_contrato) >= 3 AND LENGTH(tipo_contrato) <= 30),
    id_empleado             DECIMAL(10,0)   NOT NULL CHECK(id_empleado >= 1 AND id_empleado <= 9999999999),
    fecha_inicio            DATE            NOT NULL CHECK(fecha_inicio <= CURRENT_DATE),
    fecha_fin               DATE            CHECK(fecha_fin <= CURRENT_DATE),
    condiciones             TEXT,
    id_cargo                VARCHAR         NOT NULL CHECK(LENGTH(id_cargo) >= 1 AND LENGTH(id_cargo) <= 10),
    salario_base            DECIMAL(10,2)   NOT NULL CHECK(salario_base >= 0),
    id_tercero              VARCHAR         CHECK(LENGTH(id_tercero) >= 1 AND LENGTH(id_tercero) <= 10),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_contrato),
    CONSTRAINT fk_contrato_empleado FOREIGN KEY(id_empleado) REFERENCES tab_empleados(id_empleado),
    CONSTRAINT fk_contrato_cargo FOREIGN KEY(id_cargo) REFERENCES tab_cargos(id_cargo),
    CONSTRAINT fk_contrato_tercero FOREIGN KEY(id_tercero) REFERENCES tab_tercero(id_tercero)
);

-- --------------------------------------------
-- TABLA 17: tab_concepto_nomina
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_concepto_nomina
(
    id_concepto             VARCHAR         NOT NULL CHECK(LENGTH(id_concepto) >= 1 AND LENGTH(id_concepto) <= 10),
    nom_concepto            VARCHAR         NOT NULL CHECK(LENGTH(nom_concepto) >= 3 AND LENGTH(nom_concepto) <= 50),
    tipo                    DECIMAL(3,0)    NOT NULL CHECK(tipo >= 1 AND tipo <= 999),
    naturaleza              VARCHAR         CHECK(LENGTH(naturaleza) >= 3 AND LENGTH(naturaleza) <= 20),
    formula_calculado       VARCHAR         CHECK(LENGTH(formula_calculado) >= 3 AND LENGTH(formula_calculado) <= 100),
    cuenta_contable         VARCHAR         CHECK(LENGTH(cuenta_contable) >= 3 AND LENGTH(cuenta_contable) <= 20),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_concepto)
);

-- --------------------------------------------
-- TABLA 18: tab_nomina
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_nomina
(
    id_nomina               INTEGER         NOT NULL CHECK(id_nomina >= 1 AND id_nomina <= 999999),
    id_empleado             DECIMAL(10,0)   NOT NULL CHECK(id_empleado >= 1 AND id_empleado <= 9999999999),
    fecha_generacion        DATE            NOT NULL CHECK(fecha_generacion <= CURRENT_DATE),
    fecha_inicio_periodo    DATE            NOT NULL CHECK(fecha_inicio_periodo <= CURRENT_DATE),
    fecha_fin_periodo       DATE            NOT NULL CHECK(fecha_fin_periodo <= CURRENT_DATE),
    estado_nomina           VARCHAR         NOT NULL CHECK(LENGTH(estado_nomina) >= 3 AND LENGTH(estado_nomina) <= 20),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_nomina),
    CONSTRAINT fk_nomina_empleado FOREIGN KEY(id_empleado) REFERENCES tab_empleados(id_empleado)
);

-- --------------------------------------------
-- TABLA 19: tab_det_nomina
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_det_nomina
(
    id_detalle              VARCHAR         NOT NULL CHECK(LENGTH(id_detalle) >= 1 AND LENGTH(id_detalle) <= 10),
    id_nomina               INTEGER         NOT NULL CHECK(id_nomina >= 1 AND id_nomina <= 999999),
    id_empleado             DECIMAL(10,0)   NOT NULL CHECK(id_empleado >= 1 AND id_empleado <= 9999999999),
    id_concepto             VARCHAR         NOT NULL CHECK(LENGTH(id_concepto) >= 1 AND LENGTH(id_concepto) <= 10),
    salario                 DECIMAL(10,2)   NOT NULL CHECK(salario >= 0),
    bonificaciones          DECIMAL(10,2)   CHECK(bonificaciones >= 0),
    descuentos              DECIMAL(10,2)   CHECK(descuentos >= 0),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_detalle),
    CONSTRAINT fk_det_nomina_nomina FOREIGN KEY(id_nomina) REFERENCES tab_nomina(id_nomina),
    CONSTRAINT fk_det_nomina_empleado FOREIGN KEY(id_empleado) REFERENCES tab_empleados(id_empleado),
    CONSTRAINT fk_det_nomina_concepto FOREIGN KEY(id_concepto) REFERENCES tab_concepto_nomina(id_concepto)
);

-- --------------------------------------------
-- TABLA 20: tab_novedades
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_novedades
(
    id_novedad              VARCHAR         NOT NULL CHECK(LENGTH(id_novedad) >= 1 AND LENGTH(id_novedad) <= 10),
    id_empleado             DECIMAL(10,0)   NOT NULL CHECK(id_empleado >= 1 AND id_empleado <= 9999999999),
    tipo_novedad            VARCHAR         NOT NULL CHECK(LENGTH(tipo_novedad) >= 3 AND LENGTH(tipo_novedad) <= 30),
    descripcion             VARCHAR         CHECK(LENGTH(descripcion) >= 5 AND LENGTH(descripcion) <= 200),
    fecha_novedad           DATE            NOT NULL CHECK(fecha_novedad <= CURRENT_DATE),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_novedad),
    CONSTRAINT fk_novedad_empleado FOREIGN KEY(id_empleado) REFERENCES tab_empleados(id_empleado)
);

-- --------------------------------------------
-- TABLA 21: tab_prestamos
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_prestamos
(
    id_prestamo             VARCHAR         NOT NULL CHECK(LENGTH(id_prestamo) >= 1 AND LENGTH(id_prestamo) <= 10),
    id_empleado             DECIMAL(10,0)   NOT NULL CHECK(id_empleado >= 1 AND id_empleado <= 9999999999),
    valor_prestamo          DECIMAL(12,2)   NOT NULL CHECK(valor_prestamo >= 0),
    cuotas                  INTEGER         NOT NULL CHECK(cuotas >= 1 AND cuotas <= 360),
    tasa_intereses          DECIMAL(5,2)    NOT NULL CHECK(tasa_intereses >= 0 AND tasa_intereses <= 100),
    fecha_inicio            DATE            NOT NULL CHECK(fecha_inicio <= CURRENT_DATE),
    fecha_fin               DATE            CHECK(fecha_fin <= CURRENT_DATE),
    estado                  VARCHAR         NOT NULL CHECK(LENGTH(estado) >= 3 AND LENGTH(estado) <= 20),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_prestamo),
    CONSTRAINT fk_prestamo_empleado FOREIGN KEY(id_empleado) REFERENCES tab_empleados(id_empleado)
);

-- --------------------------------------------
-- TABLA 22: tab_liquidacion
-- --------------------------------------------

CREATE TABLE IF NOT EXISTS tab_liquidacion
(
    id_liquidacion          VARCHAR         NOT NULL CHECK(LENGTH(id_liquidacion) >= 1 AND LENGTH(id_liquidacion) <= 10),
    id_empleado             DECIMAL(10,0)   NOT NULL CHECK(id_empleado >= 1 AND id_empleado <= 9999999999),
    tipo_liquidacion        VARCHAR         NOT NULL CHECK(LENGTH(tipo_liquidacion) >= 3 AND LENGTH(tipo_liquidacion) <= 20),
    fecha_liquidacion       DATE            NOT NULL CHECK(fecha_liquidacion <= CURRENT_DATE),
    fecha_inicio_periodo    DATE            CHECK(fecha_inicio_periodo <= CURRENT_DATE),
    fecha_fin_periodo       DATE            CHECK(fecha_fin_periodo <= CURRENT_DATE),
    dias_liquidados         INTEGER         CHECK(dias_liquidados >= 0 AND dias_liquidados <= 365),
    salario_base            DECIMAL(10,2)   CHECK(salario_base >= 0),
    cesantias               DECIMAL(10,2)   CHECK(cesantias >= 0),
    intereses_cesantias     DECIMAL(10,2)   CHECK(intereses_cesantias >= 0),
    prima_servicios         DECIMAL(10,2)   CHECK(prima_servicios >= 0),
    vacaciones              DECIMAL(10,2)   CHECK(vacaciones >= 0),
    indemnizacion           DECIMAL(10,2)   CHECK(indemnizacion >= 0),
    total_liquidacion       DECIMAL(12,2)   CHECK(total_liquidacion >= 0),
    usr_insert              VARCHAR         NOT NULL CHECK(LENGTH(usr_insert) >= 8),
    fec_insert              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    usr_update              VARCHAR         CHECK(LENGTH(usr_update) >= 8),
    fec_update              TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(id_liquidacion),
    CONSTRAINT fk_liquidacion_empleado FOREIGN KEY(id_empleado) REFERENCES


    -- --------------------------------------------
-- TABLA 22: tab_pmtros_generales
-- -----------------------------------------------

CREATE TABLE IF NOT EXISTS tab_pmtros_grales
(
    id_empresa	    VARCHAR	        NOT NULL CHECK(LENGTH(id_empresa) = 10),
    nom_empresa	    VARCHAR         NOT NULL CHECK(LENGTH(nom_empresa) >= 5 AND LENGTH(nom_empresa) <= 60),
    dir_empresa	    VARCHAR	        NOT NULL,
    email_empresa	VARCHAR	        NOT NULL,
    nom_replegal	VARCHAR	        NOT NULL CHECK(LENGTH(nom_replegal) >= 5 AND LENGTH(nom_replegal) <= 60),
    val_poriva	    DECIMAL(2,0)	NOT NULL CHECK(val_poriva   >= 0   AND val_poriva   < 100) DEFAULT 0,
    val_pordes	    DECIMAL(2,0)	NOT NULL CHECK(val_pordes   >= 0   AND val_pordes   < 100) DEFAULT 0,
    val_porrete	    DECIMAL(2,0)	NOT NULL CHECK(val_porrete  >= 0   AND val_porrete  < 100) DEFAULT 0,
    val_reteica	    DECIMAL(2,0)	NOT NULL CHECK(val_reteica  >= 0   AND val_reteica  < 100) DEFAULT 0,
    val_porutil	    DECIMAL(3,0)	NOT NULL CHECK(val_porutil  >= 0   AND val_porutil  <= 100) DEFAULT 0,
    val_latitud	    DECIMAL(12,10)	NOT NULL CHECK(val_latitud  >= -4  AND val_latitud  <= 80),	
    val_longitud	DECIMAL(12,10)	NOT NULL CHECK(val_longitud >= -80 AND val_longitud <= -50),
    ind_autorete    BOOLEAN	        NOT NULL, --TRUE = autorete / FALSE = no autorete
    PRIMARY KEY(id_empresa)
);