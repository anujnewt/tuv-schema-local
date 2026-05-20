CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_ALM_TEMP" (
    numero  IN INTEGER,
    dias    IN NUMBER,
    tipo    IN VARCHAR2,
    status  IN VARCHAR2,
    inicio  IN VARCHAR2,
    fin     IN VARCHAR2,
    auto_   IN INTEGER,
    per     IN INTEGER,
    fec_act IN VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  oper       INTEGER;
  moper      INTEGER;
  aux        INTEGER;
  antigu     INTEGER;
  anti       INTEGER;
  consec     INTEGER;
  numd       NUMBER(6,2);
  tdias      NUMBER (6,2);
  perm       VARCHAR2(10);
  nomb       VARCHAR2(60);
  period     VARCHAR2(10);
  dias_temp  DECIMAL;
  numTemp    INTEGER;
  periodTemp VARCHAR2(10);
  autoTemp   INTEGER;
  aux_Temp INTEGER;
  permTemp VARCHAR2(10);
  finicio DATE;
  ffinal DATE;
  factual DATE;
  ---CURSOR 1
  CURSOR temporal
  IS
    (SELECT MAX(id_ope)+1, MAX(con_emp) +1, COUNT( *) FROM SVTEMPSC
    );
  ---CURSOR 2
  CURSOR temporal_2 (numTemp IN INTEGER)
  IS
    (SELECT DISTINCT(id_ope)
    FROM SVTEMPSC
    WHERE SVTEMPSC.num_emp = numTemp
    AND SVTEMPSC.sta_sol   = 'P'
    );
  ---CURSOR 3
  CURSOR temporal_3 (numTemp IN INTEGER)
  IS
    (SELECT MIN(vac_period)
    FROM NMCOCVAC
    WHERE vac_status = 'V'
    AND vac_keyemp   = numTemp
    );
  ---CURSOR 4
  CURSOR temporal_4 (numTemp IN INTEGER, periodTemp IN VARCHAR2)
  IS
    (SELECT vac_antigu
    FROM NMCOCVAC
    WHERE vac_status = 'V'
    AND vac_keyemp   = numTemp
    AND vac_period   = periodTemp
    );
  ---CURSOR 5
  CURSOR temporal_5 (numTemp IN INTEGER)
  IS
    (SELECT MAX(vac_period)
    FROM NMCOCVAC
    WHERE vac_status = 'V'
    AND vac_keyemp   = numTemp
    );
  ---CURSOR 6
  CURSOR temporal_6 (numTemp IN INTEGER, periodTemp IN VARCHAR2)
  IS
    (SELECT vac_antigu
    FROM NMCOCVAC
    WHERE vac_status = 'V'
    AND vac_keyemp   = numTemp
    AND vac_period   = periodTemp
    );
  ---CURSOR 7
  CURSOR temporal_7 (numTemp IN INTEGER, periodTemp IN VARCHAR2)
  IS
    (SELECT vac_dtomad
    FROM NMCOCVAC
    WHERE NMCOCVAC.vac_keyemp = numTemp
    AND NMCOCVAC.vac_period   = periodTemp
    );
  ---CURSOR 8
  CURSOR temporal_8 (auto_ IN INTEGER)
  IS
    ( SELECT emp_nomemp FROM NMCOEMPL WHERE emp_keyemp = auto_
    );
  ---CURSOR 9
  CURSOR temporal_9 (numTemp IN INTEGER)
  IS
    (SELECT num_dia,per_vac
    FROM SVTEMPSC
    WHERE SVTEMPSC.num_emp = numTemp
    AND SVTEMPSC.sta_sol   = 'A'
    );
  ---CURSOR 10
  CURSOR temporal_10 (numTemp IN INTEGER, perm IN VARCHAR2)
  IS
    (SELECT vac_salper
    FROM NMCOCVAC
    WHERE vac_status = 'V'
    AND vac_keyemp   = numTemp
    and vac_period= trim(perm)
    );
    CURSOR temporal_11 (numTemp IN INTEGER)
  IS
    (SELECT MIN(vac_period)
    FROM NMCOCVAC
    WHERE vac_status = 'V'
    AND vac_keyemp   = numTemp
    );
  ---CURSOR 6
  CURSOR temporal_12 (numTemp IN INTEGER, periodTemp IN VARCHAR2)
  IS
    (SELECT vac_antigu
    FROM NMCOCVAC
    WHERE vac_status = 'V'
    AND vac_keyemp   = numTemp
    AND vac_period   = periodTemp
    );
