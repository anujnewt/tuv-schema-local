CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HPGIMPRENEW_3" (ws_nomrep VARCHAR2, ws_idepcc VARCHAR2, wn_keyusu NUMBER,
                                wn_LenPro NUMBER, wn_LenNom NUMBER, wn_lstemp NUMBER,
                                wn_LenEmi NUMBER, ws_tpoRec VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   wn_numsec  NUMBER(10);  -- cry_numsec
   wn_perini  NUMBER(10);  -- cry_dec008
   wn_perfin  NUMBER(10);  -- cry_dec009
   wn_numrec  NUMBER(10);  -- cry_dec010
   wn_keyemp  NUMBER(10);  -- cry_dec011
   wn_numcap  NUMBER(10);  -- cry_dec012
   wn_keyrph  NUMBER(10);  -- cry_dec013
   wn_capini  NUMBER(10);  -- cry_dec014
   wn_capfin  NUMBER(10);  -- cry_dec015
   wn_cosuni  BINARY_DOUBLE;    -- cry_dec018
   wn_costot  BINARY_DOUBLE;    -- cry_dec019
   wn_rowide  BINARY_DOUBLE;    -- cAMPO AGREGADO PARA LA DESAGRUPACION DE DESCUENTOS SITATYR - MARZO 2010
   wn_costot1 BINARY_DOUBLE;
   wn_tipcam  BINARY_DOUBLE;    -- cry_dec022
   wn_keynom  NUMBER(5); --
   ws_condic  VARCHAR2(10); --
   ws_nomi    NUMBER(5); --
   ws_nomexc  VARCHAR2(10); --
   wn_numemi  NUMBER(10);  --
   ws_keyapr  VARCHAR2(6);  --
   wn_keypro  NUMBER(5); --
   ws_nomemp  VARCHAR2(150); -- cry_chr001
   ws_desapr  VARCHAR2(40); -- cry_chr003
   ws_destip  VARCHAR2(40); -- cry_chr004
   ws_desdep  VARCHAR2(40); -- cry_chr005
   ws_descon  VARCHAR2(40); -- cry_chr006
   ws_keydep  VARCHAR2(16); -- cry_chr012
   ws_regrfc  VARCHAR2(13); -- cry_chr013
   ws_keycon  VARCHAR2(3);  -- cry_chr017
   Ws_Keyconcep VARCHAR2(3);
   ws_codimp  VARCHAR2(2);  -- cry_chr018
   wd_fecpag  DATE;     -- cry_dat001
   wd_fectrab DATE;     -- cry_dat002
   wd_fecini  DATE;     -- cry_dat003
   wd_fecfin  DATE;     -- cry_dat004
   ws_sitfis  VARCHAR2(8);  -- cry_chr019
   ws_estcta  VARCHAR2(8);  -- cry_chr020
   ws_stscon  VARCHAR2(3);  -- cry_chr021
   wn_keyagr  NUMBER(10);  -- numero de agrupacion
   wn_regded  NUMBER(10);  -- numero del secuencial para deduccion
   wn_defrec  NUMBER(5); -- cry_dec023 define si es recibo o liquidacion para derechos de autor
   wn_tip112  NUMBER(5); --            define si es recibo o liquidacisn para derechos de autor
   lsDescon   VARCHAR2(40);  -- DESCRIPCION DE CONCEPTO PARA VALIDAR POR OPCIS
   vs_fecpag  VARCHAR2(10);     -- Variable que contiene la fecha de pago tecleada por el Usuario
   wn_keysec  NUMBER(10);  -- cry_dec025
   wn_emision NUMBER(10);
   wi_bandera NUMBER(5); -- bandera para saber si se encontro concepto de netos en la tabla glcopams.pam_keypar = 'NET'
   numreci_e  NUMBER(10);
   vd_fecpago DATE;
   vn_ejerci  NUMBER(5);
   wn_keycon  VARCHAR2 (3);
   wn_keypue NUMBER(10);
   ws_keyper VARCHAR2(7);
   wi_primeravez NUMBER(5);
   we_ant_keyper VARCHAR2(7);
   we_ant_keyemp NUMBER(10);
   we_ant_keypue NUMBER(10);
   we_ant_keycon VARCHAR2(3);
