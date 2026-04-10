-- =============================================
-- SCRIPT_GESTIÓN_HUMANA.1.2
-- =============================================

CREATE SCHEMA IF NOT EXISTS GEHNOM; --CREACIÓN DEL ESQUEMA

-- ELIMINACIÓN DE TABLAS (ORDEN CORRECTO POR DEPENDENCIAS)
DROP TABLE IF EXISTS GEHNOM.tab_novedades;
DROP TABLE IF EXISTS GEHNOM.tab_hoja_vida;
DROP TABLE IF EXISTS GEHNOM.tab_conceptos_nomina;
DROP TABLE IF EXISTS GEHNOM.tab_ref_laboral;
DROP TABLE IF EXISTS GEHNOM.tab_exp_laboral;
DROP TABLE IF EXISTS GEHNOM.tab_prestamos;
DROP TABLE IF EXISTS GEHNOM.tab_empleados;
DROP TABLE IF EXISTS GEHNOM.tab_empresas;
DROP TABLE IF EXISTS GEHNOM.tab_bancos;
DROP TABLE IF EXISTS GEHNOM.tab_candidatos;
DROP TABLE IF EXISTS GEHNOM.tab_areas;
DROP TABLE IF EXISTS GEHNOM.tab_jefes;
DROP TABLE IF EXISTS GEHNOM.tab_cargos;
DROP TABLE IF EXISTS GEHNOM.tab_perfil;
DROP TABLE IF EXISTS GEHNOM.tab_profesion;

-- TABLA DE PROFESIONES 
CREATE TABLE IF NOT EXISTS GEHNOM.tab_profesion
(
    id_profesion        VARCHAR(15)     NOT NULL CHECK(LENGTH(id_profesion) >= 4 AND LENGTH(id_profesion) <= 15),
    nom_profesion       VARCHAR(50)     NOT NULL CHECK(LENGTH(nom_profesion) >= 4 AND LENGTH(nom_profesion) <= 50),
    nivel_educativo     VARCHAR(30)     NOT NULL CHECK(LENGTH(nivel_educativo) >= 4),
    area_conocimiento   VARCHAR(50)     NOT NULL CHECK(LENGTH(area_conocimiento) >= 4),
    PRIMARY KEY(id_profesion)
);
CREATE INDEX idx_nom_profesion ON GEHNOM.tab_profesion(nom_profesion);

----- TABLA DE PERFILES
CREATE TABLE IF NOT EXISTS GEHNOM.tab_perfil
(
    id_perfil           VARCHAR(10)     NOT NULL CHECK(LENGTH(id_perfil) >= 1),
    nom_perfil          VARCHAR(50)     NOT NULL CHECK(LENGTH(nom_perfil) >= 3),
    descripcion         VARCHAR(255)    NOT NULL CHECK(LENGTH(descripcion) >= 10),
    nivel_estudio       VARCHAR(50)     NOT NULL,
    exp_minima          INTEGER         NOT NULL CHECK(exp_minima >= 0 AND exp_minima <= 30),
    habilidades         VARCHAR(255)    NOT NULL,
    PRIMARY KEY(id_perfil)
);
CREATE INDEX idx_nom_perfil ON GEHNOM.tab_perfil(nom_perfil);

----- TABLA DE CARGOS
CREATE TABLE IF NOT EXISTS GEHNOM.tab_cargos
(
    id_cargo            VARCHAR(10)     NOT NULL,
    nombre_cargo        VARCHAR(50)     NOT NULL CHECK(LENGTH(nombre_cargo) >= 3),
    descripcion         VARCHAR(255)    NOT NULL,
    salario_maximo      DECIMAL(12,2)   NOT NULL,
    salario_minimo      DECIMAL(12,2)   NOT NULL CHECK(salario_minimo > 0),
    nivel_jerarquico    VARCHAR(30)     NOT NULL,
    CONSTRAINT check_rango_salarial CHECK (salario_maximo >= salario_minimo),
    PRIMARY KEY(id_cargo)
);
CREATE INDEX idx_nom_cargo ON GEHNOM.tab_cargos(nombre_cargo);

