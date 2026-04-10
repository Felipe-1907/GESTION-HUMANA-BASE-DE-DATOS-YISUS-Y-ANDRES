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
id_profesion		VARCHAR		NOT NULL CHECK(LENGTH(id_profesion) >= 4 >= AND LENGTH(id_profesion) <= 15),   -- identificador unico de profesion
nom_profesion	    VARCHAR		NOT NULL CHECK(LENGTH(nom_profesion) >= 4 >= AND LENGTH(nom_profesion) <= 20),   -- nombre de profesion 
nivel_educativo		VARCHAR		NOT NULL CHECK(LENGTH(nivel_educativo) >= 4 >= AND LENGTH(nivel_educativo) <= 15),   -- nivel educativo
area_conocimiento	VARCHAR		NOT NULL CHECK(LENGTH(area_conocimiento) >= 4 >= AND LENGTH(area_conocimiento) <= 20),   --  area de conocimiento
PRIMARY KEY(id_profesion)
);
CREATE INDEX idx_nom_profesion ON GEHNOM.tab_profesion(nom_profesion);

----- TABLA DE PERFILES 
CREATE TABLE IF NOT EXISTS GEHNOM.tab_perfil
(
id_perfil			VARCHAR		NOT NULL CHECK(LENGTH(id_perfil) >= 1 AND LENGTH(id_perfil) <= 10),   --identificador unico de perfil 
nom_perfil		    VARCHAR		NOT NULL CHECK(LENGTH(nom_perfil) >= 3 AND LENGTH(nom_perfil) <= 20 ),   --nombre de perfil
descripcion			VARCHAR		NOT NULL CHECK(LENGTH(descripcion) >= 10 AND LENGTH(descripcion) <= 200 ),   -- descripcion del perfil
nivel_estudio		VARCHAR		NOT NULL CHECK(LENGTH(nivel_estudio) >= 3 AND LENGTH(nivel_estudio) <= 20 ),   -- nivel de estudios 
exp_minima			INTEGER		NOT NULL CHECK(exp_minima >= 0 >= AND exp_minima <= 20 ),   -- experiencia minima requerida 
habilidades			VARCHAR		NOT NULL CHECK(LENGTH(habilidades) >= 5 AND LENGTH(habilidades) <= 200 ),   -- habilidades requeridas
PRIMARY KEY(id_perfil)
);

CREATE INDEX idx_nom_perfil ON GEHNOM.tab_perfil(nom_perfil);


----- TABLA DE CARGOS
CREATE TABLE IF NOT EXISTS GEHNOM.tab_cargos
(
id_cargo			VARCHAR			NOT NULL CHECK(LENGTH(id_cargo) >= 1  AND LENGTH(id_cargo) <= 10),   -- identificador unico de cargo
nombre_cargo		VARCHAR			NOT NULL CHECK(LENGTH(nombre_cargo) >= 3 AND LENGTH(nombre_cargo) <= 50),   -- nombre del cargo
descripcion			VARCHAR			NOT NULL CHECK(LENGTH(descripcion) >= 5 AND LENGTH(descripcion) <= 200),   -- descripcion del cargo
salario_maximo		DECIMAL(10,2)	NOT NULL CHECK(salario_maximo >= 1 ),   -- salario maximo del cargo
salario_minimo		DECIMAL(10,2)	NOT NULL CHECK(salario_minimo >= 1 ),   -- salario minimo del cargo
nivel_jerarquico	VARCHAR			NOT NULL CHECK(LENGTH(nivel_jerarquico) >= 3 AND LENGTH(nivel_jerarquico) <= 20),   -- nivel jeràrquico
PRIMARY KEY(id_cargo)
);

CREATE INDEX idx_nom_cargo ON GEHNOM.tab_cargos(nombre_cargo);

