CREATE OR REPLACE NONEDITIONABLE PACKAGE "LABCONF"."TVCONTAB" IS
	TYPE argumentos IS RECORD ( idepro LABCONF.glcoargu.arg_idepro%TYPE, idepcc LABCONF.glcoargu.arg_idepcc%TYPE,
								keyusu LABCONF.glcoargu.arg_keyusu%TYPE, fecini LABCONF.glcoargu.arg_fecini%TYPE,
								horini LABCONF.glcoargu.arg_horini%TYPE);
	TYPE partefija  IS RECORD ( keyemp LABCONF.nmlohism.his_keyemp%TYPE, keypro LABCONF.nmlohism.his_keypro%TYPE,
								keycon LABCONF.nmlohism.his_keycon%TYPE, codimp LABCONF.nmlohism.his_codimp%TYPE,
								descon LABCONF.nmloconc.con_descon%TYPE, keycia LABCONF.nmloproc.pro_keycia%TYPE,
								keypol LABCONF.nmloperi.per_keypol%TYPE, cveban LABCONF.nmcoempl.emp_cveban%TYPE,
								forpag LABCONF.nmcoempl.emp_forpag%TYPE, keyben LABCONF.nmlohism.his_keyben%TYPE,
								comfam LABCONF.nmlohism.his_comfam%TYPE, fecmov LABCONF.nmlohism.his_fecmov%TYPE);
	---------------------------------
	-- procedimientos
    PROCEDURE SP_POLIZA (idepro IN LABCONF.glcoargu.arg_idepro%TYPE, idepcc IN LABCONF.glcoargu.arg_idepcc%TYPE,
						 keyusu IN LABCONF.glcoargu.arg_keyusu%TYPE, fecini IN LABCONF.glcoargu.arg_fecini%TYPE,
						 horini IN LABCONF.glcoargu.arg_horini%TYPE);
    PROCEDURE SP_CONTABLE (proceso IN LABCONF.nmlohism.his_keypro%TYPE, periodo IN LABCONF.nmlohism.his_keyper%TYPE);
    PROCEDURE SP_INSERTA (datospf IN partefija, referencia IN LABCONF.nmcodeps.dep_refcon%TYPE,
						  ctaconcepto IN LABCONF.nmloconc.con_ctaref%TYPE,seietu IN LABCONF.nmloconc.con_porcen%TYPE,
						  impcar IN LABCONF.nmlohism.his_import%TYPE, impabo IN LABCONF.nmlohism.his_import%TYPE,
						  tipo IN LABCONF.tvwkpoli.pol_tipo%TYPE);
    PROCEDURE SP_FINIQUITO (empleado IN LABCONF.nmwkmovt.mov_keyemp%TYPE, periodo IN LABCONF.nmwkmovt.mov_keyper%TYPE,
							proceso IN LABCONF.nmcoempl.emp_keypro%TYPE);
    PROCEDURE SP_RECLASIFICA (proceso IN LABCONF.nmlohism.his_keypro%TYPE, periodo IN LABCONF.nmlohism.his_keyper%TYPE,
							  keypol IN LABCONF.tvwkpoli.pol_keypol%TYPE);
	--------------------------------
    --funciones
END TVCONTAB;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "LABCONF"."TVCONTAB" IS
/* -- Variables Globales-------------------------------------------- */
    poliza 	partefija;  -- Campos que no var¿¿¿¿an en la p¿¿¿¿liza para un registro espec¿¿¿¿fico
    args 		argumentos;  -- valores de la glcoargu
    proceso	LABCONF.nmlohism.his_keypro%TYPE;  -- proceso guardado en la glcoargu
    periodo LABCONF.nmlohism.his_keyper%TYPE;  -- periodo guardado en la glcoargu
    nomina 	LABCONF.nmlohism.his_keynom%TYPE;   -- Tipo de Nomina
    -- -----------------------------------------------------------------------------------------------------------------
    -- ELJM OPCIS PARA REGISTRO DUPLICADO
   	DR_ciaori LABCONF.TVWKPOLI.POL_CIA%TYPE;  	-- CIA ORIGEN PARA APLICAR DOBLE REGISTRO		'019'
   	DR_ciades LABCONF.TVWKPOLI.POL_CIA%TYPE;  	-- CIA DESTINO PARA APLICAR DOBLE REGISTRO	'522'
    DR_concep LABCONF.NMLOHISM.HIS_KEYCON%TYPE; -- CVE CONCEPTO DE COMISIONES					    	'M39'
    DR_cta   	LABCONF.TVWKPOLI.POL_CTA%TYPE;		-- CTA PARA AFECTACION DOBLE REGISTRO       '126'
    DR_scta   LABCONF.TVWKPOLI.POL_SCTA%TYPE;  	-- SCTA PARA AFECTACION	DOBLE REGISTRO 			'012002'
    -- -----------------------------------------------------------------------------------------------------------------
/* -- Constantes -------------------------------------------- */
    argpro  	LABCONF.glcoargu.arg_keycam%TYPE := 'KEYPRO'; -- clave de campo en la glcoargu para proceso
    argper  	LABCONF.glcoargu.arg_keycam%TYPE := 'KEYPER'; -- clave de campo en la glcoargu para periodo
    madre   	LABCONF.tvwkpoli.pol_tipo%TYPE := 1; -- clave para la cuenta madre
    hija    	LABCONF.tvwkpoli.pol_tipo%TYPE := 2; -- clave para la cuenta hija
    regs    INTEGER := 10; -- numero de registros antes de actualizar en la glcoresu
    PROCEDURE SP_RECLASIFICA2(proceso IN LABCONF.nmlohism.his_keypro%TYPE, periodo IN LABCONF.nmlohism.his_keyper%TYPE,keypol IN LABCONF.tvwkpoli.pol_keypol%TYPE);