-- TABLA JEFES DE ÁREA
CREATE TABLE IF NOT EXISTS GEHNOM.tab_jefes 
(
    id_jefe             DECIMAL(12,0)   NOT NULL CHECK(id_jefe > 0),
    nom_jefe            VARCHAR(50)     NOT NULL CHECK(LENGTH(nom_jefe) >= 2),
    ape_jefe            VARCHAR(50)     NOT NULL CHECK(LENGTH(ape_jefe) >= 2),
    cel_jefe            DECIMAL(10,0)   NOT NULL CHECK(cel_jefe >= 3000000000 AND cel_jefe <= 3999999999),
    mail_coorp          VARCHAR(100)    NOT NULL CHECK(LENGTH(mail_coorp) >= 5 AND LENGTH(mail_coorp) <= 100 AND mail_coorp LIKE '%@%'),
    PRIMARY KEY(id_jefe)
);
CREATE INDEX idx_nom_jefe ON GEHNOM.tab_jefes(nom_jefe);
CREATE INDEX idx_ape_jefe ON GEHNOM.tab_jefes(ape_jefe);

-- TABLA DE ÁREAS EMPRESARIALES (relación a jefes)
CREATE TABLE IF NOT EXISTS GEHNOM.tab_areas 
(
    id_area             DECIMAL(15,0)   NOT NULL CHECK(id_area > 0),
    nom_area            VARCHAR(100)    NOT NULL CHECK(LENGTH(nom_area) >= 3),
    id_jefe             DECIMAL(10,0)   NOT NULL,
    PRIMARY KEY(id_area),
    FOREIGN KEY(id_jefe) REFERENCES GEHNOM.tab_jefes(id_jefe)
);
CREATE INDEX idx_nom_area ON GEHNOM.tab_areas(nom_area);

----- TABLA DE CANDIDATOS
CREATE TABLE IF NOT EXISTS GEHNOM.tab_candidatos
(
    id_candidato        DECIMAL(10,0)   NOT NULL CHECK(id_candidato > 0),
    nom_candidato       VARCHAR(50)     NOT NULL CHECK(LENGTH(nom_candidato) >= 2),
    ape_candidato       VARCHAR(50)     NOT NULL CHECK(LENGTH(ape_candidato) >= 2),
    fecha_nacimiento    DATE            NOT NULL CHECK(fecha_nacimiento < CURRENT_DATE),
    ind_gen_biologico   BOOLEAN         NOT NULL,
    tipo_documento      VARCHAR(10)     NOT NULL CHECK(tipo_documento IN ('CC', 'CE', 'TI', 'PAS')),
    id_ciudad           VARCHAR(10)     NOT NULL,
    ind_estado          BOOLEAN         NOT NULL,
    data_residencia     public.DATOS_UBICACION,
    PRIMARY KEY(id_candidato),
    FOREIGN KEY(id_ciudad) REFERENCES public.tab_ciudades(id_ciudad)
);
CREATE INDEX idx_nom_candidato ON GEHNOM.tab_candidatos(nom_candidato);
CREATE INDEX idx_ape_candidato ON GEHNOM.tab_candidatos(ape_candidato);

---------- TABLA DE EMPRESAS
CREATE TABLE IF NOT EXISTS GEHNOM.tab_empresas
(
    id_empresa          DECIMAL(10,0)   NOT NULL CHECK(id_empresa > 0),
    nom_empresa         VARCHAR(100)    NOT NULL CHECK(LENGTH(nom_empresa) >= 3),
    caja_compensacion   VARCHAR(100)    NOT NULL,
    data_residencia     public.DATOS_UBICACION,
    PRIMARY KEY(id_empresa)
);
CREATE INDEX idx_nom_empresa ON GEHNOM.tab_empresas(nom_empresa);

-- TABLA DE BANCOS
CREATE TABLE IF NOT EXISTS GEHNOM.tab_bancos
(
    id_cuenta           DECIMAL(12,0)   NOT NULL CHECK(id_cuenta > 0),
    tipo_cuenta         VARCHAR(20)     NOT NULL CHECK(tipo_cuenta IN ('AHORROS', 'CORRIENTE')),
    PRIMARY KEY(id_cuenta)
);

