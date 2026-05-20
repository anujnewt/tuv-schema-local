CREATE OR REPLACE NONEDITIONABLE PACKAGE "LABPROD"."PKG_PROTELE_SV_VALIDA" 
IS
FUNCTION Sv_Solvac_Ban(User_Vacsol IN VARCHAR2, Num_Vacdep IN INTEGER) RETURN INTEGER;
FUNCTION Sv_fec_aux(num_empleado  IN INTEGER) RETURN VARCHAR2;
FUNCTION sv_emp_keyloc(p_num_emp IN INTEGER) RETURN INTEGER;
FUNCTION sv_dia_festivo (p_fecha IN VARCHAR2) RETURN INTEGER;
FUNCTION Sv_Usuario_Aut(num IN INTEGER,ban_solvac IN INTEGER,user_Vacsol IN VARCHAR2) RETURN VARCHAR2;
FUNCTION Sv_Status_Sol( Num IN INTEGER) RETURN INTEGER;
FUNCTION Sv_Usuario_Red( Num IN INTEGER) RETURN Varchar2;
FUNCTION sv_per_dis( num IN INTEGER) RETURN INTEGER;
FUNCTION sv_per3_vac(num IN INTEGER) RETURN INTEGER;
PROCEDURE Sv_Insert_Per( Num_Emp  In Integer);
PROCEDURE sv_alm_temp(numero IN INTEGER,dias IN NUMBER,status IN VARCHAR2,inicio IN VARCHAR2,fin IN VARCHAR2,auto_ IN INTEGER,per IN INTEGER);
END Pkg_Protele_Sv_Valida;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "LABPROD"."PKG_PROTELE_SV_VALIDA" 
AS
FUNCTION Sv_Solvac_Ban(
    user_Vacsol IN VARCHAR2,
    Num_Vacdep  IN INTEGER)
  RETURN INTEGER
IS
  vacsol INTEGER;
BEGIN
  SELECT 1
  INTO vacsol
  FROM Solvacnoper
  WHERE 1         =1
  AND Emp_Vacdep  = Num_Vacdep
  AND Emp_Vacsol IN
    (SELECT Emp_Keyemp FROM Mail WHERE lower(Usuario) = lower(user_Vacsol)
    );
  RETURN vacsol;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  RETURN 0;
END;
FUNCTION Sv_fec_aux(num_empleado  IN INTEGER) RETURN VARCHAR2
IS
  v_fec_aux VARCHAR2(30);
BEGIN
  SELECT TO_CHAR (emp_fecaux, 'DD-MON-RRRR')
    INTO v_fec_aux
    FROM Nmcoempl
   WHERE emp_Keyemp = num_empleado;
  RETURN v_fec_aux;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  RETURN NULL;
END;
FUNCTION sv_emp_keyloc(p_num_emp IN INTEGER) RETURN INTEGER
IS
  v_emp_keyloc INTEGER;
BEGIN
  SELECT emp_keyloc
    INTO v_emp_keyloc
    FROM NMCOEMPL
   WHERE emp_keyemp = p_num_emp;
  RETURN v_emp_keyloc;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  RETURN 0;
END;
FUNCTION sv_dia_festivo (p_fecha IN VARCHAR2) RETURN INTEGER
  IS
  v_existe INTEGER;
  begin
        select  1
          into v_existe
          from DIAS_FESTIVOS
         where 1=1
           and to_char(fecha,'DD/MM/RRRR') = p_fecha;
        return  1;
     exception
        when NO_DATA_FOUND then
            return 0;
  end;
FUNCTION sv_usuario_aut(
    num         IN INTEGER,
    ban_solvac  IN INTEGER,
    user_Vacsol IN VARCHAR2)
  RETURN VARCHAR2
IS
  ger_auto1 INTEGER;
  num_auto1 INTEGER;
  num_auto2 INTEGER;
  num_auto3 INTEGER;
  user_red  VARCHAR2(30):='NO EXISTE';
