CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_I_VACACIONES2" 
(fFechaProceso in date,o_num_r_procesados out integer, o_num_r_insertados out integer,
				o_num_r_actualizados out integer, o_iRegFijP out integer, o_iRegFijN out integer) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
         num_r_procesados         INTEGER;
         num_r_insertados         INTEGER;
         num_r_actualizados       INTEGER;
         --fFechaProceso      	  DATE;
         n_meses_expiracion       INTEGER;
         ckeycon            	  CHAR(3);
         n_keyemp                 INTEGER;
         n_anio_trabajados        INTEGER;
         n_annio_proceso          INTEGER;
         n_mes_proceso            INTEGER;
         n_dia_proceso            INTEGER;
         n_keypro                 INTEGER;
         n_annio_proc_ant         INTEGER;
         n_confianza              INTEGER;
         d_fecha_ingreso          DATE;
         c_keydep                 CHAR(16);
         c_keypue                 CHAR(16);
         c_periodo          		CHAR(9);
         c_tab_vacaciones   	CHAR(3);
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
		ws_pva_stapas      CHAR(30);
		iRegFijP           INTEGER;
		iRegFijN           INTEGER;
		iexistecon         INTEGER;
		cpereje            CHAR(7);
    --pFecha          DATE;
--Igneos.I
CURSOR cursor1 (fFechaProceso_c1 IN DATE) IS
  SELECT emp_keyemp, YEAR(fFechaProceso_c1) - Year(emp_fecaux), Year(fFechaProceso_c1) -1 || '-' || Year(fFechaProceso_c1),
         YEAR(fFechaProceso_c1), MONTH(emp_fecaux), DAY(emp_fecaux), emp_keypro, YEAR(fFechaProceso_c1) - 1,
		 emp_tipemp,emp_fecaux,emp_keydep,emp_keypue
		FROM nmcoempl
		WHERE emp_status = 1 AND YEAR(emp_fecaux)  < YEAR(fFechaProceso_c1) AND MONTH(emp_fecaux) = MONTH(fFechaProceso_c1)
			AND DAY(emp_fecaux)   = DAY(fFechaProceso_c1);
-------------------------
CURSOR cursor3 IS
SELECT emp_keyemp, emp_keypro, emp_keydep, emp_keypue
     FROM nmcoempl WHERE emp_status = 1;
BEGIN
--i.i
      --pFecha := SYSDATE;
        num_r_procesados   := 0;
        num_r_actualizados := 0;
        num_r_insertados   := 0;
        n_meses_expiracion := 6;
        --  el numero de concepto para la actualizaci?e datos fijos.
        ckeycon := '607';
        --Se lee y evalua la fecha de procesamiento
        --fFechaProceso := SYSDATE;
        --fFechaProceso := 'OCT 09 2011';
        --fFechaProceso := DAY(SYSDATE) || '/' || MONTH(SYSDATE) || '/' || YEAR(SYSDATE);
        --IF YEAR(fFechaProceso) = 1900 AND MONTH(fFechaProceso) = 1 AND DAY(fFechaProceso) = 1 THEN
        --        fFechaProceso := DAY(SYSDATE) || '/' || MONTH(SYSDATE) || '/' || YEAR(SYSDATE);
        --END IF;
