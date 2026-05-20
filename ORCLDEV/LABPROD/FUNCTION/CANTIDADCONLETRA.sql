CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."CANTIDADCONLETRA" 
(
    p_Numero             Number
)
RETURN Varchar2
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    v_ImpLetra Varchar2(180);
    v_lnEntero NUMBER(10);
    v_lcRetorno VARCHAR2(512);
    v_lnTerna NUMBER(10);
    v_lcMiles VARCHAR2(512);
    v_lcCadena VARCHAR2(512);
    v_lnUnidades NUMBER(10);
    v_lnDecenas NUMBER(10);
    v_lnCentenas NUMBER(10);
    v_lnFraccion NUMBER(10);
    v_sFraccion VARCHAR2(15);
BEGIN
  v_lnEntero := TRUNC(p_Numero);
  v_lnFraccion := (p_Numero - v_lnEntero) * 100;
  v_lcRetorno := '';
  v_lnTerna := 1;
  WHILE v_lnEntero > 0
  LOOP /* WHILE */
            v_lcCadena := '';
            v_lnUnidades := MOD(v_lnEntero,10);
            v_lnEntero := TRUNC(v_lnEntero/10);
            v_lnDecenas := MOD(v_lnEntero,10);
            v_lnEntero := TRUNC(v_lnEntero/10);
            v_lnCentenas := MOD(v_lnEntero,10);
            v_lnEntero := TRUNC(v_lnEntero/10);
            SELECT
            CASE /* UNIDADES */
              WHEN v_lnUnidades = 1 THEN 'UN ' || v_lcCadena
              WHEN v_lnUnidades = 2 THEN 'DOS ' || v_lcCadena
              WHEN v_lnUnidades = 3 THEN 'TRES ' || v_lcCadena
              WHEN v_lnUnidades = 4 THEN 'CUATRO ' || v_lcCadena
              WHEN v_lnUnidades = 5 THEN 'CINCO ' || v_lcCadena
              WHEN v_lnUnidades = 6 THEN 'SEIS ' || v_lcCadena
              WHEN v_lnUnidades = 7 THEN 'SIETE ' || v_lcCadena
              WHEN v_lnUnidades = 8 THEN 'OCHO ' || v_lcCadena
              WHEN v_lnUnidades = 9 THEN 'NUEVE ' || v_lcCadena
              ELSE v_lcCadena
            END  INTO v_lcCadena FROM dual; /* UNIDADES */
            -- Analizo las decenas
            -- SQLINES LICENSE FOR EVALUATION USE ONLY
            v_lcCadena :=
            CASE /* DECENAS */
              WHEN v_lnDecenas = 1 THEN
                CASE v_lnUnidades
                  WHEN 0 THEN 'DIEZ '
                  WHEN 1 THEN 'ONCE '
                  WHEN 2 THEN 'DOCE '
                  WHEN 3 THEN 'TRECE '
                  WHEN 4 THEN 'CATORCE '
                  WHEN 5 THEN 'QUINCE '
                  WHEN 6 THEN 'DIEZ Y SEIS '
                  WHEN 7 THEN 'DIEZ Y SIETE '
                  WHEN 8 THEN 'DIEZ Y OCHO '
                  WHEN 9 THEN 'DIEZ Y NUEVE '
                END
              WHEN v_lnDecenas = 2 THEN
              CASE v_lnUnidades
                WHEN 0 THEN 'VEINTE '
                ELSE 'VEINTI' || v_lcCadena
              END
              WHEN v_lnDecenas = 3 THEN
              CASE v_lnUnidades
                WHEN 0 THEN 'TREINTA '
                ELSE 'TREINTA Y ' || v_lcCadena
              END
              WHEN v_lnDecenas = 4 THEN
                CASE v_lnUnidades
                    WHEN 0 THEN 'CUARENTA'
                    ELSE 'CUARENTA Y ' || v_lcCadena
                END
              WHEN v_lnDecenas = 5 THEN
                CASE v_lnUnidades
                    WHEN 0 THEN 'CINCUENTA '
                    ELSE 'CINCUENTA Y ' || v_lcCadena
                END
              WHEN v_lnDecenas = 6 THEN
                CASE v_lnUnidades
                    WHEN 0 THEN 'SESENTA '
                    ELSE 'SESENTA Y ' || v_lcCadena
                END
              WHEN v_lnDecenas = 7 THEN
                 CASE v_lnUnidades
                    WHEN 0 THEN 'SETENTA '
                    ELSE 'SETENTA Y ' || v_lcCadena
                 END
              WHEN v_lnDecenas = 8 THEN
                CASE v_lnUnidades
                    WHEN 0 THEN 'OCHENTA '
                    ELSE  'OCHENTA Y ' || v_lcCadena
                END
              WHEN v_lnDecenas = 9 THEN
                CASE v_lnUnidades
                    WHEN 0 THEN 'NOVENTA '
                    ELSE 'NOVENTA Y ' || v_lcCadena
                END
              ELSE v_lcCadena
            END; /* DECENAS */
            v_lcCadena :=
            CASE /* CENTENAS */
              WHEN v_lnCentenas = 1 THEN 'CIENTO ' || v_lcCadena
              WHEN v_lnCentenas = 2 THEN 'DOSCIENTOS ' || v_lcCadena
              WHEN v_lnCentenas = 3 THEN 'TRESCIENTOS ' || v_lcCadena
              WHEN v_lnCentenas = 4 THEN 'CUATROCIENTOS ' || v_lcCadena
              WHEN v_lnCentenas = 5 THEN 'QUINIENTOS ' || v_lcCadena
              WHEN v_lnCentenas = 6 THEN 'SEISCIENTOS ' || v_lcCadena
              WHEN v_lnCentenas = 7 THEN 'SETECIENTOS ' || v_lcCadena
              WHEN v_lnCentenas = 8 THEN 'OCHOCIENTOS ' || v_lcCadena
              WHEN v_lnCentenas = 9 THEN 'NOVECIENTOS ' || v_lcCadena
              ELSE v_lcCadena
            END; /* CENTENAS */
            v_lcCadena :=
            CASE /* TERNA */
              WHEN v_lnTerna = 1 THEN v_lcCadena
              WHEN v_lnTerna = 2 THEN v_lcCadena || 'MIL '
              WHEN v_lnTerna = 3 THEN v_lcCadena || 'MILLONES '
              WHEN v_lnTerna = 4 THEN v_lcCadena || 'MIL '
              ELSE ''
            END; /* TERNA */
            v_lcRetorno := v_lcCadena  || v_lcRetorno;
