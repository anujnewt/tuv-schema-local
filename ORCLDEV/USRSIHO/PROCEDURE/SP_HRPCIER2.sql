CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HRPCIER2" (pi_proceso NUMBER, ps_periodo VARCHAR2) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 li_keyrph NUMBER(10);
 li_keyfol NUMBER(10);
 li_keyplz NUMBER(10);
 li_capini NUMBER(10);
 li_capfin NUMBER(10);
 li_tipocontr NUMBER(10);
 li_keysec NUMBER(10);
 li_count  NUMBER(10);
 li_numcap  NUMBER(10);
 li_cntpag  NUMBER(10);
 ls_keydep VARCHAR2(16);
 ls_keypue VARCHAR2(16);
 li_costo  NUMBER(16,2);
 li_exipre NUMBER(10);
 li_empleado NUMBER(10);
 ls_tipfol VARCHAR2(1);
 ls_sindic VARCHAR2(1);
 ls_regfis VARCHAR2(6);
 ls_activi VARCHAR2(6);
 ls_concep VARCHAR2(6);
 ld_fecpag DATE;
    vn_keytco NUMBER(3);
    vn_keyfol NUMBER(6);
    vn_numcap NUMBER(5);
    vn_sumcap NUMBER(5);
    li_keydep VARCHAR2(8);
    li_keyemp NUMBER (09);
    li_keytco NUMBER(03);
    li_ctvplz NUMBER (09);
    wn_ca2aux VARCHAR2(12);
    li_nomina NUMBER(10);
BEGIN
   	--MODIFICACIONES DE CONTRATOS CAPITULOS
   	FOR rec IN (SELECT 	frp.frp_keyrph,gdp.gdp_keyfol,gdp.gdp_capini,gdp.gdp_capfin,gdp.gdp_keytco,con.con_keyplz,
                  	frp.frp_keydep,gdp.gdp_keypue,gdp.gdp_numcap * gdp.gdp_cosuni total
           	FROM 	USRSIHO.holofrph frp,USRSIHO.hologdpr gdp,USRSIHO.HOLOCONT con
           	WHERE 	frp.frp_keypro = pi_proceso
            AND 	frp.frp_keyper = ps_periodo
            AND 	frp.frp_keyrph = gdp.gdp_keyrph
            AND 	con.con_keyfol = gdp.gdp_keyfol
            AND 	con.con_keytco = gdp.gdp_keytco
            AND 	con.con_stspag = 'V'
           	GROUP BY 	frp.frp_keyrph,	gdp.gdp_keyfol,	gdp.gdp_capini,	gdp.gdp_capfin,	gdp.gdp_keytco,	con.con_keyplz,
                    	frp.frp_keydep, gdp.gdp_keypue, gdp.gdp_numcap, gdp.gdp_cosuni) LOOP
           	--ACTUALIZACION POR CADA UNO DEL LOS REGISTROS
	           li_keyrph := rec.frp_keyrph;
	           li_keyfol := rec.gdp_keyfol;
	           li_capini := rec.gdp_capini;
	           li_capfin := rec.gdp_capfin;
	           li_tipocontr := rec.gdp_keytco;
	           li_keyplz := rec.con_keyplz;
	           ls_keydep := rec.frp_keydep;
	           ls_keypue := rec.gdp_keypue;
	           li_costo := rec.total;
	           UPDATE USRSIHO.holococa
                SET coc_stspag = 'E'
                WHERE coc_keyplz = li_keyplz and coc_keycap between li_capini and li_capfin;
-- 		      --SI EL REGISTRO EXISTE => ACTUALIZA DE LO CONTRARIO, INSERTA EL REGISTRO
--            SELECT COUNT(*)
--            INTO 	li_exipre
--            FROM 	holopres
--            WHERE 	pre_keydep=ls_keydep
--            AND	pre_keypue=ls_keypue;
        	-- Si el tipo de folio es normal => realiza la actualizacion
			BEGIN
				SELECT	TRIM(per_nu5aux)
				INTO 	ls_tipfol
				FROM 	USRSIHO.nmloperi
				WHERE 	per_keypro = pi_proceso
				AND 	per_keyper = ps_periodo;
				EXCEPTION WHEN no_data_found THEN ls_tipfol := '';
			END;