--PROCEDIMIENTOS /* -------------------------------------------------------------------------- */
  PROCEDURE SP_POLIZA (idepro IN LABCONF.glcoargu.arg_idepro%TYPE, idepcc IN LABCONF.glcoargu.arg_idepcc%TYPE, keyusu IN LABCONF.glcoargu.arg_keyusu%TYPE,
                        fecini IN LABCONF.glcoargu.arg_fecini%TYPE, horini IN LABCONF.glcoargu.arg_horini%TYPE) IS
   BEGIN
       args.idepro := idepro;  args.idepcc := idepcc;  args.keyusu := keyusu;  args.fecini := fecini;  args.horini := horini;
       SELECT arg_pvalor INTO proceso FROM LABCONF.glcoargu
       WHERE arg_idepro = idepro AND arg_idepcc = idepcc AND arg_keyusu = keyusu
       AND arg_fecini = fecini AND arg_horini = horini AND arg_keycam = argpro;
       SELECT arg_pvalor INTO periodo FROM LABCONF.glcoargu
       WHERE arg_idepro = idepro AND arg_idepcc = idepcc AND arg_keyusu = keyusu
       AND arg_fecini = fecini AND arg_horini = horini AND arg_keycam = argper;
       SP_CONTABLE(proceso, periodo);
   END SP_POLIZA;
