DROP TABLE IF EXISTS tab_novedades;
DROP TABLE IF EXISTS tab_hoja_vida;
DROP TABLE IF EXISTS tab_conceptos_nomina;
DROP TABLE IF EXISTS tab_ref_laboral;
DROP TABLE IF EXISTS tab_exp_laboral;
DROP TABLE IF EXISTS tab_prestamos;
DROP TABLE IF EXISTS tab_empleados;
DROP TABLE IF EXISTS tab_empresas;
DROP TABLE IF EXISTS tab_bancos;
DROP TABLE IF EXISTS tab_candidatos;
DROP TABLE IF EXISTS tab_areas;
DROP TABLE IF EXISTS tab_jefes;
DROP TABLE IF EXISTS tab_cargos;
DROP TABLE IF EXISTS tab_terceros;
DROP TABLE IF EXISTS tab_restricciones;
DROP TABLE IF EXISTS tab_cat_terceros;
DROP TABLE IF EXISTS tab_perfil;
DROP TABLE IF EXISTS tab_profesion;
DROP TABLE IF EXISTS tab_ciudades;
DROP TABLE IF EXISTS tab_departamentos;
DROP TABLE IF EXISTS tab_paises;
DROP TABLE IF EXISTS tab_pmtros;
DROP TYPE  IF EXISTS audit_trail;
DROP TYPE  IF EXISTS datos_ubic;



-- TABLA DE PARÁMETROS GENERALES
CREATE TABLE IF NOT EXISTS tab_pmtros 
(
id_empresa		DECIMAL(10,0)			NOT NULL, --Identificador único de una empresa
nom_empresa		VARCHAR			        NOT NULL, --Nombre de la empresa
tel_empresa		DECIMAL(10,0)	        NOT NULL, --Número de teléfono de la empresa
dir_empresa		VARCHAR			        NOT NULl, --
email_empresa	VARCHAR			        NOT NULl, --Correo electrónico de contacto de la empresa
nom_replegal	VARCHAR			        NOT NULL, --Nombre del representante legal de la empresa
val_poriva		DECIMAL(2,0)	        NOT NULL, --Apellido del representante legal de la empresa
val_pordes		DECIMAL(2,0)	        NOT NULL, --Valor o porcentaje aplicado para el impuesto IVA
val_porrete		DECIMAL(2,0)	        NOT NULL, --valor o porcentaje para retefuente
val_reteica		DECIMAL(2,0)	        NOT NULL, --valor reteica
val_porutil		DECIMAL(3,0)	        NOT NULL, --valor porcent
val_latitud		DECIMAL(12,10)	        NOT NULL, -- valor latitud
val_longitud	DECIMAL(12,10)	        NOT NULL, --valor longitud
ind_autorete	BOOLEAN			        NOT NULL, --
PRIMARY KEY(id_empresa)
);

--TYPE AUDITORIO 
CREATE TYPE  audit_trail AS
(
	usr_insert      VARCHAR,                   
    fec_insert      TIMESTAMP,
    usr_update      VARCHAR,
    fec_update      TIMESTAMP
);

--TYPE UBICACION 
CREATE TYPE  datos_ubic AS 
(
	val_longitud	DECIMAL(12,10),  
	val_latitud		DECIMAL(12,10),  
	val_direccion	VARCHAR
);

----- TABLA DE PAISES 
CREATE TABLE IF NOT EXISTS tab_paises
(
id_pais 		DECIMAL(4,0)		NOT NULL,       --identificador unico de pais 
nom_pais 		VARCHAR				NOT NULL,       --nombre del pais
val_longitud 	DECIMAL(12,10)		NOT NULL,       --valor de longitud
val_latitud 	DECIMAL(12,10)		NOT NULL,       --valor de latitud
datos_audit 	audit_trail,
PRIMARY KEY(id_pais)
);
CREATE INDEX idx_nom_pais ON tab_paises(nom_pais);

-- TABLA DE DEPARTAMENTOS
CREATE TABLE IF NOT EXISTS tab_departamentos 
(
    id_departamento   VARCHAR                      NOT NULL,    --identificador unico de departamento
    nom_departamento  VARCHAR                      NOT NULL,    --nombre de departamento
    dir_tercero       datos_ubic,
	datos_audit		  audit_trail,
   
	PRIMARY KEY(id_departamento)
);
CREATE INDEX idx_nom_departamento ON tab_departamentos(nom_departamento);