--            IF li_exipre > 0 THEN
--            	  --AJUSTE DEL PRESUPUESTO SOLO SI EL TIPO DE FOLIO ES NORMAL
--                IF ls_tipfol = 'N' THEN
--              	  UPDATE	holopres
--                    SET 		pre_pagado=pre_pagado+li_costo
--                    WHERE 	pre_keydep=ls_keydep
--                    AND 		pre_keypue=ls_keypue;
--                END IF
--        	  ELSE
--            	  INSERT INTO holopres(pre_keydep,pre_keypue,pre_presup,pre_ejerci,pre_pagado)
--            	  VALUES(ls_keydep,ls_keypue,0,0,li_costo);
--         	  END IF
	END LOOP;
   	--INSERTADO EN LA TABLA TEMPORAL
			li_keyrph := 0 ;
		li_keyfol := 0 ;
	INSERT INTO cierre2_tmp
	SELECT 	gdp.gdp_keyfol tem_keyfol,gdp.gdp_keytco tem_keytco
	FROM	USRSIHO.holofrph frp,USRSIHO.hologdpr gdp,USRSIHO.HOLOCONT con
	WHERE 	frp.frp_keypro = pi_proceso
	AND 	frp.frp_keyper = ps_periodo
	AND 	frp.frp_keyrph = gdp.gdp_keyrph
	AND 	con.con_keyfol = gdp.gdp_keyfol
	AND 	con.con_keytco = gdp.gdp_keytco
	GROUP BY 	gdp.gdp_keyfol,gdp.gdp_keytco
   ;
   	--ACTUALIZACION DE CONTRATOS
   	--PHM 20161018 Se agrega el con_numcap al SELECT y al INTO el li_numcap
   	FOR rec2	IN (SELECT	con.con_keyplz, con.con_keytva, con_keydep, con_keyemp, con_keytco, con_ctvplz, con_numcap
           	FROM 	USRSIHO.HOLOCONT con, USRSIHO.cierre2_tmp tem
           	WHERE 	con.con_keyfol = tem.gdp_keyfol
        	AND 	con_keytco = gdp_keytco) LOOP
	           li_keyplz := rec2.con_keyplz;
	           li_tipocontr := rec2.con_keytva;
	           li_keydep := rec2.con_keydep;
	           li_keyemp := rec2.con_keyemp;
	           li_keytco := rec2.con_keytco;
	           li_ctvplz := rec2.con_ctvplz;
	           li_numcap := rec2.con_numcap;
	           IF li_tipocontr = 1 THEN
           		--SELECT COUNT(*) INTO li_count FROM holococa
              	--WHERE coc_keyplz = li_keyplz AND coc_stspag <> 'E';
              	--IF  li_count = 0 THEN
              	--PHM 20161018 Se comentan las 3 lineas anteriores y se agregan las 2 siguientes
				BEGIN
					SELECT COUNT(*)
					INTO li_cntpag
					FROM USRSIHO.HOLOCOCA
					WHERE coc_keyplz = li_keyplz
					AND coc_keyrph is not null;
					EXCEPTION WHEN no_data_found THEN li_cntpag := 0;
				END;
              	IF li_cntpag = li_numcap THEN
                	UPDATE  USRSIHO.HOLOCONT
                 	SET     con_stspag = 'E'
                 	WHERE   con_keyplz = li_keyplz;
					UPDATE USRSIHO.holoplza
     	 	 		SET plz_status = 0, plz_keyfol = null
         	 		WHERE plz_ctvplz = li_ctvplz
         	 		AND plz_keydep = li_keydep
         	 		AND plz_keyemp = li_keyemp
         	 		AND plz_keytco = li_keytco;
              	END IF;
           	END IF;
           	IF li_tipocontr = 2 THEN
           		--PHM 20161018 Se agrega el con_numcap al SELECT y al INTO el li_numcap
            	FOR rec3 IN (SELECT con_numcdi, con_numcap FROM USRSIHO.HOLOCONT WHERE con_keyplz = li_keyplz) LOOP
	                li_count := rec3.con_numcdi;
	                li_numcap := rec3.con_numcap;
	                IF  li_count = 0 THEN
                		--PHM 20161018 Se agrega el SELECT y el IF de las siguientes 2 lineas
                 		SELECT COUNT(*) INTO li_cntpag FROM USRSIHO.HOLOCOCA WHERE coc_keyplz = li_keyplz and coc_keyrph is not null;
                 			IF li_cntpag = li_numcap THEN
                    			UPDATE  USRSIHO.HOLOCONT
                    			SET     con_stspag = 'E'
                    			WHERE   con_keyplz = li_keyplz;
                    		END IF;
                 	END IF;
              	END LOOP;
           	END IF;
	END LOOP;
   --TRASPASO DE GASTOS DE PRODUCCION A HISTORICO DE PRODUCCION.
   INSERT INTO USRSIHO.holohgdp(hgd_keysec,hgd_keydep,hgd_keyrph,hgd_fechag,hgd_keyemp,
                        hgd_keypue,hgd_capini,hgd_capfin,hgd_numcap,hgd_keycon,
                        hgd_marcon,hgd_marcos,hgd_costog,hgd_keysue,hgd_keytco,
                        hgd_keyfol,hgd_minleg,hgd_minsal,hgd_minext,hgd_mincom)
          SELECT gdp.gdp_keysec,gdp.gdp_keydep,frp.frp_keyrph,gdp.gdp_fechag,gdp.gdp_keyemp,
                 gdp.gdp_keypue,gdp.gdp_capini,gdp.gdp_capfin,gdp.gdp_numcap,gdp.gdp_keycon,
                 gdp.gdp_marcon,gdp.gdp_marcos,gdp.gdp_cosuni,gdp.gdp_keysue,gdp.gdp_keytco,
                 gdp.gdp_keyfol,gdp.gdp_minleg,gdp.gdp_minsal,gdp.gdp_minext,gdp.gdp_mincom
          FROM   USRSIHO.hologdpr gdp , USRSIHO.holofrph frp
          WHERE  frp.frp_keypro = pi_proceso and
                 frp.frp_keyper = ps_periodo and
                 frp.frp_keyrph = gdp.gdp_keyrph;
   --MARCAR LOS RPH COMO HISTORICOS
   UPDATE USRSIHO.holofrph
      SET frp_stsfol = '2'
    WHERE frp_keypro = pi_proceso
      AND frp_keyper = ps_periodo;
   --BORRAR LOS REGISTROS DE LA TABLA DE GASTOS DE PRODUCCION
   DELETE
   FROM USRSIHO.hologdpr
   WHERE  GDP_KEYRPH  IN ( select frp.frp_keyrph  from USRSIHO.holofrph frp
                           where frp.frp_keypro = pi_proceso and
                                 frp.frp_keyper = ps_periodo);
   --BORRAR LA TABLA TEMPORAL
   --EXECUTE IMMEDIATE 'TRUNCATE TABLE temporal';
  -- cierre2_tmp
