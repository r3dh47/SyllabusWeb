/*--------------------------------------------------------------------------*/
/* NOMBRE    : DEVUELVE_NOMBRE_ASIG_APER                                            	*/
/* OBJETIVO  : RETORNA EL NOMBRE DE UNA ASIGNATURA POR SU ID      */
/* FECHA MODIFICACION : 11/11/2016 7:30pm
/*--------------------------------------------------------------------------*/
/*     INFORMACION:                                                          */
/*     AUTOR: TAKESHI FARRO HINOSHITA                                 */
/*---------------------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION DBSEGSYL.DEVUELVE_NOMBRE_ASIG_APER(
	COD 	IN VARCHAR2
)
RETURN VARCHAR2 IS VNOMBRE VARCHAR2(200);
BEGIN
		SELECT ASIG.NOMBRE
		  INTO VNOMBRE
		  FROM ASIGNATURA_APERTURADA ASIG_APERTURADA
		  JOIN ASIGNATURA ASIG ON (ASIG_APERTURADA.ID_ASIGNATURA = ASIG.ID_ASIGNATURA)
		 WHERE ID_ASIG_APERTURADA = TO_NUMBER(COD);

	RETURN VNOMBRE;
EXCEPTION
	WHEN OTHERS THEN
		RETURN NULL;
END;
/

create or replace PROCEDURE REG_REF_BIBLIO
/*---------------------------------------------------------------------------*/
/* Nombre    : REG_REF_BIBLIO       		                             */
/* Objetivo  : Inserta un registro en la tabla REFERENCIA_BIBLIOGRAFICA      */
/*---------------------------------------------------------------------------*/
/*     Informacion:                                                          */
/*     Autor: Thalia Quiroz Guzman                                           */
/*---------------------------------------------------------------------------*/

   (TITULO		REFERENCIA_BIBLIOGRAFICA.TITULO%TYPE,
    AUTOR		REFERENCIA_BIBLIOGRAFICA.AUTOR%TYPE,
    ANIO_PUBLICACION	REFERENCIA_BIBLIOGRAFICA.ANIO_PUBLICACION%TYPE,
    LUGAR_PUBLICACION	REFERENCIA_BIBLIOGRAFICA.LUGAR_PUBLICACION%TYPE,
    EDITORIAL		REFERENCIA_BIBLIOGRAFICA.EDITORIAL%TYPE,
    ISBN REFERENCIA_BIBLIOGRAFICA.ISBN%TYPE,
    ID_SYLLABUS		REFERENCIA_BIBLIOGRAFICA.ID_SYLLABUS%TYPE) AUTHID CURRENT_USER AS

BEGIN
    INSERT INTO REFERENCIA_BIBLIOGRAFICA (ID_REFERENCIA,
	                TITULO, AUTOR,
					ANIO_PUBLICACION,
					LUGAR_PUBLICACION,
					EDITORIAL,
					ISBN,
					ID_SYLLABUS)
      VALUES (sq_referencia.NEXTVAL,
	        REG_REF_BIBLIO.TITULO,
			REG_REF_BIBLIO.AUTOR,
			REG_REF_BIBLIO.ANIO_PUBLICACION,
			REG_REF_BIBLIO.LUGAR_PUBLICACION,
			REG_REF_BIBLIO.EDITORIAL,
			REG_REF_BIBLIO.ISBN,
			REG_REF_BIBLIO.ID_SYLLABUS);

END REG_REF_BIBLIO;
/

/*---------------------------------------------------------------------------*/
/* Nombre    : REG_TEMA       		                             */
/* Objetivo  : Inserta un registro en la tabla TEMA      */
/*---------------------------------------------------------------------------*/
/*     Informacion:                                                          */
/*     Autor: Thalia Quiroz Guzman                                           */
/*---------------------------------------------------------------------------*/
create or replace PROCEDURE REG_TEMA
   (DESCRIPCION		TEMA.DESCRIPCION%TYPE,
    UNIDAD			TEMA.UNIDAD%TYPE,
    SEMANA			TEMA.SEMANA%TYPE,
    ID_SYLLABUS		TEMA.ID_SYLLABUS%TYPE) AUTHID CURRENT_USER AS