-- TABLA DE CIUDADES
CREATE TABLE IF NOT EXISTS tab_ciudades 
(
    id_ciudad       VARCHAR                      NOT NULL,  -- identificador unico de ciudad
    nom_ciudad      VARCHAR                      NOT NULL,  -- nombre de ciudad
    id_departamento VARCHAR                      NOT NULL,  -- identificador departamento
    ind_capital     BOOLEAN                      NULL,      -- indicador capital
    cod_postal      VARCHAR                      NOT NULL,  -- codigo postal
	ubi_ciudad      datos_ubic,
	datos_audit		audit_trail,
    
    PRIMARY KEY(id_ciudad),
    FOREIGN KEY(id_departamento) REFERENCES tab_departamentos(id_departamento)
);
CREATE INDEX idx_nom_ciudad ON tab_ciudades(nom_ciudad);


-- TABLA DE PROFESIONES 
CREATE TABLE IF NOT EXISTS tab_profesion
(
id_profesion		VARCHAR		NOT NULL,   -- identificador unico de profesion
nom_profesion	VARCHAR		NOT NULL,   -- nombre de profesion 
nivel_educativo		VARCHAR		NOT NULL,   -- nivel educativo
area_conocimiento	VARCHAR		NOT NULL,   --  area de conocimiento
datos_audit			audit_trail,

PRIMARY KEY(id_profesion)
);
CREATE INDEX idx_nom_profesion ON tab_profesion(nom_profesion);

----- TABLA DE PERFILES 
CREATE TABLE IF NOT EXISTS tab_perfil
(
id_perfil			VARCHAR		NOT NULL,   --identificador unico de perfil 
nom_perfil		VARCHAR		NOT NULL,   --nombre de perfil
descripcion			VARCHAR		NOT NULL,   -- descripcion del perfil
nivel_estudio		VARCHAR		NOT NULL,   -- nivel de estudios 
exp_minima			INTEGER		NOT NULL,   -- experiencia minima requerida 
habilidades			VARCHAR		NOT NULL,   -- habilidades requeridas
datos_audit			audit_trail, 

PRIMARY KEY(id_perfil)
);
CREATE INDEX idx_nom_perfil ON tab_perfil(nom_perfil);

-- TABLA DE CATEGORIAS DE USUARIOS
CREATE TABLE IF NOT EXISTS tab_cat_terceros			
(			
    id_cat_tercero       DECIMAL(2,0)     NOT NULL,     -- identificador unico de categoria de tercero			
    nom_cat_tercero      VARCHAR    	  NOT NULL,     -- nombre categoria de tercero
    datos_audit          audit_trail,
    PRIMARY KEY(id_cat_tercero)			
);

CREATE INDEX idx_nom_categoria ON tab_cat_terceros(nom_cat_tercero);

-- TABLA DE RESTRICCIONES
CREATE TABLE IF NOT EXISTS tab_restricciones			
(			
    id_restriccion       DECIMAL(2,0)     NOT NULL,			--identificador unico de restriccion 
    nom_restriccion      VARCHAR     	  NOT NULL,         --nombre de restriccion 
    datos_audit          audit_trail,
    PRIMARY KEY(id_restriccion)		
);	
CREATE INDEX idx_nom_restriccion ON tab_restricciones(nom_restriccion);	


-- TABLA DE TERCEROS
CREATE TABLE IF NOT EXISTS tab_terceros			
(			
    id_tercero           DECIMAL(10,0)      NOT NULL,			--identificador unico de tercero
    ind_tipo_tercero     BOOLEAN            NOT NULL,			--indicador de tipo de tercero
    id_cat_tercero       DECIMAL(2,0)       NOT NULL,			-- identificador unico de categoria de tercero
    nom_tercero          VARCHAR	        NOT NULL,           --nombre de tercero
	ape_tercero          VARCHAR	        NOT NULL,           --apellidos de tercero
    id_ciudad            VARCHAR            NOT NULL,           -- identificador unico de ciudad 
    id_restriccion       DECIMAL(2,0)       NOT NULL,		    -- identificador unico de restriccion 
    ind_estado           BOOLEAN            NOT NULL, 		    -- indicador de estado de tercero
    datos_audit          audit_trail,
	dir_tercero          datos_ubic,		
    PRIMARY KEY(id_tercero),			
    FOREIGN KEY(id_ciudad)       REFERENCES tab_ciudades(id_ciudad),			
    FOREIGN KEY(id_cat_tercero)  REFERENCES tab_cat_terceros(id_cat_tercero),			
    FOREIGN KEY(id_restriccion)  REFERENCES tab_restricciones(id_restriccion) 
);	