--    UPDATE nmlohism set his_ca1aux = nvl(his_ca1aux[1,3],'   ')||'0'
--     where his_keypro = pi_proceso
       --and his_keyper = ps_periodo;
	BEGIN
		SELECT per_fecpag
		INTO ld_fecpag
		FROM USRSIHO.nmloperi
		WHERE per_keypro = pi_proceso
		AND per_keyper = ps_periodo;
		EXCEPTION WHEN no_data_found THEN ld_fecpag := '';
	END;
    DBMS_OUTPUT.put_line('nvl(substr(his_ca1aux,1,3)');
    UPDATE USRSIHO.nmlohism
       -- SET his_ca1aux = nvl(substr(his_ca1aux,1,3),'   ')||'0',
       SET his_ca1aux = PON_VALOR(his_ca1aux, 4, '0'),
           his_fecmov = ld_fecpag
     WHERE his_keypro = pi_proceso
       AND his_keyper = ps_periodo;
   ------------     ACTUALIZA EL REGIMEN FISCAL  ------------------
    for rec4
     in (select his_keyemp,pam_cvesec
       from USRSIHO.nmlohism,USRSIHO.glcopams
      where his_keypro = pi_proceso
        and his_keyper = ps_periodo
        and his_keycon = 'H87'
        and pam_keypar = 'TC2'
        and to_number(pam_cvesec) = his_import) loop
         li_empleado := rec4.his_keyemp;
         ls_regfis := rec4.pam_cvesec;
         DBMS_OUTPUT.put_line('ls_regfis '||to_char(ls_regfis));
         UPDATE USRSIHO.nmlohism set his_ca1aux = ls_regfis
          where his_keypro = pi_proceso
            and his_keyper = ps_periodo
            and his_keyemp = li_empleado;
    end loop;
   ------------     ACTUALIZA LAS CUOTAS SINDICALES ------------------
    for rec5
     in (select distinct pue_keypue,pue_ca5aux,decode(substr(pue_ca3aux,1,2),'10','7','12','8','8','9',substr(pue_ca3aux,1,1)) valor
       from USRSIHO.nmlohism,USRSIHO.nmcopues
      where his_keypro = pi_proceso
        and his_keyper = ps_periodo
        and his_keypue = pue_keypue
        and his_keypue != 'H01'
        and pue_ca3aux is not null) loop
         ls_activi := rec5.pue_keypue;
         ls_concep := rec5.pue_ca5aux;
         ls_sindic := rec5.valor;