BEGIN
    INSERT INTO TEMA (ID_TEMA,
	                DESCRIPCION,
					UNIDAD,
					SEMANA,
					ID_SYLLABUS)
      VALUES (sq_tema.nextval,
	        REG_TEMA.DESCRIPCION,
			REG_TEMA.UNIDAD,
			REG_TEMA.SEMANA,
			REG_TEMA.ID_SYLLABUS);

END REG_TEMA;
/

/*--------------------------------------------------------------------------
 * NOMBRE    : Reg_Syllabus
 * OBJETIVO  : Registrar syllabus en la base de datos
 * FECHA MOD : 03/11/2016 2:53pm
 *--------------------------------------------------------------------------
 *     INFORMACI?:
 *     AUTOR: LUCERO DEL PILAR LIZA PUICAN
 *---------------------------------------------------------------------------*/
create or replace PROCEDURE Reg_Syllabus
   (p_IDAsigAperturada      IN dbsegsyl.syllabus.id_asig_aperturada%TYPE
   ) AUTHID CURRENT_USER AS

BEGIN
   INSERT INTO syllabus (
      id_syllabus,
      id_estado,
      fecha_entrega,
      id_asig_aperturada
   )
   VALUES (sq_syllabus.nextval, 1, SYSDATE, p_IDAsigAperturada);

END Reg_Syllabus;
/

    --FECHA ULTIMA MODIFICACION: 11/11/2016 14:45PM
            -- Verificar procedures de LISTAR y BUSCAR
            -- Definir parametros de salida de Listar_Syllabus_x_EAP
            -- Se agrego Registrar/Modificar/Eliminar Validacion_Alumno

/*--------------------------------------------------------------------------
 * NOMBRE    : Devuelve_IDPeriodo_Actual
 * OBJETIVO  : Retorna los datos del periodo actual
 * FECHA MOD : 02/11/2016 2:12pm
 *--------------------------------------------------------------------------
 *     INFORMACI?:
 *     AUTOR: LUCERO DEL PILAR LIZA PUICAN
 *--------------------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION dbsegsyl.Devuelve_IDPeriodo_Actual
RETURN dbsegsyl.periodo.id_periodo%TYPE
IS    vIDPeriodo INTEGER;
      vFechaActual DATE;
BEGIN
       vFechaActual := SYSDATE;

       SELECT id_periodo
         INTO vIDPeriodo
         FROM dbsegsyl.periodo
        WHERE anio = TO_NUMBER( TO_CHAR(SYSDATE, 'YYYY'))
          AND fecha_inicio <= vFechaActual
          AND fecha_fin >= vFechaActual;

       RETURN vIDPeriodo;
END;
/

create or replace PACKAGE          PAC_CURSOR is
  --Creating REF CURSOR type
  type g_cursor is ref cursor;

  --Procedure that return the cursor
  /*--------------------------------------------------------------------------
   * NOMBRE    : LISTAR_ASIG_X_COORD
   * OBJETIVO  : Lista asignaturas aperturadas de acuerdo al periodo actual
   * FECHA MOD : 11/11/2016 2:53pm
   *--------------------------------------------------------------------------
   *     INFORMACI?:
   *     AUTOR: TAKESHI FARRO HINOSHITA
   *---------------------------------------------------------------------------*/
  procedure LISTAR_ASIG_X_COORD(
    p_IDCoordinador     in     docente.id_usuario%type,
    p_IDPeriodo in periodo.id_periodo%type,
    o_cursor in out g_cursor); -- Our cursor

