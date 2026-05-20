CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HPGIMPRE4" (ws_nomrep IN VARCHAR2,ws_idepcc IN VARCHAR2, wn_keyusu IN NUMBER,
 ws_keyapr IN VARCHAR2, wn_keypro IN NUMBER, wn_tiprec IN NUMBER,
 wn_lstemp IN NUMBER, wd_fec_pag IN DATE) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
--- RETURNING VARVARCHAR2(99);
--- DEFINE VAL VARVARCHAR2(99);
 wn_numsec NUMBER(10); -- cry_numsec
 wn_perini NUMBER(10); -- cry_dec008
 wn_perfin NUMBER(10); -- cry_dec009
 wn_numrec NUMBER(10); -- cry_dec010
 wn_keyemp NUMBER(10); -- cry_dec011
 wn_numcap NUMBER(10); -- cry_dec012
 wn_keyrph NUMBER(10); -- cry_dec013
 wn_capini NUMBER(10); -- cry_dec014
 wn_capfin NUMBER(10); -- cry_dec015
 wn_cosuni BINARY_DOUBLE; -- cry_dec018
 wn_costot BINARY_DOUBLE; -- cry_dec019
 wn_tipcam BINARY_DOUBLE; -- cry_dec022
 wn_keynom NUMBER(5); --
 ws_condic VARCHAR2(10); --
 ws_nomi NUMBER(5); --
 ws_nomexc VARCHAR2(10); --
 wn_numemi NUMBER(10); --
 ws_nomemp VARCHAR2(60); -- cry_chr001
 ws_desapr VARCHAR2(40); -- cry_chr003
 ws_destip VARCHAR2(40); -- cry_chr004
 ws_desdep VARCHAR2(40); -- cry_chr005
 ws_descon VARCHAR2(40); -- cry_chr006
 ws_keydep VARCHAR2(16); -- cry_chr012
 ws_regrfc VARCHAR2(13); -- cry_chr013
 ws_keycon VARCHAR2(3); -- cry_chr017
 ws_codimp VARCHAR2(2); -- cry_chr018
 wd_fecpag DATE; -- cry_dat001
 wd_fectrab DATE; -- cry_dat002
 wd_fecini DATE; -- cry_dat003
 wd_fecfin DATE; -- cry_dat004
 ws_sitfis VARCHAR2(8); -- cry_chr019
 ws_estcta VARCHAR2(8); -- cry_chr020
 ws_stscon VARCHAR2(3); -- cry_chr021
 wn_keyagr NUMBER(10); -- numero de agrupacion
 wn_regded NUMBER(10); -- numero del secuencial para deduccion
 wn_defrec NUMBER(5); -- cry_dec023 define si es recibo o liquidacisn para derechos de autor
 wn_tip112 NUMBER(5); -- define si es recibo o liquidacisn para derechos de autor
 lsDescon VARCHAR2(40);
 --wd_fec_pag DATE;
