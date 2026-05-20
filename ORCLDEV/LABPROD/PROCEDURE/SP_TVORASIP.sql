CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_TVORASIP" (wi_proceso IN SMALLINT, conta_a IN VARCHAR2, psConceptos IN VARCHAR2,
psConceptosOpci IN VARCHAR2, psKeyUsu IN INTEGER, conta_o OUT VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  sPer_keyper VARCHAR2(7);
  dPer_fecini DATE;
  iPre_impsal DECIMAL(12,2);
  iPre_impamo DECIMAL(12,2);
  wn_tot_mov DECIMAL(16,6);
  wi_valido  INTEGER;
  wi_refere  INTEGER;
  i          INTEGER;
  conta      DECIMAL(16,6);
-- Lectura de la tabla 'ap_sipros' para actualizar el proceso      ---
-- asi como el status del empleado, para poder hacer despues el filtro ---
--Si no hay filtros de conceptos y conceptos opci
BEGIN
	-- Lectura de la tabla 'ap_sipros' para fecha y carga nulas --
	-- asi como el filtro de Proceso ---
	-- Validacion del archivo de entrada ---
  FOR c_2 IN (
	  SELECT
	   soi_keyemp, soi_keycon, soi_refere, soi_tipope,
	   soi_import, soi_fecope, soi_tipmon, soi_tipcam,
	   soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
	  --INTO
	   --iSoi_keyemp, sSoi_keycon, sSoi_refere, sSoi_tipope,
	   --sSoi_import, iSoi_fecope, sSoi_tipmon, sSoi_tipcam,
	   --sSoi_tipreg, sSoi_keypre, iSoi_keypro, iSoi_status, sSoi_refamo
	  FROM
	   ap_sipros
	  WHERE soi_feccar IS NULL
	  AND   soi_stacar IS NULL
	  AND   soi_keypro = wi_proceso)
  LOOP
  -- Valido prestamo
    wi_valido := 0;
    SELECT COUNT(*) INTO wi_valido
      FROM nmlopres
      WHERE pre_keyemp = c_2.soi_keyemp
        AND pre_keycon  = c_2.soi_keycon
        AND pre_refere  = c_2.soi_refere;
    IF wi_valido > 0 THEN
           --- si ya existe el prestamo rechazo los anticipos ---
      UPDATE ap_sipros
       SET soi_tipreg = 'R',
           soi_keypre = 0,
           soi_feccar = TRUNC(SYSDATE),
           soi_stacar = 'P'
        WHERE soi_keyemp = c_2.soi_keyemp
          AND   soi_keycon = c_2.soi_keycon
          AND   soi_refere = c_2.soi_refere
          AND   soi_tipreg = 'A'
          AND   soi_feccar IS NULL
          AND   soi_stacar IS NULL
          AND   soi_refamo = c_2.soi_refamo;
      COMMIT;
      CONTINUE;
    END IF;
      --- Rechazo los prestamos nuevos (anticipos = 'A')
      --- y el proceso sea igual al proceso enviado por parametro
      --- para los empleados dados de baja (10-agosto-2001)
    UPDATE ap_sipros
       SET soi_tipreg = 'R',
         soi_keypre = 0,
         soi_feccar = TRUNC(SYSDATE),
         soi_stacar = 'P'
      WHERE soi_tipreg = 'A'
        AND soi_status = 2
        AND   soi_feccar IS NULL
        AND   soi_stacar IS NULL
        AND   soi_refamo = c_2.soi_refamo
        AND   soi_keypro = wi_proceso;
    COMMIT;
	      --- Rechazo cualquier registro cuyo tipreg no sea 'A', 'C' y no haya
	      --- sido rechazado anteriormente (fecha de carga nula)
	      --- y el proceso sea igual al proceso enviado por parametro
    UPDATE ap_sipros
       SET  soi_keypre = 0,
            soi_tipreg = 'R',
            soi_feccar = TRUNC(SYSDATE),
            soi_stacar = 'P'
     WHERE soi_tipreg NOT IN ('A','C','R','E','O')
     AND   soi_feccar IS NULL
     AND   soi_stacar IS NULL
     AND   soi_refamo = c_2.soi_refamo
     AND   soi_keypro = wi_proceso;
    COMMIT;
	END LOOP;
	-- Empiezo con los anticipos
	-- Asigno la llave de Prestamos mientras sea 'A' (anticipos)
	-- y el proceso sea igual al proceso enviado por parametro
	-- para empleados activos (23 - julio- 2001)
  conta := conta_a;
	FOR c_3 IN (
	  SELECT
	   soi_keyemp, soi_keycon, soi_refere, soi_tipope,
	   soi_import, soi_fecope, soi_tipmon, soi_tipcam,
	   soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
	  --INTO
	   --iSoi_keyemp, sSoi_keycon, sSoi_refere, sSoi_tipope,
	   --sSoi_import, iSoi_fecope, sSoi_tipmon, sSoi_tipcam,
	   --sSoi_tipreg, sSoi_keypre, iSoi_keypro, iSoi_status, sSoi_refamo
	  FROM
	   ap_sipros
	  WHERE soi_tipreg = 'A'
	  AND   soi_status = 1   --- 23-julio-2001  ---
	  AND   soi_feccar IS NULL
	  AND   soi_stacar IS NULL
	  AND   soi_keypro = wi_proceso)
  LOOP
    --SP_NMKEYPRE2('',wn_tot_mov);
    --wn_tot_mov := wn_tot_mov + conta;
    conta := conta + 0.000001;
    dPer_fecini := c_3.soi_fecope;
	-- Inserto en la tabla 'nmlopres' los anticipos del dia de hoy---
	-- cuando el proceso sea igual al proceso enviado por parametro ---
	-- y empleados activos (23-julio-2001)
	  --CARSI SELECT per_keyper, per_fecini INTO sPer_keyper, dPer_fecini
	  SELECT per_keyper INTO sPer_keyper
	    FROM nmloperi
	   WHERE per_keypro= c_3.soi_keypro
	    AND  per_fecini <= c_3.soi_fecope     --CARSI wd_fecope
	    AND  per_fecfin >= c_3.soi_fecope     --CARSI wd_fecope
	    AND  per_keynom=1;
	   --actualizo tipo de cambio a 1 para Moneda Nacional
    IF c_3.soi_tipmon = '1' THEN
      IF c_3.soi_tipcam = 0.0 THEN
        c_3.soi_tipcam := 1.0;
      END IF;
    END IF;
    INSERT INTO nmlopres
      (pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
      pre_tippre, pre_unipre, pre_imppre, pre_gastos, pre_plazop,
      pre_unides, pre_impdes, pre_porint, pre_perini, pre_fecini,
      pre_fecaut, pre_cveaut, pre_fechab, pre_uniamo, pre_impamo,
      pre_unisal, pre_impsal, pre_uniult, pre_impult, pre_numpag,
      pre_intpag, pre_status, pre_ultact, pre_refcon, pre_ctreve,
      pre_fe1aux, pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux,
      pre_ca4aux, pre_uniope, pre_keypro)
    VALUES
    (
      c_3.soi_keyemp, c_3.soi_keycon, conta, c_3.soi_refere, c_3.soi_fecope,
      1          , NULL       , c_3.soi_import, NULL       , 1          ,
      NULL       , c_3.soi_import, 0          , sPer_keyper, dPer_fecini,
      c_3.soi_fecope, NULL       , NULL       , 0          , 0          ,
      0          , c_3.soi_import, 0          , 0          , 0          ,
      0          , 4          , c_3.soi_fecope, NULL       , c_3.soi_refamo,
      NULL       , NULL       , c_3.soi_tipmon, c_3.soi_tipcam, NULL       ,
      NULL       , NULL       , c_3.soi_keypro
    );
	  UPDATE ap_sipros
	     SET soi_keypre = wn_tot_mov,
	         soi_feccar = TRUNC(SYSDATE),
	         soi_stacar = 'P'
	   WHERE soi_keyemp = c_3.soi_keyemp
	   AND   soi_keycon = c_3.soi_keycon
	   AND   soi_refere = c_3.soi_refere
	   AND   soi_tipreg = 'A'
	   AND   soi_feccar IS NULL
	   AND   soi_stacar IS NULL
	   AND   soi_refamo = c_3.soi_refamo;
     COMMIT;
	END LOOP;
  conta_o := conta;
END;
/