/*--------------------------------------------------------------------------
   * NOMBRE    : LISTAR_TEMAS_X_ASIG_APER
   * OBJETIVO  : Lista temas por asignatura aperturada
   * FECHA MOD : 13/11/2016 10:30pm
   *--------------------------------------------------------------------------
   *     INFORMACI?:
   *     AUTOR: GIANCARLOS CLAUDIO ZAVALETA
   *---------------------------------------------------------------------------*/
   
  procedure LISTAR_TEMAS_X_ASIG_APER(
    ASIG_APER_ID     in ASIGNATURA_APERTURADA.ID_ASIG_APERTURADA%TYPE,
    SEM              in TEMA.SEMANA%TYPE,
    O_CURSOR         in out g_cursor
  );

/*--------------------------------------------------------------------------
   * NOMBRE    : RET_ASIG_X_ASIG_APER
   * OBJETIVO  : Retorna el ID y nombre de la Asignatura aperturada
   * FECHA MOD : 13/11/2016 10:30pm
   *--------------------------------------------------------------------------
   *     INFORMACI?:
   *     AUTOR: GIANCARLOS CLAUDIO ZAVALETA
   *---------------------------------------------------------------------------*/
   
  procedure RET_ASIG_X_ASIG_APER(
    ASIG_APER_ID in ASIGNATURA_APERTURADA.ID_ASIG_APERTURADA%TYPE,
    O_CURSOR         in out g_cursor
  );

 /*--------------------------------------------------------------------------
   * NOMBRE    : LISTAR_ASIG_AP_X_ALUMNO
   * OBJETIVO  : Retorna las asignaturas aperturadas en las que se encuentra 
                 matriculado el alumno
   * FECHA MOD : 13/11/2016 10:30pm
   *--------------------------------------------------------------------------
   *     INFORMACI?:
   *     AUTOR: GIANCARLOS CLAUDIO ZAVALETA
   *---------------------------------------------------------------------------*/
   
  procedure LISTAR_ASIG_AP_X_ALUMNO(
    ID_ALUM  IN     ALUMNO.ID_USUARIO%TYPE,
    PERIOD   IN     PERIODO.ID_PERIODO%TYPE,
    O_CURSOR IN OUT G_CURSOR
  );

/*--------------------------------------------------------------------------
 * NOMBRE    : LISTAR_GRUPOS
 * OBJETIVO  : Lista grupos del periodo actual
 * FECHA MOD : 11/11/2016 2:53pm
 *--------------------------------------------------------------------------
 *     INFORMACI?:
 *     AUTOR: TAKESHI FARRO HINOSHITA
 *---------------------------------------------------------------------------*/
 
  procedure LISTAR_GRUPOS(
     p_IDPeriodo IN periodo.id_periodo%TYPE,
     o_cursor    IN OUT g_cursor
  );