BEGIN
   -- -> LIMPIA LA TABLA GLWKCRYS PARA ESTE REPORTE
   DELETE FROM usrsiho.glwkcrys
   WHERE cry_nomrep = ws_nomrep
     AND cry_idepcc = ws_idepcc
     AND cry_keyusu = wn_keyusu;
   -- -> OBTENEMOS LA FECHA DE PAGO TECLEADA POR EL USUARIO
   BEGIN
       SELECT ran_keycen
         INTO vs_fecpag
         FROM usrsiho.glwkrang
        WHERE ran_nomrep = ws_nomrep
          AND ran_idepcc = ws_idepcc
          AND ran_keyusu = wn_keyusu
          AND ran_keycon = 'FEC';
        EXCEPTION WHEN no_data_found THEN vs_fecpag := '';
    END;
   wn_numsec := 0;
   vd_fecpago := to_date(vs_fecpag,'MM/DD/YYYY');
   vn_ejerci := EXTRACT(YEAR FROM vd_fecpago);
  ------------------JDCM MODIFICACION PARA DISMINUIR TIEMPO DE RESPUESTA 12/AGO/2008------------------------
   --Inserta en Tablas Temporales
    INSERT INTO usrsiho.paso VALUES('sp_hpgimprenew_3',ws_nomrep,ws_idepcc,wn_keyusu,'--','Insertando en Temporal periodos');
     --Busca Periodos
     INSERT INTO usrsiho.periodos
     SELECT DISTINCT per_keyper
       FROM usrsiho.nmloperi
      WHERE per_keypro IN(SELECT ran_keycen
                            FROM usrsiho.glwkrang
                           WHERE ran_nomrep = ws_nomrep
                             AND ran_idepcc = ws_idepcc
                             AND ran_keyusu = wn_keyusu
                             AND ran_keycon = 'PRO')
        AND per_nu3aux IN(SELECT ran_keycen
                            FROM usrsiho.glwkrang
                           WHERE ran_nomrep = ws_nomrep
                             AND ran_idepcc = ws_idepcc
                             AND ran_keyusu = wn_keyusu
                             AND ran_keycon = 'ARE')
        AND per_keynom IN(SELECT ran_keycen
                            FROM usrsiho.glwkrang
                           WHERE ran_nomrep = ws_nomrep
                             AND ran_idepcc = ws_idepcc
                             AND ran_keyusu = wn_keyusu
                             AND ran_keycon = 'NOM')
        AND per_fecpag = vd_fecpago
  --      AND per_fecpag = (SELECT to_date(ran_keycen,'MM/DD/YYYY')
  --                         FROM glwkrang
   --                       WHERE ran_nomrep = ws_nomrep
  --                          AND ran_idepcc = ws_idepcc
  --                          AND ran_keyusu = wn_keyusu
  --                          AND ran_keycon = 'FEC')
    ;
     --Busca Emisiones
     INSERT INTO usrsiho.paso VALUES('sp_hpgimprenew_3',ws_nomrep,ws_idepcc,wn_keyusu,'--','Insertando en Temporal emisiones');
     INSERT INTO usrsiho.emisiones
     SELECT DISTINCT per_nu4aux
       FROM usrsiho.nmloperi
      WHERE per_keypro IN(SELECT ran_keycen
                            FROM glwkrang
                           WHERE ran_nomrep = ws_nomrep
                             AND ran_idepcc = ws_idepcc
                             AND ran_keyusu = wn_keyusu
                             AND ran_keycon = 'PRO')
        AND per_nu3aux IN(SELECT ran_keycen
                            FROM glwkrang
                           WHERE ran_nomrep = ws_nomrep
                             AND ran_idepcc = ws_idepcc
                             AND ran_keyusu = wn_keyusu
                             AND ran_keycon = 'ARE')
        AND per_keynom IN(SELECT ran_keycen
                            FROM glwkrang
                           WHERE ran_nomrep = ws_nomrep
                             AND ran_idepcc = ws_idepcc
                             AND ran_keyusu = wn_keyusu
                             AND ran_keycon = 'NOM')
        AND per_fecpag = (SELECT to_date(ran_keycen,'MM/DD/YYYY')
                           FROM glwkrang
                          WHERE ran_nomrep = ws_nomrep
                            AND ran_idepcc = ws_idepcc
                            AND ran_keyusu = wn_keyusu
                            AND ran_keycon = 'FEC')
     ;
    -- Busca Historicos
    INSERT INTO usrsiho.paso VALUES('sp_hpgimprenew_3',ws_nomrep,ws_idepcc,wn_keyusu,'--','Insertando en Temporal nmlohism_tmp');
     INSERT INTO usrsiho.nmlohism_tmp
     SELECT *
       FROM usrsiho.nmlohism
      WHERE his_keypro IN(SELECT ran_keycen
                            FROM usrsiho.glwkrang
                           WHERE ran_nomrep = ws_nomrep
                             AND ran_idepcc = ws_idepcc
                             AND ran_keyusu = wn_keyusu
                             AND ran_keycon = 'PRO')
        AND his_keynom IN(SELECT ran_keycen
                            FROM usrsiho.glwkrang
                           WHERE ran_nomrep = ws_nomrep
                             AND ran_idepcc = ws_idepcc
                             AND ran_keyusu = wn_keyusu
                             AND ran_keycon = 'NOM')
        AND his_keyper IN(SELECT per_keyper FROM periodos);
   /* update statistics medium for table nmlohism_tmp; */
   --Busca Recibos
   INSERT INTO usrsiho.paso VALUES('sp_hpgimprenew_3',ws_nomrep,ws_idepcc,wn_keyusu,'--','Insertando en Temporal holoreci_tmp');
   INSERT INTO usrsiho.holoreci_tmp
   SELECT *
     FROM usrsiho.holoreci
    WHERE rec_ejerci = vn_ejerci
      AND rec_keypro IN(SELECT ran_keycen
                          FROM usrsiho.glwkrang
                         WHERE ran_nomrep = ws_nomrep
                           AND ran_idepcc = ws_idepcc
                           AND ran_keyusu = wn_keyusu
                           AND ran_keycon = 'PRO')
      AND rec_keyapr IN(SELECT ran_keycen
                          FROM usrsiho.glwkrang
                         WHERE ran_nomrep = ws_nomrep
                           AND ran_idepcc = ws_idepcc
                           AND ran_keyusu = wn_keyusu
                           AND ran_keycon = 'ARE')
      AND rec_keynom IN(SELECT ran_keycen
                          FROM usrsiho.glwkrang
                         WHERE ran_nomrep = ws_nomrep
                           AND ran_idepcc = ws_idepcc
                           AND ran_keyusu = wn_keyusu
                           AND ran_keycon = 'NOM')
      AND rec_numemi IN(SELECT per_nu4aux FROM usrsiho.emisiones)
      and rec_fecpag = vd_fecpago;