--
-- TABLA JEFES DE ÁREA
CREATE TABLE IF NOT EXISTS GEHNOM.tab_jefes 
(
    id_jefe     	DECIMAL(10,0)            	 NOT NULL CHECK(id_jefe >=  AND id_jefe <= ),  --identificador unico de jefe
    nom_jefe    	VARCHAR                  	 NOT NULL CHECK(LENGTH(nom_jefe)  AND LENGTH(ape_jefe)),  --nombre de jefe
    ape_jefe    	VARCHAR                  	 NOT NULL CHECK(LENGTH(nom_jefe)  AND LENGTH(ape_jefe)),  -- apellido de jefe
    cel_jefe    	DECIMAL(10,0)           	 NOT NULL CHECK(),  --telefono celular de jefe
    mail_coorp  	VARCHAR                  	 NOT NULL CHECK(LENGTH(mail_coorp)  AND LENGTH(mail_coorp) <=),  -- mail coorporativo 
	PRIMARY KEY(id_jefe)
);

CREATE INDEX idx_nom_jefe ON GEHNOM.tab_jefes(nom_jefe);
CREATE INDEX idx_ape_jefe ON GEHNOM.tab_jefes(ape_jefe);

-- TABLA DE ÁREAS EMPRESARIALES (relación a jefes)
CREATE TABLE IF NOT EXISTS GEHNOM.tab_areas 
(
    id_area     	DECIMAL(15,0)		NOT NULL,  --identificador unico de area
    nom_area    	VARCHAR      		NOT NULL,  --nombre de area
    id_jefe     	DECIMAL(10,0)		NOT NULL,  --identificador unico de jefe
	PRIMARY KEY(id_area),
    FOREIGN KEY(id_jefe) REFERENCES GEHNOM.tab_jefes(id_jefe)
);
CREATE INDEX idx_nom_area ON GEHNOM.tab_areas(nom_area);

----- TABLA DE CANDIDATOS
CREATE TABLE IF NOT EXISTS GEHNOM.tab_candidatos
(
id_candidato 		DECIMAL(10,0)		NOT NULL,   -- identificador unico de candidato 
nom_candidato 		VARCHAR				NOT NULL,   -- nombre de candidato
ape_candidato		VARCHAR				NOT NULL,   -- apellido de candidato
fecha_nacimiento 	DATE				NOT NULL,   -- fecha de nacimiento de candidato
ind_gen_biologico 	BOOLEAN				NOT NULL,   -- genero del candidato
tipo_documento 		VARCHAR				NOT NULL,   -- tipo de documento del candidato
id_ciudad 			VARCHAR				NOT NULL,   -- identificador unico de ciudad 
ind_estado	 		BOOLEAN				NOT NULL,   -- estado del candidato
data_residencia		public.DATOS_UBICACION,
PRIMARY KEY(id_candidato),
FOREIGN KEY(id_ciudad)		REFERENCES public.tab_ciudades(id_ciudad)
);

CREATE INDEX idx_nom_candidato ON GEHNOM.tab_candidatos(nom_candidato);
CREATE INDEX idx_ape_candidato ON GEHNOM.tab_candidatos(ape_candidato);

---------- TABLA DE EMPRESAS
CREATE TABLE IF NOT EXISTS GEHNOM.tab_empresas
(
id_empresa 			DECIMAL(10,0)		NOT NULL,   --identificador unico de empresa
nom_empresa 		VARCHAR				NOT NULL,   --nombre de empresa
caja_compensacion 	VARCHAR				NOT NULL,   -- caja de compensasion de la empresa
data_residencia		public.DATOS_UBICACION,

PRIMARY KEY(id_empresa)
);
CREATE INDEX idx_nom_empresa ON GEHNOM.tab_empresas(nom_empresa);

---------- TABLA DE BANCOS
CREATE TABLE IF NOT EXISTS GEHNOM.tab_bancos
(
id_cuenta			DECIMAL(12,0)	NOT NULL,   -- identificador unico de cuenta
tipo_cuenta 		VARCHAR			NOT NULL,   -- tipo de cuenta

PRIMARY KEY(id_cuenta)
);