BEGIN
  BEGIN
    SELECT DISTINCT(plz_cverem)
      INTO num_auto1
      FROM eocoplza
     WHERE plz_keyemp  = num;
 EXCEPTION
      WHEN NO_DATA_FOUND THEN
    RETURN 'No hay datos';
  END;
  BEGIN
    SELECT
      CASE
        WHEN PUE_DESPUE LIKE '%DIR%'
        THEN '4'
        WHEN PUE_DESPUE LIKE '%COORD%'
        THEN '3'
        WHEN PUE_DESPUE LIKE '%GTE%'
        THEN '2'
        ELSE '1'
      END
    INTO ger_auto1
    FROM nmcopues,
      eocoplza
    WHERE plz_keypue = pue_keypue
    AND PLZ_KEYEMP   = num_auto1;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'No hay datos';
  END;
  BEGIN
    SELECT plz_cverem INTO num_auto2 FROM Eocoplza WHERE Plz_Keyemp = num_auto1;
    DBMS_OUTPUT.PUT_LINE('num_auto2:' || num_auto2);
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'No hay datos';
  END;
  IF ban_solvac  = 1 THEN
    IF ger_auto1 = 1 THEN
      SELECT Usuario INTO user_red FROM Mail WHERE Emp_Keyemp = num_auto2;
      DBMS_OUTPUT.PUT_LINE('user_red:' || user_red);
      RETURN user_red;
    ELSE
      SELECT Usuario INTO user_red FROM Mail WHERE Emp_Keyemp = num_auto1;
      DBMS_OUTPUT.PUT_LINE('user_red:' || user_red);
      RETURN user_red;
    END IF;
  ELSE
  BEGIN
       SELECT emp_autori
        INTO num_auto3
        FROM Solvacnoper
        WHERE 1         =1
        AND Emp_Vacdep  = num
        AND Emp_Vacsol IN
          (SELECT Emp_Keyemp FROM Mail WHERE lower(Usuario) = lower(user_Vacsol)
          );
        EXCEPTION
       WHEN NO_DATA_FOUND THEN
        RETURN 'No hay datos';
   END;
    DBMS_OUTPUT.PUT_LINE('num_auto3:' || num_auto3);
    SELECT Usuario INTO user_red FROM Mail WHERE Emp_Keyemp = num_auto3;
    DBMS_OUTPUT.PUT_LINE('user_red:' || user_red);
    RETURN user_red;
  END IF;
END;
FUNCTION sv_status_sol(
    num IN INTEGER)
  RETURN INTEGER
IS
  n_existe INTEGER;
BEGIN
  SELECT COUNT(*)
  INTO n_existe
  FROM Svtempsc
  WHERE Num_Emp = num
  AND STA_SOL  IN ('A','P');
  RETURN n_existe;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  RETURN 0;
END;
FUNCTION sv_usuario_red(
    num IN INTEGER)
  RETURN VARCHAR2
IS
  user_red VARCHAR2(30);
BEGIN
  SELECT usuario INTO user_red FROM mail WHERE Emp_Keyemp = num;
  RETURN user_red;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  RETURN 'No hay datos';
END;
FUNCTION sv_per_dis(
    num IN INTEGER)
  RETURN INTEGER
IS
  n_existe INTEGER;
  n_ant    INTEGER;
BEGIN
  BEGIN
    SELECT ROUND(SYSDATE - emp_fecaux,0)
    INTO n_ant
    FROM Nmcoempl
    WHERE Emp_Keyemp = num;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
  END;
  IF n_ant >= 365 THEN
    BEGIN
      SELECT COUNT(*)
      INTO n_existe
      FROM nmcocvac
      WHERE Vac_Keyemp      = num
      AND YEAR(Vac_Fecfin) >= YEAR(SYSDATE)-1
      AND Vac_Status        = 'V'
      AND Vac_Diavac        > 0;
      RETURN n_existe;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 0;
    END;
  ELSE
    RETURN 0;
  END IF;
END;
FUNCTION sv_per3_vac(
    num IN INTEGER)
  RETURN INTEGER
IS
  n_existe INTEGER;
  max_periodo integer;
BEGIN
      EXECUTE IMMEDIATE
        'ALTER SESSION SET NLS_DATE_FORMAT=''DD/MM/RR''';
      BEGIN
       SELECT MAX(vac_antigu)
         INTO max_periodo
         FROM nmcocvac
        WHERE 1=1
          AND Vac_Keyemp      = num;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
             max_periodo := 0;
      END;
      BEGIN
          SELECT COUNT(*)
          INTO n_existe
          FROM nmcocvac
          WHERE 1=1
          AND vac_salper      = 0
          AND vac_Keyemp      = num
          AND vac_antigu      = max_periodo
          AND vac_status='V'
          AND to_char(sysdate,'DD/MM/RR') > add_months(TO_CHAR (vac_fecfin,'DD/MM/RR'),-3);
          RETURN n_existe;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RETURN 0;
      END;
 END;
PROCEDURE Sv_insert_per(
    num_emp IN INTEGER)