CREATE INDEX idx_nom_terceros ON tab_terceros(nom_tercero);
CREATE INDEX idx_ape_terceros ON tab_terceros(ape_tercero);

----- TABLA DE CARGOS
CREATE TABLE IF NOT EXISTS tab_cargos
(
id_cargo			VARCHAR			NOT NULL,   -- identificador unico de cargo
nombre_cargo		VARCHAR			NOT NULL,   -- nombre del cargo
descripcion			VARCHAR			NOT NULL,   -- descripcion del cargo
salario_maximo		DECIMAL(10,2)	NOT NULL,   -- salario maximo del cargo
salario_minimo		DECIMAL(10,2)	NOT NULL,   -- salario minimo del cargo
nivel_jerarquico	VARCHAR			NOT NULL,   -- nivel jeràrquico
datos_audit			audit_trail,

PRIMARY KEY(id_cargo)
);

CREATE INDEX idx_nom_cargo ON tab_cargos(nombre_cargo);

--
-- TABLA JEFES DE ÁREA
CREATE TABLE IF NOT EXISTS tab_jefes 
(
    id_jefe     	DECIMAL(10,0)            	 NOT NULL,  --identificador unico de jefe
    nom_jefe    	VARCHAR                  	 NOT NULL,  --nombre de jefe
    ape_jefe    	VARCHAR                  	 NOT NULL,  -- apellido de jefe
    cel_jefe    	DECIMAL(10,0)           	 NOT NULL,  --telefono celular de jefe
    mail_coorp  	VARCHAR                  	 NOT NULL,  -- mail coorporativo 
	datos_audit		audit_trail,
	dir_jefe        datos_ubic,
	
    PRIMARY KEY(id_jefe)
);

CREATE INDEX idx_nom_jefe ON tab_jefes(nom_jefe);
CREATE INDEX idx_ape_jefe ON tab_jefes(ape_jefe);

-- TABLA DE ÁREAS EMPRESARIALES (relación a jefes)
CREATE TABLE IF NOT EXISTS tab_areas 
(
    id_area     	DECIMAL(15,0)           		 NOT NULL,  --identificador unico de area
    nom_area    	VARCHAR                 		 NOT NULL,  --nombre de area
    id_jefe     	DECIMAL(10,0)           		 NOT NULL,  --identificador unico de jefe
	datos_audit		audit_trail,
	
    PRIMARY KEY(id_area),
    FOREIGN KEY(id_jefe) REFERENCES tab_jefes(id_jefe)
);
CREATE INDEX idx_nom_area ON tab_areas(nom_area);

----- TABLA DE CANDIDATOS
CREATE TABLE IF NOT EXISTS tab_candidatos
(
id_candidato 		DECIMAL(10,0)		NOT NULL,   -- identificador unico de candidato 
nom_candidato 		VARCHAR				NOT NULL,   -- nombre de candidato
ape_candidato		VARCHAR				NOT NULL,   -- apellido de candidato
fecha_nacimiento 	DATE				NOT NULL,   -- fecha de nacimiento de candidato
ind_gen_biologico 	BOOLEAN				NOT NULL,   -- genero del candidato
id_pais				DECIMAL(4,0)		NOT NULL,   -- identificador unico de pais
tipo_documento 		VARCHAR				NOT NULL,   -- tipo de documento del candidato
id_ciudad 			VARCHAR				NOT NULL,   -- identificador unico de ciudad 
ind_estado	 		BOOLEAN				NOT NULL,   -- estado del candidato
datos_audit 		audit_trail,
data_residencia		datos_ubic,

PRIMARY KEY(id_candidato),
FOREIGN KEY(id_ciudad)		REFERENCES tab_ciudades(id_ciudad),
FOREIGN KEY(id_pais)		REFERENCES tab_paises(id_pais)
);

