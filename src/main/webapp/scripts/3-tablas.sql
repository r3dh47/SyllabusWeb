/*  LPLP - Creacion de tablas v06
13/11/2016 7:56pm
        -- 26 TABLAS
*/
CREATE TABLE DBSEGSYL.PERIODO (
   ID_PERIODO   INTEGER NOT NULL,
   ANIO         INTEGER NOT NULL,
   SEMESTRE     INTEGER NOT NULL,
   FECHA_INICIO DATE NOT NULL,
   FECHA_FIN    DATE NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.ASIGNATURA (
   ID_ASIGNATURA   INTEGER NOT NULL,
   NOMBRE          VARCHAR2(60) NOT NULL,
   CODIGO          INTEGER NOT NULL,
   CREDITAJE       INTEGER NOT NULL,
   CICLO           INTEGER NOT NULL,
   ID_PLAN_ESTUDIO INTEGER NOT NULL,
   ID_REGIMEN      INTEGER NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.ASIGNATURA_APERTURADA (
   ID_ASIG_APERTURADA INTEGER NOT NULL,
   ID_PERIODO         INTEGER NOT NULL,
   ID_ASIGNATURA      INTEGER NOT NULL,
   ID_COORDINADOR     INTEGER
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.GRUPO (
   ID_GRUPO           INTEGER NOT NULL,
   NUMERO             INTEGER NOT NULL,
   ID_ASIG_APERTURADA INTEGER NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.ESTADO_SYLLABUS (
   ID_ESTADO_SYLLABUS INTEGER NOT NULL,
   DESCRIPCION        VARCHAR2(20) NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;	

CREATE TABLE DBSEGSYL.SYLLABUS (
   ID_SYLLABUS        INTEGER NOT NULL,
   ID_ESTADO          INTEGER,
   FECHA_ENTREGA      DATE 	NOT NULL,
   FECHA_APROBACION   DATE DEFAULT NULL,
   ID_ASIG_APERTURADA INTEGER NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;	

CREATE TABLE DBSEGSYL.REGIMEN (
   ID_REGIMEN  INTEGER 		NOT NULL,
   DESCRIPCION VARCHAR2(30) 	NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.CLASE (
   ID_CLASE    INTEGER NOT NULL,
   HORA_INICIO TIMESTAMP NOT NULL,
   HORA_FIN    TIMESTAMP NOT NULL,
   ID_DIA      INTEGER NOT NULL,
   ID_TIPO     INTEGER NOT NULL,
   ID_GRUPO    INTEGER NOT NULL,
   ID_DOCENTE  INTEGER NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.TIPO_CLASE (
   ID_TIPO_CLASE INTEGER NOT NULL,
   DESCRIPCION   VARCHAR2(30) NOT NULL
	)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.PLAN_DE_ESTUDIO (
   ID_PLAN_ESTUDIO     INTEGER NOT NULL,
   NOMBRE              VARCHAR2(30) NOT NULL,
   ESTA_VIGENTE        CHAR(1) NOT NULL,
   ANIO_DE_PUBLICACION INTEGER NOT NULL,
   ID_EAP              INTEGER NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.EAP (
   ID_EAP     INTEGER NOT NULL,
   CODIGO_EAP INTEGER NOT NULL,
   NOMBRE     VARCHAR2(30) NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.MATRICULA (
   ID_MATRICULA INTEGER NOT NULL,
   ID_ALUMNO    INTEGER NOT NULL,
   ID_GRUPO     INTEGER NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.ALUMNO (
   ID_EAP     INTEGER NOT NULL,
   ID_USUARIO INTEGER NOT NULL,
   SITUACION  CHAR(1) NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.DOCENTE (
   ID_USUARIO INTEGER NOT NULL,
   GRADO      VARCHAR2(30) NOT NULL
	)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.USUARIO (
   ID_USUARIO INTEGER NOT NULL,
   NOMBRE     VARCHAR2(90) NOT NULL,
   APELLIDO   VARCHAR2(90) NOT NULL,
   CORREO     VARCHAR2(30) NOT NULL,
   PASSWORD   VARCHAR2(30) NOT NULL,
   TELEFONO   INTEGER NOT NULL,
   DIRECCION  VARCHAR2(90) NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.SESION (
   ID_SESION INTEGER NOT NULL,
   ESTADO    CHAR(1) NOT NULL,
   FECHA     DATE NOT NULL,
   ID_CLASE  INTEGER NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.ASISTENCIA (
   ID_ASISTENCIA INTEGER NOT NULL,
   VERIFICACION  CHAR(1) NOT NULL,
   ID_SESION     INTEGER NOT NULL,
   ID_USUARIO    INTEGER NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.TEMA (
   ID_TEMA     INTEGER NOT NULL,
   DESCRIPCION VARCHAR2(200) NOT NULL,
   UNIDAD      INTEGER NOT NULL,
   SEMANA      INTEGER NOT NULL,
   ID_TIPO     INTEGER NOT NULL,
   ID_SYLLABUS INTEGER NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.REFERENCIA_BIBLIOGRAFICA (
   TITULO            VARCHAR2(75) NOT NULL,
   AUTOR             VARCHAR2(90),
   ANIO_PUBLICACION  INTEGER,
   LUGAR_PUBLICACION VARCHAR2(90),
   EDITORIAL         VARCHAR2(30),
   ISBN              VARCHAR(13),
   ID_REFERENCIA     INTEGER NOT NULL,
   ID_SYLLABUS       INTEGER NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.TEMA_X_SESION (
   ID_TEMA_X_SESION INTEGER NOT NULL,
   CUMPLIDO         CHAR(1),
   ID_TEMA          INTEGER NOT NULL,
   ID_SESION        INTEGER NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.ROL (
   ID_ROL      INTEGER NOT NULL,
   NOMBRE      VARCHAR2(30) NOT NULL,
   DESCRIPCION VARCHAR2(75) NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.DIA (
   ID_DIA      INTEGER NOT NULL,
   DESCRIPCION VARCHAR2(10) NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.TEMA_ADICIONAL (
   ID_TEMA_ADICIONAL INTEGER NOT NULL,
   CUMPLIDO          CHAR(1),
   DESCRIPCION       VARCHAR2(200) NOT NULL,
   ID_SESION         INTEGER NOT NULL
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.VALIDACION_ALUMNO(
   ID_VALIDACION    INTEGER NOT NULL,
   CUMPLIDO         CHAR(1) NOT NULL,
   COMENTARIO       VARCHAR2(100),
   ID_ALUMNO        INTEGER NULL,
   ID_TEMA_X_SESION INTEGER NULL 
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.CODIGO_GENERAL_DET(
   ID_CODIGO_GENERAL  INTEGER NOT NULL, --123
   CODIGO_GENERAL     VARCHAR2(20) NOT NULL,  --'ESTADO' --NOMBRE DE LA COLUMNA
   CODIGO_GENERAL_DET VARCHAR2(3) NOT NULL, --'T' 
   DESCRIPCION        VARCHAR2(50) NOT NULL --'TERMINADO'
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE TABLE DBSEGSYL.ROL_X_USUARIO(
   ID_ROL_X_USUARIO INTEGER NOT NULL,
   ID_ROL           INTEGER NOT NULL,
   ID_USUARIO       INTEGER NOT NULL 
)
TABLESPACE TS_SEGSYL
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;