----- TABLA DE EMPLEADOS
CREATE TABLE IF NOT EXISTS GEHNOM.tab_empleados
(
    id_empleado         DECIMAL(10,0)   NOT NULL CHECK(id_empleado > 0),
    nom_empleado        VARCHAR(50)     NOT NULL CHECK(LENGTH(nom_empleado) >= 2),
    ape_empleado        VARCHAR(50)     NOT NULL CHECK(LENGTH(ape_empleado) >= 2),
    fecha_nacimiento    DATE            NOT NULL CHECK(fecha_nacimiento < CURRENT_DATE),
    ind_genero          BOOLEAN         NOT NULL,
    ind_auditor         BOOLEAN         NOT NULL,
    data_residencia     public.DATOS_UBICACION,
    nom_estudios        VARCHAR(100)    NOT NULL,
    id_area             DECIMAL(15,0)   NOT NULL,
    id_cargo            VARCHAR(10)     NOT NULL,
    val_sal_base        DECIMAL(10,2)   NOT NULL CHECK(val_sal_base > 0),
    fecha_ingreso       DATE            NOT NULL DEFAULT CURRENT_DATE,
    ind_estado          BOOLEAN         NOT NULL,
    ind_disponibilidad  BOOLEAN         NOT NULL,
    fecha_salida        DATE,
    tel_emp             DECIMAL(10,0)   NOT NULL CHECK(tel_emp >= 3000000000 AND tel_emp <= 3999999999),
    id_cuenta           DECIMAL(12,0)   NOT NULL,
    id_empresa          DECIMAL(10,0)   NOT NULL,
    id_departamento     VARCHAR(10)     NOT NULL,
    id_ciudad           VARCHAR(10)     NOT NULL,
    PRIMARY KEY(id_empleado),
    FOREIGN KEY(id_area)      REFERENCES GEHNOM.tab_areas(id_area),
    FOREIGN KEY(id_cargo)     REFERENCES GEHNOM.tab_cargos(id_cargo),
    FOREIGN KEY(id_cuenta)    REFERENCES GEHNOM.tab_bancos(id_cuenta),
    FOREIGN KEY(id_empresa)   REFERENCES GEHNOM.tab_empresas(id_empresa),
    FOREIGN KEY(id_departamento) REFERENCES public.tab_dptos(id_dpto),
    FOREIGN KEY(id_ciudad)       REFERENCES public.tab_ciudades(id_ciudad)
);
CREATE INDEX idx_nom_empleado ON GEHNOM.tab_empleados(nom_empleado);
CREATE INDEX idx_ape_empleado ON GEHNOM.tab_empleados(ape_empleado);

------ TABLA DE PRESTAMOS
CREATE TABLE IF NOT EXISTS GEHNOM.tab_prestamos
(
    id_prestamo         VARCHAR(15)     NOT NULL,
    id_empleado         DECIMAL(10,0)   NOT NULL,
    val_prestamo        DECIMAL(12,2)   NOT NULL CHECK(val_prestamo > 0),
    num_cuotas          INTEGER         NOT NULL CHECK(num_cuotas >= 1),
    tasa_intereses      DECIMAL(5,2)    NOT NULL CHECK(tasa_intereses >= 0),
    fecha_inicio        DATE            NOT NULL,
    fecha_fin           DATE            NOT NULL CHECK(fecha_fin > fecha_inicio),
    ind_estado          BOOLEAN         NOT NULL,
    PRIMARY KEY(id_prestamo),
    FOREIGN KEY(id_empleado) REFERENCES GEHNOM.tab_empleados(id_empleado)
);

---------- TABLA DE EXPERIENCIA LABORAL 
CREATE TABLE IF NOT EXISTS GEHNOM.tab_exp_laboral
(
    id_experiencia      VARCHAR(15)     NOT NULL,
    id_empleado         DECIMAL(10,0)   NOT NULL,
    id_empresa          DECIMAL(10,0)   NOT NULL,
    val_cargo           VARCHAR(100)    NOT NULL CHECK(LENGTH(val_cargo) >= 3),
    fecha_inicio        DATE            NOT NULL,
    fecha_fin           DATE            NOT NULL CHECK(fecha_fin >= fecha_inicio),
    val_funciones       VARCHAR(500)    NOT NULL CHECK(LENGTH(val_funciones) >= 5),
    nom_logros          VARCHAR(500)    NOT NULL,
    PRIMARY KEY(id_experiencia),
    FOREIGN KEY(id_empleado) REFERENCES GEHNOM.tab_empleados(id_empleado),
    FOREIGN KEY(id_empresa)  REFERENCES GEHNOM.tab_empresas(id_empresa)
);