CREATE INDEX idx_nom_candidato ON tab_candidatos(nom_candidato);
CREATE INDEX idx_ape_candidato ON tab_candidatos(ape_candidato);


---------- TABLA DE EMPRESAS
CREATE TABLE IF NOT EXISTS tab_empresas
(
id_empresa 			DECIMAL(10,0)		NOT NULL,   --identificador unico de empresa
nom_empresa 		VARCHAR				NOT NULL,   --nombre de empresa
caja_compensacion 	VARCHAR				NOT NULL,   -- caja de compensasion de la empresa
datos_audit 		audit_trail,   
data_residencia		datos_ubic,

PRIMARY KEY(id_empresa)
);
CREATE INDEX idx_nom_empresa ON tab_empresas(nom_empresa);

---------- TABLA DE BANCOS
CREATE TABLE IF NOT EXISTS tab_bancos
(
id_cuenta			DECIMAL(12,0)	NOT NULL,   -- identificador unico de cuenta
tipo_cuenta 		VARCHAR			NOT NULL,   -- tipo de cuenta
datos_audit 		audit_traiL,

PRIMARY KEY(id_cuenta)
);


----- TABLA DE EMPLEADOS
CREATE TABLE IF NOT EXISTS tab_empleados
(
id_empleado				DECIMAL(10,0)		NOT NULL,   -- numero de documento del empleado
nom_empleado			VARCHAR				NOT NULL,   -- nombre del empleado 
ape_empleado			VARCHAR				NOT NULL,   --apellido del empleado
fecha_nacimiento		DATE				NOT NULL,   --fecha de nacimiento del empleado
ind_genero				BOOLEAN				NOT NULL,   -- indicador de genero
ind_auditor				BOOLEAN				NOT NULL,   -- indicador de auditor 
data_residencia			datos_ubic,
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
id_pais					DECIMAL(4,0)		NOT NULL,   -- identificador unico de pais
id_departamento			VARCHAR				NOT NULL,   -- identificador unico de departamento
id_ciudad				VARCHAR				NOT NULL,   -- identificador unico de ciudad
datos_audit				audit_trail,

PRIMARY KEY(id_empleado),
FOREIGN KEY(id_area)			REFERENCES tab_areas(id_area),
FOREIGN KEY(id_cargo)			REFERENCES tab_cargoS(id_cargo),
FOREIGN KEY(id_cuenta)			REFERENCES tab_bancos(id_cuenta),
FOREIGN KEY(id_empresa)			REFERENCES tab_empresas(id_empresa),
FOREIGN KEY(id_pais)			REFERENCES tab_paises(id_pais),
FOREIGN KEY(id_departamento)	REFERENCES tab_departamentos(id_departamento),
FOREIGN KEY(id_ciudad)			REFERENCES tab_ciudades(id_ciudad)
);
CREATE INDEX idx_nom_empleado ON tab_empleados(nom_empleado);
CREATE INDEX idx_ape_empleado ON tab_empleados(ape_empleado);


------ TABLA DE PRESTAMOS
CREATE TABLE IF NOT EXISTS tab_prestamos
(
id_prestamo			VARCHAR				NOT NULL,   --identificador unico de prestamo
id_empleado			DECIMAL(10,0)		NOT NULL,   -- numero de documento del empleado
val_prestamo		DECIMAL(12,2)		NOT NULL,   -- valor del prestamo
num_cuotas			INTEGER				NOT NULL,   -- numero de cuotas
tasa_intereses		DECIMAL(5,2)		NOT NULL,   -- tasa de interes de prestamo
fecha_inicio		DATE				NOT NULL,   -- fecha inicio de prestamo 
fecha_fin			DATE				NOT NULL,   -- fecha final de prestamo
ind_estado			BOOLEAN				NOT NULL,   -- estado de prestamo
datos_audit			audit_trail,

PRIMARY KEY(id_prestamo),
FOREIGN KEY(id_empleado)	 REFERENCES	tab_empleados(id_empleado)
);