v_lnTerna := v_lnTerna + 1;
   END LOOP; /* WHILE */
   IF v_lnTerna = 1 THEN
       v_lcRetorno := 'CERO';
   END IF;
   v_sFraccion := '00' || LTRIM(TO_CHAR(v_lnFraccion));
   -- SQLINES LICENSE FOR EVALUATION USE ONLY
   v_ImpLetra := RTRIM(v_lcRetorno) || ' PESOS ' || SUBSTR(v_sFraccion,LENGTH(RTRIM(v_sFraccion))-1,2) || '/100 M.N.';
   RETURN v_ImpLetra;
END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."CANTIDADCONLETRA" 
(
    p_Numero             Number
)
RETURN Varchar2
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    v_ImpLetra Varchar2(180);
    v_lnEntero NUMBER(10);
    v_lcRetorno VARCHAR2(512);
    v_lnTerna NUMBER(10);
    v_lcMiles VARCHAR2(512);
    v_lcCadena VARCHAR2(512);
    v_lnUnidades NUMBER(10);
    v_lnDecenas NUMBER(10);
    v_lnCentenas NUMBER(10);
    v_lnFraccion NUMBER(10);
    v_sFraccion VARCHAR2(15);
BEGIN
  v_lnEntero := TRUNC(p_Numero);
  v_lnFraccion := (p_Numero - v_lnEntero) * 100;
  v_lcRetorno := '';
  v_lnTerna := 1;
  WHILE v_lnEntero > 0
  LOOP /* WHILE */
            v_lcCadena := '';
            v_lnUnidades := MOD(v_lnEntero,10);
            v_lnEntero := TRUNC(v_lnEntero/10);
            v_lnDecenas := MOD(v_lnEntero,10);
            v_lnEntero := TRUNC(v_lnEntero/10);
            v_lnCentenas := MOD(v_lnEntero,10);
            v_lnEntero := TRUNC(v_lnEntero/10);
            SELECT
            CASE /* UNIDADES */
              WHEN v_lnUnidades = 1 THEN 'UN ' || v_lcCadena
              WHEN v_lnUnidades = 2 THEN 'DOS ' || v_lcCadena
              WHEN v_lnUnidades = 3 THEN 'TRES ' || v_lcCadena
              WHEN v_lnUnidades = 4 THEN 'CUATRO ' || v_lcCadena
              WHEN v_lnUnidades = 5 THEN 'CINCO ' || v_lcCadena
              WHEN v_lnUnidades = 6 THEN 'SEIS ' || v_lcCadena
              WHEN v_lnUnidades = 7 THEN 'SIETE ' || v_lcCadena
              WHEN v_lnUnidades = 8 THEN 'OCHO ' || v_lcCadena
              WHEN v_lnUnidades = 9 THEN 'NUEVE ' || v_lcCadena
              ELSE v_lcCadena
            END  INTO v_lcCadena FROM dual; /* UNIDADES */
            -- Analizo las decenas
            -- SQLINES LICENSE FOR EVALUATION USE ONLY
            v_lcCadena :=
            CASE /* DECENAS */
              WHEN v_lnDecenas = 1 THEN
                CASE v_lnUnidades
                  WHEN 0 THEN 'DIEZ '
                  WHEN 1 THEN 'ONCE '
                  WHEN 2 THEN 'DOCE '
                  WHEN 3 THEN 'TRECE '
                  WHEN 4 THEN 'CATORCE '
                  WHEN 5 THEN 'QUINCE '
                  WHEN 6 THEN 'DIEZ Y SEIS '
                  WHEN 7 THEN 'DIEZ Y SIETE '
                  WHEN 8 THEN 'DIEZ Y OCHO '
                  WHEN 9 THEN 'DIEZ Y NUEVE '
                END
              WHEN v_lnDecenas = 2 THEN
              CASE v_lnUnidades
                WHEN 0 THEN 'VEINTE '
                ELSE 'VEINTI' || v_lcCadena
              END
              WHEN v_lnDecenas = 3 THEN
              CASE v_lnUnidades
                WHEN 0 THEN 'TREINTA '
                ELSE 'TREINTA Y ' || v_lcCadena
              END
              WHEN v_lnDecenas = 4 THEN
                CASE v_lnUnidades
                    WHEN 0 THEN 'CUARENTA'
                    ELSE 'CUARENTA Y ' || v_lcCadena
                END
              WHEN v_lnDecenas = 5 THEN
                CASE v_lnUnidades
                    WHEN 0 THEN 'CINCUENTA '
                    ELSE 'CINCUENTA Y ' || v_lcCadena
                END
              WHEN v_lnDecenas = 6 THEN
                CASE v_lnUnidades
                    WHEN 0 THEN 'SESENTA '
                    ELSE 'SESENTA Y ' || v_lcCadena
                END
              WHEN v_lnDecenas = 7 THEN
                 CASE v_lnUnidades
                    WHEN 0 THEN 'SETENTA '
                    ELSE 'SETENTA Y ' || v_lcCadena
                 END
              WHEN v_lnDecenas = 8 THEN
                CASE v_lnUnidades
                    WHEN 0 THEN 'OCHENTA '
                    ELSE  'OCHENTA Y ' || v_lcCadena
                END
              WHEN v_lnDecenas = 9 THEN
                CASE v_lnUnidades
                    WHEN 0 THEN 'NOVENTA '
                    ELSE 'NOVENTA Y ' || v_lcCadena
                END
              ELSE v_lcCadena
            END; /* DECENAS */
            v_lcCadena :=
            CASE /* CENTENAS */
              WHEN v_lnCentenas = 1 THEN 'CIENTO ' || v_lcCadena
              WHEN v_lnCentenas = 2 THEN 'DOSCIENTOS ' || v_lcCadena
              WHEN v_lnCentenas = 3 THEN 'TRESCIENTOS ' || v_lcCadena
              WHEN v_lnCentenas = 4 THEN 'CUATROCIENTOS ' || v_lcCadena
              WHEN v_lnCentenas = 5 THEN 'QUINIENTOS ' || v_lcCadena
              WHEN v_lnCentenas = 6 THEN 'SEISCIENTOS ' || v_lcCadena
              WHEN v_lnCentenas = 7 THEN 'SETECIENTOS ' || v_lcCadena
              WHEN v_lnCentenas = 8 THEN 'OCHOCIENTOS ' || v_lcCadena
              WHEN v_lnCentenas = 9 THEN 'NOVECIENTOS ' || v_lcCadena
              ELSE v_lcCadena
            END; /* CENTENAS */
            v_lcCadena :=
            CASE /* TERNA */
              WHEN v_lnTerna = 1 THEN v_lcCadena
              WHEN v_lnTerna = 2 THEN v_lcCadena || 'MIL '
              WHEN v_lnTerna = 3 THEN v_lcCadena || 'MILLONES '
              WHEN v_lnTerna = 4 THEN v_lcCadena || 'MIL '
              ELSE ''
            END; /* TERNA */
            v_lcRetorno := v_lcCadena  || v_lcRetorno;
v_lnTerna := v_lnTerna + 1;
   END LOOP; /* WHILE */
   IF v_lnTerna = 1 THEN
       v_lcRetorno := 'CERO';
   END IF;
   v_sFraccion := '00' || LTRIM(TO_CHAR(v_lnFraccion));
   -- SQLINES LICENSE FOR EVALUATION USE ONLY
   v_ImpLetra := RTRIM(v_lcRetorno) || ' PESOS ' || SUBSTR(v_sFraccion,LENGTH(RTRIM(v_sFraccion))-1,2) || '/100 M.N.';
   RETURN v_ImpLetra;
END;
/