IS
  num_r_insertados   INTEGER;
  n_meses_expiracion INTEGER;
  ckeycon            CHAR(3);
  n_keyemp           INTEGER;
  n_anio_trabajados  INTEGER;
  n_annio_proceso    INTEGER;
  n_mes_proceso      INTEGER;
  n_dia_proceso      INTEGER;
  n_keypro           INTEGER;
  n_annio_proc_ant   INTEGER;
  n_confianza        INTEGER;
  d_fecha_ingreso    DATE;
  c_keydep           CHAR(16);
  c_keypue           CHAR(16);
  c_periodo          CHAR(9);
  c_tab_vacaciones   CHAR(3);
  n_r_anio_trab      INTEGER;
  n_dias_vacaciones  INTEGER;
  d_f_expiracion     DATE;
  d_fecha_calculo    DATE;
  d_fecha_calculo1   DATE;
  d_fecha_calculo2   DATE;
  n_existe           INTEGER;
  p_adj_days         INTEGER;
  ws_vac_status      CHAR(02);
  wd_vac_salper      DECIMAL(10,2);
  nagnostrab         DECIMAL(12,6);
  idiasvac           DECIMAL(16,2);
  dfecini            DATE;
  dfecnow            DATE;
  nkeyemp            INTEGER;
  nkeypro            INTEGER;
  ckeydep            CHAR(16);
  ckeypue            CHAR(16);
  o_num_r_insertados INTEGER;