----- TABLA DE EMPLEADOS
CREATE TABLE IF NOT EXISTS GEHNOM.tab_empleados
(
id_empleado				DECIMAL(10,0)		NOT NULL,   -- numero de documento del empleado
nom_empleado			VARCHAR				NOT NULL,   -- nombre del empleado 
ape_empleado			VARCHAR				NOT NULL,   --apellido del empleado
fecha_nacimiento		DATE				NOT NULL,   --fecha de nacimiento del empleado
ind_genero				BOOLEAN				NOT NULL,   -- indicador de genero
ind_auditor				BOOLEAN				NOT NULL,   -- indicador de auditor 
data_residencia			public.DATOS_UBICACION,
nom_estudios			DECIMAL(4,0)		NOT NULL,   -- nombre de estudios
id_area					DECIMAL(2,0)		NOT NULL,   -- identificador unico de area
id_cargo				VARCHAR				NOT NULL,   -- identificador unico de cargo
val_sal_base			DECIMAL(10,2)		NOT NULL,   --valor de salario base del empleado
fecha_ingreso			DATE				NOT NULL,   -- fecha de ingreso del empleado
ind_estado				BOOLEAN				NOT NULL,   -- indicador de estado del empleado 
ind_disponibilidad		BOOLEAN				NOT NULL,   -- indicador de disponibilidad del empleado
fecha_salida			DATE				,           -- fecha de salida del empleado
tel_emp					DECIMAL(10,0)		NOT NULL,   -- telefono del empleado
id_cuenta				DECIMAL(12,0)		NOT NULL,   -- identificador unico de cuenta
id_empresa				DECIMAL(10,0)		NOT NULL,   -- identificador unico de empresa
id_departamento			VARCHAR				NOT NULL,   -- identificador unico de departamento
id_ciudad				VARCHAR				NOT NULL,   -- identificador unico de ciudad
PRIMARY KEY(id_empleado),
FOREIGN KEY(id_area)			REFERENCES GEHNOM.tab_areas(id_area),
FOREIGN KEY(id_cargo)			REFERENCES GEHNOM.tab_cargoS(id_cargo),
FOREIGN KEY(id_cuenta)			REFERENCES GEHNOM.tab_bancos(id_cuenta),
FOREIGN KEY(id_empresa)			REFERENCES GEHNOM.tab_empresas(id_empresa),
FOREIGN KEY(id_departamento)	REFERENCES public.tab_dptos(id_dpto),
FOREIGN KEY(id_ciudad)			REFERENCES public.tab_ciudades(id_ciudad)
);
CREATE INDEX idx_nom_empleado ON GEHNOM.tab_empleados(nom_empleado);
CREATE INDEX idx_ape_empleado ON GEHNOM.tab_empleados(ape_empleado);


------ TABLA DE PRESTAMOS
CREATE TABLE IF NOT EXISTS GEHNOM.tab_prestamos
(
id_prestamo			VARCHAR				NOT NULL,   --identificador unico de prestamo
id_empleado			DECIMAL(10,0)		NOT NULL,   -- numero de documento del empleado
val_prestamo		DECIMAL(12,2)		NOT NULL,   -- valor del prestamo
num_cuotas			INTEGER				NOT NULL,   -- numero de cuotas
tasa_intereses		DECIMAL(5,2)		NOT NULL,   -- tasa de interes de prestamo
fecha_inicio		DATE				NOT NULL,   -- fecha inicio de prestamo 
fecha_fin			DATE				NOT NULL,   -- fecha final de prestamo
ind_estado			BOOLEAN				NOT NULL,   -- estado de prestamo
PRIMARY KEY(id_prestamo),
FOREIGN KEY(id_empleado)	 REFERENCES	GEHNOM.tab_empleados(id_empleado)
);

---------- TABLA DE EXPERIENCIA LABORAL 
CREATE TABLE IF NOT EXISTS GEHNOM.tab_exp_laboral
(
id_experiencia			VARCHAR				NOT NULL,   -- identificador unico de experiencia
id_empleado				DECIMAL(10,0)		NOT NULL,   -- numero de documento del empleado
id_empresa				DECIMAL(10,0)		NOT NULL,   -- identificador unico de empresa
val_cargo				VARCHAR				NOT NULL,   -- 
fecha_inicio			DATE				NOT NULL,   -- fecha inicio de experiencia
fecha_fin				DATE				NOT NULL,   -- fecha final de experiencia
val_funciones			VARCHAR				NOT NULL,   -- funciones de experiencia
nom_logros				VARCHAR				NOT NULL,   -- logros alcanzados			
PRIMARY KEY(id_experiencia),
FOREIGN KEY(id_empleado)		REFERENCES GEHNOM.tab_empleados(id_empleado),
FOREIGN KEY(id_empresa)			REFERENCES GEHNOM.tab_empresas(id_empresa)
);