BEGIN
  --Asignacion de Fechas
  --SELECT to_date(inicio,'yyyy/MM/dd') into finicio from dual;
  --  SELECT to_date(fin,'yyyy/MM/dd') into ffinal from dual;
   -- SELECT to_date(fec_act,'yyyy/MM/dd') into factual from dual;
    --Finaliza Asignacion de Fechas
  --inicia cursor 1
  OPEN temporal;
  FETCH temporal INTO oper, consec, moper;
  CLOSE temporal;
  dbms_output.put_line('VARIABLE oper 1 despues primer select:' || oper);
  dbms_output.put_line('VARIABLE consec 1 despues primer select:' || consec);
  dbms_output.put_line('VARIABLE moper 1 despues primer select:' || moper);
  IF moper  = 0 THEN
    consec := 1000;
    oper   := 1000;
  END IF;
  dbms_output.put_line('VARIABLE consec 2 despues del 1er If:' || consec);
  dbms_output.put_line('VARIABLE oper 2 despues del 1er If:' || oper);
  --termina cursor 1
  --inicia cursor 2
  OPEN temporal_2 (numero);
  FETCH temporal_2 INTO aux;
  CLOSE temporal_2;
  dbms_output.put_line('VARIABLE AUX 1 despues segundo select:' || aux);
  IF aux  > 0 THEN
    oper := aux;
  END IF;
  dbms_output.put_line('VARIABLE oper 3 despues del 2do If:' || oper);
  --termina curso 2
  IF status = 'P' THEN
    DELETE
    FROM SVTEMPSC
    WHERE SVTEMPSC.num_emp = numero
    AND SVTEMPSC.sta_sol   = 'P'
    AND SVTEMPSC.tipo_sol  = 'S';
    IF per                 = 1 THEN
      --inicia cursor 3
      OPEN temporal_3(numero);
      FETCH temporal_3 INTO period;
      CLOSE temporal_3;
      ---termina cursor 3
      --inicia cursor 4
      OPEN temporal_4(numero, period);
      FETCH temporal_4 INTO antigu;
      CLOSE temporal_4;
      --termina cursor 4
    END IF;
    IF per = 2 THEN
      --inicia cursor5
      OPEN temporal_5(numero);
      FETCH temporal_5 INTO period;
      CLOSE temporal_5;
      ---termina cursor 5
      --inicia cursor 6
      OPEN temporal_6(numero, period);
      FETCH temporal_6 INTO antigu;
      CLOSE temporal_6;
      --termina cursor 6
    END IF;
    UPDATE SVTEMPSC
    SET tipo_sol           = 'S'
    WHERE SVTEMPSC.num_emp = numero
    AND SVTEMPSC.sta_sol   = 'P'
    AND SVTEMPSC.tipo_sol  = 'P';
    INSERT
    INTO SVTEMPSC
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
        to_date(inicio,'yyyy/MM/dd'),
        to_date(fin,'yyyy/MM/dd'),
        period,
        antigu,
        to_date(fec_act,'yyyy/MM/dd'),
        consec
      );
   -- RETURN oper;
    RETURN;