BEGIN
  num_r_insertados   := 0; -- o_num_r_insertados out integer
  n_meses_expiracion := 6;
  ckeycon            := '607'; ---  el numero de concepto para la actualizacion de datos fijos.
  ----Obtengo parametros de acuerdo al numero de empleado
  SELECT YEAR(SYSDATE) - YEAR(emp_fecaux),
    YEAR(SYSDATE) - 1
    || '-'
    || YEAR(SYSDATE),
    YEAR(SYSDATE),
    MONTH(emp_fecaux),
    DAY(emp_fecaux),
    emp_keypro,
    YEAR(SYSDATE) - 1,
    emp_tipemp,
    emp_fecaux,
    emp_keydep,
    emp_Keypue
  INTO n_anio_trabajados,
    c_periodo,
    n_annio_proceso,
    n_mes_proceso,
    n_dia_proceso,
    n_keypro,
    n_annio_proc_ant,
    n_confianza,
    d_fecha_ingreso,
    C_Keydep,
    c_keypue
  FROM nmcoempl
  WHERE emp_status = 1
  AND emp_keyemp   = num_emp;
  ---------------------Se valida que la fecha de proceso NO sea biciesto-------------------------------------------
  IF n_mes_proceso = 2 AND n_dia_proceso = 29 THEN
    n_dia_proceso := 28;
  END IF;
  --------------------Obtengo la tabla que le corresponde para la obtencion de las vacaciones---------------------
  BEGIN
    SELECT pam_folfin
    INTO c_tab_vacaciones
    FROM glcopams
    WHERE pam_keypar = 'TTV'
    AND pam_nompar   = 'TABLA DE VACACIONES'
    AND pam_cvesec   = TO_CHAR(n_keypro);
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    NULL;
  END;
  -------------------Obtengo el rango de a?os trabajados en el que cae el empleado---------------------------------
  BEGIN
    SELECT MIN(tab_eledos)
    INTO n_r_anio_trab
    FROM nmlotabn
    WHERE tab_keytab= TRIM(c_tab_vacaciones)
    AND tab_eledos >= n_anio_trabajados
    ORDER BY tab_eledos;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    NULL;
  END;
  --------------------Valido si el empleado es de confianza (1) o NO (2)-------------------------------------------
  IF n_confianza = 2 THEN
    SELECT DISTINCT tab_elecua
    INTO n_dias_vacaciones
    FROM nmlotabn
    WHERE tab_keytab = TRIM(c_tab_vacaciones)
    AND tab_eledos   = n_r_anio_trab;
  ELSE
    -----Obtengo los dias que le corresponden de vacaciones-------
    SELECT DISTINCT tab_eletre
    INTO n_dias_vacaciones
    FROM nmlotabn
    WHERE tab_keytab      = TRIM(c_tab_vacaciones)
    AND tab_eledos        = n_r_anio_trab;
    IF n_dias_vacaciones IS NULL THEN
      n_anio_trabajados  := n_anio_trabajados + '.000002';
    END IF;
  END IF;
  -----------------------------Armo la fecha para poder calcular la fecha de expiracion-----------------------------
  d_fecha_calculo  := to_date(TO_CHAR(n_dia_proceso) || '/' || TO_CHAR(n_mes_proceso) || '/' || TO_CHAR(n_annio_proceso), 'dd/mm/yyyy');
  d_fecha_calculo2 := to_date(TO_CHAR(n_dia_proceso) || '/' || TO_CHAR(n_mes_proceso) || '/' || TO_CHAR(n_annio_proceso + 1), 'dd/mm/yyyy');
  d_fecha_calculo1 := d_fecha_calculo2                                                                                  - 1;
  ----------Lo meto en un ciclo para validar que sea una fecha valida, ya que la fecha pudiera se invalida.--------
  d_f_expiracion := add_months(d_fecha_calculo1, n_meses_expiracion);
  --------------Verifico que el empleado NO tenga ya calculado su periodo de vacaciones para el periodo------------
      BEGIN
         SELECT count(*)
           INTO n_existe
           FROM nmcocvac
          WHERE vac_keyemp = num_emp
            AND vac_period   = c_periodo;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             n_existe  := 0;
      END;
  IF n_existe  = 0  THEN
     BEGIN
              INSERT
              INTO nmcocvac
                (
                  vac_keyemp,
                  vac_antigu,
                  vac_diavac,
                  vac_period,
                  vac_fecini,
                  vac_fecfin,
                  vac_fecpre,
                  vac_dtomad,
                  vac_salper,
                  vac_status,
                  vac_cosrea
                )
                VALUES
                (
                  num_emp,
                  n_anio_trabajados,
                  n_dias_vacaciones,
                  c_periodo,
                  d_fecha_calculo,
                  d_fecha_calculo1,
                  d_f_expiracion,
                  0,
                  n_dias_vacaciones,
                  'V',
                  0
                );
              COMMIT;
              o_num_r_insertados := num_r_insertados + 1;
               EXCEPTION
              WHEN OTHERS THEN
              NULL;
     END;
   ELSE
     SELECT (YEAR(SYSDATE)+1) - YEAR(emp_fecaux),
            YEAR(SYSDATE)
            || '-'
            || (YEAR(SYSDATE) +1),
            (YEAR(SYSDATE) +1),
            MONTH(emp_fecaux),
            DAY(emp_fecaux),
            emp_keypro,
            YEAR(SYSDATE),
            emp_tipemp,
            emp_fecaux,
            emp_keydep,
            emp_Keypue
          INTO n_anio_trabajados,
            c_periodo,
            n_annio_proceso,
            n_mes_proceso,
            n_dia_proceso,
            n_keypro,
            n_annio_proc_ant,
            n_confianza,
            d_fecha_ingreso,
            C_Keydep,
            c_keypue
          FROM nmcoempl
          WHERE emp_status = 1
          AND emp_keyemp   = num_emp;
                   ---------------------Se valida que la fecha de proceso NO sea biciesto-------------------------------------------
          IF n_mes_proceso = 2 AND n_dia_proceso = 29 THEN
            n_dia_proceso := 28;
          END IF;
          --------------------Obtengo la tabla que le corresponde para la obtencion de las vacaciones---------------------
          BEGIN
            SELECT pam_folfin
            INTO c_tab_vacaciones
            FROM glcopams
            WHERE pam_keypar = 'TTV'
            AND pam_nompar   = 'TABLA DE VACACIONES'
            AND pam_cvesec   = TO_CHAR(n_keypro);
          EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
          END;
          -------------------Obtengo el rango de a?os trabajados en el que cae el empleado---------------------------------
          BEGIN
            SELECT MIN(tab_eledos)
            INTO n_r_anio_trab
            FROM nmlotabn
            WHERE tab_keytab= TRIM(c_tab_vacaciones)
            AND tab_eledos >= n_anio_trabajados
            ORDER BY tab_eledos;
          EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
          END;
          --------------------Valido si el empleado es de confianza (1) o NO (2)-------------------------------------------
          IF n_confianza = 2 THEN
            SELECT DISTINCT tab_elecua
            INTO n_dias_vacaciones
            FROM nmlotabn
            WHERE tab_keytab = TRIM(c_tab_vacaciones)
            AND tab_eledos   = n_r_anio_trab;
          ELSE
            -----Obtengo los dias que le corresponden de vacaciones-------
            SELECT DISTINCT tab_eletre
            INTO n_dias_vacaciones
            FROM nmlotabn
            WHERE tab_keytab      = TRIM(c_tab_vacaciones)
            AND tab_eledos        = n_r_anio_trab;
            IF n_dias_vacaciones IS NULL THEN
              n_anio_trabajados  := n_anio_trabajados + '.000002';
            END IF;
          END IF;
          -----------------------------Armo la fecha para poder calcular la fecha de expiracion-----------------------------
          d_fecha_calculo  := to_date(TO_CHAR(n_dia_proceso) || '/' || TO_CHAR(n_mes_proceso) || '/' || TO_CHAR(n_annio_proceso), 'dd/mm/yyyy');
          d_fecha_calculo2 := to_date(TO_CHAR(n_dia_proceso) || '/' || TO_CHAR(n_mes_proceso) || '/' || TO_CHAR(n_annio_proceso + 1), 'dd/mm/yyyy');
          d_fecha_calculo1 := d_fecha_calculo2                                                                                  - 1;
          ----------Lo meto en un ciclo para validar que sea una fecha valida, ya que la fecha pudiera se invalida.--------
          d_f_expiracion := add_months(d_fecha_calculo1, n_meses_expiracion);
         BEGIN
              INSERT
              INTO nmcocvac
                (
                  vac_keyemp,
                  vac_antigu,
                  vac_diavac,
                  vac_period,
                  vac_fecini,
                  vac_fecfin,
                  vac_fecpre,
                  vac_dtomad,
                  vac_salper,
                  vac_status,
                  vac_cosrea
                )
                VALUES
                (
                  num_emp,
                  n_anio_trabajados,
                  n_dias_vacaciones,
                  c_periodo,
                  d_fecha_calculo,
                  d_fecha_calculo1,
                  d_f_expiracion,
                  0,
                  n_dias_vacaciones,
                  'V',
                  0
                );
              COMMIT;
              o_num_r_insertados := num_r_insertados + 1;
               EXCEPTION
              WHEN OTHERS THEN
              NULL;
     END;
  END IF;
 COMMIT;
  --Actualizo el estatus a expirado (E) a todos los registros que su fecha de expiracion sea menor a la fecha de proceso