BEGIN -- DESCRIPCION DE CONCEPTO PARA VALIDAR POR OPCIS
--wd_fec_pag := to_date(ws_fec_pag,'MM/DD/yyyy');
 -- LIMPIA LA TABLA PARA ESTE REPORTE
 DELETE FROM usrsiho.glwkcrys
 WHERE cry_nomrep = ws_nomrep
 AND cry_idepcc = ws_idepcc
 AND cry_keyusu = wn_keyusu;
 wn_numsec := 0;
 --LECTURA DE LOS DATOS DEL HEADER
 --NORECIBO,CODIGO,NOMEMP,RFCEMP,UBICACION,KEYNOM,DESNOM,NUMEMI,PERINI,PERFIN,FECINI,FECFIN,FECPAG
 --PER/DED CODIMP,CONEPTO DESCON
 FOR rec IN (SELECT rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_destip,
 min(to_number(per_keyper)) perini,max(to_number(per_keyper)) perfin,
 min(per_fecini) fecini,max(per_fecfin) fecfin,per_fecpag,
 his_codimp,con_keycon,con_descon,sum(his_import) suma_imp,agc_keyagr,per_nu1aux,emp_ca2aux,
 emp_cveban,rec_keynom,rec_numemi,rec_stscon --DECODE(rec_stscon,1,' ','*') stscon
 FROM usrsiho.holoreci
 join usrsiho.nmcoempl on rec_keyemp=emp_keyemp
 join usrsiho.nmlonomi on rec_keynom=nom_keynom
 join usrsiho.nmloperi on rec_keypro=per_keypro AND rec_keynom=per_keynom AND rec_keyapr=per_nu3aux
 AND rec_numemi=per_nu4aux
 join usrsiho.glcopams on pam_cvesec=rec_keyapr AND pam_keypar='H2' -- areas de produccion
 join usrsiho.nmlohism on per_keypro=his_keypro AND per_keyper=his_keyper AND rec_keyemp=his_keyemp
 AND his_codimp IN ('01','02')
 join usrsiho.nmloconc on his_keycon=con_keycon
 left join usrsiho.holoagcp on agc_keycon = con_keycon AND agc_keyagr = 18
 WHERE rec_keyapr=ws_keyapr
 AND rec_keypro=wn_keypro
 AND rec_keynom IN (SELECT ran_keynom
 FROM usrsiho.glwkrang
 WHERE ran_nomrep = ws_nomrep
 AND ran_keynom IS NOT NULL
 AND ran_idepcc = ws_idepcc
 AND ran_keyusu = wn_keyusu)
 AND rec_fecpag = wd_fec_pag
 AND rec_ejerci = extract(year from rec_fecpag)
 AND con_keycon NOT IN ('H08','H09','28D')
 AND his_keyemp IN (SELECT ran_keyemp
 FROM usrsiho.glwkrang
 WHERE ran_nomrep = ws_nomrep
 AND ran_idepcc = ws_idepcc
 AND ran_keyusu = wn_keyusu)
 GROUP BY rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_keynom,
 nom_destip,rec_numemi,per_fecpag,his_codimp,con_keycon,con_descon,
 agc_keyagr,per_nu1aux,emp_ca2aux,emp_cveban,rec_import,rec_stscon,rec_keynom,rec_numemi
 UNION
 SELECT
 rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_destip,
 min(to_number(per_keyper)) perini,max(to_number(per_keyper)) perfin,
 min(per_fecini) fecini,max(per_fecfin) fecfin,per_fecpag,
 his_codimp,'H08','VIATICOS' con_keycon,sum(his_import),agc_keyagr,per_nu1aux,
 emp_ca2aux,emp_cveban,rec_keynom,rec_numemi,rec_stscon --DECODE(rec_stscon,1,' ','*') stscon
 FROM usrsiho.holoreci
 join usrsiho.nmcoempl on rec_keyemp=emp_keyemp
 join usrsiho.nmlonomi on rec_keynom=nom_keynom
 join usrsiho.nmloperi on rec_keypro=per_keypro AND rec_keynom=per_keynom AND rec_keyapr=per_nu3aux
 AND rec_numemi=per_nu4aux
 join usrsiho.glcopams on pam_cvesec=rec_keyapr AND pam_keypar='H2' -- Areas de produccion
 join usrsiho.nmlohism on per_keypro=his_keypro AND per_keyper=his_keyper
 AND rec_keyemp=his_keyemp AND his_codimp IN ('01','02')
 join usrsiho.nmloconc on his_keycon=con_keycon
 left join usrsiho.holoagcp on agc_keycon = con_keycon AND agc_keyagr = 18
 WHERE rec_keyapr=ws_keyapr
 AND rec_keypro=wn_keypro
 AND rec_keynom IN (SELECT ran_keynom
 FROM usrsiho.glwkrang
 WHERE ran_nomrep = ws_nomrep
 AND ran_keynom IS NOT NULL
 AND ran_idepcc = ws_idepcc
 AND ran_keyusu = wn_keyusu)
 AND rec_fecpag = wd_fec_pag
 AND rec_ejerci = extract(year from rec_fecpag)
 AND con_keycon IN ('H08','H09')
 AND his_keyemp IN (SELECT ran_keyemp
 FROM usrsiho.glwkrang
 WHERE ran_nomrep = ws_nomrep
 AND ran_idepcc = ws_idepcc
 AND ran_keyusu = wn_keyusu)
 GROUP BY rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_keynom,
 nom_destip,rec_numemi,per_fecpag,his_codimp,agc_keyagr,per_nu1aux,
 emp_ca2aux,emp_cveban,rec_import,rec_stscon,rec_keynom,rec_numemi
 ORDER BY 12,16) LOOP -- Ordenado: PE - DE
