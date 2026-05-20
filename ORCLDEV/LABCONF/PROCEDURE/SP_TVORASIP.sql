CREATE OR REPLACE EDITIONABLE PROCEDURE "LABCONF"."SP_TVORASIP" (wi_proceso IN SMALLINT, conta_a IN DECIMAL, psConceptos IN VARCHAR2,
psConceptosOpci IN VARCHAR2, psKeyUsu IN INTEGER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
--Variables
-- Tabla de 'ap_sipros'
  iSoi_keyemp INTEGER;
  sSoi_keycon VARCHAR2(3);
  sSoi_refere VARCHAR2(20);
  sSoi_tipope VARCHAR2(1);
  sSoi_import DECIMAL(11,2);
  iSoi_fecope DATE;
  wd_fecope   DATE;
  sSoi_tipmon VARCHAR2(1);
  sSoi_tipcam DECIMAL(11,4);
  sSoi_tipreg VARCHAR2(1);
  sSoi_keypre DECIMAL(11,6);
  iSoi_keypro SMALLINT;
  iSoi_status VARCHAR2(1);
  sSoi_refamo VARCHAR2(16);
  sPer_keyper VARCHAR2(7);
  dPer_fecini DATE;
  iPre_impsal DECIMAL(12,2);
  iPre_impamo DECIMAL(12,2);
  sEmp_keydep VARCHAR2(16);
  sEmp_keypue VARCHAR2(16);
  sEmp_keycat VARCHAR2(16);
  sEmp_keyloc VARCHAR2(16);
  wn_fec_mov INTEGER;
  wn_hor_mov INTEGER;
  wn_min_mov INTEGER;
  wn_seg_mov INTEGER;
  wn_tot_mov DECIMAL(16,6);
  wn_tot_mo2 DECIMAL(16,6);
  ws_tmp_mov VARCHAR2(2);
  wi_valido  INTEGER;
  wi_refere  INTEGER;
--   conta_a    DECIMAL(10,6);
  largo_a    INTEGER;
  sHoMinSe   VARCHAR2(6);
  count_pres INTEGER;
  iCountapres INTEGER;
  i          INTEGER;
  conta      DECIMAL(16,6);
-- Lectura de la tabla 'ap_sipros' para actualizar el proceso      ---
-- asi como el status del empleado, para poder hacer despues el filtro ---
--Si no hay filtros de conceptos y conceptos opci
BEGIN
--SET DEBUG FILE TO '/tmp/algo.txt';
--TRACE ON;
IF psConceptos = '*' AND psConceptosOpci = '*' THEN
  -------------------------------------------
  -------------------------------------------
  FOR c_1 in (
	  SELECT soi_keyemp, soi_refamo
	  --INTO iSoi_keyemp, sSoi_refamo
	  FROM ap_sipros
	  WHERE soi_feccar IS NULL
	  AND   soi_stacar IS NULL)
  LOOP
    -- Obtengo el proceso y el status de la tabla de empleados
	  SELECT emp_keypro, emp_status INTO iSoi_keypro,iSoi_status
	    FROM nmcoempl
	   WHERE emp_keyemp = c_1.soi_keyemp
	     AND emp_keypro = wi_proceso;
	      UPDATE ap_sipros
	         SET soi_keypro = iSoi_keypro,
	             soi_status = iSoi_status
	       WHERE soi_keyemp = c_1.soi_keyemp
	       AND   soi_feccar IS NULL
	       AND   soi_stacar IS NULL
	       AND   soi_refamo = c_1.soi_refamo;
	END LOOP;
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
	  --FOR i = 1 TO 1
	  -- Valido si el numero de empleado existe
	     wi_valido := 0;
	     SELECT COUNT(*) INTO wi_valido
	       FROM nmcoempl
	      WHERE emp_keyemp = c_2.soi_keyemp;
	     IF wi_valido = 0 THEN
	     -- si no existe el empleado rechazo el movimiento ----
	        UPDATE ap_sipros
	           SET soi_tipreg = 'E',
	               soi_keypre = 0,
	               soi_feccar = SYSDATE,
	               soi_stacar = 'P'
	         WHERE soi_keyemp = c_2.soi_keyemp
	         AND   soi_feccar IS NULL
	         AND   soi_stacar IS NULL
	         AND   soi_refamo = c_2.soi_refamo;
	        --CONTINUE FOR;
          -- ?continue? pus si va de 1 a 1 ?
	     ELSE
	     -- Valido si el numero de concepto existe
	        wi_valido := 0;
	        SELECT COUNT(*) INTO wi_valido
	          FROM nmloconc
	         WHERE con_keycon = c_2.soi_keycon;
	        IF wi_valido = 0 THEN
	        --- si el concepto no existe rechazo el movimiento ---
	           UPDATE ap_sipros
	              SET soi_tipreg = 'O',
	                  soi_keypre = 0,
	                  soi_feccar = SYSDATE,
	                  soi_stacar = 'P'
	            WHERE soi_keyemp = c_2.soi_keyemp
	            AND   soi_keycon = c_2.soi_keycon
	            AND   soi_feccar IS NULL
	            AND   soi_stacar IS NULL
	            AND   soi_refamo = c_2.soi_refamo;
	            --CONTINUE FOR;
              -- ?continue? pus si va de 1 a 1 ?
	        ELSE
	        -- Valido si la referencia existe para ese empleado
	        -- y ese concepto
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
	                     soi_feccar = SYSDATE,
	                     soi_stacar = 'P'
	               WHERE soi_keyemp = c_2.soi_keyemp
	               AND   soi_keycon = c_2.soi_keycon
	               AND   soi_refere = c_2.soi_refere
	               AND   soi_tipreg = 'A'
	               AND   soi_feccar IS NULL
	               AND   soi_stacar IS NULL
	               AND   soi_refamo = c_2.soi_refamo;
	           END IF;
	        END IF;
	     END IF;
	     -- Obtengo el proceso y el status de la tabla de empleados
	      SELECT emp_keypro, emp_status INTO iSoi_keypro,iSoi_status
	        FROM nmcoempl
	       WHERE emp_keyemp = c_2.soi_keyemp;
	      UPDATE ap_sipros
	         SET soi_keypro = iSoi_keypro,
	             soi_status = iSoi_status
	       WHERE soi_keyemp = c_2.soi_keyemp
	       AND   (soi_tipreg = 'A' or soi_tipreg = 'C')
	       AND   soi_feccar IS NULL
	       AND   soi_stacar IS NULL
	       AND   soi_refamo = c_2.soi_refamo;
	        --- Rechazo los prestamos nuevos (anticipos = 'A')
	        --- y el proceso sea igual al proceso enviado por parametro
	        --- para los empleados dados de baja (10-agosto-2001)
	        UPDATE ap_sipros
	           SET soi_tipreg = 'R',
	             soi_keypre = 0,
	             soi_feccar = SYSDATE,
	             soi_stacar = 'P'
	         WHERE soi_tipreg = 'A'
	         AND soi_status = 2
	         AND   soi_feccar IS NULL
	         AND   soi_stacar IS NULL
	         AND   soi_refamo = c_2.soi_refamo
	         AND   soi_keypro = wi_proceso;
	      --- Rechazo cualquier registro cuyo tipreg no sea 'A', 'C' y no haya
	      --- sido rechazado anteriormente (fecha de carga nula)
	      --- y el proceso sea igual al proceso enviado por parametro
	      UPDATE ap_sipros
	         SET  soi_keypre = 0,
	              soi_tipreg = 'R',
	              soi_feccar = SYSDATE,
	              soi_stacar = 'P'
	       WHERE soi_tipreg NOT IN ('A','C','R','E','O')
	       AND   soi_feccar IS NULL
	       AND   soi_stacar IS NULL
	       AND   soi_refamo = c_2.soi_refamo
	       AND   soi_keypro = wi_proceso;
	  --END FOR;
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
	  wn_fec_mov := 0;
	  wn_hor_mov := 0;
	    wn_min_mov := 0;
	    wn_seg_mov := 0;
	    wn_tot_mov := '0.0';
	    ws_tmp_mov := '';
	    wn_fec_mov := TO_NUMBER(SYSDATE);
	    wn_tot_mov := wn_fec_mov + conta_a;
	  UPDATE ap_sipros
	     SET soi_keypre = wn_tot_mov,
	         soi_feccar = SYSDATE,
	         soi_stacar = 'P'
	   WHERE soi_keyemp = c_3.soi_keyemp
	   AND   soi_keycon = c_3.soi_keycon
	   AND   soi_refere = c_3.soi_refere
	   AND   soi_tipreg = 'A'
	   AND   soi_feccar IS NULL
	   AND   soi_stacar IS NULL
	   AND   soi_refamo = c_3.soi_refamo;
	    conta := conta + 0.000001;
	END LOOP;
	-- Inserto en la tabla 'nmlopres' los anticipos del dia de hoy---
	-- cuando el proceso sea igual al proceso enviado por parametro ---
	-- y empleados activos (23-julio-2001)
	FOR c_4 IN (
	  SELECT
	   soi_keyemp, soi_keycon, soi_refere, soi_tipope,
	   soi_import, soi_fecope, soi_tipmon, soi_tipcam,
	   soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
	  --INTO
	   --iSoi_keyemp, sSoi_keycon, sSoi_refere, sSoi_tipope,
	   --sSoi_import, iSoi_fecope, sSoi_tipmon, sSoi_tipcam,
	   --sSoi_tipreg, sSoi_keypre, iSoi_keypro, iSoi_status
	  FROM
	   ap_sipros
	  WHERE soi_tipreg = 'A'
	  AND   soi_status = 1
	  AND   soi_feccar = SYSDATE
	  AND   soi_keypre <> 0
	  AND   soi_keypro = wi_proceso)
   LOOP
	  -- selecciono fecha para insertar en prestamos con 45 dias de colchon
	  --CARSI LET wd_fecope = iSoi_fecope + 45;
	    dPer_fecini := c_4.soi_fecope + 30;
	  --CARSI SELECT per_keyper, per_fecini INTO sPer_keyper, dPer_fecini
	  SELECT per_keyper INTO sPer_keyper
	    FROM nmloperi
	   WHERE per_keypro= c_4.soi_keypro
	    AND  per_fecini <= c_4.soi_fecope     --CARSI wd_fecope
	    AND  per_fecfin >= c_4.soi_fecope     --CARSI wd_fecope
	    AND  per_keynom=1;
	   --actualizo tipo de cambio a 1 para Moneda Nacional
	   IF c_4.soi_tipmon = '1' THEN
	      IF c_4.soi_tipcam = 0.0 THEN
	           c_4.soi_tipcam := 1.0;
	      END IF;
	   END IF;
	   -- Para emleados activos....--
	   IF c_4.soi_status = 1 THEN
	        iCountapres := 0;
	      -- Verifico si la llave existe en la tabla 'nmlopres'
	      SELECT COUNT(*) INTO iCountapres
	        FROM nmlopres
	       WHERE pre_keypre = c_4.soi_keypre;
	      -- Si no existe, se inserta el prestamo con estatus=2 --
	      IF iCountapres = 0 THEN
	         INSERT INTO nmlopres
	         (
	          pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
	          pre_tippre, pre_unipre, pre_imppre, pre_gastos, pre_plazop,
	          pre_unides, pre_impdes, pre_porint, pre_perini, pre_fecini,
	          pre_fecaut, pre_cveaut, pre_fechab, pre_uniamo, pre_impamo,
	          pre_unisal, pre_impsal, pre_uniult, pre_impult, pre_numpag,
	          pre_intpag, pre_status, pre_ultact, pre_refcon, pre_ctreve,
	          pre_fe1aux, pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux,
	          pre_ca4aux, pre_uniope, pre_keypro
	         )
	         VALUES
	         (
	          c_4.soi_keyemp, c_4.soi_keycon, c_4.soi_keypre, c_4.soi_refere, c_4.soi_fecope,
	          1          , NULL       , c_4.soi_import, NULL       , 1          ,
	          NULL       , c_4.soi_import, 0          , sPer_keyper, dPer_fecini,
	          c_4.soi_fecope, NULL       , NULL       , 0          , 0          ,
	          0          , c_4.soi_import, 0          , 0          , 0          ,
	          0          , 2          , c_4.soi_fecope, NULL       , c_4.soi_refamo,
	          NULL       , NULL       , c_4.soi_tipmon, c_4.soi_tipcam, NULL       ,
	          NULL       , NULL       , c_4.soi_keypro
	         );
	      ELSE
	         -- si existe la llave rechazo el movimiento --
	         UPDATE ap_sipros
	            SET soi_tipreg = 'R'
	          WHERE soi_keyemp = c_4.soi_keyemp
	          AND   soi_keycon = c_4.soi_keycon
	          AND   soi_refere = c_4.soi_refere
	          AND   soi_keypre = c_4.soi_keypre
	          AND   soi_tipreg = 'A'
	          AND   soi_stacar = 'P'
	          AND   soi_feccar = SYSDATE;
	      END IF;
	   END IF;
	END LOOP;
ELSE
--Si hay filtros de conceptos y  no hay conceptos opci
	IF psConceptos <> '*' AND psConceptosOpci = '*' THEN
		FOR c_5 IN (
		  SELECT soi_keyemp, soi_refamo, soi_keycon
		  --INTO iSoi_keyemp, sSoi_refamo, sSoi_keycon
		  FROM ap_sipros
		  WHERE soi_feccar IS NULL
		  AND   soi_stacar IS NULL
		  AND   soi_keycon IN ( SELECT dat_valore
	                             FROM glcodats,glcousua
	                            WHERE usu_keyusu = psKeyUsu
	                              AND usu_keymen = dat_keymen
	                              AND dat_idecam = 'keycon' ))
    LOOP
		  -- Obtengo el proceso y el status de la tabla de empleados
		  SELECT emp_keypro, emp_status INTO iSoi_keypro,iSoi_status
		    FROM nmcoempl
		   WHERE emp_keyemp = c_5.soi_keyemp
		     AND emp_keypro = wi_proceso;
		      UPDATE ap_sipros
		         SET soi_keypro = iSoi_keypro,
		             soi_status = iSoi_status
		       WHERE soi_keyemp = c_5.soi_keyemp
		       AND   soi_keycon = c_5.soi_keycon
		       AND   soi_feccar IS NULL
		       AND   soi_stacar IS NULL
		       AND   soi_refamo = c_5.soi_refamo;
		END LOOP;
		-- Lectura de la tabla 'ap_sipros' para fecha y carga nulas --
		-- asi como el filtro de Proceso ---
		-- Validacion del archivo de entrada ---
    FOR c_6 IN (
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
		  AND   soi_keypro = wi_proceso
		  AND   soi_keycon IN ( SELECT dat_valore
	                             FROM glcodats,glcousua
	                            WHERE usu_keyusu = psKeyUsu
	                              AND usu_keymen = dat_keymen
	                              AND dat_idecam = 'keycon' ))
   LOOP
		  --FOR i = 1 TO 1
		  -- Valido si el numero de empleado existe
		     wi_valido := 0;
		     SELECT COUNT(*) INTO wi_valido
		       FROM nmcoempl
		      WHERE emp_keyemp = c_6.soi_keyemp;
		     IF wi_valido = 0 THEN
		     -- si no existe el empleado rechazo el movimiento ----
		        UPDATE ap_sipros
		           SET soi_tipreg = 'E',
		               soi_keypre = 0,
		               soi_feccar = SYSDATE,
		               soi_stacar = 'P'
		         WHERE soi_keyemp = c_6.soi_keyemp
		         AND   soi_keycon = c_6.soi_keycon
		         AND   soi_feccar IS NULL
		         AND   soi_stacar IS NULL
		         AND   soi_refamo = c_6.soi_refamo;
		        --CONTINUE FOR;  nel
		     ELSE
		     -- Valido si el numero de concepto existe
		        wi_valido := 0;
		        SELECT COUNT(*) INTO wi_valido
		          FROM nmloconc
		         WHERE con_keycon = c_6.soi_keycon;
		        IF wi_valido = 0 THEN
		        --- si el concepto no existe rechazo el movimiento ---
		           UPDATE ap_sipros
		              SET soi_tipreg = 'O',
		                  soi_keypre = 0,
		                  soi_feccar = SYSDATE,
		                  soi_stacar = 'P'
		            WHERE soi_keyemp = c_6.soi_keyemp
		            AND   soi_keycon = c_6.soi_keycon
		            AND   soi_feccar IS NULL
		            AND   soi_stacar IS NULL
		            AND   soi_refamo = c_6.soi_refamo;
		            --CONTINUE FOR; neta?
		        ELSE
		        -- Valido si la referencia existe para ese empleado
		        -- y ese concepto
		           wi_valido := 0;
		           SELECT COUNT(*) INTO wi_valido
		             FROM nmlopres
		            WHERE pre_keyemp = c_6.soi_keyemp
		              AND pre_keycon  = c_6.soi_keycon
		              AND pre_refere  = c_6.soi_refere;
		           IF wi_valido > 0 THEN
		           --- si ya existe el prestamo rechazo los anticipos ---
		              UPDATE ap_sipros
		                 SET soi_tipreg = 'R',
		                     soi_keypre = 0,
		                     soi_feccar = SYSDATE,
		                     soi_stacar = 'P'
		               WHERE soi_keyemp = c_6.soi_keyemp
		               AND   soi_keycon = c_6.soi_keycon
		               AND   soi_refere = c_6.soi_refere
		               AND   soi_tipreg = 'A'
		               AND   soi_feccar IS NULL
		               AND   soi_stacar IS NULL
		               AND   soi_refamo = c_6.soi_refamo;
		           END IF;
		        END IF;
		     END IF;
		     -- Obtengo el proceso y el status de la tabla de empleados
		      SELECT emp_keypro, emp_status INTO iSoi_keypro,iSoi_status
		        FROM nmcoempl
		       WHERE emp_keyemp = c_6.soi_keyemp;
		      UPDATE ap_sipros
		         SET soi_keypro = iSoi_keypro,
		             soi_status = iSoi_status
		       WHERE soi_keyemp = c_6.soi_keyemp
		       AND   soi_keycon = c_6.soi_keycon
		       AND   (soi_tipreg = 'A' or soi_tipreg = 'C')
		       AND   soi_feccar IS NULL
		       AND   soi_stacar IS NULL
		       AND   soi_refamo = c_6.soi_refamo;
		        --- Rechazo los prestamos nuevos (anticipos = 'A')
		        --- y el proceso sea igual al proceso enviado por parametro
		        --- para los empleados dados de baja (10-agosto-2001)
		        UPDATE ap_sipros
		           SET soi_tipreg = 'R',
		             soi_keypre = 0,
		             soi_feccar = SYSDATE,
		             soi_stacar = 'P'
		         WHERE soi_tipreg = 'A'
		         AND soi_status = 2
		         AND   soi_feccar IS NULL
		         AND   soi_stacar IS NULL
		         AND   soi_refamo = c_6.soi_refamo
		         AND   soi_keypro = wi_proceso
				  AND   soi_keycon IN ( SELECT dat_valore
			                             FROM glcodats,glcousua
			                            WHERE usu_keyusu = psKeyUsu
			                              AND usu_keymen = dat_keymen
			                              AND dat_idecam = 'keycon' );
		      --- Rechazo cualquier registro cuyo tipreg no sea 'A', 'C' y no haya
		      --- sido rechazado anteriormente (fecha de carga nula)
		      --- y el proceso sea igual al proceso enviado por parametro
		      UPDATE ap_sipros
		         SET  soi_keypre = 0,
		              soi_tipreg = 'R',
		              soi_feccar = SYSDATE,
		              soi_stacar = 'P'
		       WHERE soi_tipreg NOT IN ('A','C','R','E','O')
		       AND   soi_feccar IS NULL
		       AND   soi_stacar IS NULL
		       AND   soi_refamo = c_6.soi_refamo
		       AND   soi_keypro = wi_proceso
				  AND   soi_keycon IN ( SELECT dat_valore
			                             FROM glcodats,glcousua
			                            WHERE usu_keyusu = psKeyUsu
			                              AND usu_keymen = dat_keymen
			                              AND dat_idecam = 'keycon' );
		  --END FOR;
		END LOOP;
		-- Empiezo con los anticipos
		-- Asigno la llave de Prestamos mientras sea 'A' (anticipos)
		-- y el proceso sea igual al proceso enviado por parametro
		-- para empleados activos (23 - julio- 2001)
conta := conta_a;
  FOR c_7 IN (
		  SELECT
		   soi_keyemp, soi_keycon, soi_refere, soi_tipope,
		   soi_import, soi_fecope, soi_tipmon, soi_tipcam,
		   soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
		  --INTO
		  -- iSoi_keyemp, sSoi_keycon, sSoi_refere, sSoi_tipope,
		  -- sSoi_import, iSoi_fecope, sSoi_tipmon, sSoi_tipcam,
		  -- sSoi_tipreg, sSoi_keypre, iSoi_keypro, iSoi_status, sSoi_refamo
		  FROM
		   ap_sipros
		  WHERE soi_tipreg = 'A'
		  AND   soi_status = 1   --- 23-julio-2001  ---
		  AND   soi_feccar IS NULL
		  AND   soi_stacar IS NULL
		  AND   soi_keypro = wi_proceso
		  AND   soi_keycon IN ( SELECT dat_valore
	                             FROM glcodats,glcousua
	                            WHERE usu_keyusu = psKeyUsu
	                              AND usu_keymen = dat_keymen
	                              AND dat_idecam = 'keycon' ))
      LOOP
		    wn_fec_mov := 0;
		    wn_hor_mov := 0;
		    wn_min_mov := 0;
		    wn_seg_mov := 0;
		    wn_tot_mov := '0.0';
		    ws_tmp_mov := '';
		    wn_fec_mov := TO_NUMBER(SYSDATE);
		    wn_tot_mov := wn_fec_mov + conta_a;
		  UPDATE ap_sipros
		     SET soi_keypre = wn_tot_mov,
		         soi_feccar = SYSDATE,
		         soi_stacar = 'P'
		   WHERE soi_keyemp = c_7.soi_keyemp
		   AND   soi_keycon = c_7.soi_keycon
		   AND   soi_refere = c_7.soi_refere
		   AND   soi_tipreg = 'A'
		   AND   soi_feccar IS NULL
		   AND   soi_stacar IS NULL
		   AND   soi_refamo = c_7.soi_refamo;
		    conta := conta + '0.000001';
		END LOOP;
		-- Inserto en la tabla 'nmlopres' los anticipos del dia de hoy---
		-- cuando el proceso sea igual al proceso enviado por parametro ---
		-- y empleados activos (23-julio-2001)
		FOR c_8 IN(
		  SELECT
		   soi_keyemp, soi_keycon, soi_refere, soi_tipope,
		   soi_import, soi_fecope, soi_tipmon, soi_tipcam,
		   soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
		  --INTO
		  -- iSoi_keyemp, sSoi_keycon, sSoi_refere, sSoi_tipope,
		  -- sSoi_import, iSoi_fecope, sSoi_tipmon, sSoi_tipcam,
		  -- sSoi_tipreg, sSoi_keypre, iSoi_keypro, iSoi_status
		  FROM
		   ap_sipros
		  WHERE soi_tipreg = 'A'
		  AND   soi_status = 1
		  AND   soi_feccar = SYSDATE
		  AND   soi_keypre <> 0
		  AND   soi_keypro = wi_proceso
		  AND   soi_keycon IN ( SELECT dat_valore
	                             FROM glcodats,glcousua
	                            WHERE usu_keyusu = psKeyUsu
	                              AND usu_keymen = dat_keymen
	                              AND dat_idecam = 'keycon' ))
   LOOP
		  -- selecciono fecha para insertar en prestamos con 45 dias de colchon
		  --CARSI LET wd_fecope = iSoi_fecope + 45;
		    dPer_fecini := c_8.soi_fecope + 30;
		  --CARSI SELECT per_keyper, per_fecini INTO sPer_keyper, dPer_fecini
		  SELECT per_keyper INTO sPer_keyper
		    FROM nmloperi
		   WHERE per_keypro=c_8.soi_keypro
		    AND  per_fecini <= c_8.soi_fecope     --CARSI wd_fecope
		    AND  per_fecfin >= c_8.soi_fecope     --CARSI wd_fecope
		    AND  per_keynom=1;
		   --actualizo tipo de cambio a 1 para Moneda Nacional
		   IF c_8.soi_tipmon = '1' THEN
		      IF c_8.soi_tipcam = 0.0 THEN
		           c_8.soi_tipcam := 1.0;
		      END IF;
		   END IF;
		   -- Para emleados activos....--
		   IF c_8.soi_status = 1 THEN
		        iCountapres := 0;
		      -- Verifico si la llave existe en la tabla 'nmlopres'
		      SELECT COUNT(*) INTO iCountapres
		        FROM nmlopres
		       WHERE pre_keypre = c_8.soi_keypre;
		      -- Si no existe, se inserta el prestamo con estatus=4 --
		      IF iCountapres = 0 THEN
		         INSERT INTO nmlopres
		         (
		          pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
		          pre_tippre, pre_unipre, pre_imppre, pre_gastos, pre_plazop,
		          pre_unides, pre_impdes, pre_porint, pre_perini, pre_fecini,
		          pre_fecaut, pre_cveaut, pre_fechab, pre_uniamo, pre_impamo,
		          pre_unisal, pre_impsal, pre_uniult, pre_impult, pre_numpag,
		          pre_intpag, pre_status, pre_ultact, pre_refcon, pre_ctreve,
		          pre_fe1aux, pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux,
		          pre_ca4aux, pre_uniope, pre_keypro
		         )
		         VALUES
		         (
		          c_8.soi_keyemp, c_8.soi_keycon, c_8.soi_keypre, c_8.soi_refere, c_8.soi_fecope,
		          1          , NULL       , sSoi_import, NULL       , 1          ,
		          NULL       , c_8.soi_import, 0          , sPer_keyper, dPer_fecini,
		          c_8.soi_fecope, NULL       , NULL       , 0          , 0          ,
		          0          , c_8.soi_import, 0          , 0          , 0          ,
		          0          , 4          , c_8.soi_fecope, NULL       , c_8.soi_refamo,
		          NULL       , NULL       , c_8.soi_tipmon, c_8.soi_tipcam, NULL       ,
		          NULL       , NULL       , c_8.soi_keypro
		         );
		      ELSE
		         -- si existe la llave rechazo el movimiento --
		         UPDATE ap_sipros
		            SET soi_tipreg = 'R'
		          WHERE soi_keyemp = c_8.soi_keyemp
		          AND   soi_keycon = c_8.soi_keycon
		          AND   soi_refere = c_8.soi_refere
		          AND   soi_keypre = c_8.soi_keypre
		          AND   soi_tipreg = 'A'
		          AND   soi_stacar = 'P'
		          AND   soi_feccar = SYSDATE;
		      END IF;
		   END IF;
		END LOOP;
	ELSE
--Si no hay filtros de conceptos y  hay conceptos opci
		IF psConceptos = '*' AND psConceptosOpci <> '*' THEN
      FOR c_9 IN (
			  SELECT soi_keyemp, soi_refamo, soi_keycon--, emp_keypro, emp_status
			  --INTO iSoi_keyemp, sSoi_refamo, sSoi_keycon
			  FROM ap_sipros
        --inner join nmcoempl on (soi_keyemp = emp_keyemp)
			  WHERE soi_feccar IS NULL
			  AND   soi_stacar IS NULL
			  AND   soi_keycon NOT IN ( SELECT pam_folfin
                                 FROM glcopams
                                WHERE pam_keypar='Z03Q'
                                  AND pam_nompar = 'USUARIOS SIN RESTRICCION' ))
     LOOP
			  -- Obtengo el proceso y el status de la tabla de empleados
			  SELECT emp_keypro, emp_status INTO iSoi_keypro,iSoi_status
			    FROM nmcoempl
			   WHERE emp_keyemp = c_9.soi_keyemp;
           --Igneos.I (es necesario)?
           --AND emp_keypro = wi_proceso;
			      UPDATE ap_sipros
			         SET soi_keypro = iSoi_keypro,
			             soi_status = iSoi_status
			       WHERE soi_keyemp = c_9.soi_keyemp
			       AND   soi_keycon = c_9.soi_keycon
			       AND   soi_feccar IS NULL
			       AND   soi_stacar IS NULL
			       AND   soi_refamo = c_9.soi_refamo;
			END LOOP;
			-- Lectura de la tabla 'ap_sipros' para fecha y carga nulas --
			-- asi como el filtro de Proceso ---
			-- Validacion del archivo de entrada ---
			FOR c_10 IN (
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
			  AND   soi_keypro = wi_proceso
			  AND   soi_keycon NOT IN ( SELECT pam_folfin
                                 FROM glcopams
                                WHERE pam_keypar='Z03Q'
                                  AND pam_nompar = 'USUARIOS SIN RESTRICCION' ))
      LOOP
			  --FOR i = 1 TO 1
			  -- Valido si el numero de empleado existe
			       wi_valido := 0;
			     SELECT COUNT(*) INTO wi_valido
			       FROM nmcoempl
			      WHERE emp_keyemp = c_10.soi_keyemp;
			     IF wi_valido = 0 THEN
			     -- si no existe el empleado rechazo el movimiento ----
			        UPDATE ap_sipros
			           SET soi_tipreg = 'E',
			               soi_keypre = 0,
			               soi_feccar = SYSDATE,
			               soi_stacar = 'P'
			         WHERE soi_keyemp = c_10.soi_keyemp
			         AND   soi_keycon = c_10.soi_keycon
			         AND   soi_feccar IS NULL
			         AND   soi_stacar IS NULL
			         AND   soi_refamo = c_10.soi_refamo;
			        --CONTINUE FOR; seguro?
			     ELSE
			     -- Valido si el numero de concepto existe
			          wi_valido := 0;
			        SELECT COUNT(*) INTO wi_valido
			          FROM nmloconc
			         WHERE con_keycon = c_10.soi_keycon;
			        IF wi_valido = 0 THEN
			        --- si el concepto no existe rechazo el movimiento ---
			           UPDATE ap_sipros
			              SET soi_tipreg = 'O',
			                  soi_keypre = 0,
			                  soi_feccar = SYSDATE,
			                  soi_stacar = 'P'
			            WHERE soi_keyemp = c_10.soi_keyemp
			            AND   soi_keycon = c_10.soi_keycon
			            AND   soi_feccar IS NULL
			            AND   soi_stacar IS NULL
			            AND   soi_refamo = c_10.soi_refamo;
			            --CONTINUE FOR;
			        ELSE
			        -- Valido si la referencia existe para ese empleado
			        -- y ese concepto
			             wi_valido := 0;
			           SELECT COUNT(*) INTO wi_valido
			             FROM nmlopres
			            WHERE pre_keyemp = c_10.soi_keyemp
			              AND pre_keycon  = c_10.soi_keycon
			              AND pre_refere  = c_10.soi_refere;
			           IF wi_valido > 0 THEN
			           --- si ya existe el prestamo rechazo los anticipos ---
			              UPDATE ap_sipros
			                 SET soi_tipreg = 'R',
			                     soi_keypre = 0,
			                     soi_feccar = SYSDATE,
			                     soi_stacar = 'P'
			               WHERE soi_keyemp = c_10.soi_keyemp
			               AND   soi_keycon = c_10.soi_keycon
			               AND   soi_refere = c_10.soi_refere
			               AND   soi_tipreg = 'A'
			               AND   soi_feccar IS NULL
			               AND   soi_stacar IS NULL
			               AND   soi_refamo = c_10.soi_refamo;
			           END IF;
			        END IF;
			     END IF;
			     -- Obtengo el proceso y el status de la tabla de empleados
			      SELECT emp_keypro, emp_status INTO iSoi_keypro,iSoi_status
			        FROM nmcoempl
			       WHERE emp_keyemp = c_10.soi_keyemp;
			      UPDATE ap_sipros
			         SET soi_keypro = iSoi_keypro,
			             soi_status = iSoi_status
			       WHERE soi_keyemp = c_10.soi_keyemp
			       AND   soi_keycon = c_10.soi_keycon
			       AND   (soi_tipreg = 'A' or soi_tipreg = 'C')
			       AND   soi_feccar IS NULL
			       AND   soi_stacar IS NULL
			       AND   soi_refamo = c_10.soi_refamo;
			        --- Rechazo los prestamos nuevos (anticipos = 'A')
			        --- y el proceso sea igual al proceso enviado por parametro
			        --- para los empleados dados de baja (10-agosto-2001)
			        UPDATE ap_sipros
			           SET soi_tipreg = 'R',
			             soi_keypre = 0,
			             soi_feccar = SYSDATE,
			             soi_stacar = 'P'
			         WHERE soi_tipreg = 'A'
			         AND soi_status = 2
			         AND   soi_feccar IS NULL
			         AND   soi_stacar IS NULL
			         AND   soi_refamo = c_10.soi_refamo
			         AND   soi_keypro = wi_proceso
  			         AND   soi_keycon NOT IN ( SELECT pam_folfin
                                 FROM glcopams
                                WHERE pam_keypar='Z03Q'
                                  AND pam_nompar = 'USUARIOS SIN RESTRICCION' );
			      --- Rechazo cualquier registro cuyo tipreg no sea 'A', 'C' y no haya
			      --- sido rechazado anteriormente (fecha de carga nula)
			      --- y el proceso sea igual al proceso enviado por parametro
			      UPDATE ap_sipros
			         SET  soi_keypre = 0,
			              soi_tipreg = 'R',
			              soi_feccar = SYSDATE,
			              soi_stacar = 'P'
			       WHERE soi_tipreg NOT IN ('A','C','R','E','O')
			       AND   soi_feccar IS NULL
			       AND   soi_stacar IS NULL
			       AND   soi_refamo = c_10.soi_refamo
			       AND   soi_keypro = wi_proceso
  			       AND   soi_keycon NOT IN ( SELECT pam_folfin
                                 FROM glcopams
                                WHERE pam_keypar='Z03Q'
                                  AND pam_nompar = 'USUARIOS SIN RESTRICCION' );
			  --END FOR;
			END LOOP;
			-- Empiezo con los anticipos
			-- Asigno la llave de Prestamos mientras sea 'A' (anticipos)
			-- y el proceso sea igual al proceso enviado por parametro
			-- para empleados activos (23 - julio- 2001)
conta := conta_a;
			FOR c_11 IN (
			  SELECT
			   soi_keyemp, soi_keycon, soi_refere, soi_tipope,
			   soi_import, soi_fecope, soi_tipmon, soi_tipcam,
			   soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
			  --INTO
			  -- iSoi_keyemp, sSoi_keycon, sSoi_refere, sSoi_tipope,
			  -- sSoi_import, iSoi_fecope, sSoi_tipmon, sSoi_tipcam,
			  -- sSoi_tipreg, sSoi_keypre, iSoi_keypro, iSoi_status, sSoi_refamo
			  FROM
			   ap_sipros
			  WHERE soi_tipreg = 'A'
			  AND   soi_status = 1   --- 23-julio-2001  ---
			  AND   soi_feccar IS NULL
			  AND   soi_stacar IS NULL
			  AND   soi_keypro = wi_proceso
			  AND   soi_keycon NOT IN ( SELECT pam_folfin
                                 FROM glcopams
                                WHERE pam_keypar='Z03Q'
                                  AND pam_nompar = 'USUARIOS SIN RESTRICCION' ))
      LOOP
			    wn_fec_mov := 0;
			    wn_hor_mov := 0;
			    wn_min_mov := 0;
			    wn_seg_mov := 0;
			    wn_tot_mov := '0.0';
			    ws_tmp_mov := '';
			    wn_fec_mov := TO_NUMBER(SYSDATE);
			    wn_tot_mov := wn_fec_mov + conta_a;
			  UPDATE ap_sipros
			     SET soi_keypre = wn_tot_mov,
			         soi_feccar = SYSDATE,
			         soi_stacar = 'P'
			   WHERE soi_keyemp = c_11.soi_keyemp
			   AND   soi_keycon = c_11.soi_keycon
			   AND   soi_refere = c_11.soi_refere
			   AND   soi_tipreg = 'A'
			   AND   soi_feccar IS NULL
			   AND   soi_stacar IS NULL
			   AND   soi_refamo = c_11.soi_refamo;
			    conta := conta + '0.000001';
			END LOOP;
			-- Inserto en la tabla 'nmlopres' los anticipos del dia de hoy---
			-- cuando el proceso sea igual al proceso enviado por parametro ---
			-- y empleados activos (23-julio-2001)
			FOR c_12 IN (
			  SELECT
			   soi_keyemp, soi_keycon, soi_refere, soi_tipope,
			   soi_import, soi_fecope, soi_tipmon, soi_tipcam,
			   soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
			  --INTO
			  -- iSoi_keyemp, sSoi_keycon, sSoi_refere, sSoi_tipope,
			  -- sSoi_import, iSoi_fecope, sSoi_tipmon, sSoi_tipcam,
			 --  sSoi_tipreg, sSoi_keypre, iSoi_keypro, iSoi_status
			  FROM
			   ap_sipros
			  WHERE soi_tipreg = 'A'
			  AND   soi_status = 1
			  AND   soi_feccar = SYSDATE
			  AND   soi_keypre <> 0
			  AND   soi_keypro = wi_proceso
			  AND   soi_keycon NOT IN ( SELECT pam_folfin
                                 FROM glcopams
                                WHERE pam_keypar='Z03Q'
                                  AND pam_nompar = 'USUARIOS SIN RESTRICCION' ))
     LOOP
			  -- selecciono fecha para insertar en prestamos con 45 dias de colchon
			  --CARSI LET wd_fecope = iSoi_fecope + 45;
			    dPer_fecini := iSoi_fecope + 30;
			  --CARSI SELECT per_keyper, per_fecini INTO sPer_keyper, dPer_fecini
			  SELECT per_keyper INTO sPer_keyper
			    FROM nmloperi
			   WHERE per_keypro= c_12.soi_keypro
			    AND  per_fecini <= c_12.soi_fecope     --CARSI wd_fecope
			    AND  per_fecfin >= c_12.soi_fecope     --CARSI wd_fecope
			    AND  per_keynom=1;
			   --actualizo tipo de cambio a 1 para Moneda Nacional
			   IF c_12.soi_tipmon = '1' THEN
			      IF c_12.soi_tipcam = 0.0 THEN
			           c_12.soi_tipcam := 1.0;
			      END IF;
			   END IF;
			   -- Para emleados activos....--
			   IF c_12.soi_status = 1 THEN
			        iCountapres := 0;
			      -- Verifico si la llave existe en la tabla 'nmlopres'
			      SELECT COUNT(*) INTO iCountapres
			        FROM nmlopres
			       WHERE pre_keypre = c_12.soi_keypre;
			      -- Si no existe, se inserta el prestamo con estatus=4 --
			      IF iCountapres = 0 THEN
			         INSERT INTO nmlopres
			         (
			          pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
			          pre_tippre, pre_unipre, pre_imppre, pre_gastos, pre_plazop,
			          pre_unides, pre_impdes, pre_porint, pre_perini, pre_fecini,
			          pre_fecaut, pre_cveaut, pre_fechab, pre_uniamo, pre_impamo,
			          pre_unisal, pre_impsal, pre_uniult, pre_impult, pre_numpag,
			          pre_intpag, pre_status, pre_ultact, pre_refcon, pre_ctreve,
			          pre_fe1aux, pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux,
			          pre_ca4aux, pre_uniope, pre_keypro
			         )
			         VALUES
			         (
			          c_12.soi_keyemp, c_12.soi_keycon, c_12.soi_keypre, c_12.soi_refere, c_12.soi_fecope,
			          1          , NULL       , c_12.soi_import, NULL       , 1          ,
			          NULL       , c_12.soi_import, 0          , sPer_keyper, dPer_fecini,
			          c_12.soi_fecope, NULL       , NULL       , 0          , 0          ,
			          0          , c_12.soi_import, 0          , 0          , 0          ,
			          0          , 4          , c_12.soi_fecope, NULL       , c_12.soi_refamo,
			          NULL       , NULL       , c_12.soi_tipmon, c_12.soi_tipcam, NULL       ,
			          NULL       , NULL       , c_12.soi_keypro
			         );
			      ELSE
			         -- si existe la llave rechazo el movimiento --
			         UPDATE ap_sipros
			            SET soi_tipreg = 'R'
			          WHERE soi_keyemp = c_12.soi_keyemp
			          AND   soi_keycon = c_12.soi_keycon
			          AND   soi_refere = c_12.soi_refere
			          AND   soi_keypre = c_12.soi_keypre
			          AND   soi_tipreg = 'A'
			          AND   soi_stacar = 'P'
			          AND   soi_feccar = SYSDATE;
			      END IF;
			   END IF;
			END LOOP;
		ELSE
--Si hay filtros de conceptos y conceptos opci
			FOR c_13 IN (
			  SELECT soi_keyemp, soi_refamo, soi_keycon
			  --INTO iSoi_keyemp, sSoi_refamo, sSoi_keycon
			  FROM ap_sipros
			  WHERE soi_feccar IS NULL
			  AND   soi_stacar IS NULL
			  AND   soi_keycon IN ( SELECT dat_valore
		                             FROM glcodats,glcousua
		                            WHERE usu_keyusu = psKeyUsu
		                              AND usu_keymen = dat_keymen
		                              AND dat_idecam = 'keycon' )
			  AND   soi_keycon NOT IN ( SELECT pam_folfin
                                 FROM glcopams
                                WHERE pam_keypar='Z03Q'
                                  AND pam_nompar = 'USUARIOS SIN RESTRICCION' ))
      LOOP
			  -- Obtengo el proceso y el status de la tabla de empleados
			  SELECT emp_keypro, emp_status INTO iSoi_keypro,iSoi_status
			    FROM nmcoempl
			   WHERE emp_keyemp = c_13.soi_keyemp
			     AND emp_keypro = wi_proceso;
			      UPDATE ap_sipros
			         SET soi_keypro = iSoi_keypro,
			             soi_status = iSoi_status
			       WHERE soi_keyemp = c_13.soi_keyemp
			       AND   soi_keycon = c_13.soi_keycon
			       AND   soi_feccar IS NULL
			       AND   soi_stacar IS NULL
			       AND   soi_refamo = c_13.soi_refamo;
			END LOOP;
			-- Lectura de la tabla 'ap_sipros' para fecha y carga nulas --
			-- asi como el filtro de Proceso ---
			-- Validacion del archivo de entrada ---
			FOR c_14 IN (
			  SELECT
			   soi_keyemp, soi_keycon, soi_refere, soi_tipope,
			   soi_import, soi_fecope, soi_tipmon, soi_tipcam,
			   soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
			  --INTO
			  -- iSoi_keyemp, sSoi_keycon, sSoi_refere, sSoi_tipope,
			  --- sSoi_import, iSoi_fecope, sSoi_tipmon, sSoi_tipcam,
			  -- sSoi_tipreg, sSoi_keypre, iSoi_keypro, iSoi_status, sSoi_refamo
			  FROM
			   ap_sipros
			  WHERE soi_feccar IS NULL
			  AND   soi_stacar IS NULL
			  AND   soi_keypro = wi_proceso
			  AND   soi_keycon IN ( SELECT dat_valore
		                             FROM glcodats,glcousua
		                            WHERE usu_keyusu = psKeyUsu
		                              AND usu_keymen = dat_keymen
		                              AND dat_idecam = 'keycon' )
			  AND   soi_keycon NOT IN ( SELECT pam_folfin
                                 FROM glcopams
                                WHERE pam_keypar='Z03Q'
                                  AND pam_nompar = 'USUARIOS SIN RESTRICCION' ))
      LOOP
			  --FOR i = 1 TO 1
			  -- Valido si el numero de empleado existe
			       wi_valido := 0;
			     SELECT COUNT(*) INTO wi_valido
			       FROM nmcoempl
			      WHERE emp_keyemp = c_14.soi_keyemp;
			     IF wi_valido = 0 THEN
			     -- si no existe el empleado rechazo el movimiento ----
			        UPDATE ap_sipros
			           SET soi_tipreg = 'E',
			               soi_keypre = 0,
			               soi_feccar = SYSDATE,
			               soi_stacar = 'P'
			         WHERE soi_keyemp = c_14.soi_keyemp
			         AND   soi_keycon = c_14.soi_keycon
			         AND   soi_feccar IS NULL
			         AND   soi_stacar IS NULL
			         AND   soi_refamo = c_14.soi_refamo;
			        --CONTINUE FOR;
			     ELSE
			     -- Valido si el numero de concepto existe
			          wi_valido := 0;
			        SELECT COUNT(*) INTO wi_valido
			          FROM nmloconc
			         WHERE con_keycon = c_14.soi_keycon;
			        IF wi_valido = 0 THEN
			        --- si el concepto no existe rechazo el movimiento ---
			           UPDATE ap_sipros
			              SET soi_tipreg = 'O',
			                  soi_keypre = 0,
			                  soi_feccar = SYSDATE,
			                  soi_stacar = 'P'
			            WHERE soi_keyemp = c_14.soi_keyemp
			            AND   soi_keycon = c_14.soi_keycon
			            AND   soi_feccar IS NULL
			            AND   soi_stacar IS NULL
			            AND   soi_refamo = c_14.soi_refamo;
			            --CONTINUE FOR;
			        ELSE
			        -- Valido si la referencia existe para ese empleado
			        -- y ese concepto
			             wi_valido := 0;
			           SELECT COUNT(*) INTO wi_valido
			             FROM nmlopres
			            WHERE pre_keyemp = c_14.soi_keyemp
			              AND pre_keycon  = c_14.soi_keycon
			              AND pre_refere  = c_14.soi_refere;
			           IF wi_valido > 0 THEN
			           --- si ya existe el prestamo rechazo los anticipos ---
			              UPDATE ap_sipros
			                 SET soi_tipreg = 'R',
			                     soi_keypre = 0,
			                     soi_feccar = SYSDATE,
			                     soi_stacar = 'P'
			               WHERE soi_keyemp = c_14.soi_keyemp
			               AND   soi_keycon = c_14.soi_keycon
			               AND   soi_refere = c_14.soi_refere
			               AND   soi_tipreg = 'A'
			               AND   soi_feccar IS NULL
			               AND   soi_stacar IS NULL
			               AND   soi_refamo = c_14.soi_refamo;
			           END IF;
			        END IF;
			     END IF;
			     -- Obtengo el proceso y el status de la tabla de empleados
			      SELECT emp_keypro, emp_status INTO iSoi_keypro,iSoi_status
			        FROM nmcoempl
			       WHERE emp_keyemp = c_14.soi_keyemp;
			      UPDATE ap_sipros
			         SET soi_keypro = iSoi_keypro,
			             soi_status = iSoi_status
			       WHERE soi_keyemp = c_14.soi_keyemp
			       AND   soi_keycon = c_14.soi_keycon
			       AND   (soi_tipreg = 'A' or soi_tipreg = 'C')
			       AND   soi_feccar IS NULL
			       AND   soi_stacar IS NULL
			       AND   soi_refamo = c_14.soi_refamo;
			        --- Rechazo los prestamos nuevos (anticipos = 'A')
			        --- y el proceso sea igual al proceso enviado por parametro
			        --- para los empleados dados de baja (10-agosto-2001)
			        UPDATE ap_sipros
			           SET soi_tipreg = 'R',
			             soi_keypre = 0,
			             soi_feccar = SYSDATE,
			             soi_stacar = 'P'
			         WHERE soi_tipreg = 'A'
			         AND soi_status = 2
			         AND   soi_feccar IS NULL
			         AND   soi_stacar IS NULL
			         AND   soi_refamo = c_14.soi_refamo
			         AND   soi_keypro = wi_proceso
					  AND   soi_keycon IN ( SELECT dat_valore
				                             FROM glcodats,glcousua
				                            WHERE usu_keyusu = psKeyUsu
				                              AND usu_keymen = dat_keymen
				                              AND dat_idecam = 'keycon' )
  			         AND   soi_keycon NOT IN ( SELECT pam_folfin
                                 FROM glcopams
                                WHERE pam_keypar='Z03Q'
                                  AND pam_nompar = 'USUARIOS SIN RESTRICCION' );
			      --- Rechazo cualquier registro cuyo tipreg no sea 'A', 'C' y no haya
			      --- sido rechazado anteriormente (fecha de carga nula)
			      --- y el proceso sea igual al proceso enviado por parametro
			      UPDATE ap_sipros
			         SET  soi_keypre = 0,
			              soi_tipreg = 'R',
			              soi_feccar = SYSDATE,
			              soi_stacar = 'P'
			       WHERE soi_tipreg NOT IN ('A','C','R','E','O')
			       AND   soi_feccar IS NULL
			       AND   soi_stacar IS NULL
			       AND   soi_refamo = c_14.soi_refamo
			       AND   soi_keypro = wi_proceso
					  AND   soi_keycon IN ( SELECT dat_valore
				                             FROM glcodats,glcousua
				                            WHERE usu_keyusu = psKeyUsu
				                              AND usu_keymen = dat_keymen
				                              AND dat_idecam = 'keycon' )
  			       AND   soi_keycon NOT IN ( SELECT pam_folfin
                                 FROM glcopams
                                WHERE pam_keypar='Z03Q'
                                  AND pam_nompar = 'USUARIOS SIN RESTRICCION' );
			  --END FOR;
			END LOOP;
			-- Empiezo con los anticipos
			-- Asigno la llave de Prestamos mientras sea 'A' (anticipos)
			-- y el proceso sea igual al proceso enviado por parametro
			-- para empleados activos (23 - julio- 2001)
conta := conta_a;
			FOR c_15 IN (
			  SELECT
			   soi_keyemp, soi_keycon, soi_refere, soi_tipope,
			   soi_import, soi_fecope, soi_tipmon, soi_tipcam,
			   soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
			  --INTO
			  -- iSoi_keyemp, sSoi_keycon, sSoi_refere, sSoi_tipope,
			   --sSoi_import, iSoi_fecope, sSoi_tipmon, sSoi_tipcam,
			  -- sSoi_tipreg, sSoi_keypre, iSoi_keypro, iSoi_status, sSoi_refamo
			  FROM
			   ap_sipros
			  WHERE soi_tipreg = 'A'
			  AND   soi_status = 1   --- 23-julio-2001  ---
			  AND   soi_feccar IS NULL
			  AND   soi_stacar IS NULL
			  AND   soi_keypro = wi_proceso
			  AND   soi_keycon IN ( SELECT dat_valore
		                             FROM glcodats,glcousua
		                            WHERE usu_keyusu = psKeyUsu
		                              AND usu_keymen = dat_keymen
		                              AND dat_idecam = 'keycon' )
			  AND   soi_keycon NOT IN ( SELECT pam_folfin
                                 FROM glcopams
                                WHERE pam_keypar='Z03Q'
                                  AND pam_nompar = 'USUARIOS SIN RESTRICCION' ))
       LOOP
			    wn_fec_mov := 0;
			    wn_hor_mov := 0;
			    wn_min_mov := 0;
			    wn_seg_mov := 0;
			    wn_tot_mov := '0.0';
			    ws_tmp_mov := '';
			    wn_fec_mov := TO_NUMBER(SYSDATE);
			    wn_tot_mov := wn_fec_mov + conta_a;
			  UPDATE ap_sipros
			     SET soi_keypre = wn_tot_mov,
			         soi_feccar = SYSDATE,
			         soi_stacar = 'P'
			   WHERE soi_keyemp = c_15.soi_keyemp
			   AND   soi_keycon = c_15.soi_keycon
			   AND   soi_refere = c_15.soi_refere
			   AND   soi_tipreg = 'A'
			   AND   soi_feccar IS NULL
			   AND   soi_stacar IS NULL
			   AND   soi_refamo = c_15.soi_refamo;
			    conta := conta + '0.000001';
			END LOOP;
			-- Inserto en la tabla 'nmlopres' los anticipos del dia de hoy---
			-- cuando el proceso sea igual al proceso enviado por parametro ---
			-- y empleados activos (23-julio-2001)
			FOR c_16 IN (
			  SELECT
			   soi_keyemp, soi_keycon, soi_refere, soi_tipope,
			   soi_import, soi_fecope, soi_tipmon, soi_tipcam,
			   soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
			  --INTO
			  -- iSoi_keyemp, sSoi_keycon, sSoi_refere, sSoi_tipope,
			  -- sSoi_import, iSoi_fecope, sSoi_tipmon, sSoi_tipcam,
			  -- sSoi_tipreg, sSoi_keypre, iSoi_keypro, iSoi_status
			  FROM
			   ap_sipros
			  WHERE soi_tipreg = 'A'
			  AND   soi_status = 1
			  AND   soi_feccar = SYSDATE
			  AND   soi_keypre <> 0
			  AND   soi_keypro = wi_proceso
			  AND   soi_keycon IN ( SELECT dat_valore
		                             FROM glcodats,glcousua
		                            WHERE usu_keyusu = psKeyUsu
		                              AND usu_keymen = dat_keymen
		                              AND dat_idecam = 'keycon' )
			  AND   soi_keycon NOT IN ( SELECT pam_folfin
                                 FROM glcopams
                                WHERE pam_keypar='Z03Q'
                                  AND pam_nompar = 'USUARIOS SIN RESTRICCION' ))
      LOOP
			  -- selecciono fecha para insertar en prestamos con 45 dias de colchon
			  --CARSI LET wd_fecope = iSoi_fecope + 45;
			    dPer_fecini := c_16.soi_fecope + 30;
			  --CARSI SELECT per_keyper, per_fecini INTO sPer_keyper, dPer_fecini
			  SELECT per_keyper INTO sPer_keyper
			    FROM nmloperi
			   WHERE per_keypro= c_16.soi_keypro
			    AND  per_fecini <= c_16.soi_fecope     --CARSI wd_fecope
			    AND  per_fecfin >= c_16.soi_fecope     --CARSI wd_fecope
			    AND  per_keynom=1;
			   --actualizo tipo de cambio a 1 para Moneda Nacional
			   IF c_16.soi_tipmon = '1' THEN
			      IF c_16.soi_tipcam = 0.0 THEN
			           c_16.soi_tipcam := 1.0;
			      END IF;
			   END IF;
			   -- Para empleados activos.... --
			   IF c_16.soi_status = 1 THEN
			        iCountapres := 0;
			      -- Verifico si la llave existe en la tabla 'nmlopres'
			      SELECT COUNT(*) INTO iCountapres
			        FROM nmlopres
			       WHERE pre_keypre = c_16.soi_keypre;
			      -- Si no existe, se inserta el prestamo con estatus=4 --
			      IF iCountapres = 0 THEN
			         INSERT INTO nmlopres
			         (
			          pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
			          pre_tippre, pre_unipre, pre_imppre, pre_gastos, pre_plazop,
			          pre_unides, pre_impdes, pre_porint, pre_perini, pre_fecini,
			          pre_fecaut, pre_cveaut, pre_fechab, pre_uniamo, pre_impamo,
			          pre_unisal, pre_impsal, pre_uniult, pre_impult, pre_numpag,
			          pre_intpag, pre_status, pre_ultact, pre_refcon, pre_ctreve,
			          pre_fe1aux, pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux,
			          pre_ca4aux, pre_uniope, pre_keypro
			         )
			         VALUES
			         (
			          c_16.soi_keyemp, c_16.soi_keycon, c_16.soi_keypre, c_16.soi_refere, c_16.soi_fecope,
			          1          , NULL       , c_16.soi_import, NULL       , 1          ,
			          NULL       , c_16.soi_import, 0          , sPer_keyper, dPer_fecini,
			          c_16.soi_fecope, NULL       , NULL       , 0          , 0          ,
			          0          , c_16.soi_import, 0          , 0          , 0          ,
			          0          , 4          , c_16.soi_fecope, NULL       , c_16.soi_refamo,
			          NULL       , NULL       , c_16.soi_tipmon, c_16.soi_tipcam, NULL       ,
			          NULL       , NULL       , c_16.soi_keypro
			         );
			      ELSE
			         -- si existe la llave rechazo el movimiento --
			         UPDATE ap_sipros
			            SET soi_tipreg = 'R'
			          WHERE soi_keyemp = c_16.soi_keyemp
			          AND   soi_keycon = c_16.soi_keycon
			          AND   soi_refere = c_16.soi_refere
			          AND   soi_keypre = c_16.soi_keypre
			          AND   soi_tipreg = 'A'
			          AND   soi_stacar = 'P'
			          AND   soi_feccar = SYSDATE;
			      END IF;
			   END IF;
			END LOOP;
		END IF;
	END IF;
END IF;
--TRACE OFF;
-- Inserto en la tabla de Amortizaciones
--EXECUTE PROCEDURE sp_tvsoin_insamo(wi_proceso, psConceptos, psConceptosOpci, psKeyUsu);
END;
/