END IF;
  IF status = 'I' THEN
    --inicia cursor5
    OPEN temporal_11(numero);
    FETCH temporal_11 INTO period;
    CLOSE temporal_11;
    ---termina cursor5
    --inicia cursor 6
    OPEN temporal_12(numero, period);
    FETCH temporal_12 INTO antigu;
    CLOSE temporal_12;
    --termina cursor 6
    INSERT
    INTO SVTEMPSC
      (
        id_ope,
        num_emp,
        num_dia,
        tipo_sol,
        sta_sol,
        dia_ini,
        dia_fin,
        con_emp,
        per_vac,
        ant_emp
      )
      VALUES
      (
        oper,
        numero,
        dias,
        'C',
        status,
        to_date(inicio,'yyyy/MM/dd'),
        to_date(fin,'yyyy/MM/dd'),
        consec,
        period,
        antigu
      );
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
        rva_consec
      )
    SELECT num_emp,
      ant_emp,
      fec_sol,
      per_vac,
      dia_ini,
      dia_fin,
      num_dia,
      con_emp
    FROM SVTEMPSC
    WHERE SVTEMPSC.num_emp = numero
    AND SVTEMPSC.sta_sol   = 'I'
    AND SVTEMPSC.tipo_sol  = 'C';
    UPDATE SVTEMPSC SET tipo_sol = 'T' WHERE sta_sol = 'I' AND num_emp = numero;
    --inicia cursor 7
    OPEN temporal_7(numero, period);
    FETCH temporal_7 INTO numd;
    CLOSE temporal_7;
    --termina cursor 7
    dias_temp := dias * -1.0;
    IF numd    < dias_temp THEN
      --UPDATE
      UPDATE NMCOCVAC
      SET vac_dtomad            = 0,
        vac_salper              = vac_diavac
      WHERE NMCOCVAC.vac_keyemp = numero
      AND NMCOCVAC.vac_status   = 'V'
      AND NMCOCVAC.vac_period   = period;
      ---UPDATE
      UPDATE NMCOCVAC
      SET vac_dtomad            = (vac_dtomad-(dias_temp-numd)),
        vac_salper              = vac_salper +(dias_temp-numd)
      WHERE NMCOCVAC.vac_keyemp = numero
      AND NMCOCVAC.vac_status   = 'V'
      AND NMCOCVAC.vac_period  <> period;
    END IF;
    IF numd >= dias_temp THEN
      UPDATE NMCOCVAC
      SET vac_dtomad            = (vac_dtomad-dias_temp),
        vac_salper              = vac_salper + dias_temp
      WHERE NMCOCVAC.vac_keyemp = numero
      AND NMCOCVAC.vac_status   = 'V'
      AND NMCOCVAC.vac_period   = period;
    END IF;
    RETURN;
  END IF;
  IF status = 'C' THEN
    UPDATE SVTEMPSC SET sta_sol = 'C' WHERE SVTEMPSC.id_ope = aux;
  --  RETURN aux;
  RETURN;
  dbms_output.put_line('VARIABLE AUX ANTES DEL IF A:' || aux_Temp);
  END IF;
  IF status = 'A' THEN
    dbms_output.put_line('VARIABLE AUX:' || aux);
    --UPDATE
    UPDATE SVTEMPSC SET sta_sol = 'A' WHERE SVTEMPSC.id_ope = aux;
    --inicia cursor 8
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
   SELECT num_emp,
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
    --RETURN aux;
    RETURN;
  END IF;
  IF status = 'T' THEN
    --inicia cursor 9
    OPEN temporal_9(numero);
    loop
    FETCH temporal_9 INTO tdias,perm;
    exit when temporal_9%NOTFOUND;
    dbms_output.put_line('variable tdias :' || tdias);
    dbms_output.put_line('variable perm :' || perm);
    --termina cursor 9
    --dbms_output.put_line('variable tdias :' || tdias);
    --dbms_output.put_line('variable perm :' || perm);
    --inicia cursor 10
    OPEN temporal_10 (numero,perm);
    loop
    FETCH temporal_10 INTO numd;
    exit when temporal_10%NOTFOUND;
    dbms_output.put_line('variable numd:' || numd);
    --end loop;
    --CLOSE temporal_10;
    --end loop;
    --CLOSE temporal_9;
    --inicia cursor 10
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
    end loop;
    CLOSE temporal_10;
    end loop;
    CLOSE temporal_9;
    --RETURN;
  END IF;
  COMMIT;
END;
/