UPDATE nmcocvac SET vac_status = 'E'
WHERE TO_CHAR(vac_fecpre,'RR/MM/DD') <= TO_CHAR(sysdate,'RR/MM/DD')
AND vac_status = 'V';
COMMIT;
  DBMS_OUTPUT.PUT_LINE('Parametros periodo:  ');
  DBMS_OUTPUT.PUT_LINE('P1:  '||num_emp);
  Dbms_Output.Put_Line('P2:  '||n_anio_trabajados);
  Dbms_Output.Put_Line('P3:  '||n_dias_vacaciones);
  DBMS_OUTPUT.PUT_LINE('P4:  '||c_periodo);
  DBMS_OUTPUT.PUT_LINE('P5:  '||d_fecha_calculo);
  DBMS_OUTPUT.PUT_LINE('P6:  '||d_fecha_calculo1);
  Dbms_Output.Put_Line('P7:  '||d_f_expiracion);
  Dbms_Output.Put_Line('P8:  '||0);
  Dbms_Output.Put_Line('P9:  '||n_dias_vacaciones);
  Dbms_Output.Put_Line('P10:  '||'V');
  DBMS_OUTPUT.PUT_LINE('P11:  '||0);
  DBMS_OUTPUT.PUT_LINE('o_num_r_insertados:  '||o_num_r_insertados);
  DBMS_OUTPUT.PUT_LINE('Count Periodo:  '||n_existe);
END;
PROCEDURE sv_alm_temp
  (
    numero IN INTEGER,
    dias   IN NUMBER,
    status IN VARCHAR2,
    inicio IN VARCHAR2,
    fin    IN VARCHAR2,
    auto_  IN INTEGER,
    per IN INTEGER
    --fec_act IN VARCHAR2
  )