--- LET VAL = wn_numrec;
--- RETURN VAL WITH RESUME;
--CARLOS
--Verifico que no exista descripcion opcional por opcis
 wn_numrec := rec.rec_keyrec;
 wn_keyemp := rec.emp_keyemp;
 ws_nomemp := rec.emp_nomemp;
 ws_regrfc := rec.emp_regrfc;
 ws_desapr := rec.pam_nompar;
 ws_destip := rec.nom_destip;
 wn_perini := rec.perini;
 wn_perfin := rec.perfin;
 wd_fecini := rec.fecini;
 wd_fecfin := rec.fecfin;
 wd_fecpag := rec.per_fecpag;
 ws_codimp := rec.his_codimp;
 ws_keycon := rec.con_keycon;
 ws_descon := rec.con_descon;
 wn_costot := rec.suma_imp;
 wn_keyagr := rec.agc_keyagr;
 wn_tipcam := rec.per_nu1aux;
 ws_sitfis := rtrim(substr(rec.emp_ca2aux,1,8));
 ws_estcta := rec.emp_cveban;
 --ws_stscon := rec.stscon;
 wn_Keynom := rec.rec_keynom;
 wn_numemi := rec.rec_numemi;
 --DECODE(rec_stscon,1,' ','*') stscon
 --ws_stscon := rec.stscon;
 if rec.rec_stscon = 1 then
 ws_stscon := ' ';
 else
 ws_stscon := '*';
 end if;
 begin
 SELECT pam_nompar
 INTO lsDescon
 FROM usrsiho.glcopams
 WHERE pam_keypar=(SELECT t1.pam_folini
 FROM usrsiho.glcopams t1
 WHERE t1.pam_cvesec='gimpre')
 AND pam_folini=ws_keycon
 AND pam_folfin=wn_keypro;
 exception
 when no_data_found then
    lsDescon := '';
 end;
 IF  LENGTH(lsDescon) > 0 THEN
  ws_descon:=TRIM(lsDescon);
 END IF;
-----------------------------------------------------------------------------
 --POR CADA RECIBO HACER EL DESGLOSE
 IF wn_keyagr=18 THEN -- DESGLOSE PARA LA AGRUPACION
 wn_defrec := 0;
 FOR rec2 IN (SELECT hgd_numcap,trim(frp_keydep)||' '||decode(nvl(con_stsfir,' '),'N','*',' ') lista,
 dep_desdep,frp_keyrph,frp_fectrab,
 hgd_costog,hgd_capini,hgd_capfin,hgd_numcap*hgd_costog costot,
 con_descon
 FROM usrsiho.holohgdp
 join usrsiho.holofrph on Frp_Keyrph=Hgd_Keyrph AND Frp_Keypro=Wn_Keypro
 AND Frp_Keynom=Wn_Keynom AND to_number(Frp_Keyper) between wn_perini and wn_perfin
 join usrsiho.nmcodeps on Frp_Keydep=Dep_Keydep
 join usrsiho.nmloconc on hgd_keycon=con_keycon
 left join usrsiho.holocont on hgd_keytco=con_keytco AND hgd_keyfol=con_keyfol
 WHERE Hgd_Keyemp=Wn_Keyemp
 AND hgd_keycon=Ws_Keycon
 ) LOOP