DBMS_OUTPUT.put_line('substr(his_ca1aux,1,4 '||to_char(ls_sindic));
        -- CORREGIR SENTENCIA ELJM
         -- UPDATE USRSIHO.nmlohism set his_ca1aux = nvl(substr(his_ca1aux,1,4),'    ')||ls_sindic
         UPDATE USRSIHO.nmlohism SET his_ca1aux = PON_VALOR(his_ca1aux, 5, ls_sindic)
          WHERE his_keypro = pi_proceso
            AND his_keyper = ps_periodo
            AND his_keypue = ls_activi
            AND his_keycon = ls_concep;
    end loop;
   --ACTUALIZAR LOS MOVIMIENTOS DE ANDA Y ANDI COMO PAGADOS
	BEGIN
		SELECT per_fecpag, per_keynom
		INTO ld_fecpag, li_nomina
		FROM USRSIHO.nmloperi
		WHERE per_keypro = pi_proceso
		AND per_keyper = ps_periodo;
		EXCEPTION WHEN no_data_found THEN ld_fecpag := ''; li_nomina := 0;
	END;
DBMS_OUTPUT.put_line('002 substr(his_ca1aux,4,lentgh ');
  UPDATE USRSIHO.nmlohism
     SET his_ca1aux = '002' || SUBSTR(his_ca1aux, 4, LENGTH(his_ca1aux)),
          his_fecmov = ld_fecpag
   WHERE his_keypro = pi_proceso
     AND his_keyper = ps_periodo
--      AND his_keynom in (109,110)  --   LINEA ORIGINAL
     AND his_keynom in (109,110,103); --   LINEA NUEVA  }  ---Se comento todo el UPDATE 23/01/2007
--      AND exists(select emp_keyemp
--                 from nmcoempl
--                where emp_keyemp = his_keyemp
--                  and emp_ca2aux < 100); } --Se comento esto por que no es necesario y estaba tronando conversion character
/*UPDATE nmlohism
      SET his_ca1aux = '1021',his_fecmov = ld_fecpag
    WHERE his_keypro = pi_proceso
      AND his_keyper = ps_periodo
    --AND his_keynom in (109,110)  --   LINEA ORIGINAL
      AND his_keynom in (109,110,103); --   LINEA NUEVA */   ---Se comento todo el UPDATE 23/01/2007
/*      AND exists(select emp_keyemp
                 from nmcoempl
                where emp_keyemp = his_keyemp
                  and emp_ca2aux > 99); */  --Se comento esto por que no es necesario y estaba tronando conversion character
  IF li_nomina = 113 THEN
	 BEGIN
     SELECT  emp_ca2aux
     INTO wn_ca2aux
     from USRSIHO.nmcoempl
     WHERE emp_keyemp = 490195711;
	 EXCEPTION WHEN no_data_found THEN wn_ca2aux := '';
	 END;
  END IF;
  li_nomina := 0;
DBMS_OUTPUT.put_line('wn_ca2aux '||to_char(wn_ca2aux));
  UPDATE USRSIHO.nmlohism
      --SET his_ca1aux[1,3] = wn_ca2aux
      SET his_ca1aux = wn_ca2aux || SUBSTR(his_ca1aux, 4, LENGTH(his_ca1aux)),
          his_fecmov = ld_fecpag
      WHERE his_keypro = pi_proceso
      AND his_keyper = ps_periodo
      AND his_keynom in (113)
      AND his_keyemp = 490195711;
DBMS_OUTPUT.put_line('008 ');
  UPDATE USRSIHO.nmlohism
      --SET his_ca1aux[1,3] = '008'
      SET his_ca1aux = '008' || SUBSTR(his_ca1aux, 4, LENGTH(his_ca1aux)),
          his_fecmov = ld_fecpag
      WHERE his_keypro = pi_proceso
      AND his_keyper = ps_periodo
      AND his_keynom in (113)
      AND his_keyemp <> 490195711;
---aedo 30/08/07 se comento el filtro
----      AND exists(select emp_keyemp
----                 from nmcoempl
----                where emp_keyemp = his_keyemp
----                  and emp_ca2aux not in ('104','107'));
--------------------------------------------------------------------------------
   for rec6
     in (select his_keyemp,emp_ca2aux
       from USRSIHO.nmlohism,USRSIHO.nmcoempl
     where  his_keypro = pi_proceso
        and his_keyper = ps_periodo
        and his_keyemp = emp_keyemp
        and emp_ca2aux  in ('104','107')) loop
        li_empleado := rec6.his_keyemp;
        ls_regfis := rec6.emp_ca2aux;
        DBMS_OUTPUT.put_line('ls_regfis 2 '||to_char(ls_regfis));
        UPDATE USRSIHO.nmlohism set his_ca1aux = ls_regfis
        where his_keypro = pi_proceso
            and his_keyper = ps_periodo
            and his_keyemp = li_empleado
            and his_keynom <> 113;