------ TABLA DE REFERENCIA LABORAL
CREATE TABLE IF NOT EXISTS GEHNOM.tab_ref_laboral
(
    id_referencia       VARCHAR(15)     NOT NULL,
    id_experiencia      VARCHAR(15)     NOT NULL,
    num_telefono        VARCHAR(15)     NOT NULL CHECK(LENGTH(num_telefono) >= 7),
    id_empresa          DECIMAL(10,0)   NOT NULL,
    val_cargo           VARCHAR(100)    NOT NULL,
    PRIMARY KEY(id_referencia),
    FOREIGN KEY (id_experiencia) REFERENCES GEHNOM.tab_exp_laboral(id_experiencia),
    FOREIGN KEY (id_empresa)     REFERENCES GEHNOM.tab_empresas(id_empresa)
);

------- TABLA DE CONCEPTO DE NOMINA
CREATE TABLE IF NOT EXISTS GEHNOM.tab_conceptos_nomina
(
    id_concepto         DECIMAL(3,0)    NOT NULL CHECK(id_concepto >= 1),
    nom_concepto        VARCHAR(100)    NOT NULL CHECK(LENGTH(nom_concepto) >= 3),
    ind_obligatorio     BOOLEAN         NOT NULL,
    ind_naturaleza      BOOLEAN         NOT NULL,
    ind_periodo         BOOLEAN         NOT NULL,
    ind_porc_valor      BOOLEAN         NOT NULL,
    val_porcentaje      DECIMAL(5,2)    NOT NULL CHECK(val_porcentaje >= 0),
    val_valor           DECIMAL(10,2)   NOT NULL CHECK(val_valor >= 0),
    PRIMARY KEY(id_concepto)
);
CREATE INDEX idx_nom_concepto ON GEHNOM.tab_conceptos_nomina(nom_concepto);

----------- TABLA DE HOJA DE VIDA
CREATE TABLE IF NOT EXISTS GEHNOM.tab_hoja_vida
(
    id_hoja_vida        VARCHAR(15)     NOT NULL,
    id_candidato        DECIMAL(10,0)   NOT NULL,
    presen_general      VARCHAR(500)    NOT NULL CHECK(LENGTH(presen_general) >= 10),
    datos_personales    VARCHAR(500)    NOT NULL,
    perfil_profesional  VARCHAR(500)    NOT NULL,
    id_experiencia      VARCHAR(15)     NOT NULL,
    form_academica      VARCHAR(500)    NOT NULL,
    form_complementaria VARCHAR(500)    NOT NULL,
    cert_laborales      VARCHAR(500)    NOT NULL,
    habil_laborales     VARCHAR(500)    NOT NULL,
    num_idiomas         INTEGER         NOT NULL CHECK(num_idiomas >= 0),
    id_referencia       VARCHAR(15)     NOT NULL,
    PRIMARY KEY(id_hoja_vida),
    FOREIGN KEY(id_candidato)   REFERENCES GEHNOM.tab_candidatos(id_candidato),
    FOREIGN KEY(id_experiencia) REFERENCES GEHNOM.tab_exp_laboral(id_experiencia),
    FOREIGN KEY(id_referencia)  REFERENCES GEHNOM.tab_ref_laboral(id_referencia)
);

----- TABLA DE NOVEDADES
CREATE TABLE IF NOT EXISTS GEHNOM.tab_novedades
(
    id_novedad          VARCHAR(15)     NOT NULL,
    ano_nov             INTEGER         NOT NULL CHECK(ano_nov >= 2020),
    mes_nov             VARCHAR(15)     NOT NULL,
    periodo_nov         VARCHAR(20)     NOT NULL,
    id_concepto         DECIMAL(3,0)    NOT NULL,
    PRIMARY KEY(id_novedad),
    FOREIGN KEY(id_concepto) REFERENCES GEHNOM.tab_conceptos_nomina(id_concepto)
);