---------- TABLA DE EXPERIENCIA LABORAL 
CREATE TABLE IF NOT EXISTS tab_exp_laboral
(
id_experiencia			VARCHAR				NOT NULL,   -- identificador unico de experiencia
id_empleado				DECIMAL(10,0)		NOT NULL,   -- numero de documento del empleado
id_empresa				DECIMAL(10,0)		NOT NULL,   -- identificador unico de empresa
val_cargo				VARCHAR				NOT NULL,   -- 
fecha_inicio			DATE				NOT NULL,   -- fecha inicio de experiencia
fecha_fin				DATE				NOT NULL,   -- fecha final de experiencia
val_funciones			VARCHAR				NOT NULL,   -- funciones de experiencia
nom_logros				VARCHAR				NOT NULL,   -- logros alcanzados
datos_audit				audit_trail,			

PRIMARY KEY(id_experiencia),
FOREIGN KEY(id_empleado)		REFERENCES tab_empleados(id_empleado),
FOREIGN KEY(id_empresa)			REFERENCES tab_empresas(id_empresa)
);

------ TABLA DE REFERENCIA LABORAL
CREATE TABLE IF NOT EXISTS tab_ref_laboral
(
id_referencia		VARCHAR				NOT NULL,   -- identificador unico de referencia    
id_experiencia		VARCHAR				NOT NULL,   -- identificador unico de experiencia
num_telefono		VARCHAR				NOT NULL,   -- numero de telefomo
id_empresa			DECIMAL(10,0)		NOT NULL,   -- identificador unico de empreda
val_cargo			VARCHAR				NOT NULL,   -- 
datos_audit			audit_trail,

PRIMARY KEY(id_referencia),
FOREIGN KEY (id_experiencia)	REFERENCES tab_exp_laboral(id_experiencia),
FOREIGN KEY (id_empresa)	REFERENCES tab_empresas(id_empresa)
);

------- TABLA DE CONCEPTO DE NOMINA
CREATE TABLE IF NOT EXISTS tab_conceptos_nomina
(
id_concepto 		DECIMAL(3,0)	NOT NULL,   -- identificador unico de concepto
nom_concepto 		VARCHAR			NOT NULL,   -- nombre de concepto
ind_obligatorio 	BOOLEAN			NOT NULL,   -- indicador obligatorio
ind_naturaleza 		BOOLEAN			NOT NULL,   -- indicador de naturaleza
ind_periodo 		BOOLEAN			NOT NULL,   -- indicador de periodo de concepto
ind_porc_valor 		BOOLEAN			NOT NULL,   -- indicador de porcentaje o valor
val_porcentaje 		DECIMAL(2,0)	NOT NULL,   --valor del porcentaje
val_valor 			DECIMAL(5,0)	NOT NULL,   --valor del concepto 
datos_audit 		audit_trail,

PRIMARY KEY(id_concepto)
);
CREATE INDEX idx_nom_concepto ON tab_conceptos_nomina(nom_concepto);


----------- TABLA DE HOJA DE VIDA
CREATE TABLE IF NOT EXISTS tab_hoja_vida
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
datos_audit 			audit_trail,

PRIMARY KEY(id_hoja_vida),
FOREIGN KEY(id_candidato)		REFERENCES tab_candidatos(id_candidato),
FOREIGN KEY(id_experiencia)		REFERENCES tab_exp_laboral(id_experiencia),
FOREIGN KEY(id_referencia)		REFERENCES tab_ref_laboral(id_referencia)
);

----- TABLA DE NOVEDADES
CREATE TABLE IF NOT EXISTS tab_novedades
(
id_novedad		VARCHAR			NOT NULL,         ------- identificador unico de novedad         
ano_nov			INTEGER			NOT NULL,         ------- año de la novedad                     
mes_nov			VARCHAR			NOT NULL,         ------- mes de la novedad                                     
periodo_nov		VARCHAR			NOT NULL,         ------- periodo de novedad                     
id_concepto		DECIMAL(3,0)	NOT NULL,         ------- identificador unico de concepto                               
datos_audit		audit_trail,                                       

PRIMARY KEY(id_novedad),
FOREIGN KEY(id_concepto)	REFERENCES tab_conceptos_nomina(id_concepto)
);