--- LET VAL = wn_numrec || '/' || wn_keyrph;
--- RETURN VAL WITH RESUME;
 --CARLOS
 --Verifico que no exista descripcion opcional por opcis
 wn_numcap := rec2.hgd_numcap;
 ws_keydep := rec2.lista;
 ws_desdep := rec2.dep_desdep;
 wn_keyrph := rec2.frp_keyrph;
 wd_fectrab := rec2.frp_fectrab;
 wn_cosuni := rec2.hgd_costog;
 wn_capini := rec2.hgd_capini;
 wn_capfin := rec2.hgd_capfin;
 wn_costot := rec2.costot;
 ws_descon := rec2.con_descon;
 begin
 SELECT pam_nompar
 INTO lsDescon
 FROM usrsiho.glcopams
 WHERE pam_keypar=(SELECT t1.pam_folini
 FROM usrsiho.glcopams t1
 WHERE t1.pam_cvesec='gimpre')
 AND pam_folini=ws_keycon
 AND pam_folfin=wn_keypro;
 exception
 when no_data_found then
    lsDescon := '';
 end;
 IF LENGTH(lsDescon) > 0 THEN
  ws_descon:=TRIM(lsDescon);
 END IF;
 -----------------------------------------------------------------------------
 -- Define si es recibo o liquidacisn para derechos de autor
 IF wn_tiprec = 3 THEN
 IF substr(ws_keycon,1,3)='H65' THEN
 wn_defrec:=2;
 ELSIF substr(ws_keycon,1,3)='H66' OR substr(ws_keycon,1,3) = 'H17' OR substr(ws_keycon,1,3) = 'H2' THEN
 wn_defrec:=3;
 ELSIF substr(ws_keycon,1,3)='H67' THEN
 wn_defrec:=1;
 ELSIF substr(ws_keycon,1,3)='H68' THEN
 wn_defrec:=2;
 ELSIF substr(ws_keycon,1,3)='H69' OR substr(ws_keycon,1,3)='H3' OR substr(ws_keycon,1,3)='H4' OR substr(ws_keycon,1,3)='H6' OR substr(ws_keycon,1,3)='H7' THEN
 wn_defrec:=2;
 END IF;
 END IF;
 --INSERCCION DE REGISTROS
 wn_numsec:=wn_numsec + 1;
 INSERT INTO usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
 cry_numsec,cry_dec007,cry_dec008,cry_dec009,cry_dat003,cry_dat004,cry_dec010,
 cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
 cry_dec018,cry_dec019,cry_chr001,cry_chr003,cry_chr004,cry_chr005,cry_chr012,
 cry_chr013,cry_chr017,cry_chr018,cry_dat001,cry_dat002,cry_chr006,cry_dec021,
 cry_dec022,cry_dec020,cry_chr007,cry_chr019,cry_dec023,cry_chr020,cry_chr021)
 VALUES(ws_nomrep,ws_idepcc,wn_keyusu,
 wn_numsec,wn_numemi,wn_perini,wn_perfin,wd_fecini,wd_fecfin,wn_numrec,
 wn_keyemp,wn_numcap,wn_keyrph,wn_capini,wn_capfin,wn_keynom,wn_keypro,
 wn_cosuni,wn_costot,ws_nomemp,ws_desapr,ws_destip,ws_desdep,ws_keydep,
 ws_regrfc,ws_keycon,ws_codimp,wd_fecpag,wd_fectrab,ws_descon,1 ,
 wn_tipcam,NULL ,NULL ,ws_sitfis,wn_defrec ,ws_estcta,ws_stscon);
 END LOOP;
 -- Si el recibo es para derechos de autor y no se ha definido el tipo
 IF wn_defrec = 3 THEN
 SELECT COUNT(*)
 INTO wn_tip112
 FROM usrsiho.nmlohism
 WHERE his_keypro = wn_keypro
 AND his_keyper BETWEEN wn_perini AND wn_perfin
 AND his_keyemp = wn_keyemp
 AND TRIM(his_keycon) IN ('H24','H28')
 AND his_codimp IN ('01','02');
 IF wn_tip112 > 0 THEN
 wn_defrec := 2;
 ELSE
 wn_defrec := 1;
 END IF;
 -- Define el tipo de recibo
 UPDATE usrsiho.glwkcrys
 SET cry_dec023 = wn_defrec
 WHERE cry_nomrep=ws_nomrep
 AND cry_idepcc=ws_idepcc
 AND cry_keyusu=wn_keyusu
 AND cry_dec010=wn_numrec;
 END IF;
 ELSE