------ TABLA DE REFERENCIA LABORAL
CREATE TABLE IF NOT EXISTS GEHNOM.tab_ref_laboral
(
id_referencia		VARCHAR				NOT NULL,   -- identificador unico de referencia    
id_experiencia		VARCHAR				NOT NULL,   -- identificador unico de experiencia
num_telefono		VARCHAR				NOT NULL,   -- numero de telefomo
id_empresa			DECIMAL(10,0)		NOT NULL,   -- identificador unico de empresa
val_cargo			VARCHAR				NOT NULL,   -- 

PRIMARY KEY(id_referencia),
FOREIGN KEY (id_experiencia)	REFERENCES GEHNOM.tab_exp_laboral(id_experiencia),
FOREIGN KEY (id_empresa)	REFERENCES GEHNOM.tab_empresas(id_empresa)
);

------- TABLA DE CONCEPTO DE NOMINA
CREATE TABLE IF NOT EXISTS GEHNOM.tab_conceptos_nomina
(
id_concepto 		DECIMAL(3,0)	NOT NULL,   -- identificador unico de concepto
nom_concepto 		VARCHAR			NOT NULL,   -- nombre de concepto
ind_obligatorio 	BOOLEAN			NOT NULL,   -- indicador obligatorio
ind_naturaleza 		BOOLEAN			NOT NULL,   -- indicador de naturaleza
ind_periodo 		BOOLEAN			NOT NULL,   -- indicador de periodo de concepto
ind_porc_valor 		BOOLEAN			NOT NULL,   -- indicador de porcentaje o valor
val_porcentaje 		DECIMAL(2,0)	NOT NULL,   --valor del porcentaje
val_valor 			DECIMAL(5,0)	NOT NULL,   --valor del concepto 

PRIMARY KEY(id_concepto)
);

CREATE INDEX idx_nom_concepto ON GEHNOM.tab_conceptos_nomina(nom_concepto);


----------- TABLA DE HOJA DE VIDA
CREATE TABLE IF NOT EXISTS GEHNOM.tab_hoja_vida
(
id_hoja_vida 			VARCHAR			NOT NULL,   -- identificador unico de hoja de vida 
id_candidato 			DECIMAL(10,0)	NOT NULL,   -- identificador unico de candidato
presen_general 	        VARCHAR			NOT NULL,   -- Presentacion general
datos_personales 		VARCHAR			NOT NULL,   -- Datos personales
perfil_profesional 		VARCHAR			NOT NULL,   -- Perfil profesional
id_experiencia 			VARCHAR			NOT NULL,   -- identificador unico de Experiencia laboral
form_academica 			VARCHAR			NOT NULL,   -- Formacion academica
form_complementaria 	VARCHAR			NOT NULL,   -- Formacion complementaria
cert_laborales  		VARCHAR			NOT NULL,   -- Certificaciones
habil_laborales 		VARCHAR			NOT NULL,   -- Habilidades
num_idiomas 			INTEGER		    NOT NULL,   -- Idiomas
id_referencia		 	VARCHAR			NOT NULL,   -- identificador unico de Referencias personales
PRIMARY KEY(id_hoja_vida),
FOREIGN KEY(id_candidato)		REFERENCES GEHNOM.tab_candidatos(id_candidato),
FOREIGN KEY(id_experiencia)		REFERENCES GEHNOM.tab_exp_laboral(id_experiencia),
FOREIGN KEY(id_referencia)		REFERENCES GEHNOM.tab_ref_laboral(id_referencia)
);

----- TABLA DE NOVEDADES
CREATE TABLE IF NOT EXISTS GEHNOM.tab_novedades
(
id_novedad		VARCHAR			NOT NULL,         ------- identificador unico de novedad         
ano_nov			INTEGER			NOT NULL,         ------- año de la novedad                     
mes_nov			VARCHAR			NOT NULL,         ------- mes de la novedad                                     
periodo_nov		VARCHAR			NOT NULL,         ------- periodo de novedad                     
id_concepto		DECIMAL(3,0)	NOT NULL,         ------- identificador unico de concepto                                                                      
PRIMARY KEY(id_novedad),
FOREIGN KEY(id_concepto)	REFERENCES GEHNOM.tab_conceptos_nomina(id_concepto)
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