end PAC_CURSOR;
/
create or replace PACKAGE BODY PAC_CURSOR IS
  PROCEDURE LISTAR_ASIG_X_COORD(
    p_IDCoordinador IN docente.id_usuario%TYPE,
    p_IDPeriodo     IN periodo.id_periodo%TYPE,
    o_cursor        IN OUT g_cursor) IS

    BEGIN
      --Opening the cursor to return matched rows
      OPEN o_cursor FOR
        SELECT asignatura_aperturada.id_asig_aperturada, 
               asignatura.nombre AS asig_nombre, 
               plan_de_estudio.nombre AS plan_nombre,
               estado_syllabus.descripcion AS estado_syllabus
        FROM asignatura_aperturada
        JOIN dbsegsyl.asignatura ON ( asignatura.ID_ASIGNATURA = asignatura_aperturada.ID_ASIGNATURA)
        JOIN dbsegsyl.plan_de_estudio ON ( plan_de_estudio.ID_PLAN_ESTUDIO = asignatura.ID_PLAN_ESTUDIO)
        LEFT JOIN dbsegsyl.syllabus ON (syllabus.id_asig_aperturada = asignatura_aperturada.id_asig_aperturada)
        LEFT JOIN dbsegsyl.estado_syllabus ON (estado_syllabus.id_estado_syllabus = syllabus.id_estado)
        WHERE id_coordinador = p_idcoordinador
        AND id_periodo     = p_idperiodo
        ORDER BY asignatura.codigo;

  END LISTAR_ASIG_X_COORD;
  
  PROCEDURE LISTAR_TEMAS_X_ASIG_APER(
    ASIG_APER_ID     in ASIGNATURA_APERTURADA.ID_ASIG_APERTURADA%TYPE,
    SEM              in TEMA.SEMANA%TYPE,
    O_CURSOR         in out g_cursor) IS
    
  BEGIN
    OPEN o_cursor FOR
      SELECT TEMA.ID_TEMA, TEMA.DESCRIPCION
      FROM TEMA
      JOIN SYLLABUS ON TEMA.ID_SYLLABUS = SYLLABUS.ID_SYLLABUS
      WHERE SYLLABUS.ID_ASIG_APERTURADA = ASIG_APER_ID
      AND TEMA.SEMANA = SEM;

  END LISTAR_TEMAS_X_ASIG_APER;
    
  PROCEDURE RET_ASIG_X_ASIG_APER(
    ASIG_APER_ID     in ASIGNATURA_APERTURADA.ID_ASIG_APERTURADA%TYPE,
    O_CURSOR         in out g_cursor) IS
  BEGIN
    OPEN o_cursor FOR
      SELECT ASIGNATURA.ID_ASIGNATURA, ASIGNATURA.NOMBRE
      FROM ASIGNATURA
      JOIN ASIGNATURA_APERTURADA ON ASIGNATURA.ID_ASIGNATURA = ASIGNATURA_APERTURADA.ID_ASIGNATURA
      WHERE ASIGNATURA_APERTURADA.ID_ASIG_APERTURADA = ASIG_APER_ID;
  END RET_ASIG_X_ASIG_APER;

  procedure LISTAR_ASIG_AP_X_ALUMNO(
    ID_ALUM  IN     ALUMNO.ID_USUARIO%TYPE,
    PERIOD   IN     PERIODO.ID_PERIODO%TYPE,
    O_CURSOR IN OUT G_CURSOR) IS
  BEGIN  
    OPEN O_CURSOR FOR
      SELECT ASIGNATURA_APERTURADA.ID_ASIG_APERTURADA, ASIGNATURA.NOMBRE AS ASIG_NOMBRE
      FROM ASIGNATURA_APERTURADA
      JOIN ASIGNATURA ON ASIGNATURA.ID_ASIGNATURA = ASIGNATURA_APERTURADA.ID_ASIGNATURA
      JOIN GRUPO ON GRUPO.ID_ASIG_APERTURADA = ASIGNATURA_APERTURADA.ID_ASIG_APERTURADA
      JOIN MATRICULA ON GRUPO.ID_GRUPO = MATRICULA.ID_GRUPO
      WHERE MATRICULA.ID_ALUMNO = ID_ALUM AND ASIGNATURA_APERTURADA.ID_PERIODO = PERIOD;
  END LISTAR_ASIG_AP_X_ALUMNO;
  
  procedure LISTAR_GRUPOS(
     p_IDPeriodo IN periodo.id_periodo%TYPE,
     o_cursor IN OUT g_cursor) IS
     BEGIN
        OPEN o_cursor FOR
        SELECT grupo.id_grupo AS id_grupo, grupo.numero AS grupo_numero, asignatura.nombre AS asig_nombre
        FROM grupo
        JOIN dbsegsyl.asignatura_aperturada ON ( asignatura_aperturada.ID_ASIG_APERTURADA = grupo.ID_ASIG_APERTURADA)
        JOIN dbsegsyl.asignatura ON ( asignatura.ID_ASIGNATURA = asignatura_aperturada.ID_ASIGNATURA)
        WHERE id_periodo = p_idperiodo;

    END LISTAR_GRUPOS;
  
END PAC_CURSOR;
/