--- LET VAL = wn_numrec || '/ OTRO CASO'
--- RETURN VAL WITH RESUME;
 IF ws_keycon='H08' or ws_keycon='H09' THEN --VIATICOS
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
 wn_keyemp,NULL ,NULL ,NULL ,NULL ,wn_keynom,wn_keypro,
 NULL ,wn_costot,ws_nomemp,ws_desapr,ws_destip,NULL ,NULL ,
 ws_regrfc,'H08' ,'01' ,wd_fecpag,NULL ,'VIATICOS',3 ,
 wn_tipcam,NULL ,ws_sitfis,ws_estcta,ws_stscon);
 ELSIF ws_keycon='H04' THEN --REPETICION
 --INSERCCION DE REGISTROS
 wn_numsec:=wn_numsec + 1;
 INSERT INTO usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
 cry_numsec,cry_dec007,cry_dec008,cry_dec009,cry_dat003,cry_dat004,cry_dec010,
 cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
 cry_dec018,cry_dec019,cry_chr001,cry_chr003,cry_chr004,cry_chr005,cry_chr012,
 cry_chr013,cry_chr017,cry_chr018,cry_dat001,cry_dat002,cry_chr006,cry_dec021,
 cry_dec022,cry_dec020,cry_chr007,cry_chr019,cry_chr020,cry_chr021)
 VALUES(ws_nomrep,ws_idepcc,wn_keyusu,
 wn_numsec,wn_numemi,wn_perini,wn_perfin,wd_fecini,wd_fecfin,wn_numrec,
 wn_keyemp,NULL ,NULL ,NULL ,NULL ,wn_keynom,wn_keypro,
 NULL ,wn_costot,ws_nomemp,ws_desapr,ws_destip,NULL ,NULL ,
 ws_regrfc,ws_keycon,ws_codimp,wd_fecpag,NULL ,NULL ,2 ,
 wn_tipcam,NULL ,NULL,ws_sitfis,ws_estcta,ws_stscon);
 ELSE --EL RESTO
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
 wn_keyemp,NULL ,NULL ,NULL ,NULL ,wn_keynom,wn_keypro,
 NULL ,wn_costot,ws_nomemp,ws_desapr,ws_destip,ws_descon,NULL ,
 ws_regrfc,ws_keycon,ws_codimp,wd_fecpag,NULL ,NULL ,
 NULL ,NULL ,4 ,wn_tipcam,ws_sitfis,ws_estcta,ws_stscon);
 ELSE --EN CASO DE SER DEDUCCION SE HACE UNA ACTUALIZACION O UNA INSERCCION
 --BUSQUEDA DEL REGISTRO PARA ACTUALIZAR
 SELECT nvl(MIN(cry_numsec),0)
 INTO wn_regded
 FROM usrsiho.glwkcrys
 WHERE cry_nomrep=ws_nomrep
 AND cry_idepcc=ws_idepcc
 AND cry_keyusu=wn_keyusu
 AND cry_dec010=wn_numrec
 AND cry_dec020 IS NULL
 AND cry_chr007 IS NULL;
 --SI ENCONTRO EL REGISTRO => SE REALIZA LA ACTUALIZACION
 IF wn_regded > 0 THEN
 UPDATE usrsiho.glwkcrys
 SET cry_dec020=wn_costot,
 cry_chr007=ws_descon
 WHERE cry_nomrep=ws_nomrep
 AND cry_idepcc=ws_idepcc
 AND cry_keyusu=wn_keyusu
 AND cry_numsec=wn_regded;
 ELSE
 wn_numsec:=wn_numsec + 1;
 INSERT INTO glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
 cry_numsec,cry_dec007,cry_dec008,cry_dec009,cry_dat003,cry_dat004,cry_dec010,
 cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
 cry_dec018,cry_dec019,cry_chr001,cry_chr003,cry_chr004,cry_chr005,cry_chr012,
 cry_chr013,cry_chr017,cry_chr018,cry_dat001,cry_dat002,cry_chr006,
 cry_dec020,cry_chr007,cry_dec021,cry_dec022,cry_chr019,cry_chr020,cry_chr021)
 VALUES(ws_nomrep,ws_idepcc,wn_keyusu,
 wn_numsec,wn_numemi,wn_perini,wn_perfin,wd_fecini,wd_fecfin,wn_numrec,
 wn_keyemp,NULL ,NULL ,NULL ,NULL ,wn_keynom,wn_keypro,
 NULL ,NULL ,ws_nomemp,ws_desapr,ws_destip,NULL ,NULL ,
 ws_regrfc,ws_keycon,ws_codimp,wd_fecpag,NULL ,NULL ,
 wn_costot,ws_descon,5 ,wn_tipcam,ws_sitfis,ws_estcta,ws_stscon);
 END IF;
 END IF;
 END IF;
 END IF;
 END LOOP;
 -- Elimina rangos
 DELETE
 FROM usrsiho.glwkrang
 WHERE ran_nomrep = 'hpgimpre4'
 AND ran_idepcc = ws_idepcc
 AND ran_keyusu = wn_keyusu;
END;
/