----------------------------------
--Igneos.I
  OPEN cursor1(fFechaProceso);
	LOOP
        FETCH cursor1 INTO n_keyemp,n_anio_trabajados,c_periodo,n_annio_proceso,n_mes_proceso,n_dia_proceso,n_keypro,
               n_annio_proc_ant,n_confianza,d_fecha_ingreso,c_keydep,c_keypue;
		EXIT WHEN cursor1%NOTFOUND;
      /* The original statement block */
	--Lleva la cuenta de los registros procesados
        num_r_procesados := num_r_procesados + 1;
        --Se valida que la fecha de proceso NO sea biciesto
        IF n_mes_proceso = 2 AND n_dia_proceso = 29 THEN n_dia_proceso := 28; END IF;
        --Obtengo la tabla que le corresponde para la obtenci?e las vacaciones
		begin SELECT pam_folfin INTO c_tab_vacaciones
			FROM glcopams WHERE pam_keypar = 'TTV' AND pam_nompar = 'TABLA DE VACACIONES' AND pam_cvesec = to_char(n_keypro);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
      NULL;
    end;
  --FOREACH
                --Obtengo el rango de a?trabajados en el que cae el empleado
     BEGIN
          SELECT min(tab_eledos) INTO n_r_anio_trab FROM nmlotabn
          WHERE tab_keytab= trim(c_tab_vacaciones) And tab_eledos >= n_anio_trabajados ORDER BY tab_eledos;
     EXCEPTION
          WHEN NO_DATA_FOUND THEN
          NULL;
     END;
        --EXIT FOREACH;
	--END FOREACH;
        --Valido si el empleado es de confianza (1) o NO (2)
        IF n_confianza = 2 THEN
			    SELECT DISTINCT tab_elecua INTO n_dias_vacaciones FROM nmlotabn
            WHERE tab_keytab = trim(c_tab_vacaciones) AND  tab_eledos = n_r_anio_trab;
        ELSE
                --Obtengo los d? que le corresponden de vacaciones
          SELECT DISTINCT tab_eletre INTO n_dias_vacaciones FROM nmlotabn
			      WHERE tab_keytab = trim(c_tab_vacaciones) AND  tab_eledos = n_r_anio_trab;
			      IF n_dias_vacaciones IS NULL THEN
                n_anio_trabajados := n_anio_trabajados + '.000002';
            END IF;
        END IF;
        --to_date('2003/07/09', 'yyyy/mm/dd')
        --Armo la fecha para poder calcular la fecha de expiraci?
        d_fecha_calculo := to_date(to_char(n_dia_proceso) || '/' || to_char(n_mes_proceso) || '/' || to_char(n_annio_proceso), 'dd/mm/yyyy');
        d_fecha_calculo2 := to_date(to_char(n_dia_proceso) || '/' || to_char(n_mes_proceso) || '/' || to_char(n_annio_proceso + 1), 'dd/mm/yyyy');
        d_fecha_calculo1 := d_fecha_calculo2 - 1;
        --Lo meto en un ciclo para validar que sea una fecha valida, ya que la fecha pudiera se invalida.
        --d_f_expiracion := add_months(TO_DATE(d_fecha_calculo1,'dd/mm/yyyy'), n_meses_expiracion);
        d_f_expiracion := add_months(d_fecha_calculo1, n_meses_expiracion);
        --Verifico que el empleado NO tenga ya calculado su periodo de vacaciones para el periodo
        n_existe := 0;
        SELECT COUNT(*) INTO n_existe
        FROM nmcocvac WHERE vac_keyemp = n_keyemp AND  vac_period = c_periodo ;
        IF n_existe = 0 THEN
           BEGIN
            INSERT INTO nmcocvac ( vac_keyemp, vac_antigu, vac_diavac,vac_period, vac_fecini, vac_fecfin,vac_fecpre, vac_dtomad, vac_salper,vac_status, vac_cosrea)
			          VALUES (n_keyemp, n_anio_trabajados, n_dias_vacaciones,c_periodo, d_fecha_calculo, d_fecha_calculo1,d_f_expiracion, 0, n_dias_vacaciones,'V', 0);
                num_r_insertados := num_r_insertados + 1;
           EXCEPTION
             WHEN OTHERS THEN
               NULL;
           END;
        ELSE
                wd_vac_salper := '0.00';
      BEGIN
        SELECT distinct vac_status INTO ws_vac_status FROM nmcocvac
        WHERE vac_keyemp = n_keyemp AND   vac_period = c_periodo;
      EXCEPTION
          WHEN NO_DATA_FOUND THEN
          NULL;
      END;
			IF ws_vac_status = 'A' THEN
				SELECT distinct vac_salper * -1 , vac_antigu INTO wd_vac_salper, nagnostrab
				FROM nmcocvac WHERE vac_keyemp = n_keyemp AND vac_status = 'A' AND vac_period = c_periodo;
                idiasvac := n_dias_vacaciones - wd_vac_salper;
				SELECT vac_fecini, to_date(fFechaProceso) INTO dfecini, dfecnow
				FROM nmcocvac WHERE vac_keyemp = n_keyemp AND vac_status = 'A' AND vac_period = c_periodo;
				UPDATE nmcocvac SET vac_diavac = n_dias_vacaciones, vac_salper = idiasvac,
				vac_status = 'V', vac_fecini = d_fecha_calculo, vac_fecfin = d_fecha_calculo1, vac_fecpre = d_f_expiracion,
        vac_antigu = n_anio_trabajados
				WHERE vac_keyemp = n_keyemp AND vac_period = c_periodo;
                num_r_actualizados := num_r_actualizados + 1;
			END IF;
		END IF;
    COMMIT;
	END LOOP;
 CLOSE cursor1;