/* -------------------------------------------------------------------------- */
  PROCEDURE SP_CONTABLE (proceso IN LABCONF.nmlohism.his_keypro%TYPE, periodo IN LABCONF.nmlohism.his_keyper%TYPE) IS
      total     INTEGER;
      i         INTEGER;
      CveVersion   INTEGER;
      CvePoliza LABCONF.nmloperi.per_keypol%Type;
      CveVersionProc INTEGER;
  BEGIN
  -- marcar el periodo per_selper = P para procesar
  update LABCONF.nmloperi set per_persel = 'P' where per_keyper = periodo and per_keypro = proceso;
  COMMIT;
  SELECT per_keynom,per_keypol,pro_vercon
  INTO nomina,CvePoliza,CveVersionProc
  FROM LABCONF.nmloperi
  INNER JOIN LABCONF.nmloproc ON per_keypro = pro_keypro
  WHERE per_keypro = proceso
  and per_keyper = periodo;
  SELECT CASE WHEN vxn_keyver IS NULL THEN 0 ELSE CASE WHEN CveVersionProc = 100 THEN vxn_keyver + 100 ELSE vxn_keyver END END vxn_keyver  INTO CveVersion
  FROM LABCONF.nmlonomi
  LEFT JOIN LABCONF.tvlovxnom ON nom_keynom = vxn_keynom
  WHERE nom_keynom = nomina;
  -- -------------------------------------------------------------------------------------------------------------------
	-- ELJM RECUPERA LAS OPCIS DEL PROGRAMA PARA DOBLE REGISTRO
	-- DR_ciaori TVWKPOLI.POL_CIA%TYPE;  	-- CIA ORIGEN PARA APLICAR DOBLE REGISTRO		'019'			OPCI11
	SELECT  NVL(PAM_FOLINI, '019')
	INTO    DR_ciaori
	FROM    LABCONF.GLCOPAMS
	WHERE   PAM_KEYPAR = (SELECT  PAM_FOLINI
	                      FROM    LABCONF.GLCOPAMS
	                      WHERE   PAM_KEYPAR = '00'
	                      AND     PAM_CVESEC = 'polcon')
	AND     PAM_CVESEC = 'OPCI11';
	-- DR_ciades TVWKPOLI.POL_CIA%TYPE;  	-- CIA DESTINO PARA APLICAR DOBLE REGISTRO	'522'			OPCI12
	SELECT  NVL(PAM_FOLINI, '522')
	INTO    DR_ciades
	FROM    LABCONF.GLCOPAMS
	WHERE   PAM_KEYPAR = (SELECT  PAM_FOLINI
	                      FROM    LABCONF.GLCOPAMS
	                      WHERE   PAM_KEYPAR = '00'
	                      AND     PAM_CVESEC = 'polcon')
	AND     PAM_CVESEC = 'OPCI12';
	-- DR_concep NMLOHISM.HIS_KEYCON%TYPE; -- CVE CONCEPTO DE COMISIONES					    	'M39'			OPCI13
	SELECT  NVL(PAM_FOLINI, 'M39')
	INTO    DR_concep
	FROM    LABCONF.GLCOPAMS
	WHERE   PAM_KEYPAR = (SELECT  PAM_FOLINI
	                      FROM    LABCONF.GLCOPAMS
	                      WHERE   PAM_KEYPAR = '00'
	                      AND     PAM_CVESEC = 'polcon')
	AND     PAM_CVESEC = 'OPCI13';
	-- DR_cta   	TVWKPOLI.POL_CTA%TYPE;		-- CTA PARA AFECTACION								      '126'			OPCI14
	SELECT  NVL(PAM_FOLINI, '126')
	INTO    DR_cta
	FROM    LABCONF.GLCOPAMS
	WHERE   PAM_KEYPAR = (SELECT  PAM_FOLINI
	                      FROM    LABCONF.GLCOPAMS
	                      WHERE   PAM_KEYPAR = '00'
	                      AND     PAM_CVESEC = 'polcon')
	AND     PAM_CVESEC = 'OPCI14';
	-- DR_scta   TVWKPOLI.POL_SCTA%TYPE;  	-- SCTA PARA AFECTACION											'012002'	OPCI15
	SELECT  NVL(PAM_FOLINI, '012002')
	INTO    DR_scta
	FROM    LABCONF.GLCOPAMS
	WHERE   PAM_KEYPAR = (SELECT  PAM_FOLINI
	                      FROM    LABCONF.GLCOPAMS
	                      WHERE   PAM_KEYPAR = '00'
	                      AND     PAM_CVESEC = 'polcon')
	AND     PAM_CVESEC = 'OPCI15';
  -- -------------------------------------------------------------------------------------------------------------------
  -- borra p¿¿¿¿liza
  delete from LABCONF.tvwkpoli where pol_keypol = CvePoliza;
  COMMIT;
  -- cuenta
  SELECT count(*) into total from LABCONF.nmlohism
      inner join LABCONF.nmcodeps on (his_keydep = dep_keydep)
      inner join LABCONF.nmloperi on (his_keyper = per_keyper and his_keypro = per_keypro)
      inner join LABCONF.nmcoempl on (his_keyemp = emp_keyemp)
      inner join LABCONF.nmloproc ON (his_keypro = pro_keypro)
      INNER JOIN LABCONF.tvloverc Ver0 ON (Ver0.ver_keyver = pro_vercon and his_keycon = Ver0.ver_keycon)
      LEFT JOIN LABCONF.tvloverc Ver ON (Ver.ver_keyver = CveVersion and his_keycon = Ver.ver_keycon AND Ver.ver_keyver <>0)
      where his_keyper = periodo
      and his_keypro = proceso
      and (length(dep_refcon) = 52 or length(dep_refcon) = 26);
  IF total = 0 THEN
   update LABCONF.nmloperi set per_persel = '' where per_keyper = periodo and per_keypro = proceso;
   UPDATE LABCONF.glcoresu SET res_status = 'T',res_totreg = 0,res_numreg = 0
     WHERE res_idepro = args.idepro AND res_idepcc = args.idepcc AND res_fecini = args.fecini AND res_horini = args.horini;
   COMMIT;
   RETURN;
  END IF;
  -- inicializa contador
     i := 1;
  -- inicializa registro en glcoresu (el registro ya fue insertado desde el programa del cliente
    UPDATE LABCONF.glcoresu SET res_numreg = i, res_totreg = total
    WHERE res_idepro = args.idepro AND res_idepcc = args.idepcc AND res_keyusu = args.keyusu
    AND res_fecini = args.fecini AND res_horini = args.horini;
  -- procesa
    FOR reg IN (SELECT his_keyemp, his_keypro, his_keycon, his_codimp, '' con_descon,
      CASE WHEN Ver.ver_ctaref IS NULL THEN Ver0.ver_ctaref ELSE Ver.ver_ctaref END con_ctaref,
      CASE WHEN Ver.ver_ctaaux IS NULL THEN Ver0.ver_ctaaux ELSE Ver.ver_ctaaux END con_ctaaux,
                dep_refcon,
      CASE WHEN Ver.ver_ietu IS NULL THEN Ver0.ver_ietu ELSE Ver.ver_ietu END con_porcen,
      his_import, 0 pro_keycia, per_keypol, emp_cveban, emp_forpag, his_keyben, his_comfam, his_fecmov
      from LABCONF.nmlohism
      inner join LABCONF.nmcodeps on (his_keydep = dep_keydep)
      inner join LABCONF.nmloperi on (his_keyper = per_keyper and his_keypro = per_keypro)
      inner join LABCONF.nmcoempl on (his_keyemp = emp_keyemp)
      INNER JOIN LABCONF.nmloproc ON (his_keypro = pro_keypro)
      INNER JOIN LABCONF.tvloverc Ver0 ON (Ver0.ver_keyver = pro_vercon and his_keycon = Ver0.ver_keycon)
      LEFT JOIN LABCONF.tvloverc Ver ON (Ver.ver_keyver = CveVersion and his_keycon = Ver.ver_keycon AND Ver.ver_keyver <>0)
      where his_keyper = periodo
      and his_keypro = proceso
      and (length(dep_refcon) = 52 or length(dep_refcon) = 26)
      order by emp_keyemp)
    LOOP
        poliza.keyemp := reg.his_keyemp;  poliza.keypro := reg.his_keypro;
        poliza.keycon := reg.his_keycon;  poliza.codimp := reg.his_codimp;
        poliza.descon := reg.con_descon;  poliza.keycia := reg.pro_keycia;
        poliza.keypol := reg.per_keypol;  poliza.cveban := reg.emp_cveban;
        poliza.forpag := reg.emp_forpag;  poliza.keyben := reg.his_keyben;
        poliza.comfam := reg.his_comfam;  poliza.fecmov := reg.his_fecmov;
       -- inserta registro tipo 1
        SP_INSERTA (poliza, reg.dep_refcon, reg.con_ctaref, reg.con_porcen, reg.his_import, 0, madre);
       -- inserta registro tipo 2
        SP_INSERTA (poliza, reg.dep_refcon, reg.con_ctaaux, reg.con_porcen, 0, reg.his_import, madre);
        IF length(reg.dep_refcon) = 52 THEN
        --tipo 3
          IF substr(reg.con_ctaref, 15, 8) <> '00000000' THEN
            SP_INSERTA (poliza, reg.dep_refcon, reg.con_ctaref, reg.con_porcen, reg.his_import, 0, hija);
          END IF;
          --tipo 4
          IF substr(reg.con_ctaaux, 15, 8) <> '00000000' THEN
            SP_INSERTA (poliza, reg.dep_refcon, reg.con_ctaaux, reg.con_porcen, 0, reg.his_import, hija);
          END IF;
        END IF;
        -- actualiza glcoresu cada n registros
        IF (i MOD regs = 0) THEN
            UPDATE LABCONF.glcoresu SET res_numreg = i
            WHERE res_idepro = args.idepro AND res_idepcc = args.idepcc
            AND res_keyusu = args.keyusu AND res_fecini = args.fecini AND res_horini = args.horini;
        END IF;
        commit;
         -- actualiza contador
        i := i + 1;
    END LOOP;
    --Reclasificar las incidencias de Intelectus
    SP_RECLASIFICA(proceso,periodo,CvePoliza);
    --Reclasificar Confidencial proceso 355
    SP_RECLASIFICA2(proceso,periodo,CvePoliza);
    -- desmarcar el periodo per_selper = '' para terminar
    UPDATE LABCONF.nmloperi SET per_persel = '' WHERE per_keyper = periodo AND per_keypro = proceso;
    -- actualizar el registro en glcoresu a T
    UPDATE LABCONF.glcoresu SET res_numreg = total, res_status = 'T'
    WHERE res_idepro = args.idepro AND res_idepcc = args.idepcc
    AND res_keyusu = args.keyusu AND res_fecini = args.fecini AND res_horini = args.horini;
  ---Fin Contable
  END SP_CONTABLE;
  PROCEDURE SP_INSERTA (datospf IN partefija, 										referencia IN LABCONF.nmcodeps.dep_refcon%TYPE,
  											ctaconcepto IN LABCONF.nmloconc.con_ctaref%TYPE,	seietu IN LABCONF.nmloconc.con_porcen%TYPE,
  											impcar IN LABCONF.nmlohism.his_import%TYPE, 			impabo IN LABCONF.nmlohism.his_import%TYPE,
  											tipo IN LABCONF.tvwkpoli.pol_tipo%TYPE) IS
      cia 			VARCHAR2(3);
      neg 			VARCHAR2(2);
      cuenta 		VARCHAR2(3);
      subcta 		VARCHAR2(6);
      ccostos		VARCHAR2(8);
      icia 			VARCHAR2(3);
      top 			VARCHAR2(1);
      ietu 			VARCHAR2(4);
      tot_car 	nmlohism.his_import%TYPE;
      tot_abo 	nmlohism.his_import%TYPE;
  BEGIN
        tot_car :=0;
        tot_abo :=0;
        IF impcar < 0 THEN
          tot_abo := (impcar * -1);
        ELSE
          IF impcar > 0 THEN
            tot_car := impcar;
          END IF;
        END IF;
        IF impabo < 0 THEN
          tot_car := (impabo * -1);
        ELSE
          IF impabo > 0 THEN
            tot_abo := impabo;
          END IF;
        END IF;
        IF seietu = '2005' OR seietu = '2006' THEN
          ietu := seietu;
        ELSE
          ietu := '2999';
        END IF;
        IF tipo = madre THEN
            IF UPPER(substr(ctaconcepto,1,3)) = 'XXX' THEN  --CIA
              cia := substr(referencia, 1, 3);
            ELSE
              cia :=  substr(ctaconcepto, 1, 3);
            END IF;
            IF UPPER(substr(ctaconcepto,4,2)) = 'XX' THEN  --Negocio
              neg := substr(referencia, 4, 2);
            ELSE
              neg :=  substr(ctaconcepto, 4, 2);
            END IF;
            IF UPPER(substr(ctaconcepto, 6, 3)) = 'XXX' THEN --Cuenta
              cuenta := substr(referencia, 6, 3);
            ELSE
              cuenta := substr(ctaconcepto, 6, 3);
            END IF;
            IF UPPER(substr(ctaconcepto, 9, 6)) = 'XXXXXX' THEN --Sub Cuenta
              subcta := substr(referencia, 9, 6);
            ELSE
              subcta := substr(ctaconcepto, 9, 6);
            END IF;
            IF UPPER(substr(ctaconcepto, 15, 8)) = 'XXXXXXXX' THEN -- ccostos
              ccostos := substr(referencia, 15, 8);
            ELSE
              ccostos := substr(ctaconcepto, 15, 8);
            END IF;
            IF UPPER(substr(ctaconcepto, 23, 3)) = 'XXX' THEN -- icia
              icia := substr(referencia, 23, 3);
            ELSE
              icia := substr(ctaconcepto, 23, 3);
            END IF;
            IF UPPER(substr(ctaconcepto, 26, 1)) = 'X' THEN -- top
              top := substr(referencia, 26, 1);
            ELSE
              top := substr(ctaconcepto, 26, 1);
            END IF;
            IF cia <> '000' AND SUBCTA <> '000000' THEN
              INSERT INTO LABCONF.tvwkpoli VALUES (datospf.keyemp, datospf.keypro,
              datospf.keycon, datospf.codimp, datospf.descon,
              cia, neg, cuenta, subcta, ccostos, icia, top,
              ietu, tot_car, tot_abo, datospf.keycia, datospf.keypol,
              datospf.cveban, datospf.forpag, datospf.keyben, datospf.comfam, tipo, datospf.fecmov);
            END IF;
         ELSE  --hija
            IF UPPER(substr(ctaconcepto, 1, 3)) = 'XXX' THEN  --CIA
              cia := substr(referencia, 27, 3);
            ELSE
              cia :=  substr(ctaconcepto, 1, 3);
            END IF;
            IF UPPER(substr(ctaconcepto, 4, 2)) = 'XX' THEN  --Negocio
              neg := substr(referencia, 30, 2);
            ELSE
              neg :=  substr(ctaconcepto, 4, 2);
            END IF;
            IF UPPER(substr(ctaconcepto, 6, 3)) = 'XXX' THEN --cuenta
              cuenta := substr(referencia, 32, 3);
            ELSE
              cuenta := substr(ctaconcepto, 6, 3);
            END IF;
            IF UPPER(substr(ctaconcepto, 9, 6)) = 'XXXXXX' THEN --Sub Cuenta
              subcta := substr(referencia, 35, 6);
            ELSE
              subcta := substr(ctaconcepto, 9, 6);
            END IF;
            IF UPPER(substr(ctaconcepto, 15, 8)) = 'XXXXXXXX' THEN -- ccostos
              ccostos := substr(referencia, 41, 8);
            ELSE
              ccostos := substr(ctaconcepto, 15, 8);
            END IF;
            IF UPPER(substr(ctaconcepto, 23, 3)) = 'XXX' THEN -- icia
              icia := substr(referencia, 49, 3);
            ELSE
              icia := substr(ctaconcepto, 23, 3);
            END IF;
            IF UPPER(substr(ctaconcepto, 26, 1)) = 'X' THEN -- top
              top := substr(referencia, 52, 1);
            ELSE
              top := substr(ctaconcepto, 26, 1);
            END IF;
            IF cia <> '000' AND SUBCTA <> '000000' THEN
              INSERT INTO LABCONF.tvwkpoli VALUES (datospf.keyemp, datospf.keypro, datospf.keycon,
              datospf.codimp, datospf.descon,
              cia, neg, cuenta, subcta, ccostos, icia, top,
              ietu, tot_car, tot_abo, datospf.keycia, datospf.keypol,
              datospf.cveban, datospf.forpag, datospf.keyben, datospf.comfam, tipo, datospf.fecmov);
            END IF;
            -- ---------------------------------------------------------------------------------------------------------
            -- ELJM -- REGISTRO DUPLICADO PARA CIA 522 DE EMPRESA HIJA 019
            -- CIA PARA APLICAR DOBLE REGISTRO		'019'
            -- CVE CONCEPTO DE COMISIONES					'M39'
            -- CTA PARA AFECTACION								'126'
            -- SCTA PARA AFECTACION								'012002'
   					-- DR_ciaori TVWKPOLI.POL_CIA%TYPE;  		-- CIA ORIGEN PARA APLICAR DOBLE REGISTRO		'019'
   					-- DR_ciades TVWKPOLI.POL_CIA%TYPE;  		-- CIA DESTINO PARA APLICAR DOBLE REGISTRO	'522'
    				-- DR_concep NMLOHISM.HIS_KEYCON%TYPE; 	-- CVE CONCEPTO DE COMISIONES					    	'M39'
    				-- DR_cta   	TVWKPOLI.POL_CTA%TYPE;		-- CTA PARA AFECTACION								      '126'
    				-- DR_scta   TVWKPOLI.POL_SCTA%TYPE;  	-- SCTA PARA AFECTACION											'012002'
            IF cia = DR_ciaori THEN		-- OPCI COMPA¿¿¿¿IA HIJA PARA APLICAR DOBLE REGISTRO
            	IF datospf.keycon = DR_concep THEN  -- OPCI CLAVE CONCEPTO COMISIONES
	              INSERT INTO LABCONF.tvwkpoli VALUES (datospf.keyemp, datospf.keypro, datospf.keycon,
                    datospf.codimp, datospf.descon,
                    -- cia,   neg,  cuenta, subcta,  ccostos,    icia,  top,
                    DR_ciades, '01', DR_cta, DR_scta, '00000000', '000', '0',
                    ietu, tot_car, tot_abo, datospf.keycia, datospf.keypol,
                    datospf.cveban, datospf.forpag, datospf.keyben, datospf.comfam, tipo, datospf.fecmov);
            	END IF;
            END IF;
            -- ---------------------------------------------------------------------------------------------------------
        END IF;
  commit;
  END SP_INSERTA;
 PROCEDURE SP_FINIQUITO (empleado IN LABCONF.nmwkmovt.mov_keyemp%TYPE,
						 periodo IN LABCONF.nmwkmovt.mov_keyper%TYPE,
						 proceso IN LABCONF.nmcoempl.emp_keypro%TYPE) IS
	-- ELJM 12.07.2022 Se envia como parametro
	-- proceso   LABCONF.nmcoempl.emp_keypro%TYPE;
	CveVersion   INTEGER;
	CveVersionProc INTEGER;
	keypol LABCONF.nmloperi.per_keypol%Type;
	fecmov LABCONF.nmwkmovt.mov_fecmov%TYPE;
	ws_cia VARCHAR2(3);
  BEGIN
   -- ELJM 12.07.2022 Se envia como parametro
   -- identifica proceso
   -- SELECT emp_keypro INTO proceso FROM LABCONF.nmcoempl
   -- WHERE emp_keyemp = empleado;
  SELECT per_keynom,per_keypol,pro_vercon
  INTO nomina,keypol,CveVersionProc
  FROM LABCONF.nmloperi
  INNER JOIN LABCONF.nmloproc ON per_keypro = pro_keypro
  WHERE per_keypro = proceso
  and per_keyper = periodo;
  SELECT CASE WHEN vxn_keyver IS NULL THEN 0 ELSE CASE WHEN CveVersionProc = 100 THEN vxn_keyver + 100 ELSE vxn_keyver END END vxn_keyver  INTO CveVersion
  FROM LABCONF.nmlonomi
  LEFT JOIN LABCONF.tvlovxnom ON nom_keynom = vxn_keynom
  WHERE nom_keynom = nomina;
  -- borra p¿¿¿¿liza
  delete from LABCONF.tvwkpoli
  where pol_keypol = keypol
  and pol_keyemp = empleado;
  -- procesa
    FOR reg IN (SELECT mov_keyemp, mov_keypro, mov_keycon, mov_codimp, '' con_descon,
		CASE WHEN Ver.ver_ctaref IS NULL THEN Ver0.ver_ctaref ELSE Ver.ver_ctaref END con_ctaref,
		CASE WHEN Ver.ver_ctaaux IS NULL THEN Ver0.ver_ctaaux ELSE Ver.ver_ctaaux END con_ctaaux,
				dep_refcon,
		CASE WHEN Ver.ver_ietu IS NULL THEN Ver0.ver_ietu ELSE Ver.ver_ietu END con_porcen,
		mov_import, 0 pro_keycia, per_keypol, emp_cveban, emp_forpag, mov_keyben, mov_comfam, mov_fecmov
		from LABCONF.nmwkmovt
		inner join LABCONF.nmcodeps on (mov_keydep = dep_keydep)
		inner join LABCONF.nmloperi on (mov_keyper = per_keyper and mov_keypro = per_keypro)
		inner join LABCONF.nmcoempl on (mov_keyemp = emp_keyemp)
		inner join LABCONF.nmloproc ON (mov_keypro = pro_keypro)
		INNER JOIN LABCONF.tvloverc Ver0 ON (Ver0.ver_keyver = pro_vercon and mov_keycon = Ver0.ver_keycon)
		LEFT JOIN LABCONF.tvloverc Ver ON (Ver.ver_keyver = CveVersion and mov_keycon = Ver.ver_keycon)
		where mov_keypro = proceso
		and mov_keyper = periodo
		and mov_keyemp = empleado
		and (length(dep_refcon) = 52 or length(dep_refcon) = 26)
		order by emp_keyemp)
    LOOP
	poliza.keyemp := reg.mov_keyemp;  poliza.keypro := reg.mov_keypro;  poliza.keycon := reg.mov_keycon;  poliza.codimp := reg.mov_codimp;
	poliza.descon := reg.con_descon;  poliza.keycia := reg.pro_keycia;  poliza.keypol := reg.per_keypol;  poliza.cveban := reg.emp_cveban;
	poliza.forpag := reg.emp_forpag;  poliza.keyben := reg.mov_keyben;  poliza.comfam := reg.mov_comfam;  poliza.fecmov := reg.mov_fecmov;
	-- inserta registros de la p¿¿¿¿liza madre
	SP_INSERTA (poliza, reg.dep_refcon, reg.con_ctaref, reg.con_porcen, reg.mov_import, 0, madre);
	SP_INSERTA (poliza, reg.dep_refcon, reg.con_ctaaux, reg.con_porcen, 0, reg.mov_import, madre);
	--Inserta Registros de la p¿¿¿¿liza hija si el departamento tiene una referencia contable con 52 caracteres
	IF length(reg.dep_refcon) = 52 THEN
	  IF substr(reg.con_ctaref, 15, 8) <> '00000000' THEN
		SP_INSERTA (poliza, reg.dep_refcon, reg.con_ctaref, reg.con_porcen, reg.mov_import, 0, hija);
	  END IF;
	  --tipo 4
	  IF substr(reg.con_ctaaux, 15, 8) <> '00000000' THEN
		SP_INSERTA (poliza, reg.dep_refcon, reg.con_ctaaux, reg.con_porcen, 0, reg.mov_import, hija);
	  END IF;
	END IF;
    END LOOP;
    IF proceso = 6 OR proceso = 120 OR proceso = 139 THEN
      IF proceso = 6 OR proceso = 120 THEN
        ws_cia := '024';
      ELSE
        ws_cia := '790';
      END IF;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF1' POL_DESCTA,ws_cia POL_CIA,POL_NEG,POL_CTA,POL_SCTA,POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_keyemp = empleado
      group by POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, 'RECLASIFICA_CONF1', ws_cia, POL_NEG, POL_CTA, POL_SCTA, POL_CC, '000', '0', POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, 1, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF2' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'485' POL_CTA,POL_SCTA,'00799417','000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '4%'
        AND pol_keyemp = empleado
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, POL_SCTA,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF2' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'515' POL_CTA,POL_SCTA,'00799313','000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR ,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '5%'
        AND pol_keyemp = empleado
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, POL_SCTA,  POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF2' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'615' POL_CTA,POL_SCTA,'00799851','000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '6%'
        AND pol_keyemp = empleado
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,POL_SCTA,  POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF3' POL_DESCTA,ws_cia POL_CIA,POL_NEG,POL_CTA,'121339' POL_SCTA,POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_keyemp = empleado
      group by POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, 'RECLASIFICA_CONF3', ws_cia, POL_NEG, POL_CTA, '121339', POL_CC, '000', '0', POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, 1, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF4' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'485' POL_CTA,'121339' POL_SCTA,'00799417' POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '4%'
        AND pol_keyemp = empleado
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,  POL_CTA,  POL_CC,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF4' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'515' POL_CTA,'121339' POL_SCTA,'00799313' POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '5%'
        AND pol_keyemp = empleado
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,      POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF4' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'615' POL_CTA,'121339' POL_SCTA,'00799851' POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '6%'
        AND pol_keyemp = empleado
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF5' POL_DESCTA,ws_cia POL_CIA,POL_NEG,POL_CTA,POL_SCTA,POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia NOT IN ('552','284')
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_tipo = '2'
        AND pol_keyemp = empleado
      group by POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, 'RECLASIFICA_CONF5', ws_cia, POL_NEG, POL_CTA, POL_SCTA, POL_CC, '000', '0', POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, 1, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF6' POL_DESCTA,ws_cia POL_CIA,  '01' POL_NEG,POL_CTA,'121339',POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia NOT IN ('552','284')
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_tipo = '2'
        AND pol_keyemp = empleado
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,  POL_CTA,  POL_CC,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      --MODIFICACION 30/06/2020
      --RECLASIFICACION PARA EMPRESA 284
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF7' POL_DESCTA,ws_cia POL_CIA,POL_NEG,POL_CTA,POL_SCTA,POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_keyemp = empleado
      group by POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, 'RECLASIFICA_CONF7', ws_cia, POL_NEG, POL_CTA, POL_SCTA, POL_CC, '000', '0', POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, 1, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF8' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'485' POL_CTA,POL_SCTA,'00816417','000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '4%'
        AND pol_keyemp = empleado
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, POL_SCTA,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
     INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF8' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'515' POL_CTA,POL_SCTA,'00816855','000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '5%'
        AND pol_keyemp = empleado
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, POL_SCTA,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF8' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'615' POL_CTA,POL_SCTA,'00816851','000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '6%'
        AND pol_keyemp = empleado
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,POL_SCTA,  POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF9' POL_DESCTA,ws_cia POL_CIA,POL_NEG,POL_CTA,'121339' POL_SCTA,POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_keyemp = empleado
      group by POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, 'RECLASIFICA_CONF9', ws_cia, POL_NEG, POL_CTA, '121339', POL_CC, '000', '0', POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, 1, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF10' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'485' POL_CTA,'121339' POL_SCTA,'00816417' POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '4%'
        AND pol_keyemp = empleado
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,  POL_CTA,  POL_CC,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF10' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'515' POL_CTA,POL_SCTA,'00816855','000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '5%'
        AND pol_keyemp = empleado
      group by POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, 'RECLASIFICA_CONF10', ws_cia, '01', '515', POL_SCTA, '00816855', '000', '0', POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, 1, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF10' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'615' POL_CTA,'121339' POL_SCTA,'00816851' POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '6%'
        AND pol_keyemp = empleado
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
    END IF;
  ---Fin Contable
  END SP_FINIQUITO;
--FUNCIONES
  PROCEDURE SP_RECLASIFICA (proceso IN LABCONF.nmlohism.his_keypro%TYPE, periodo IN LABCONF.nmlohism.his_keyper%TYPE,keypol IN LABCONF.tvwkpoli.pol_keypol%TYPE) IS
    ws_cia VARCHAR2(3);
  BEGIN
/*
    INSERT INTO LABCONF.TVWKPOLI
    SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA1',POL_CIA,POL_NEG,POL_CTA,POL_SCTA,POL_CC,POL_ICIA,POL_TOP,POL_IETU,0,SUM(INC_IMPORT),POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV
    FROM
    (SELECT DISTINCT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_CIA,POL_NEG,POL_CTA,POL_SCTA,POL_CC,POL_ICIA,POL_TOP,POL_IETU,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV
    FROM LABCONF.TVWKPOLI
      WHERE pol_keypol = keypol
        AND pol_keycon IN (SELECT pam_cvesec FROM LABCONF.glcopams WHERE pam_keypar = 'CONT')
        AND pol_cc > '00000000'
        AND POL_DESCTA IS NULL
        AND pol_tipo = 1),
     ---   LABCONF.TVLOINCT
      WHERE pol_keypro = inc_keypro AND inc_keyper = substr(pol_keypol,4,7) AND pol_keyemp = inc_keyemp AND pol_keycon = inc_keycon
      AND inc_keypro = proceso
      AND inc_keyper = periodo
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, POL_CIA, POL_NEG, POL_CTA, POL_SCTA, POL_CC, POL_ICIA, POL_TOP, POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_TIPO, POL_FECMOV
      ORDER BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, POL_CIA, POL_NEG, POL_CTA, POL_SCTA, POL_CC, POL_ICIA, POL_TOP, POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_TIPO, POL_FECMOV;
    INSERT INTO LABCONF.TVWKPOLI
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA2',POL_CIA,CEN_NEG,CEN_CTA,POL_SCTA,INC_KEYCEN,POL_ICIA,POL_TOP,POL_IETU,SUM(INC_IMPORT),0,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV
      FROM (SELECT DISTINCT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_CIA,POL_NEG,POL_CTA,POL_SCTA,POL_CC,POL_ICIA,POL_TOP,POL_IETU,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV
    FROM LABCONF.TVWKPOLI
      WHERE pol_keypol  = keypol
        AND pol_keycon IN (SELECT pam_cvesec FROM LABCONF.glcopams WHERE pam_keypar = 'CONT')
        AND pol_cc > '00000000'
        AND POL_DESCTA IS NULL
        AND pol_tipo = 1),
     ---   LABCONF.TVLOINCT,
        LABCONF.NMLOCEPRO
      WHERE pol_keypro = inc_keypro AND inc_keyper = substr(pol_keypol,4,7) AND pol_keyemp = inc_keyemp AND pol_keycon = inc_keycon AND inc_keycen = cen_keycen
        AND inc_keypro = proceso
        AND inc_keyper = periodo
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, POL_CIA,CEN_NEG,CEN_CTA, POL_SCTA, INC_KEYCEN, POL_ICIA, POL_TOP, POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_TIPO, POL_FECMOV;
    COMMIT;
    */
    --RETURN;
    IF proceso = 6 OR proceso = 120 OR proceso = 139 THEN
      IF proceso = 6 OR proceso = 120 THEN
        ws_cia := '024';
      ELSE
        ws_cia := '790';
      END IF;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF1' POL_DESCTA,ws_cia POL_CIA,POL_NEG,POL_CTA,POL_SCTA,POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,POL_NEG,  POL_CTA, POL_SCTA, POL_CC,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      /*INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF2' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'485' POL_CTA,POL_SCTA,'00799417','000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '4%'
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, POL_SCTA,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF2' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'515' POL_CTA,POL_SCTA,'00799313','000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR ,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '5%'
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, POL_SCTA,  POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF2' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'615' POL_CTA,POL_SCTA,'00799851','000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '6%'
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,POL_SCTA,  POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      */
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF3' POL_DESCTA,ws_cia POL_CIA,POL_NEG,POL_CTA,'121339' POL_SCTA,POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,POL_NEG, POL_CTA,  POL_CC,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      /*INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF4' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'485' POL_CTA,'121339' POL_SCTA,'00799417' POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '4%'
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,  POL_CTA,  POL_CC,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF4' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'515' POL_CTA,'121339' POL_SCTA,'00799313' POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '5%'
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,      POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF4' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'615' POL_CTA,'121339' POL_SCTA,'00799851' POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '552'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '6%'
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF5' POL_DESCTA,ws_cia POL_CIA,POL_NEG,POL_CTA,POL_SCTA,POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia NOT IN ('552','284')
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_tipo = '2'
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,POL_NEG, POL_CTA, POL_SCTA, POL_CC,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF6' POL_DESCTA,ws_cia POL_CIA, POL_NEG,POL_CTA,'121339',POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia NOT IN ('552','284')
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_tipo = '2'
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,POL_NEG,  POL_CTA,  POL_CC,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      --MODIFICACION 30/06/2020
      --RECLASIFICACION PARA EMPRESA 284
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF7' POL_DESCTA,ws_cia POL_CIA,POL_NEG,POL_CTA,POL_SCTA,POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,POL_NEG,  POL_CTA, POL_SCTA, POL_CC,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF8' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'485' POL_CTA,POL_SCTA,'00816417','000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '4%'
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, POL_SCTA,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF8' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'515' POL_CTA,POL_SCTA,'00816855','000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '5%'
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, POL_SCTA,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF8' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'615' POL_CTA,POL_SCTA,'00816851','000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '6%'
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,POL_SCTA,  POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      */
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF9' POL_DESCTA,ws_cia POL_CIA,POL_NEG,POL_CTA,'121339' POL_SCTA,POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,POL_NEG,  POL_CTA,  POL_CC,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      /*
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF10' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'485' POL_CTA,'121339' POL_SCTA,'00816417' POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '4%'
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,  POL_CTA,  POL_CC,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF10' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'485' POL_CTA,'121339' POL_SCTA,'00816417' POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '5%'
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,  POL_CTA,  POL_CC,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      INSERT INTO LABCONF.TVWKPOLI
            (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
      SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF10' POL_DESCTA,ws_cia POL_CIA,'01' POL_NEG,'615' POL_CTA,'121339' POL_SCTA,'00816851' POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
      FROM LABCONF.tvwkpoli
      WHERE pol_keypol = keypol
        AND pol_cia = '284'
        AND pol_cc NOT IN ('00000024','00000000')
        AND pol_cta LIKE '6%'
      GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU,   POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
      */
    END IF;
  END SP_RECLASIFICA;
  PROCEDURE SP_RECLASIFICA2 (proceso IN LABCONF.nmlohism.his_keypro%TYPE, periodo IN LABCONF.nmlohism.his_keyper%TYPE,keypol IN LABCONF.tvwkpoli.pol_keypol%TYPE) IS
    ws_cia VARCHAR2(3);
  BEGIN
    --IF PROCESO <> 533 AND PROCESO <> 534 AND PROCESO <> 535 OR PROCESO <> 553 THEN
    IF PROCESO NOT IN (533,534,535,553,560) THEN
        RETURN;
    END IF;
    SELECT cia_ca3aux INTO ws_cia
    FROM LABCONF.nmloproc
	  INNER JOIN LABCONF.nmlocias ON cia_keycia = pro_keycia
	  WHERE pro_keypro = proceso;
    INSERT INTO LABCONF.TVWKPOLI
          (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
    SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF11' POL_DESCTA,POL_CIA,POL_NEG,POL_CTA,'121339' POL_SCTA,POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPCAR) POL_IMPCAR,SUM(POL_IMPABO) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
    FROM LABCONF.tvwkpoli
    WHERE pol_keypol = keypol
      AND pol_cia = ws_cia
      AND pol_cc NOT IN ('00000024','00000000')
    group by POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, 'RECLASIFICA_CONF11', POL_CIA, POL_NEG, POL_CTA, '121339', POL_CC, '000', '0', POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, 1, POL_FECMOV;
    INSERT INTO LABCONF.TVWKPOLI
          (POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,POL_DESCTA,         POL_CIA,POL_NEG,     POL_CTA,POL_SCTA,POL_CC,POL_ICIA,      POL_TOP,    POL_IETU,POL_IMPCAR,     POL_IMPABO,     POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,POL_TIPO,POL_FECMOV)
    SELECT POL_KEYEMP,POL_KEYPRO,POL_KEYCON,POL_CODACU,'RECLASIFICA_CONF12' POL_DESCTA,POL_CIA,POL_NEG,POL_CTA,POL_SCTA,POL_CC,'000' POL_ICIA,'0' POL_TOP,POL_IETU,SUM(POL_IMPABO) POL_IMPCAR,SUM(POL_IMPCAR) POL_IMPABO,POL_KEYCIA,POL_KEYPOL,POL_CVEBAN,POL_FORPAG,POL_KEYBEN,POL_COMFAM,1 POL_TIPO,POL_FECMOV
    FROM LABCONF.tvwkpoli
    WHERE pol_keypol = keypol
      AND pol_cc NOT IN ('00000024','00000000')
      AND pol_cia = ws_cia
      AND (POL_SCTA <> '121339')
    GROUP BY POL_KEYEMP, POL_KEYPRO, POL_KEYCON, POL_CODACU, POL_CIA, POL_NEG, POL_CTA, POL_SCTA, POL_CC, POL_IETU, POL_KEYCIA, POL_KEYPOL, POL_CVEBAN, POL_FORPAG, POL_KEYBEN, POL_COMFAM, POL_FECMOV;
  END SP_RECLASIFICA2;
END TVCONTAB;
/;