---aedo 30/08/07  se agrego el filtro de la nomina 113
    end loop;
---------------------------------------------------------------------------------
--aedo 30/08/07  se quito el envio del valor 1
---   SET his_ca1aux = '008'||'1',his_fecmov = ld_fecpag
DBMS_OUTPUT.put_line('008');
UPDATE USRSIHO.nmlohism
      SET his_ca1aux = '008',his_fecmov = ld_fecpag
    WHERE his_keypro = pi_proceso
      AND his_keyper = ps_periodo
      AND (his_keycon = 'H42' or his_keyemp = 1);
--aedo 30/08/07  se quito el envio del valor 1
---   SET his_ca1aux = '0081',his_fecmov = ld_fecpag
DBMS_OUTPUT.put_line('008 2 ');
UPDATE USRSIHO.nmlohism
      SET his_ca1aux = '008',
          his_fecmov = ld_fecpag
    WHERE his_keypro = pi_proceso
      AND his_keyper = ps_periodo
      AND his_keycon = 'H20';
---Se adicionaron estas lineas al Store Procedure JDCM 23/FEB/2005
   --- Primero es un foreach
   FOR rec7  IN (SELECT hgd_keytco,hgd_keyfol,con_numcap
              FROM USRSIHO.holofrph,
                   USRSIHO.holohgdp,
                   USRSIHO.HOLOCONT
             WHERE frp_keypro=pi_proceso
               AND frp_keyper=ps_periodo
               AND frp_keyrph=hgd_keyrph
               AND con_keytco=hgd_keytco
               AND con_keyfol=hgd_keyfol
               AND con_stspag='V') LOOP
            --- Segundo, sumatoria de capitulos realmente pagados
            vn_keytco := rec7.hgd_keytco;
            vn_keyfol := rec7.hgd_keyfol;
            vn_numcap := rec7.con_numcap;
            SELECT sum(hgd_numcap)
              INTO vn_sumcap
              FROM USRSIHO.holohgdp,USRSIHO.holofrph,USRSIHO.nmloperi,USRSIHO.nmlohism,USRSIHO.holoenctra,USRSIHO.holodettra
             WHERE hgd_keytco=vn_keytco
               AND hgd_keyfol=vn_keyfol
               AND frp_keypro=pi_proceso
               AND frp_keyrph=hgd_keyrph
               AND frp_keypro=per_keypro
               AND frp_keyper=per_keyper
               AND per_keypro=his_keypro
               AND per_keyper=his_keyper
               AND per_keynom=his_keynom
               AND his_keyemp=hgd_keyemp
               AND his_keypue=hgd_keypue
               AND his_keycon=hgd_keycon
               AND HIS_KEYDEP=FRP_KEYDEP      ---CIG---27/04/2005---
               AND substr(his_ca1aux,4, 1)!='2'
               --PHM 2017 Se le anexan las siguientes 6 lineas y las tablas holoenctra y holodettra
               AND frp_keyrph=det_keyrph
               AND hgd_keyfol=det_keyfol
               AND hgd_keyemp=det_keyemp
               AND det_num_id=enc_num_id
               AND det_stsreg='V'
               AND enc_descap NOT LIKE 'RETROACTIVO%';
             -- En caso de con_numcap = a la sumatoria del segundo
             IF vn_sumcap = vn_numcap THEN
               /* INSERT INTO borra(campo1) VALUES(vn_keyfol);
                INSERT INTO borra(campo1) VALUES(vn_keytco);
                INSERT INTO borra(campo1) VALUES(vn_numcap);
                INSERT INTO borra(campo1) VALUES(vn_sumcap);*/
               UPDATE USRSIHO.HOLOCONT
                  SET con_numcdi=0,
                      con_stspag='E'
                WHERE con_keytco=vn_keytco
                  AND con_keyfol=vn_keyfol;
             END IF;
   END LOOP;
  ---JDCM Termina Lineas extras
 ---JCRO Proceso para actualizar el estatus de las hojas de trabajo a cerradas.
 UPDATE USRSIHO.HOLOENCTRA
    SET enc_stsrep = '4'
  WHERE enc_num_id IN  (SELECT DISTINCT det_num_id
                          FROM USRSIHO.HOLODETTRA,USRSIHO.HOLOFRPH
                         WHERE det_keyrph = frp_keyrph
                           AND frp_keypro = pi_proceso
                           AND frp_keyper = ps_periodo
                       );
 ---JCRO
END;
/