----------------------------------------------------------------------
--Actualizo el estatus a expirado (E) a todos los registros que su fecha de expiraci?ea menor a la fecha de proceso
UPDATE nmcocvac SET vac_status = 'E' WHERE vac_fecpre < to_date(fFechaProceso) AND vac_status = 'V';
--Actualizo datos en tablas de datos fijos
iRegFijP := 0;
iRegFijN := 0;
----------------------------------
--Igneos.I
OPEN cursor3;
	LOOP
		FETCH cursor3 INTO nkeyemp, nkeypro, ckeydep, ckeypue;
		EXIT WHEN cursor3%NOTFOUND;
      /* The original statement block */
		wd_vac_salper := '0.0';
    -- Actualizo la Tabla de Datos Fijos
     BEGIN
          SELECT UPPER(dat_valpar) INTO ws_pva_stapas FROM nmlodata WHERE dat_keyemp = nkeyemp AND dat_keypar = '28';
     EXCEPTION
          WHEN NO_DATA_FOUND THEN
          NULL;
     END;
    --i.i
		wd_vac_salper := '0.0';
		IF ws_pva_stapas = 'S' OR ws_pva_stapas = 'SI' THEN
			SELECT SUM(vac_salper) INTO wd_vac_salper FROM nmcocvac WHERE vac_status IN ('V','A','P') AND vac_keyemp = nkeyemp;
			iRegFijP := iRegFijP + 1;
		ELSE
			SELECT SUM(vac_salper) INTO wd_vac_salper FROM nmcocvac WHERE vac_status IN ('V','A') AND vac_keyemp = nkeyemp;
			iRegFijN := iRegFijN + 1;
		END IF;
		iexistecon := 0;
     BEGIN
          SELECT pro_pereje INTO cpereje FROM nmloproc WHERE pro_keypro = nkeypro;
     EXCEPTION
          WHEN NO_DATA_FOUND THEN
          NULL;
     END;
     BEGIN
          SELECT DISTINCT dfi_keyemp INTO iexistecon FROM nmlodfij
          WHERE dfi_keycon = ckeycon AND dfi_keyemp = nkeyemp AND dfi_keypro = nkeypro;
     EXCEPTION
          WHEN NO_DATA_FOUND THEN
          NULL;
     END;
		IF ckeycon IS NOT NULL THEN
			IF iexistecon IS NULL THEN
				INSERT INTO nmlodfij VALUES(nkeyemp,ckeycon,nkeypro,cpereje,2020999,ckeydep, ckeypue,fFechaProceso,wd_vac_salper,0.0,' ',' ');
			ELSE
				UPDATE nmlodfij SET dfi_cantid = wd_vac_salper WHERE dfi_keyemp = nkeyemp AND dfi_keycon = ckeycon AND dfi_keypro = nkeypro ;
			END IF;
		END IF;
	END LOOP;
 CLOSE cursor3;
---------------------------------
o_num_r_procesados := num_r_procesados;
o_num_r_insertados := num_r_insertados;
o_num_r_actualizados := num_r_actualizados;
o_iRegFijP := iRegFijP;
o_iRegFijN := iRegFijN;
END;
/