IS
  oper          INTEGER;
  moper         INTEGER;
  aux           INTEGER;
  antigu        INTEGER;
  anti          INTEGER;
  consec        INTEGER;
  numd          NUMBER(6,2);
  tdias         NUMBER (6,2);
  perm          VARCHAR2(10);
  nomb          VARCHAR2(60);
  Period        VARCHAR2(10);
  tipo          VARCHAR2(5);
  dias_temp     DECIMAL;
  numTemp       INTEGER;
  periodTemp    VARCHAR2(10);
  autoTemp      INTEGER;
  aux_Temp      INTEGER;
  permTemp      VARCHAR2(10);
  o_act_estatus INTEGER;
  dias_dsp      INTEGER;  -- VARIABLE UTILIZADA PARA ONTENER LOS DIAS DISPONIBLES DEL PERIODO MAS ANTIGUO
  dias_dsp2      INTEGER;  -- VARIABLE UTILIZADA PARA ONTENER LOS DIAS DISPONIBLES DEL PERIODO MAS NUEVO
  ---CURSOR 1 Id Operaci??n m?!ximo
  CURSOR temporal
  IS
    (SELECT MAX(id_ope)+1, MAX(con_emp) +1, COUNT( *) FROM SVTEMPSC
    )
  ;
  ---CURSOR 2  Id de Operaciones pendientes
  CURSOR temporal_2 (numTemp IN INTEGER)
  IS
    (SELECT DISTINCT(id_ope)
    FROM SVTEMPSC
    WHERE SVTEMPSC.num_emp = numTemp
    AND SVTEMPSC.sta_sol   = 'P'
    );
  ---CURSOR 3 Periodo m?-nimo
  CURSOR temporal_3 (numTemp IN INTEGER)
  IS
    (SELECT MIN(vac_period)
    FROM NMCOCVAC
    WHERE vac_status = 'V'
    AND vac_keyemp   = numTemp
    )
  ;
  ---CURSOR 4
  CURSOR temporal_4 (numTemp IN INTEGER, periodTemp IN VARCHAR2)
  IS
    (SELECT vac_antigu
    FROM NMCOCVAC
    WHERE vac_status = 'V'
    AND vac_keyemp   = numTemp
    AND vac_period   = periodTemp
    )
  ;
  ---CURSOR 5
  CURSOR temporal_5 (numTemp IN INTEGER)
  IS
    (SELECT MAX(vac_period)
    FROM NMCOCVAC
    WHERE vac_status = 'V'
    AND vac_keyemp   = numTemp
    )
  ;
  ---CURSOR 6
  CURSOR temporal_6 (numTemp IN INTEGER, periodTemp IN VARCHAR2)
  IS
    (SELECT vac_antigu
    FROM NMCOCVAC
    WHERE vac_status = 'V'
    AND vac_keyemp   = numTemp
    AND vac_period   = periodTemp
    )
  ;
  ---CURSOR 7
  CURSOR temporal_7 (numTemp IN INTEGER, periodTemp IN VARCHAR2)
  IS
    (SELECT vac_dtomad
    FROM NMCOCVAC
    WHERE NMCOCVAC.vac_keyemp = numTemp
    AND NMCOCVAC.vac_period   = periodTemp
    )
  ;
  ---CURSOR 8
  CURSOR temporal_8 (auto_ IN INTEGER)
  IS
    ( SELECT emp_nomemp FROM NMCOEMPL WHERE emp_keyemp = auto_
    )
  ;
  ---CURSOR 9
  CURSOR temporal_9 (numTemp IN INTEGER)
  IS
    (SELECT num_dia,
      per_vac
    FROM SVTEMPSC
    WHERE SVTEMPSC.num_emp = numTemp
    AND SVTEMPSC.sta_sol   = 'A'
    )
  ;
  ---CURSOR 10
  CURSOR temporal_10 (numTemp IN INTEGER, perm IN VARCHAR2)
  IS
    (SELECT vac_salper
    FROM NMCOCVAC
    WHERE vac_status = 'V'
    AND vac_keyemp   = numTemp
    AND vac_period   = trim(perm)
    )
  ;