---------------------------------------quitar despues...--------
CREATE OR REPLACE FUNCTION fun_insert_pmtros(wid_empresa tab_pmtros_grales.id_empresa%TYPE,
											 wnom_empresa tab_pmtros_grales.nom_empresa%TYPE,
											 wdatos_residencia DATOS_UBICACION,
											 wnom_replegal tab_pmtros_grales.nom_replegal%TYPE,
											 wval_poriva tab_pmtros_grales.val_poriva%TYPE,
											 wval_pordesc tab_pmtros_grales.val_pordesc%TYPE,
											 wval_porrete tab_pmtros_grales.val_porrete%TYPE,
											 wval_reteica tab_pmtros_grales.val_reteica%TYPE,
											 wval_porutil tab_pmtros_grales.val_porutil%TYPE,
											 wval_latitud tab_pmtros_grales.val_latitud%TYPE,
											 wval_longitud tab_pmtros_grales.val_longitud%TYPE,
											 wval_color_letra tab_pmtros_grales.val_color_letra%TYPE,
											 wval_color_logo tab_pmtros_grales.val_color_logo%TYPE,
											 wval_color_fondo tab_pmtros_grales.val_color_fondo%TYPE,
											 wanio_fiscal tab_pmtros_grales.anio_fiscal%TYPE,
											 wmes_fiscal tab_pmtros_grales.mes_fiscal%TYPE,
											 wind_autoretenedor tab_pmtros_grales.ind_autoretenedor%TYPE,
																						) RETURNS VARCHAR AS
$BODY$
	DECLARE
	wwid_prod  tab_prod.id_prod%TYPE;
    wwid_ref  tab_prod.id_ref%TYPE;
    wwnom_prod  tab_prod.nom_prod%TYPE;
	BEGIN
------------------------------VALIDACIONES DE ENTRADAS-------------------------
		IF wid_empresa IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
		IF wnom_empresa IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
		IF wdatos_residencia IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
		IF wnom_replegal IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
			IF wval_poriva IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
		IF wval_pordesc IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
		IF wval_porrete IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
		IF wval_reteica IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
		IF wval_porutil IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
		IF wval_latitud IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
			IF wval_longitud IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
		IF wval_color_letra IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
		IF wval_color_logo IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
		IF wval_color_fondo  IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
		IF wanio_fiscal IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
		IF wmes_fiscal IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
			IF wind_autoretenedor IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
		IF wdatos_audit IS NULL THEN
			RAISE NOTICE 'ES NULO ESCRIBA DE NUEVO';
			RETURN 'NO SE ACEPTAN VALORES NULOS';
		END IF;
		

-------- VALIDACIÓN DE EXISTENCIA DE LLAVE PRIMARIA

SELECT a.id_prod INTO wwid_prod FROM tab_prod AS a
		WHERE a.id_prod = wid_prod;
		IF FOUND THEN
				RAISE NOTICE 'El producto % YA existe.',wid_prod;
				RETURN 'Producto ya registrado';
		END IF;

		
SELECT a.id_ref INTO wwid_ref FROM tab_prod AS a
		WHERE a.id_ref = wid_ref;
		IF FOUND THEN
			RAISE NOTICE 'Esta de % referencia ya esta registrada',wid_ref;
			RETURN 'ESA REF YA ESTA POR AHI REVISE';
		END IF;

SELECT a.nom_prod INTO wwnom_prod FROM tab_prod AS a
		WHERE a.nom_prod = wnom_prod;
		IF FOUND THEN
			RAISE NOTICE 'EL nombre % de producto ya esta registrado',wnom_prod;
			RETURN 'Oiga corrija el producto porque este ya existe..';
		END IF;	

		IF wind_estado = FALSE THEN
			RAISE NOTICE 'PROD YA DESACTIVADO';
			RETURN 'PRODUCTO NO DISPONIBLE';
		END IF;


-------------------- ACA SE INSERTA ------------
		INSERT INTO tab_pmtros_grales VALUES(wid_empresa,
											 wnom_empresa,
											 wdatos_residencia DATOS_UBICACION,
											 wnom_replegal,
											 wval_poriva,
											 wval_pordesc,
											 wval_porrete,
											 wval_reteica,
											 wval_porutil,
											 wval_latitud,
											 wval_longitud,
											 wval_color_letra,
											 wval_color_logo,
											 wval_color_fondo,
											 wanio_fiscal,
											 wmes_fiscal,
											 wind_autoretenedor,
											 wdatos_audit);
		IF NOT FOUND THEN
			RETURN 'Dont be brutation... back to the elementary school ASSHOLE';
		ELSE
			RETURN 'La cosa nos funcionó.. Somos unos duros, y no propiamente del estómago';
		END IF;
	END;
$BODY$
LANGUAGE PLPGSQL;
---------------------------quitar de este script