--      AND rec_fecpag = (SELECT ran_keycen
--                         FROM glwkrang
--                        WHERE ran_nomrep = ws_nomrep
--                          AND ran_idepcc = ws_idepcc
--                          AND ran_keyusu = wn_keyusu
--                          AND ran_keycon = 'FEC');
   /* update statistics medium for table holoreci_tmp; */
  --Busca RPHs
  INSERT INTO usrsiho.paso VALUES('sp_hpgimprenew_3',ws_nomrep,ws_idepcc,wn_keyusu,'--','Insertando en Temporal holofrph_tmp');
   INSERT INTO usrsiho.holofrph_tmp
   SELECT *
     FROM usrsiho.holofrph
    WHERE frp_keypro IN(SELECT ran_keycen
                         FROM usrsiho.glwkrang
                        WHERE ran_nomrep = ws_nomrep
                          AND ran_idepcc = ws_idepcc
                          AND ran_keyusu = wn_keyusu
                          AND ran_keycon = 'PRO')
      AND frp_keyper IN(SELECT per_keyper FROM usrsiho.periodos)
      AND frp_keynom IN(SELECT ran_keycen
                          FROM usrsiho.glwkrang
                         WHERE ran_nomrep = ws_nomrep
                           AND ran_idepcc = ws_idepcc
                           AND ran_keyusu = wn_keyusu
                           AND ran_keycon = 'NOM');
  /* update statistics medium for table holofrph_tmp; */
 --Busca Historico de RPHs
 INSERT INTO usrsiho.paso VALUES('sp_hpgimprenew_3',ws_nomrep,ws_idepcc,wn_keyusu,'--','Insertando en Temporal holohgdp_tmp');
  INSERT INTO usrsiho.holohgdp_tmp
  SELECT *
    FROM usrsiho.holohgdp
   WHERE hgd_keyrph IN(SELECT frp_keyrph
                         FROM usrsiho.holofrph
                        WHERE frp_keypro IN(SELECT ran_keycen
                                              FROM usrsiho.glwkrang
                                             WHERE ran_nomrep = ws_nomrep
                                               AND ran_idepcc = ws_idepcc
                                               AND ran_keyusu = wn_keyusu
                                               AND ran_keycon = 'PRO')
                           AND frp_keyper IN(SELECT per_keyper FROM usrsiho.periodos)
                           AND frp_keynom IN(SELECT ran_keycen
                                               FROM usrsiho.glwkrang
                                              WHERE ran_nomrep = ws_nomrep
                                                AND ran_idepcc = ws_idepcc
                                                AND ran_keyusu = wn_keyusu
                                                AND ran_keycon = 'NOM'));
  /* update statistics medium for table holohgdp_tmp; */
  /* update statistics medium for table glwkrang; */