BEGIN
  --Inicia cursor 1: Obtiene Id Operaci??n m?!ximo
  OPEN temporal;
  FETCH temporal INTO oper, consec, moper;
  CLOSE temporal;
  IF moper  = 0 THEN
    consec := 1000;
    oper   := 1000;
  END IF;
  --dbms_output.put_line('VARIABLE consec 2 despues del 1er If:' || consec);
  --dbms_output.put_line('VARIABLE oper 2 despues del 1er If:' || oper);
  --Termina cursor 1
  --inicia cursor 2
  OPEN temporal_2 (numero);
  FETCH temporal_2 INTO aux;
  CLOSE temporal_2;
  --dbms_output.put_line('VARIABLE AUX 1 despues segundo select:' || aux);
  IF aux  > 0 THEN
    oper := aux;
  END IF;
  --dbms_output.put_line('VARIABLE oper 3 despues del 2do If:' || oper);
  --termina curso 2
  tipo          := 'S';
  o_act_estatus := 0;
  IF status      = 'P' THEN
    SELECT VAC_PERIOD
          ,VAC_SALPER
    INTO period, dias_dsp FROM (
                             SELECT VAC_PERIOD
                                  , VAC_SALPER
                             FROM NMCOCVAC
                             WHERE vac_status = 'V'
                             AND vac_keyemp   = numero
                             AND vac_salper > 0
                             ORDER BY VAC_PERIOD ASC)
    WHERE ROWNUM = 1;
    OPEN temporal_4(numero, period);
    FETCH temporal_4 INTO antigu;
    CLOSE temporal_4;
    DBMS_OUTPUT.PUT_LINE('Periodo: ' || period || ' Dias disponibles: ' || dias_dsp);
    IF (dias_dsp < dias) THEN -- En caso de que el periodo mas antiguo no tenga los suficientes dias
    DBMS_OUTPUT.PUT_LINE('Dias no suficientes' || dias_dsp || ' < ' || dias);
       -- Se inserta los dias para los que alcanza el periodo
      INSERT INTO SVTEMPSC
      (
        id_ope,
        num_emp,
        num_dia,
        tipo_sol,
        sta_sol,
        dia_ini,
        dia_fin,
        per_vac,
        ant_emp,
        fec_sol,
        con_emp
      )
      VALUES
      (
        oper,
        numero,
        dias_dsp,
        tipo,
        status,
        to_date(inicio,'DD/MM/YYYY'),
        to_date(fin,'DD/MM/YYYY'),
        period,
        antigu,
        SYSDATE,
        consec
      );
      BEGIN
      SELECT VAC_PERIOD   -- Se busca el siguiemte periodo para insertr los dias soliciatdos que faltan por cubrir
            ,VAC_SALPER
      INTO period, dias_dsp2
      FROM NMCOCVAC
      WHERE vac_status = 'V'
      AND vac_keyemp   = numero
      AND vac_salper > 0
      AND vac_period <> period;
      EXCEPTION WHEN NO_DATA_FOUND THEN
          period:= ' ';
          dias_dsp2 := 0;
      END;
      DBMS_OUTPUT.PUT_LINE('Periodo: ' || period);
      DBMS_OUTPUT.PUT_LINE('Dias: ' || dias  || ' dias_dsp: ' || dias_dsp || ' dias_dsp2: ' || dias_dsp2);
      IF ((period != ' ') AND (dias - dias_dsp) <= dias_dsp2) THEN
      DBMS_OUTPUT.PUT_LINE('Segundo periodo: ' || (dias - dias_dsp) || ' <= ' || dias_dsp2);
          OPEN temporal_4(numero, period);
          FETCH temporal_4 INTO antigu;
          CLOSE temporal_4;
          INSERT INTO SVTEMPSC(
                            id_ope,
                            num_emp,
                            num_dia,
                            tipo_sol,
                            sta_sol,
                            dia_ini,
                            dia_fin,
                            per_vac,
                            ant_emp,
                            fec_sol,
                            con_emp
                          )
          VALUES              (
                            oper,
                            numero,
                            (dias - dias_dsp),
                            tipo,
                            status,
                            to_date(inicio,'DD/MM/YYYY'),
                            to_date(fin,'DD/MM/YYYY'),
                            period,
                            antigu,
                            SYSDATE,
                            consec);
          COMMIT;
      ELSE
          DBMS_OUTPUT.PUT_LINE('Rollback');
          ROLLBACK;
      END IF;
    ELSE
       DBMS_OUTPUT.PUT_LINE('Dias sufucientes ' || dias_dsp || ' >= ' || dias);
        INSERT INTO SVTEMPSC
      (
        id_ope,
        num_emp,
        num_dia,
        tipo_sol,
        sta_sol,
        dia_ini,
        dia_fin,
        per_vac,
        ant_emp,
        fec_sol,
        con_emp
      )
      VALUES
      (
        oper,
        numero,
        dias,
        tipo,
        status,
        to_date(inicio,'DD/MM/YYYY'),
        to_date(fin,'DD/MM/YYYY'),
        period,
        antigu,
        SYSDATE,
        consec
      );
    COMMIT;
    END IF;
    o_act_estatus := 1;
    --DBMS_OUTPUT.PUT_LINE('Parametros insert Hist??rico:  ');
    --DBMS_OUTPUT.PUT_LINE('# de Operaci??n:  '||oper);
    --Dbms_Output.Put_Line('# empleado:  '||numero);
    --Dbms_Output.Put_Line('# de d?-as:  '||dias);
    --DBMS_OUTPUT.PUT_LINE('Tipo Solicitud:  '||tipo);
    --DBMS_OUTPUT.PUT_LINE('Estatus solicitud:  '||status);
    --DBMS_OUTPUT.PUT_LINE('Periodo:  '||period);
    --Dbms_Output.Put_Line('Antigu:  '||antigu);
    --Dbms_Output.Put_Line('Fecha inicio'||to_date(inicio,'yyyy/MM/dd'));
    --Dbms_Output.Put_Line('Fecha fin:  '||to_date(fin,'yyyy/MM/dd'));
   -- Dbms_Output.Put_Line('consec:  '||consec);
  END IF;
  IF status = 'A' THEN
    dbms_output.put_line('VARIABLE AUX:' || aux);
    UPDATE SVTEMPSC SET sta_sol = 'A' WHERE SVTEMPSC.id_ope = aux;
    COMMIT;
    -- inicia cursor 8
    OPEN temporal_8 (auto_);
    FETCH temporal_8 INTO nomb;
    CLOSE temporal_8;
    --termina cursor 8
    dbms_output.put_line('VARIABLE AUX:' || nomb);
    INSERT
    INTO NMCORVAC
      (
        rva_keyemp,
        rva_antigu,
        rva_fecsol,
        rva_period,
        rva_fecini,
        rva_fecfin,
        rva_diadis,
        rva_autori,
        rva_consec
      )
    SELECT
	  num_emp,
      ant_emp,
      fec_sol,
      per_vac,
      dia_ini,
      dia_fin,
      num_dia,
      nomb,
      con_emp
    FROM SVTEMPSC
    WHERE SVTEMPSC.num_emp = numero
    AND SVTEMPSC.sta_sol   = 'A';
    o_act_estatus         := 1;
  END IF;
  IF status = 'C' THEN
    dbms_output.put_line('VARIABLE AUX:' || aux);
    UPDATE SVTEMPSC SET sta_sol = 'C' WHERE SVTEMPSC.id_ope = aux;
    COMMIT;
    o_act_estatus := 1;
    dbms_output.put_line('VARIABLE AUX:' || oper);
  END IF;
  IF status = 'T' THEN
    --inicia cursor 9
    OPEN temporal_9(numero);
    LOOP
      FETCH temporal_9 INTO tdias,perm;
      EXIT
    WHEN temporal_9%NOTFOUND;
      dbms_output.put_line('variable tdias :' || tdias);
      dbms_output.put_line('variable perm :' || perm);
      --termina cursor 9
      --dbms_output.put_line('variable tdias :' || tdias);
      --dbms_output.put_line('variable perm :' || perm);
      --inicia cursor 10
      OPEN temporal_10 (numero,perm);
      LOOP
        FETCH temporal_10 INTO numd;
        EXIT
      WHEN temporal_10%NOTFOUND;
        dbms_output.put_line('variable numd:' || numd);
        --dbms_output.put_line('variable numd:' || numd);
        dbms_output.put_line('numero:' || numero);
        --UPDATE
        UPDATE SVTEMPSC
        SET sta_sol            = 'T'
        WHERE SVTEMPSC.num_emp = numero
        AND SVTEMPSC.sta_sol   = 'A';
        IF numd                < tdias THEN
          --UPDATE
          UPDATE NMCOCVAC
          SET vac_dtomad            = vac_diavac,
            vac_salper              = 0
          WHERE NMCOCVAC.vac_keyemp = numero
          AND NMCOCVAC.vac_status   = 'V'
          AND NMCOCVAC.vac_period   = trim(perm);
          --UPDATE
          UPDATE NMCOCVAC
          SET vac_dtomad            = (vac_dtomad+(tdias-numd)),
            vac_salper              = vac_salper -(tdias-numd)
          WHERE NMCOCVAC.vac_keyemp = numero
          AND NMCOCVAC.vac_status   = 'V'
          AND NMCOCVAC.vac_period  <> trim(perm);
        END IF;
        COMMIT;
        dbms_output.put_line('variable tdias antes de numd >= :' || tdias);
        dbms_output.put_line('variable numd antes de numd >=:' || numd);
        IF numd >= tdias THEN
          --UPDATE
          UPDATE NMCOCVAC
          SET vac_dtomad            = (vac_dtomad+tdias),
            vac_salper              = vac_salper -tdias
          WHERE NMCOCVAC.vac_keyemp = numero
          AND NMCOCVAC.vac_status   = 'V'
          AND NMCOCVAC.vac_period   = trim(perm);
        END IF;
        COMMIT;
      END LOOP;
      CLOSE temporal_10;
    END LOOP;
    CLOSE temporal_9;
    o_act_estatus := 1;
    UPDATE NMCOCVAC
    SET VAC_STATUS            = 'E'
    WHERE NMCOCVAC.vac_keyemp = numero
      AND TO_CHAR(vac_fecpre,'YYYY/MM/DD') <= TO_CHAR(SYSDATE,'YYYY/MM/DD')
      AND vac_salper            =0
      AND NMCOCVAC.vac_status   = 'V'
      AND NMCOCVAC.vac_period   = TRIM(perm);
    COMMIT;
  END IF;
END;
END Pkg_Protele_Sv_Valida;
/;
