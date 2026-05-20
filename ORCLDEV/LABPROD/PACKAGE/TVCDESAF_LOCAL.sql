CREATE OR REPLACE NONEDITIONABLE PACKAGE "LABPROD"."TVCDESAF_LOCAL" IS
    TYPE empleado IS RECORD ( keyemp LABPROD.nmcoempl.emp_keyemp%TYPE, keydep LABPROD.nmcoempl.emp_keydep%TYPE, keypue LABPROD.nmcoempl.emp_keypue%TYPE,
                            keypro LABPROD.nmcoempl.emp_keypro%TYPE, status LABPROD.nmcoempl.emp_status%TYPE);
    TYPE periodo IS RECORD ( period LABPROD.glcopams.pam_nompar%TYPE, fecini LABPROD.glcopams.pam_folini%TYPE, fecfin LABPROD.glcopams.pam_folfin%TYPE,
                             diaper INTEGER, cvecal VARCHAR(3));
    TYPE afiliacion IS RECORD (keycon LABPROD.nmlodfij.dfi_keycon%TYPE, porcen LABPROD.nmlodfij.dfi_cantid%TYPE, cuofij LABPROD.nmlodfij.dfi_import%TYPE);
   ---------------------------------
    PROCEDURE Afiliar (recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , cantid IN NUMBER, tipact IN NUMBER, keycon IN LABPROD.nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
    PROCEDURE Modifica_Afiliacion ( recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , cantid IN NUMBER, tipact IN NUMBER, keycon IN LABPROD.nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
    PROCEDURE Desafiliar ( recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , keycon IN LABPROD.nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
    PROCEDURE Pagos (recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , cantid IN NUMBER, tipact IN NUMBER, keycon IN LABPROD.nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
    PROCEDURE Inserta (recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , monsol IN NUMBER, mondes IN NUMBER, tipact IN NUMBER, cveref IN LABPROD.nmlopres.pre_refere%TYPE,
      unipre IN NUMBER, unides IN NUMBER, unisal IN NUMBER, keycon IN LABPROD.nmloconc.con_keycon%TYPE, resultado OUT NUMBER);
    PROCEDURE Reestructura (client IN LABPROD.nmlopres.pre_ca2aux%TYPE, recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , cveres IN LABPROD.nmlopres.pre_refere%TYPE, monsol IN NUMBER, mondes IN NUMBER,
      cveref IN LABPROD.nmlopres.pre_refere%TYPE, unipre IN NUMBER, unides IN NUMBER, unisal IN NUMBER,
      sdocap IN NUMBER, monadi IN NUMBER, keycon IN LABPROD.nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
    PROCEDURE Elimina_Prestamo ( recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , cveref IN LABPROD.nmlopres.pre_refere%TYPE, keycon IN LABPROD.nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
    PROCEDURE Actualiza_Prestamo ( recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , cveref IN LABPROD.nmlopres.pre_refere%TYPE, keycon IN LABPROD.nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
    PROCEDURE Inserta_Prestamo (recurp IN LABPROD.nmcoempl.emp_recurp%TYPE, totsol in number, impdes in number, totint in number, intdes in number, unisal in number,
                              cvecli in varchar, cveref IN LABPROD.nmlopres.pre_refere%TYPE, keycon IN LABPROD.nmloconc.con_keycon%TYPE,
      resultado OUT NUMBER);
    PROCEDURE validacion (recurp IN LABPROD.nmcoempl.emp_recurp%TYPE, keycon IN LABPROD.nmloconc.con_keycon%TYPE, resultado OUT NUMBER, emp OUT empleado, per OUT periodo);
    PROCEDURE ValidacionDesafiliar (recurp IN LABPROD.nmcoempl.emp_recurp%TYPE, keycon IN LABPROD.nmloconc.con_keycon%TYPE, resultado OUT NUMBER, emp OUT empleado, per OUT periodo);
    FUNCTION existe_empleado ( recurp IN LABPROD.nmcoempl.emp_recurp%TYPE )
      RETURN empleado;
    FUNCTION existe_concepto (keycon IN LABPROD.nmloconc.con_keycon%TYPE)
      RETURN NUMBER;
    FUNCTION existe_prestamo (cveref IN LABPROD.nmlopres.pre_refere%TYPE, keyemp IN LABPROD.nmlopres.pre_keyemp%TYPE, keycon IN LABPROD.nmlopres.pre_keycon%TYPE, tipact IN NUMBER)
      RETURN NUMBER;
    FUNCTION existe_periodo ( empl IN empleado )
      RETURN periodo;
    FUNCTION existe_afiliacion (keyemp IN LABPROD.nmlodfij.dfi_keyemp%TYPE, keycon IN LABPROD.nmlodfij.dfi_keycon%TYPE, keypro IN LABPROD.nmlodfij.dfi_keypro%TYPE)
      RETURN afiliacion;
END TVCDESAF_LOCAL;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "LABPROD"."TVCDESAF_LOCAL" IS
/* -- Private Global Variables -------------------------------------------- */
  porcen NUMBER;
  cuofij NUMBER;
  capdes NUMBER;
  peract VARCHAR(7);
  fecini DATE;
  total NUMBER;
  v_var  NUMBER;
  keypre NUMBER;
  impdes_validado number;
  totafi number;
  perini VARCHAR(7);
  impdes NUMBER;
  ------------------------
  v_empleado empleado;
  v_periodo   periodo;
  v_afiliacion afiliacion;
  prueba NUMBER;
--PROCEDIMIENTO AFILIAR
/* -------------------------------------------------------------------------- */
  PROCEDURE Afiliar (recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , cantid IN NUMBER, tipact IN NUMBER, keycon IN LABPROD.nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
    Validacion (recurp, keycon, v_var, v_empleado, v_periodo); --Existencia de empleado, periodo y concepto
    if v_var > 0 then
      resultado := v_var; RETURN;
    end if;
--compara rango de fechas de calendario
  peract := v_periodo.period;
    IF (trunc(SYSDATE) > v_periodo.fecini AND trunc(SYSDATE) < v_periodo.fecfin) THEN
      if to_number(substr(v_periodo.period, 5, 3)) = floor(365/v_periodo.diaper) then
        peract := to_char(to_number(substr(v_periodo.period, 1, 4))+1) || '001';
      else
        peract := to_char(to_number(v_periodo.period) + 1);
       end if;
    END IF;
--pasar??an por accidente algo distinto de 1 o 2?
    if tipact = 1 then
      porcen := 0; cuofij := cantid;
    elsif tipact = 2 then
      porcen := cantid; cuofij := 0;
    else
      resultado := 12; RETURN;
    end if;
--busca la afiliaci??n
    v_afiliacion := existe_afiliacion (v_empleado.keyemp, keycon, v_empleado.keypro);
--busca el concepto
      SELECT COUNT(*) INTO totafi FROM LABPROD.glcopams
      WHERE pam_keypar = 'SAFO' AND pam_cvesec = keycon;
            IF v_afiliacion.keycon IS NULL THEN
          --inserta afiliaci??n
               BEGIN
                  INSERT INTO LABPROD.nmlodfij (dfi_keyemp, dfi_keycon, dfi_keypro, dfi_perini, dfi_perfin, dfi_keydep,
                                dfi_keypue, dfi_fecmov, dfi_cantid, dfi_import, dfi_ca1aux, dfi_ca2aux)
                         VALUES( v_empleado.keyemp, keycon, v_empleado.keypro, peract ,'2999999', v_empleado.keydep,
                               v_empleado.keypue, SYSDATE, porcen , cuofij, SYSDATE, NULL);
               EXCEPTION
                  WHEN OTHERS THEN resultado := 15; RETURN;
               END;
            ELSE
                IF totafi = 0 THEN
                    --actualiza sumando o manda error?       --se suma y se valida que...?
                     BEGIN
                        UPDATE LABPROD.nmlodfij SET dfi_cantid = v_afiliacion.porcen + porcen, dfi_import = v_afiliacion.cuofij + cuofij, dfi_ca2aux = SYSDATE
                        WHERE dfi_keyemp = v_empleado.keyemp
                        AND dfi_keycon = keycon
                        AND dfi_keypro = v_empleado.keypro;
                     EXCEPTION
                        WHEN OTHERS THEN resultado := 16; RETURN;
                     END;
                ELSE
                    --existe en la alfanum??rica
                    resultado := 12; RETURN;
                END IF;
            END IF;
--calcula nueva capacidad de descuento
    LABPROD.SP_CAPDES_LOCAL(v_empleado.keyemp, capdes);
--termina
    resultado :=0;
  END Afiliar;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO MODIFICA AFILIACION
/* -------------------------------------------------------------------------- */
  PROCEDURE Modifica_Afiliacion ( recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , cantid IN NUMBER, tipact IN NUMBER, keycon IN LABPROD.nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
    Validacion (recurp, keycon, v_var, v_empleado, v_periodo); --Existencia de empleado, periodo y concepto
    if v_var > 0 then
      resultado := v_var; RETURN;
    end if;
--compara rango de fechas de calendario
    IF (trunc(SYSDATE) > v_periodo.fecini AND trunc(SYSDATE) < v_periodo.fecfin) THEN
      resultado := 4; RETURN; -- la n??mina se est?? calculando
    END IF;
--pasar??an por accidente algo distinto de 11 o 12?
    if tipact = 11 then
      porcen := 0; cuofij := cantid;
    elsif tipact = 12 then
      porcen := cantid; cuofij := 0;
    else
      resultado := 12; RETURN;
    end if;
--modifica afiliaci??n
     BEGIN
        UPDATE LABPROD.nmlodfij set dfi_cantid = porcen, dfi_import = cuofij, dfi_fecmov = SYSDATE
        WHERE dfi_keyemp = v_empleado.keyemp
        AND dfi_keycon = keycon;
     EXCEPTION
        WHEN OTHERS THEN
          resultado := 16; RETURN;
     END;
--preguntamos por el proceso? a veces lo hacen, a veces n -- podr??a haber m??s de un registro?
--si no se actualizaron registros, avisar
    IF SQL%ROWCOUNT = 0 THEN
      resultado := 6; RETURN;
    END IF;
--calcula nueva capacidad de descuento
    LABPROD.SP_CAPDES_LOCAL(v_empleado.keyemp, capdes);
--termina
    resultado :=0;
  END Modifica_Afiliacion;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO DESAFILIAR
/* -------------------------------------------------------------------------- */
  PROCEDURE Desafiliar ( recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , keycon IN LABPROD.nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
    ValidacionDesafiliar (recurp, keycon, v_var, v_empleado, v_periodo); --Existencia de empleado, periodo y concepto
    if v_var > 0 then
      resultado := v_var; RETURN;
    end if;
--compara rango de fechas de calendario
    IF (trunc(SYSDATE) > v_periodo.fecini AND trunc(SYSDATE) < v_periodo.fecfin) THEN
      resultado := 4; RETURN; -- la n??mina se est?? calculando
    END IF;
--desafiliar
     BEGIN
        DELETE FROM LABPROD.nmlodfij
        WHERE dfi_keyemp = v_empleado.keyemp
        AND dfi_keycon = keycon;
     EXCEPTION
        WHEN OTHERS THEN
          resultado := 17; RETURN;
     END;
--podr??a haber mas de un registro?
--si no se eliminaron registros, avisar
    IF SQL%ROWCOUNT = 0 THEN
      resultado := 6; RETURN;
    END IF;
--calcula nueva capacidad de descuento
    LABPROD.SP_CAPDES_LOCAL(v_empleado.keyemp, capdes);
--termina
    resultado :=0;
  END Desafiliar;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO PAGOS
/* -------------------------------------------------------------------------- */
  PROCEDURE Pagos(recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , cantid IN NUMBER, tipact IN NUMBER, keycon IN LABPROD.nmloconc.con_keycon%TYPE,resultado OUT NUMBER) IS
  BEGIN
    Validacion (recurp, keycon, v_var, v_empleado, v_periodo); --Existencia de empleado, periodo y concepto
    if v_var > 0 then
      resultado := v_var; RETURN;
    end if;
--compara rango de fechas de calendario
    IF (trunc(SYSDATE) > v_periodo.fecini AND trunc(SYSDATE) < v_periodo.fecfin) THEN
      resultado := 4; RETURN; -- la n??mina se est?? calculando
    END IF;
--pasar??an por accidente algo distinto de 15 o 16?
    if tipact = 15 then
      porcen := 0; cuofij := cantid;
    elsif tipact = 16 then
      porcen := cantid; cuofij := 0;
    else
      resultado := 12; RETURN;
    end if;
--valida que exista --select nmlodfij
	  v_afiliacion  := existe_afiliacion(v_empleado.keyemp, keycon, v_empleado.keypro);
  IF v_afiliacion.keycon IS NULL THEN
        resultado := 6; RETURN;
  ELSE
		IF v_afiliacion.porcen = porcen AND v_afiliacion.cuofij = cuofij THEN
           BEGIN
              DELETE FROM LABPROD.nmlodfij
              WHERE dfi_keyemp = v_empleado.keyemp
              AND dfi_keycon = keycon
              AND dfi_keypro = v_empleado.keypro;
           EXCEPTION
              WHEN OTHERS THEN
                resultado := 17; RETURN;
           END;
			--podr??a perderse la referencia del proceso --delete
		END IF;
		IF v_afiliacion.porcen > porcen OR v_afiliacion.cuofij > cuofij THEN
			--update
           BEGIN
              UPDATE LABPROD.nmlodfij SET dfi_cantid = v_afiliacion.porcen - porcen, dfi_import = v_afiliacion.cuofij - cuofij, dfi_ca2aux = SYSDATE
              WHERE dfi_keyemp = v_empleado.keyemp
              AND dfi_keycon = keycon
              AND dfi_keypro = v_empleado.keypro;
           EXCEPTION
              WHEN OTHERS THEN
                resultado := 16; RETURN;
           END;
		END IF;
		IF v_afiliacion.porcen < porcen OR v_afiliacion.cuofij < cuofij THEN
			resultado := 11; RETURN;
		END IF;
		--??Son exhaustivos?
	END IF;
--calcula nueva capacidad de descuento
    LABPROD.SP_CAPDES_LOCAL(v_empleado.keyemp, capdes);
--termina
    resultado :=0;
  END Pagos;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO INSERTA
/* -------------------------------------------------------------------------- */
  PROCEDURE Inserta (recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , monsol IN NUMBER, mondes IN NUMBER, tipact IN NUMBER, cveref IN LABPROD.nmlopres.pre_refere%TYPE,
                  unipre IN NUMBER, unides IN NUMBER, unisal IN NUMBER, keycon IN LABPROD.nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
    Validacion (recurp, keycon, v_var, v_empleado, v_periodo); --Existencia de empleado, periodo y concepto
    if v_var > 0 then
      resultado := v_var; RETURN;
    end if;
--compara rango de fechas de calendario
    peract := v_periodo.period;
    IF (trunc(SYSDATE) > v_periodo.fecini AND trunc(SYSDATE) < v_periodo.fecfin) THEN
      if to_number(substr(v_periodo.period, 5, 3)) = floor(365/v_periodo.diaper) then
        peract := to_char(to_number(substr(v_periodo.period, 1, 4))+1) || '001';
      else
        peract := to_char(to_number(v_periodo.period) + 1);
       end if;
    END IF;
--pasar??an por accidente algo distinto de 7?
    if tipact <> 7 then
      resultado := 12; RETURN;
    end if;
--valida que no exista
   IF existe_prestamo(cveref, v_empleado.keyemp, keycon, tipact) > 0 THEN
      resultado := 9; RETURN;
	ELSE
		--calcula capacidad de descuento
		LABPROD.SP_CAPDES_LOCAL(v_empleado.keyemp, capdes);
		IF FLOOR(30/v_periodo.diaper)*(mondes+unides) > capdes THEN
			resultado := 11; RETURN;
		ELSE
			--Campos a Insertar
           BEGIN
                select per_fecini into fecini from LABPROD.nmloperi
                where per_keyper = peract
                and per_keypro = v_empleado.keypro;
           EXCEPTION
              WHEN OTHERS THEN
                resultado := 18; RETURN;
           END;
 --se le est?? mandando al insert el fecini?
        SELECT LABPROD.NMLOPRES_SEQ.NEXTVAL into keypre FROM dual;
        keypre := (keypre * 0.000001) + to_number(to_char(sysdate, 'YYMMDD'));
           BEGIN
             INSERT INTO LABPROD.nmlopres
              (pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
              pre_tippre, pre_unipre, pre_imppre, pre_gastos, pre_plazop,
              pre_unides, pre_impdes, pre_porint, pre_perini, pre_fecini,
              pre_fecaut, pre_cveaut, pre_fechab, pre_uniamo, pre_impamo,
              pre_unisal, pre_impsal, pre_uniult, pre_impult, pre_numpag,
              pre_intpag, pre_status, pre_ultact, pre_refcon, pre_ctreve,
              pre_fe1aux, pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux,
              pre_ca4aux, pre_uniope, pre_keypro, pre_impnoa, pre_pernoa)
            VALUES(
                v_empleado.keyemp, keycon, keypre, cveref, SYSDATE,
                'N', unipre, monsol + unipre, 0, 0,
                unides, mondes + unides, 0, peract, v_periodo.fecini,
                NULL, NULL, NULL, 0, 0,
                unipre, monsol + unipre , 0, 0, 0,
                0, 1, SYSDATE, NULL, NULL,
                NULL, NULL, NULL, 1, mondes + unides,
                v_empleado.keypro, 1, v_empleado.keypro, NULL, NULL);
           EXCEPTION
              WHEN OTHERS THEN
                resultado := 15; RETURN;
           END;
		END IF;
	END IF;
--calcula nueva capacidad de descuento
    LABPROD.SP_CAPDES_LOCAL(v_empleado.keyemp, capdes);
--termina
    resultado :=0;
  END Inserta;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO REESTRUCTURA
/* -------------------------------------------------------------------------- */
  PROCEDURE Reestructura (client IN LABPROD.nmlopres.pre_ca2aux%TYPE, recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , cveres IN LABPROD.nmlopres.pre_refere%TYPE, monsol IN NUMBER, mondes IN NUMBER,
                        cveref IN LABPROD.nmlopres.pre_refere%TYPE, unipre IN NUMBER, unides IN NUMBER, unisal IN NUMBER,
                        sdocap IN NUMBER, monadi IN NUMBER, keycon IN LABPROD.nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
    impdes := 0;
    INSERT INTO LABPROD.GLWKCRYS (CRY_NOMREP,CRY_NUMSEC,CRY_CHR001,CRY_CHR002,CRY_CHR003,CRY_CHR004,CRY_CHR005,CRY_CHR006,CRY_CHR007,CRY_CHR008,CRY_CHR009,CRY_CHR010,CRY_CHR011,CRY_CHR012,CRY_CHR024)
              VALUES ('CDESAF',1,client,recurp,cveres,monsol,mondes,cveref,unipre,unides,unisal,sdocap,monadi,keycon,recurp);
    Validacion (recurp, keycon, v_var, v_empleado, v_periodo);  --Existencia de empleado, periodo y concepto
    if v_var > 0 then
      resultado := v_var; RETURN;
    end if;
--compara rango de fechas de calendario
    IF (trunc(SYSDATE) > TO_DATE(v_periodo.fecini,'DD/MM/RR') AND trunc(SYSDATE) < TO_DATE(v_periodo.fecfin,'DD/MM/RR')) THEN
      resultado := 4; RETURN; -- la n??mina se est?? calculando
    END IF;
--valida que exista, se le manda la bandera antigua que referer??a a reestructura: 14
    IF existe_prestamo(cveres, v_empleado.keyemp, keycon, 14) = 0 THEN
      resultado := 3; RETURN;
    ELSE
      --verificar pr??stamo saldado
      BEGIN
          SELECT COUNT(*) INTO total FROM LABPROD.nmlopres WHERE pre_refere = cveres
          AND pre_keyemp = v_empleado.keyemp AND pre_ca2aux = 1 AND pre_keycon = keycon
          AND pre_status = 2 AND pre_impsal > 0 AND pre_unisal > 0;
      EXCEPTION
        WHEN OTHERS THEN
          resultado := 1234; RETURN;
      END;
      IF total = 0 THEN
         IF existe_prestamo(cveref, v_empleado.keyemp, keycon, 17) = 0 THEN
            resultado := 3; RETURN;
         ELSE
            resultado := 10; RETURN;
         END IF;
      ELSE
        BEGIN
              INSERT INTO LABPROD.GLWKCRYS (CRY_NOMREP,CRY_NUMSEC,CRY_CHR001,CRY_CHR002,CRY_CHR003,CRY_DEC006,CRY_CHR024)
              VALUES ('CDESAF',2,cveres,client,keycon,v_empleado.keyemp,recurp);
              SELECT pre_ca3aux INTO impdes
              FROM LABPROD.NMLOPRES
              WHERE pre_refere = cveres AND pre_keyemp = v_empleado.keyemp
              AND pre_ca2aux = 1 AND pre_keycon = keycon;
              /*UPDATE LABPROD.nmlopres SET pre_status = 9
              WHERE pre_refere = cveres AND pre_keyemp = v_empleado.keyemp
              AND pre_ca2aux = 1 AND pre_keycon = keycon;
              total:= SQL%ROWCOUNT;
              */
              INSERT INTO LABPROD.GLWKCRYS (CRY_NOMREP,CRY_NUMSEC,CRY_CHR001,CRY_CHR002,CRY_CHR003,CRY_DEC006,CRY_DEC007,CRY_CHR024)
              VALUES ('CDESAF',3,cveres,client,keycon,v_empleado.keyemp,impdes,recurp);
         EXCEPTION
            WHEN OTHERS THEN
              resultado := 16; RETURN;
         END;
      END IF;
      --calcula capacidad de descuento
      LABPROD.SP_CAPDES_LOCAL(v_empleado.keyemp, capdes);
      INSERT INTO LABPROD.GLWKCRYS (CRY_NOMREP,CRY_NUMSEC,CRY_CHR001,CRY_CHR002,CRY_CHR003,CRY_DEC006,CRY_DEC001,CRY_CHR024)
              VALUES ('CDESAF',4,cveres,client,keycon,v_empleado.keyemp,capdes,recurp);
      capdes := capdes + (impdes * FLOOR(30/v_periodo.diaper));
      IF FLOOR(30/v_periodo.diaper)*(mondes+unides) > capdes THEN
        resultado := 11;
         BEGIN
              UPDATE LABPROD.nmlopres SET pre_status = 2
              WHERE pre_refere = cveres AND pre_keyemp = v_empleado.keyemp
              AND pre_ca2aux = '1' AND pre_keycon = keycon;
         EXCEPTION
            WHEN OTHERS THEN
              resultado := 16; RETURN;
         END;
        LABPROD.SP_CAPDES_LOCAL(v_empleado.keyemp, capdes);
        RETURN;
      ELSE
        --inserta
        peract := v_periodo.period;
        IF (trunc(SYSDATE) > v_periodo.fecini AND trunc(SYSDATE) < v_periodo.fecfin) THEN
          if to_number(substr(v_periodo.period, 5, 3)) = floor(365/v_periodo.diaper) then
            peract := to_char(to_number(substr(v_periodo.period, 1, 4))+1) || '001';
          else
            peract := to_char(to_number(v_periodo.period) + 1);
           end if;
        END IF;
        --Campos a Insertar
        BEGIN
              select per_fecini into fecini from LABPROD.nmloperi
              where per_keyper = peract
              and per_keypro = v_empleado.keypro;
        EXCEPTION
            WHEN OTHERS THEN
              resultado := 18; RETURN;
        END;
        --se est?? mandando el fecini correcto al insert?
        SELECT LABPROD.NMLOPRES_SEQ.NEXTVAL into keypre FROM dual;
        keypre := (keypre * 0.000001) + to_number(to_char(sysdate, 'YYMMDD'));
        BEGIN
           INSERT INTO LABPROD.nmlopres
            (pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
            pre_tippre, pre_unipre, pre_imppre, pre_gastos, pre_plazop,
            pre_unides, pre_impdes, pre_porint, pre_perini, pre_fecini,
            pre_fecaut, pre_cveaut, pre_fechab, pre_uniamo, pre_impamo,
            pre_unisal, pre_impsal, pre_uniult, pre_impult, pre_numpag,
            pre_intpag, pre_status, pre_ultact, pre_refcon, pre_ctreve,
            pre_fe1aux, pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux,
            pre_ca4aux, pre_uniope, pre_keypro, pre_impnoa, pre_pernoa)
          VALUES(
              v_empleado.keyemp, keycon, keypre , cveref, SYSDATE,
              'N', unipre, monsol, 0, 0,
              unides, mondes, 0, peract, v_periodo.fecini,
              NULL, NULL, NULL, 0, 0,
              unisal, monsol, 0, 0, 0,
              0, 2, SYSDATE, NULL, NULL,
              NULL, NULL, NULL, client, mondes + unides,
              v_empleado.keypro, 1, v_empleado.keypro, NULL, NULL);
        EXCEPTION
              WHEN OTHERS THEN
                resultado := 15; RETURN;
        END;
        -- salda el pr??stamo anterior
        BEGIN
            UPDATE LABPROD.nmlopres SET pre_status = 2, pre_impsal = 0, pre_unisal = 0
            WHERE pre_refere = cveres
            AND pre_keyemp = v_empleado.keyemp
            AND pre_ca2aux = '1'
            AND pre_keycon = keycon;
        EXCEPTION
          WHEN OTHERS THEN
            resultado := 16; RETURN;
        END;
      END IF;
	END IF;
--calcula nueva capacidad de descuento
    LABPROD.SP_CAPDES_LOCAL(v_empleado.keyemp, capdes);
--termina
    resultado :=0;
  END Reestructura;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO ELIMINA_PRESTAMO
/* -------------------------------------------------------------------------- */
  PROCEDURE Elimina_Prestamo ( recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , cveref IN LABPROD.nmlopres.pre_refere%TYPE, keycon IN LABPROD.nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
    Validacion (recurp, keycon, v_var, v_empleado, v_periodo); --Existencia de empleado, periodo y concepto
    if v_var > 0 then
      resultado := v_var; RETURN;
    end if;
-- Valida si existe el prestamo 06052014
    IF existe_prestamo(cveref, v_empleado.keyemp, keycon, 2034151) = 0 THEN
      resultado := 3; RETURN;
    END IF;
--compara rango de fechas de calendario
    --IF (trunc(SYSDATE) > v_periodo.fecini AND trunc(SYSDATE) < v_periodo.fecfin) THEN
      --resultado := 4; RETURN; -- la n??mina se est?? calculando
    --END IF;
--Elimina registro de pr??stamo
            BEGIN
                DELETE FROM LABPROD.nmlopres
                WHERE pre_refere = cveref
                AND pre_keyemp = v_empleado.keyemp
                AND pre_keycon = keycon
                AND pre_ca2aux = 1;
           EXCEPTION
              WHEN OTHERS THEN
                resultado := 17; RETURN;
           END;
--si no se eliminaron registros, avisar
    IF SQL%ROWCOUNT = 0 THEN
      resultado := 3; RETURN;
    END IF;
--calcula nueva capacidad de descuento
    LABPROD.SP_CAPDES_LOCAL(v_empleado.keyemp, capdes);
--termina
    resultado :=0;
  END Elimina_Prestamo;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO ACTUALIZA_PRESTAMO
/* -------------------------------------------------------------------------- */
  PROCEDURE Actualiza_Prestamo ( recurp IN LABPROD.nmcoempl.emp_recurp%TYPE , cveref IN LABPROD.nmlopres.pre_refere%TYPE, keycon IN LABPROD.nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
    Validacion (recurp, keycon, v_var, v_empleado, v_periodo); --Existencia de empleado, periodo y concepto
    if v_var > 0 then
      resultado := v_var; RETURN;
    end if;
--consulta perini del pr??stamo
            BEGIN
                select pre_perini into perini From LABPROD.nmlopres
                Where pre_keyemp = v_empleado.keyemp
                AND pre_refere = cveref AND pre_keycon = keycon;
           EXCEPTION
              WHEN OTHERS THEN
                resultado := 18; RETURN;
           END;
--Verifica si existe el pr??stamo
IF existe_prestamo(cveref, v_empleado.keyemp, keycon, 14) > 0 THEN
      resultado := 9; RETURN;
END IF;
--compara rango de fechas de calendario
    IF (trunc(SYSDATE) > v_periodo.fecini AND trunc(SYSDATE) < v_periodo.fecfin) THEN
      --resultado := 4; RETURN; -- la n??mina se est?? calculando
	    if perini <= v_periodo.period then
			  if to_number(substr(v_periodo.period, 5, 3)) = floor(365/v_periodo.diaper) then
					  peract := to_char(to_number(substr(v_periodo.period, 1, 4))+1) || '001';
					else
					  peract := to_char(to_number(v_periodo.period) + 1);
			  end if;
            BEGIN
                UPDATE LABPROD.nmlopres SET pre_status = 2, pre_perini = peract
                WHERE pre_refere = cveref
                AND pre_keyemp = v_empleado.keyemp
                AND pre_keycon = keycon
                AND pre_ca2aux = 1
                AND pre_status = 1;
           EXCEPTION
              WHEN OTHERS THEN
                resultado := 16; RETURN;
           END;
           --si no se actualizaron registros, avisar
          IF SQL%ROWCOUNT = 0 THEN
            resultado := 3; RETURN;
          END IF;
        else
                      --Actualiza registro de pr??stamo
                    BEGIN
                        UPDATE LABPROD.nmlopres SET pre_status = 2
                        WHERE pre_refere = cveref
                        AND pre_keyemp = v_empleado.keyemp
                        AND pre_keycon = keycon
                        AND pre_ca2aux = 1
                        AND pre_status = 1;
                   EXCEPTION
                      WHEN OTHERS THEN
                        resultado := 16; RETURN;
                   END;
            --si no se actualizaron registros, avisar
                IF SQL%ROWCOUNT = 0 THEN
                  resultado := 3; RETURN;
                END IF;
        end if;
    ELSE
    --Actualiza registro de pr??stamo
            BEGIN
                UPDATE LABPROD.nmlopres SET pre_status = 2
                WHERE pre_refere = cveref
                AND pre_keyemp = v_empleado.keyemp
                AND pre_keycon = keycon
                AND pre_ca2aux = 1
                AND pre_status = 1;
           EXCEPTION
              WHEN OTHERS THEN
                resultado := 16; RETURN;
           END;
    --si no se actualizaron registros, avisar
        IF SQL%ROWCOUNT = 0 THEN
          resultado := 3; RETURN;
        END IF;
    END IF;
/*
--compara rango de fechas de calendario
    IF (trunc(SYSDATE) > v_periodo.fecini AND trunc(SYSDATE) < v_periodo.fecfin) and perini <= v_periodo.period THEN
      resultado := 4; RETURN; -- la n??mina se est?? calculando
    END IF;
--Verifica si existe el pr??stamo
IF existe_prestamo(cveref, v_empleado.keyemp, keycon, 14) > 0 THEN
      resultado := 9; RETURN;
END IF;
*/
--calcula nueva capacidad de descuento
    LABPROD.SP_CAPDES_LOCAL(v_empleado.keyemp, capdes);
--termina
    resultado :=0;
  END Actualiza_Prestamo;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO INSERTA_PRESTAMO
/* -------------------------------------------------------------------------- */
PROCEDURE Inserta_Prestamo (recurp IN LABPROD.nmcoempl.emp_recurp%TYPE, totsol in number, impdes in number, totint in number, intdes in number, unisal in number,
                              cvecli in varchar, cveref IN LABPROD.nmlopres.pre_refere%TYPE, keycon IN LABPROD.nmloconc.con_keycon%TYPE, resultado OUT NUMBER) IS
  BEGIN
    Validacion (recurp, keycon, v_var, v_empleado, v_periodo); --Existencia de empleado, periodo y concepto
    if v_var > 0 then
      resultado := v_var; RETURN;
    end if;
    --compara rango de fechas de calendario
    peract := v_periodo.period;
    IF (trunc(SYSDATE) > v_periodo.fecini AND trunc(SYSDATE) < v_periodo.fecfin) THEN
      if to_number(substr(v_periodo.period, 5, 3)) = floor(365/v_periodo.diaper) then
        peract := to_char(to_number(substr(v_periodo.period, 1, 4))+1) || '001';
      else
        peract := to_char(to_number(v_periodo.period) + 1);
       end if;
    END IF;
--incapacitados
            BEGIN
                select count(*) into total From LABPROD.nmlopres
                Where pre_keyemp = v_empleado.keyemp
                AND pre_status = '2'
                AND pre_keycon IN ('307','308','309')
                AND trunc(sysdate) >= pre_fecini
                AND trunc(sysdate) <= pre_fe1aux;
           EXCEPTION
              WHEN OTHERS THEN
                resultado := 18; RETURN;
           END;
     --6. incapacitado
  IF total > 0 THEN
    resultado := 14;
    RETURN;
  END IF;
  -------------------------------------------
  --Solicitud Concepto 89A
            BEGIN
                select count(*) into total From LABPROD.glcopams
                where pam_keypar = 'SAFF' and pam_folini = keycon;
           EXCEPTION
              WHEN OTHERS THEN
                resultado := 18; RETURN;
           END;
  IF total > 0 THEN
    impdes_validado := 0;
  ELSE
    impdes_validado := impdes;
  END IF;
--valida que no exista
  IF existe_prestamo(cveref, v_empleado.keyemp, keycon, 1) > 0 THEN
      resultado := 9; RETURN;
  ELSE
		--calcula capacidad de descuento
      LABPROD.sp_capdes(v_empleado.keyemp, capdes);
      IF FLOOR(30/v_periodo.diaper)*(impdes+intdes) > capdes THEN
          resultado := 11; RETURN;
      ELSE
			--Campos a Insertar
           BEGIN
                select per_fecini into fecini from LABPROD.nmloperi
                where per_keyper = peract
                and per_keypro = v_empleado.keypro;
           EXCEPTION
              WHEN OTHERS THEN
                resultado := 18; RETURN;
           END;
        SELECT LABPROD.NMLOPRES_SEQ.NEXTVAL into keypre FROM dual;
        keypre := (keypre * 0.000001) + to_number(to_char(sysdate, 'YYMMDD'));
           BEGIN
                 INSERT INTO LABPROD.nmlopres
                  (pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
                  pre_tippre, pre_unipre, pre_imppre, pre_gastos, pre_plazop,
                  pre_unides, pre_impdes, pre_porint, pre_perini, pre_fecini,
                  pre_fecaut, pre_cveaut, pre_fechab, pre_uniamo, pre_impamo,
                  pre_unisal, pre_impsal, pre_uniult, pre_impult, pre_numpag,
                  pre_intpag, pre_status, pre_ultact, pre_refcon, pre_ctreve,
                  pre_fe1aux, pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux,
                  pre_ca4aux, pre_uniope, pre_keypro, pre_impnoa, pre_pernoa)
                VALUES(
                    v_empleado.keyemp, keycon, keypre , cveref, SYSDATE,
                    'N', totint, totsol, 0, 0,
                    intdes, impdes_validado, 0, peract, fecini,
                    NULL, NULL, NULL, 0, 0,
                    unisal, totsol, 0, 0, 0,
                    0, 1, SYSDATE, NULL, NULL,
                    NULL, NULL, NULL, 1, impdes + intdes,
                    v_empleado.keypro, 1, v_empleado.keypro, NULL, NULL);
           EXCEPTION
              WHEN OTHERS THEN
                resultado := 15; RETURN;
           END;
        END IF;
    END IF;
------------------------------------------
------------------------------------------
--calcula nueva capacidad de descuento
    LABPROD.SP_CAPDES_LOCAL(v_empleado.keyemp, capdes);
--termina
    resultado :=0;
  END Inserta_Prestamo;
/* -------------------------------------------------------------------------- */
--PROCEDIMIENTO VALIDACION
 /* -------------------------------------------------------------------------- */
 PROCEDURE Validacion (recurp IN LABPROD.nmcoempl.emp_recurp%TYPE, keycon IN LABPROD.nmloconc.con_keycon%TYPE, resultado OUT NUMBER, emp OUT empleado, per OUT periodo) IS
   BEGIN
--1, 2. Buscar datos del Empleado
    emp := existe_empleado(recurp);
    IF emp.keyemp IS NULL THEN resultado := 1; RETURN; END IF;
    IF emp.status = 2 THEN resultado := 2; RETURN; END IF;
--3. Buscar Concepto
    IF existe_concepto(keycon) = 0 THEN resultado := 8; RETURN; END IF;
--4. Busca Periodo, fechas de Calendario
    per :=  existe_periodo ( emp );
    prueba := per.diaper;
    IF (per.diaper <> 7 and per.diaper <> 10 and per.diaper <> 15)
      THEN resultado := 13;
      RETURN;
    END IF;
    IF per.period IS NULL THEN resultado := 5;  RETURN; END IF;
     resultado := 0;
   END Validacion;
 PROCEDURE ValidacionDesafiliar (recurp IN LABPROD.nmcoempl.emp_recurp%TYPE, keycon IN LABPROD.nmloconc.con_keycon%TYPE, resultado OUT NUMBER, emp OUT empleado, per OUT periodo) IS
   BEGIN
--1, 2. Buscar datos del Empleado
    emp := existe_empleado(recurp);
    IF emp.keyemp IS NULL THEN resultado := 1; RETURN; END IF;
    --IF emp.status = 2 THEN resultado := 2; RETURN; END IF;
--3. Buscar Concepto
    IF existe_concepto(keycon) = 0 THEN resultado := 8; RETURN; END IF;
--4. Busca Periodo, fechas de Calendario
    per :=  existe_periodo ( emp );
    prueba := per.diaper;
    IF (per.diaper <> 7 and per.diaper <> 10 and per.diaper <> 15)
      THEN resultado := 13;
      RETURN;
    END IF;
    IF per.period IS NULL THEN resultado := 5;  RETURN; END IF;
     resultado := 0;
   END ValidacionDesafiliar;
/* -------------------------------------------------------------------------- */
--FUNCTION EXISTE EMPLEADO
/* -------------------------------------------------------------------------- */
   FUNCTION existe_empleado ( recurp IN LABPROD.nmcoempl.emp_recurp%TYPE )  RETURN empleado IS
   BEGIN
      FOR q_empleado IN
        (SELECT emp_keyemp,emp_keydep,emp_keypue,emp_keypro,emp_status FROM LABPROD.nmcoempl WHERE emp_recurp = recurp ORDER BY emp_status)
      LOOP
          v_empleado.keyemp := q_empleado.emp_keyemp;
          v_empleado.keydep := q_empleado.emp_keydep;
          v_empleado.keypue := q_empleado.emp_keypue;
          v_empleado.keypro := q_empleado.emp_keypro;
          v_empleado.status := q_empleado.emp_status;
          EXIT;
      END LOOP;
      RETURN v_empleado;
   END existe_empleado;
/* -------------------------------------------------------------------------- */
  --FUNCTION EXISTE CONCEPTO
 /* -------------------------------------------------------------------------- */
   FUNCTION existe_concepto (keycon IN LABPROD.nmloconc.con_keycon%TYPE) RETURN NUMBER IS
   BEGIN
      SELECT COUNT(*) INTO total FROM LABPROD.nmloconc WHERE con_keycon = keycon;
      RETURN total;
   END existe_concepto;
/* -------------------------------------------------------------------------- */
--FUNCTION EXISTE PERIODO
/* -------------------------------------------------------------------------- */
   FUNCTION existe_periodo ( empl IN empleado ) RETURN periodo IS
   BEGIN
    SELECT pro_diaper INTO v_periodo.diaper
    FROM LABPROD.nmloproc WHERE pro_keypro = empl.keypro;
    IF v_periodo.diaper = 7 Then v_periodo.cvecal := 'CPS';
    Elsif v_periodo.diaper = 10 Then v_periodo.cvecal := 'CPD';
    ElsIf v_periodo.diaper = 15 Then v_periodo.cvecal := 'CPQ';
    END IF;    --pasar??a algo distinto de 7,10,15?
      FOR q_periodo IN
          (SELECT pam_nompar, pam_folini, pam_folfin FROM LABPROD.glcopams WHERE pam_keypar = v_periodo.cvecal
          AND pam_nompar = (SELECT MIN(per_keyper) FROM LABPROD.nmloperi WHERE per_keypro = empl.keypro AND per_keynom IN( 1, 26 ) AND per_fecact IS NULL))
      LOOP
          v_periodo.period := q_periodo.pam_nompar;
          v_periodo.fecini := q_periodo.pam_folini;
          v_periodo.fecfin := q_periodo.pam_folfin;
          EXIT;
      END LOOP;
      RETURN v_periodo;
   END existe_periodo;
/* -------------------------------------------------------------------------- */
--FUNCTION EXISTE PRESTAMO
 /* -------------------------------------------------------------------------- */
   FUNCTION existe_prestamo (cveref IN LABPROD.nmlopres.pre_refere%TYPE, keyemp IN LABPROD.nmlopres.pre_keyemp%TYPE, keycon IN LABPROD.nmlopres.pre_keycon%TYPE, tipact IN NUMBER) RETURN NUMBER IS
   BEGIN
    IF tipact = 14 THEN
      SELECT COUNT(*) INTO total FROM LABPROD.nmlopres
      WHERE pre_refere = cveref AND pre_keyemp = keyemp
      AND pre_ca2aux = 1 AND pre_keycon = keycon
      AND pre_status = 2;
    ELSIF tipact = 2034151 THEN
      SELECT COUNT(*) INTO total FROM LABPROD.nmlopres
      WHERE pre_refere = cveref AND pre_keyemp = keyemp
      AND pre_ca2aux = 1 AND pre_keycon = keycon
      AND pre_status = 1;
    ELSE
      SELECT COUNT(*) INTO total FROM LABPROD.nmlopres
      WHERE pre_refere = cveref AND pre_keyemp = keyemp
      AND pre_ca2aux = 1 AND pre_keycon = keycon;
    END IF;
      RETURN total;
   END existe_prestamo;
/* -------------------------------------------------------------------------- */
--FUNCTION EXISTE AFILIACI??N
 /* -------------------------------------------------------------------------- */
   FUNCTION existe_afiliacion (keyemp IN LABPROD.nmlodfij.dfi_keyemp%TYPE, keycon IN LABPROD.nmlodfij.dfi_keycon%TYPE, keypro IN LABPROD.nmlodfij.dfi_keypro%TYPE) RETURN afiliacion IS
   BEGIN
      FOR q_afiliacion IN
          (SELECT dfi_cantid, dfi_import FROM LABPROD.nmlodfij WHERE dfi_keyemp = keyemp AND dfi_keycon = keycon AND dfi_keypro = keypro)
      LOOP
          v_afiliacion.keycon := keycon;
          v_afiliacion.porcen := q_afiliacion.dfi_cantid;
		      v_afiliacion.cuofij := q_afiliacion.dfi_import;
          EXIT;
      END LOOP;
      RETURN v_afiliacion;
   END existe_afiliacion;
/* -------------------------------------------------------------------------- */
END TVCDESAF_LOCAL;
/;