INSERT INTO paso VALUES('sp_hpgimprenew_3',ws_nomrep,ws_idepcc,wn_keyusu,'--','Insertando en Tabla glwkcrys');
   ---------------************************************-------------------------
   -- -> LECTURA DE TODOS LOS PROCESOS Y AREAS (1er FOREACH)
   FOR rec IN (SELECT DISTINCT per_keypro,per_nu3aux,per_nu4aux
             FROM usrsiho.nmloperi, usrsiho.glwkrang
            WHERE per_fecpag = vd_fecpago
              AND ( (wn_LenPro > 0 AND per_keypro  IN (SELECT ran_keycen
                                                         FROM usrsiho.glwkrang
                                                        WHERE ran_nomrep = ws_nomrep
                                                          AND ran_idepcc = ws_idepcc
                                                          AND ran_keyusu = wn_keyusu
                                                          AND ran_keycon = 'PRO') ) OR
                     wn_LenPro = 0 )
              AND per_nu3aux = ran_keycen
              AND ran_nomrep = ws_nomrep
              AND ran_idepcc = ws_idepcc
              AND ran_keyusu = wn_keyusu
              AND ran_keycon = 'ARE'
              AND ( (wn_LenEmi > 0 AND per_nu4aux  IN (SELECT ran_keycen
                                                         FROM usrsiho.glwkrang
                                                        WHERE ran_nomrep = ws_nomrep
                                                          AND ran_idepcc = ws_idepcc
                                                          AND ran_keyusu = wn_keyusu
                                                          AND ran_keycon = 'EMI') ) OR
                     wn_LenEmi = 0 )) LOOP
      -- -> LECTURA DE TODOS LOS RECIBOS DE ESE PROCESOS, AREA y EMISION (2o. FOREACH)
      wn_keypro := rec.per_keypro;
      ws_keyapr := trim(rec.per_nu3aux);
      wn_emision := trim(rec.per_nu4aux);
      FOR rec2 IN (SELECT DISTINCT rec_keyrec
                FROM usrsiho.holoreci_tmp
               left join usrsiho.glwkrang a on rec_keynom = a.ran_keycen and a.ran_nomrep = ws_nomrep AND a.ran_idepcc = ws_idepcc
                            AND a.ran_keyusu = wn_keyusu AND a.ran_keycon = 'NOM'
               left join usrsiho.glwkrang b on rec_keyemp = b.ran_keycen and b.ran_nomrep = ws_nomrep AND b.ran_idepcc = ws_idepcc
                            AND b.ran_keyusu = wn_keyusu AND b.ran_keycon = 'EMP'
               WHERE rec_ejerci = vn_ejerci
                 AND rec_keypro = wn_keypro
                 AND rec_keyapr = ws_keyapr
                 AND rec_numemi = wn_emision
                 AND rec_fecpag = vd_fecpago
                 --AND rec_ejerci = extract(year from rec_fecpag)
                 ) LOOP
 --                AND ( (wn_LenNom > 0 AND rec_keynom IN (SELECT ran_keycen
 --                                                          FROM glwkrang
 --                                                         WHERE ran_nomrep = ws_nomrep
 --                                                           AND ran_idepcc = ws_idepcc
 --                                                          AND ran_keyusu = wn_keyusu
 --                                                           AND ran_keycon = 'NOM') ) OR
 --                       wn_LenNom = 0 )
 --                AND ( (wn_lstemp > 0 AND rec_keyemp IN (SELECT ran_keycen
 --                                                          FROM glwkrang
 --                                                         WHERE ran_nomrep = ws_nomrep
 --                                                           AND ran_idepcc = ws_idepcc
 --                                                           AND ran_keyusu = wn_keyusu
 --                                                           AND ran_keycon = 'EMP') ) OR
 --                       wn_lstemp = 0 )) LOOP
         -- -> LECTURA DE LOS DATOS DEL HEADER (3er. FOREACH)
	 -- Se Modifica agrupacion para desglosar los descuentos de Sitatyr.
	 -- se agrega el campo his_rowide en el select y el group by
	 -- Marzo 2010
         numreci_e := rec2.rec_keyrec;
         FOR rec3 IN (SELECT
                        rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_destip,
                        min(per_keyper) perini,max(per_keyper) perfin,
                        min(per_fecini) fecini,max(per_fecfin) fecfin,per_fecpag,
                        his_codimp,con_keycon,con_descon,sum(his_import) tot_importe,agc_keyagr,per_nu1aux,emp_ca2aux,
                        emp_cveban,DECODE(rec_stscon,1,' ','*') stscon,rec_keynom,rec_numemi,his_rowide
                   FROM usrsiho.holoreci_tmp
                   join usrsiho.nmcoempl on rec_keyemp = emp_keyemp
                   join usrsiho.nmlonomi on rec_keynom = nom_keynom
                   join usrsiho.nmloperi on rec_keypro = per_keypro AND rec_keyapr = per_nu3aux AND rec_keynom = per_keynom AND rec_numemi = per_nu4aux
                   join usrsiho.glcopams on pam_keypar = 'H2' -- areas de produccion
                                AND pam_cvesec = rec_keyapr
                   join usrsiho.nmloconc on con_keycon NOT IN ('H08','H09','28D')
                   join usrsiho.nmlohism_tmp on his_keypro = per_keypro AND his_keyper = per_keyper AND his_keycon = con_keycon
                        AND his_keyemp = rec_keyemp AND his_codimp IN ('01','02')
                   left join usrsiho.holoagcp on agc_keyagr = 18 AND agc_keycon = con_keycon
                  WHERE rec_ejerci = vn_ejerci
                    AND rec_keypro = wn_keypro
                    AND rec_keyrec = numreci_e
                    AND rec_keyapr = ws_keyapr
                    AND rec_numemi = wn_emision
                    AND rec_fecpag = vd_fecpago
                    AND rec_ejerci = extract(year from rec_fecpag)
                    -- (5/5) EMPLEADO(S)
                    AND ( (wn_lstemp > 0 AND his_keyemp IN (SELECT ran_keycen
                                                              FROM usrsiho.glwkrang
                                                             WHERE ran_nomrep = ws_nomrep
                                                               AND ran_idepcc = ws_idepcc
                                                               AND ran_keyusu = wn_keyusu
                                                               AND ran_keycon = 'EMP') ) OR
                           wn_lstemp = 0 )
                    -- (4/5) NOMINA(S)
                    AND ( (wn_LenNom > 0 AND rec_keynom IN (SELECT ran_keycen
                                                              FROM usrsiho.glwkrang
                                                             WHERE ran_nomrep = ws_nomrep
                                                               AND ran_idepcc = ws_idepcc
                                                               AND ran_keyusu = wn_keyusu
                                                               AND ran_keycon = 'NOM') ) OR
                           wn_LenNom = 0 )
                 GROUP BY rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_keynom,
                          nom_destip,rec_numemi,per_fecpag,his_codimp,con_keycon,con_descon,
                          agc_keyagr,per_nu1aux,emp_ca2aux,emp_cveban,rec_import,rec_stscon,
			  rec_keynom,rec_numemi,his_rowide
	 	-- Se agrega his_rowide en el group para los conceptos de Sitatyr
	 	-- Marzo 2010
                 UNION
                 SELECT
                        rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_destip,
                        min(per_keyper) perini,max(per_keyper) perfin,
                        min(per_fecini) fecini,max(per_fecfin) fecfin,per_fecpag,
                        his_codimp,'H08','VIATICOS' con_keycon,sum(his_import) tot_importe,agc_keyagr,per_nu1aux,
                        emp_ca2aux,emp_cveban,DECODE(rec_stscon,1,' ','*') stscon,rec_keynom,rec_numemi,his_rowide
                   FROM usrsiho.holoreci_tmp
                   join usrsiho.nmcoempl on rec_keyemp = emp_keyemp
                   join usrsiho.nmlonomi on rec_keynom = nom_keynom
                   join usrsiho.nmloperi on rec_keypro = per_keypro AND rec_keyapr = per_nu3aux AND rec_keynom = per_keynom
                    AND rec_numemi = per_nu4aux
                   join usrsiho.glcopams on pam_keypar = 'H2' -- areas de produccion
                            AND pam_cvesec = rec_keyapr
                   join usrsiho.nmloconc on  con_keycon IN ('H08','H09')
                   join usrsiho.nmlohism_tmp on his_keypro = per_keypro AND his_keyper = per_keyper AND his_keycon = con_keycon
                    AND his_keyemp = rec_keyemp AND his_codimp IN ('01','02')
                   left join usrsiho.holoagcp on agc_keycon = con_keycon AND agc_keyagr = 18
                  WHERE rec_ejerci = vn_ejerci
                    AND rec_keypro = wn_keypro
                    AND rec_keyrec = numreci_e
                    AND rec_keyapr = ws_keyapr
                    AND rec_numemi = wn_emision
                    AND rec_fecpag = vd_fecpago
                    AND rec_ejerci = extract(year from rec_fecpag)
                    -- (5/5) EMPLEADO(S)
                    AND ( (wn_lstemp > 0 AND his_keyemp IN (SELECT ran_keycen
                                                              FROM usrsiho.glwkrang
                                                             WHERE ran_nomrep = ws_nomrep
                                                               AND ran_idepcc = ws_idepcc
                                                               AND ran_keyusu = wn_keyusu
                                                               AND ran_keycon = 'EMP') ) OR
                           wn_lstemp = 0 )
                    -- (4/5) NOMINA(S)
                    AND ( (wn_LenNom > 0 AND rec_keynom IN (SELECT ran_keycen
                                                              FROM usrsiho.glwkrang
                                                             WHERE ran_nomrep = ws_nomrep
                                                               AND ran_idepcc = ws_idepcc
                                                               AND ran_keyusu = wn_keyusu
                                                               AND ran_keycon = 'NOM') ) OR
                           wn_LenNom = 0 )
                 GROUP BY rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_keynom,
                          nom_destip,rec_numemi,per_fecpag,his_codimp,agc_keyagr,per_nu1aux,
                          emp_ca2aux,emp_cveban,rec_import,rec_stscon,rec_keynom,rec_numemi,his_rowide
                 ORDER BY 12,16) LOOP -- Ordenado: his_codimp,agc_keyagr
	 	-- Se agrega his_rowide en el group para los conceptos de Sitatyr
	 	-- Marzo 2010
            -- -> Verifico que no exista descripcion opcional por opcis
            wn_numrec := rec3.rec_keyrec;
            wn_keyemp := rec3.emp_keyemp;
            ws_nomemp := rec3.emp_nomemp;
            ws_regrfc := rec3.emp_regrfc;
            ws_desapr := rec3.pam_nompar;
            ws_destip := rec3.nom_destip;
            wn_perini := rec3.perini;
            wn_perfin := rec3.perfin;
            wd_fecini := rec3.fecini;
            wd_fecfin := rec3.fecfin;
            wd_fecpag := rec3.per_fecpag;
            ws_codimp := rec3.his_codimp;
            ws_keycon := rec3.con_keycon;
            ws_descon := rec3.con_descon;
            wn_costot := rec3.tot_importe;
            wn_keyagr := rec3.agc_keyagr;
            wn_tipcam := rec3.per_nu1aux;
            ws_sitfis := rec3.emp_ca2aux;
            ws_estcta := rec3.emp_cveban;
            ws_stscon := rec3.stscon;
            wn_Keynom := rec3.rec_keynom;
            wn_numemi := rec3.rec_numemi;
            wn_rowide := rec3.his_rowide;
            begin
                SELECT pam_nompar
                  INTO lsDescon
                  FROM usrsiho.glcopams
                 WHERE pam_keypar=(SELECT t1.pam_folini
                                     FROM usrsiho.glcopams t1
                                    WHERE t1.pam_cvesec='gimpre')
                   AND pam_folini = ws_keycon
                   AND pam_folfin = wn_keypro;
                exception
                    when no_data_found then
                     lsDescon := null;
            end;
            IF lsDescon IS NOT NULL THEN
                ws_descon:=TRIM(lsDescon);
            END IF;
            -- -> POR CADA RECIBO HACER EL DESGLOSE
            IF wn_keyagr = 18 THEN   -- -> DESGLOSE PARA LA AGRUPACION 18
               wn_defrec := 0;
               -- -> CHECAMOS EN LA TABLA 'NET' SI EXISTE EL CONCEPTO ORIGINAL PARA SABER SI SE PROCESAN CONCEPTOS NETOS ( FUTBOL)
               Ws_Keyconcep := '';
                wi_bandera := 0;
               begin
                   SELECT pam_nompar
                     INTO Ws_Keyconcep
                     FROM usrsiho.glcopams
                    WHERE pam_keypar = 'NET'
                      AND pam_cvesec = Ws_Keycon;
                   exception
                    when no_data_found then
                     Ws_Keyconcep := '';
               end;
               IF Ws_Keyconcep <> '' THEN
                  wn_costot1 := wn_costot;
                  Ws_Keycon := TRIM(Ws_Keyconcep);
                  wi_bandera := 1;
               END IF;
               IF wi_bandera = 1 THEN    -- SE PROCESAN CONCEPTOS NETOS ( FUTBOL)
                  wi_primeravez := 1;
                  we_ant_keyper := '';
                  we_ant_keyemp := 0;
                  we_ant_keypue := 0;
                  we_ant_keycon := '';
               END IF;
               FOR rec4 IN (SELECT hgd_numcap,trim(frp_keydep)||' '||decode(nvl(con_stsfir,' '),'N','*',' ') valor2,
                              dep_desdep,frp_keyrph,hgd_keysec,frp_fectrab,
                              hgd_costog,hgd_capini,hgd_capfin,hgd_numcap*hgd_costog costot,
                              con_descon,hgd_keypue,frp_keyper
                        FROM usrsiho.holohgdp_tmp
                        join usrsiho.holofrph_tmp on Frp_Keyrph = Hgd_Keyrph AND Frp_Keypro = Wn_Keypro AND Frp_Keynom = Wn_Keynom
                          AND Frp_Keyper between wn_perini and wn_perfin
                        join usrsiho.nmcodeps on Frp_Keydep = Dep_Keydep
                        join usrsiho.nmloconc on hgd_keycon = con_keycon
                        left join usrsiho.holocont on  hgd_keytco = con_keytco AND hgd_keyfol = con_keyfol
                        WHERE Hgd_Keyemp = Wn_Keyemp
                          AND hgd_keycon = Ws_Keycon
                         ) LOOP
                  -- -----------------------------------
                  wn_numcap := rec4.hgd_numcap;
                  ws_keydep := rec4.valor2;
                  ws_desdep := rec4.dep_desdep;
                  wn_keyrph := rec4.frp_keyrph;
                  wn_keysec := rec4.hgd_keysec;
                  wd_fectrab := rec4.frp_fectrab;
                  wn_cosuni := rec4.hgd_costog;
                  wn_capini := rec4.hgd_capini;
                  wn_capfin := rec4.hgd_capfin;
                  wn_costot := rec4.costot;
                  ws_descon := rec4.con_descon;
                  wn_keypue := rec4.hgd_keypue;
                  ws_keyper := rec4.frp_keyper;
                  IF wi_bandera = 1 THEN    -- SE PROCESAN CONCEPTOS NETOS ( FUTBOL)
                     IF wi_primeravez = 1 THEN
                        we_ant_keyper := ws_keyper;
                        we_ant_keyemp := Wn_Keyemp;
                        we_ant_keypue := wn_keypue;
                       we_ant_keycon := Ws_Keycon;
                     END IF;
                    IF wi_primeravez > 1 THEN
                       IF we_ant_keyper = ws_keyper AND we_ant_keyemp = Wn_Keyemp AND we_ant_keypue = wn_keypue AND we_ant_keycon = Ws_Keycon THEN
                          wn_costot := 0;
                          wn_costot1 := 0;
                       END IF;
                       we_ant_keyper := ws_keyper;
                       we_ant_keyemp := Wn_Keyemp;
                       we_ant_keypue := wn_keypue;
                       we_ant_keycon := Ws_Keycon;
                    END IF;
                 END IF;
                 -- ----------------------------------------------------------
                  -- -> Verifico que no exista descripcion opcional por opcis
                begin
                    SELECT pam_nompar
                    INTO lsDescon
                    FROM usrsiho.glcopams
                   WHERE pam_keypar=(SELECT t1.pam_folini
                                       FROM usrsiho.glcopams t1
                                      WHERE t1.pam_cvesec='gimpre')
                     AND pam_folini = ws_keycon
                     AND pam_folfin = wn_keypro;
                    exception
                    when no_data_found then
                     lsDescon := null;
                 end;
                  IF lsDescon IS NOT NULL THEN
                     ws_descon:=TRIM(lsDescon);
                  END IF;
                  -----------------------------------------------------------------------------
                  IF wi_bandera = 1 THEN
                     wn_costot := wn_costot1;
                  END IF;
                  -- -> INSERCCION DE REGISTROS
                  wn_numsec := wn_numsec + 1;
                  INSERT INTO usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
                                       cry_numsec,cry_dec007,cry_dec008,cry_dec009,cry_dat003,cry_dat004,cry_dec010,
                                       cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
                                       cry_dec018,cry_dec019,cry_chr001,cry_chr003,cry_chr004,cry_chr005,cry_chr012,
                                       cry_chr013,cry_chr017,cry_chr018,cry_dat001,cry_dat002,cry_chr006,cry_dec021,
                                       cry_dec022,cry_dec020,cry_chr007,cry_chr019,cry_dec023,cry_chr020,cry_chr021,cry_dec025)
                                VALUES(ws_nomrep,ws_idepcc,wn_keyusu,
                                       wn_numsec,wn_numemi,wn_perini,wn_perfin,wd_fecini,wd_fecfin,wn_numrec,
                                       wn_keyemp,wn_numcap,wn_keyrph,wn_capini,wn_capfin,wn_keynom,wn_keypro,
                                       wn_cosuni,wn_costot,ws_nomemp,ws_desapr,ws_destip,ws_desdep,ws_keydep,
                                       ws_regrfc,ws_keycon,ws_codimp,wd_fecpag,wd_fectrab,ws_descon,1        ,
                                       wn_tipcam,NULL     ,NULL     ,ws_sitfis,wn_defrec ,ws_estcta,ws_stscon,wn_keysec);
                  IF wi_bandera = 1 THEN    -- SE PROCESAN CONCEPTOS NETOS ( FUTBOL)
                     wi_primeravez := wi_primeravez + 1;
                  END IF;
               END LOOP;
            ELSE   -- -> Diferente a agrupacion 18
               IF ws_keycon = 'H08' or ws_keycon = 'H09' THEN -- -> VIATICOS
                  --INSERCCION DE REGISTROS
                  wn_numsec:=wn_numsec + 1;
                  INSERT INTO usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
                                       cry_numsec,cry_dec007,cry_dec008,cry_dec009,cry_dat003,cry_dat004,cry_dec010,
                                       cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
                                       cry_dec018,cry_dec019,cry_chr001,cry_chr003,cry_chr004,cry_chr007,cry_chr012,
                                       cry_chr013,cry_chr017,cry_chr018,cry_dat001,cry_dat002,cry_chr005,cry_dec021,
                                       cry_dec022,cry_dec020,cry_chr019,cry_chr020,cry_chr021)
                                VALUES(ws_nomrep,ws_idepcc,wn_keyusu,
                                       wn_numsec,wn_numemi,wn_perini,wn_perfin,wd_fecini,wd_fecfin,wn_numrec,
                                       wn_keyemp,NULL     ,NULL     ,NULL     ,NULL     ,wn_keynom,wn_keypro,
                                       NULL     ,wn_costot,ws_nomemp,ws_desapr,ws_destip,NULL     ,NULL     ,
                                       ws_regrfc,'H08'    ,'01'     ,wd_fecpag,NULL     ,'VIATICOS',3       ,
                                       wn_tipcam,NULL     ,ws_sitfis,ws_estcta,ws_stscon);
               ELSIF ws_keycon = 'H04' THEN --REPETICION
                  -- -> INSERCCION DE REGISTROS
                  wn_numsec:=wn_numsec + 1;
                  INSERT INTO usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
                                       cry_numsec,cry_dec007,cry_dec008,cry_dec009,cry_dat003,cry_dat004,cry_dec010,
                                       cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
                                       cry_dec018,cry_dec019,cry_chr001,cry_chr003,cry_chr004,cry_chr005,cry_chr012,
                                       cry_chr013,cry_chr017,cry_chr018,cry_dat001,cry_dat002,cry_chr006,cry_dec021,
                                       cry_dec022,cry_dec020,cry_chr007,cry_chr019,cry_chr020,cry_chr021)
                                VALUES(ws_nomrep,ws_idepcc,wn_keyusu,
                                       wn_numsec,wn_numemi,wn_perini,wn_perfin,wd_fecini,wd_fecfin,wn_numrec,
                                       wn_keyemp,NULL     ,NULL     ,NULL     ,NULL     ,wn_keynom,wn_keypro,
                                       NULL     ,wn_costot,ws_nomemp,ws_desapr,ws_destip,NULL     ,NULL     ,
                                       ws_regrfc,ws_keycon,ws_codimp,wd_fecpag,NULL     ,NULL     ,2        ,
                                       wn_tipcam,NULL     ,NULL,ws_sitfis,ws_estcta,ws_stscon);
               ELSE -- EL RESTO
                  -- PUEDE SER PERCEPCION O DEDUCCION
                  -- EN CASO DE SER UNA PERSEPCION SE REALIZA UNA NUEVA INSERCCION
                  IF ws_codimp='01' THEN
                     wn_numsec:=wn_numsec + 1;
                     INSERT INTO usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
                                          cry_numsec,cry_dec007,cry_dec008,cry_dec009,cry_dat003,cry_dat004,cry_dec010,
                                          cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
                                          cry_dec018,cry_dec019,cry_chr001,cry_chr003,cry_chr004,cry_chr005,cry_chr012,
                                          cry_chr013,cry_chr017,cry_chr018,cry_dat001,cry_dat002,cry_chr006,
                                          cry_dec020,cry_chr007,cry_dec021,cry_dec022,cry_chr019,cry_chr020,cry_chr021)
                                   VALUES(ws_nomrep,ws_idepcc,wn_keyusu,
                                          wn_numsec,wn_numemi,wn_perini,wn_perfin,wd_fecini,wd_fecfin,wn_numrec,
                                          wn_keyemp,NULL     ,NULL     ,NULL     ,NULL     ,wn_keynom,wn_keypro,
                                          NULL     ,wn_costot,ws_nomemp,ws_desapr,ws_destip,ws_descon,NULL     ,
                                          ws_regrfc,ws_keycon,ws_codimp,wd_fecpag,NULL     ,NULL     ,
                                          NULL     ,NULL     ,4        ,wn_tipcam,ws_sitfis,ws_estcta,ws_stscon);
                  ELSE --EN CASO DE SER DEDUCCION SE HACE UNA ACTUALIZACION O UNA INSERCCION
                     -- -> BUSQUEDA DEL REGISTRO PARA ACTUALIZAR
                     BEGIN
                         SELECT nvl(MIN(cry_numsec),0)
                            INTO wn_regded
                            FROM usrsiho.glwkcrys
                           WHERE cry_nomrep = ws_nomrep
                             AND cry_idepcc = ws_idepcc
                             AND cry_keyusu = wn_keyusu
                             AND cry_dec010 = wn_numrec
                             AND cry_dec017 = wn_keypro
                             AND cry_dec020 IS NULL
                             AND cry_chr007 IS NULL;
                             EXCEPTION WHEN no_data_found THEN wn_regded := 0;
                     END;
                     -- -> SI ENCONTRO EL REGISTRO => SE REALIZA LA ACTUALIZACION
                     IF wn_regded > 0 THEN
                        UPDATE usrsiho.glwkcrys
                           SET cry_dec020 = wn_costot,
                               cry_chr007 = ws_descon
                         WHERE cry_nomrep = ws_nomrep
                           AND cry_idepcc = ws_idepcc
                           AND cry_keyusu = wn_keyusu
                           AND cry_numsec = wn_regded;
                     ELSE
                        wn_numsec:=wn_numsec + 1;
                        INSERT INTO usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
                                             cry_numsec,cry_dec007,cry_dec008,cry_dec009,cry_dat003,cry_dat004,cry_dec010,
                                             cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
                                             cry_dec018,cry_dec019,cry_chr001,cry_chr003,cry_chr004,cry_chr005,cry_chr012,
                                             cry_chr013,cry_chr017,cry_chr018,cry_dat001,cry_dat002,cry_chr006,
                                             cry_dec020,cry_chr007,cry_dec021,cry_dec022,cry_chr019,cry_chr020,cry_chr021)
                                      VALUES(ws_nomrep,ws_idepcc,wn_keyusu,
                                             wn_numsec,wn_numemi,wn_perini,wn_perfin,wd_fecini,wd_fecfin,wn_numrec,
                                             wn_keyemp,NULL     ,NULL     ,NULL     ,NULL     ,wn_keynom,wn_keypro,
                                             NULL     ,NULL     ,ws_nomemp,ws_desapr,ws_destip,NULL     ,NULL     ,
                                             ws_regrfc,ws_keycon,ws_codimp,wd_fecpag,NULL     ,NULL    ,
                                             wn_costot,ws_descon,5        ,wn_tipcam,ws_sitfis,ws_estcta,ws_stscon);
                     END IF;
                  END IF;
               END IF;
            END IF;
         END LOOP;
      END LOOP;
   END LOOP;
  --Actualiza Indices
  /* update statistics medium for table glwkcrys; */
  -- -> Elimina rangos
  -- DELETE
  --   FROM glwkrang
  --  WHERE ran_idepcc = ws_idepcc
  --    AND ran_keyusu = wn_keyusu
  --    AND ran_nomrep = ws_nomrep;
  --Dropea Tablas Temporales  JDCM
   --delete from periodos;
   --delete from emisiones;
   --delete from nmlohism_tmp;
   --delete from holoreci_tmp;
   --delete from holofrph_tmp;
   --delete from holohgdp_tmp;
  --
END;
/
