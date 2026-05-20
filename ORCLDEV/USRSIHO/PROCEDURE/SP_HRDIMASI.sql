CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HRDIMASI" (ps_programa IN VARCHAR2, ps_proceso IN NUMBER, ps_keyusu IN NUMBER,
        ps_ejercicio IN NUMBER, ps_MesIni IN NUMBER, ps_MesFin IN NUMBER,
        ps_ZonaGeo IN NUMBER, ps_BanProceso IN NUMBER, ps_BanEMPL IN NUMBER, st_BanSqlNotIN IN NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  -- ps_proceso  / proceso que se consulto
  -- ps_keyusu  / usuario que esta generando la consulta
  -- ps_ejercicio / ejercicio a aplicar en la consulta
  -- ps_MesIni / periodo de mes inicial a consultar
  -- ps_MesFin / periodo de mes final a consultar
  -- ps_ZonaGeo / parametro para realizar la consulta y aplicar una columna
  -- ps_BanProceso / parametro para asignar el valor de siesasimsal
  -- ps_BanEMPL / parametro para generar la consulta en el caso de constancias por codigos o todos
  -- ps_EmpIN / parametro de que codigos se realizara la consulta
  -- Se Crea stored para asimilables
   li_mesinirec NUMBER(10); li_mesfinrec NUMBER(10); li_mesinihis NUMBER(10); li_mesfinhis NUMBER(10); li_calcanual NUMBER(10);
   li_tarifautil NUMBER(10); li_tarifa1991 NUMBER(10); li_sindicalizado NUMBER(10); li_MesIni NUMBER(10); li_MesFin NUMBER(10); li_ContRegimen  NUMBER(10);
   ld_ingasimasdos NUMBER(16,2);ld_isrretenido NUMBER(16,2);ld_isrconftaranual NUMBER(16,2); ld_mtosubacred NUMBER(16,2); ld_imptoingacum NUMBER(16,2);
   ls_cvesec VARCHAR2(10);
   ls_codempl VARCHAR2(10);
   ls_rfc VARCHAR2(20);
   ls_curp VARCHAR2(20);
   ls_paterno VARCHAR2(50);
   ls_materno VARCHAR2(50);
   ls_nombres VARCHAR2(50);
   ls_aregeos VARCHAR2(2);
   ls_propsub VARCHAR2(10);
   ls_siesasimsal VARCHAR2(1);
   ls_cveentidad VARCHAR2(2);
   ls_empstatus VARCHAR2(1);
   ls_vacio1 VARCHAR2(1);
   ls_vacio2 VARCHAR2(1);
   ls_vacio3 VARCHAR2(1);
   ls_vacio4 VARCHAR2(1);
   ls_vacio5 VARCHAR2(1);
   ls_vacio6 VARCHAR2(1);
   ls_vacio7 VARCHAR2(1);
   ls_vacio8 VARCHAR2(1);
   ls_vacio9 VARCHAR2(1);
   ls_vacio10 VARCHAR2(1);
   ls_vacio11 VARCHAR2(1);
   ls_vacio12 VARCHAR2(1);
   ls_vacio13 VARCHAR2(1);
   ls_vacio14 VARCHAR2(1);
   ls_vacio15 VARCHAR2(1);
   ls_vacio16 VARCHAR2(1);
   ls_vacio17 VARCHAR2(1);
BEGIN
   ls_vacio1  := '0';
   ls_vacio2  := '2';
   ls_vacio3  := '0';
   ls_vacio4  := '0';
   ls_vacio5  := '0';
   ls_vacio6  := '1';
   ls_vacio7  := '0';
   ls_vacio8  := '0';
   ls_vacio9  := '0';
   ls_vacio10  := '0';
   ls_vacio11  := '0';
   ls_vacio12  := '0';
   ls_vacio13  := '0';
   ls_vacio14  := '0';
   ls_vacio15  := '0';
   ls_vacio16  := '0';
   ls_vacio17  := '0';
   li_tarifautil := 1;
   li_tarifa1991 := 2;
   ls_propsub := '0.00000';
   li_sindicalizado := 2;
--ps_programa IN VARCHAR2, ps_proceso IN NUMBER, ps_keyusu IN NUMBER,
--        ps_ejercicio IN NUMBER, ps_MesIni IN NUMBER, ps_MesFin IN NUMBER,
--        ps_ZonaGeo IN NUMBER, ps_BanProceso IN NUMBER, ps_BanEMPL IN NUMBER, st_BanSqlNotIN IN NUMBER
   insert into usrsiho.glwkcrys(cry_nomrep,cry_chr016,cry_dec006,cry_dec007,cry_dec008,cry_dec009,cry_dec010,cry_dec011,
    cry_dec012,cry_dec013,cry_dec014)
    values ('debug',ps_programa,ps_proceso,ps_keyusu,ps_ejercicio,ps_mesini,ps_mesfin,ps_zonageo,ps_banproceso,ps_banempl,    st_bansqlnotin);
    commit;
   IF ps_BanProceso = 1 then   -- valor 1 es proceso 143,144,145;
        ls_siesasimsal := 'B';
   ELSE
        ls_siesasimsal := 'E';
   END IF;
--  Realiza la consulta para archivo XLS, txt
IF ps_ZonaGeo = 1 THEN  --  (IMPRESION EN EXCEL)
   IF st_BanSqlNotIN = 0 THEN   -- CASO DE NO APLICAR FILTRO NOT IN - EMPLEADO (IMPRESION EN EXCEL)
           -- Genera un For de la consulta principal y hacer un insert del resultado
           FOR rec  IN (SELECT pam_cvesec, emp_keyemp codigo, emp_regrfc RFC, emp_recurp CURP,
                            emp_nomemp,
                            DECODE(dat_valpar,'1','1','2') CALCULOANUAL,
                            SUM(DECODE(agc_keyagr,11,((his_import)*1),0)) IngAsimASdos,
                            SUM(DECODE(agc_keyagr,15,(his_import)*1,0)) ISRRetenido,
                            SUM(DECODE(agc_keyagr,15,((his_import)*1),0))  ISRCONFTARANUAL,
                            SUM(DECODE(agc_keyagr,79,((his_import)*1),0))  MTOSUBACRED,
                            SUM(DECODE(agc_keyagr,15,(his_import)*1,0)) IMPTOINGACUM, emp_status
                FROM usrsiho.nmlohism_cons h1
                join usrsiho.nmloperi on per_keypro=h1.his_keypro AND per_keyper = h1.his_keyper
                join usrsiho.nmcoempl on h1.his_keyemp=emp_keyemp
                join usrsiho.holoagcp on agc_keyagr IN (11,12,13,14,15,45) AND h1.his_keycon=agc_keycon
                join usrsiho.glcopams g2 on g2.pam_keypar = 'H2' AND g2.pam_cvesec = per_nu3aux
                left join usrsiho.nmlodata on dat_keyemp=his_keyemp AND dat_keypar=27
                WHERE per_keypro = ps_proceso
                    AND EXTRACT(YEAR FROM per_fecpag) = ps_ejercicio
                    AND extract(month from per_fecpag) >= ps_MesIni AND extract(month from per_fecpag) <= ps_MesFin
                    AND substr(h1.his_ca1aux,1,3) in ('001','501')
                    AND agc_keyagr IN (11,12,13,15) AND h1.his_keynom not in (103,110)
                    AND SUBSTR(h1.HIS_CA1AUX,4,1) in ('1','3')
                GROUP BY pam_cvesec, emp_keyemp, emp_regrfc, emp_recurp,
                            emp_nomemp, emp_status,dat_valpar
                ORDER BY Curp) LOOP
                -- Area geografica / ClaveEntidad
                ------------------------------------------------------------
                ls_cvesec := rec.pam_cvesec;
                ls_codempl := rec.codigo;
                ls_rfc := rec.RFC;
                ls_curp := rec.CURP;
                --sp_delimitador(emp_nomemp,'/',1) Paterno,
                --sp_delimitador(emp_nomemp,'/',2) Materno,
                --sp_delimitador(emp_nomemp,'/',3) Nombres,
                ls_paterno := sp_delimitador(rec.emp_nomemp,'/',1);
                ls_materno := sp_delimitador(rec.emp_nomemp,'/',2);
                ls_nombres := sp_delimitador(rec.emp_nomemp,'/',3);
                li_calcanual := rec.CALCULOANUAL;
                ld_ingasimasdos := rec.IngAsimASdos;
                ld_isrretenido := rec.ISRRetenido;
                ld_isrconftaranual := rec.ISRCONFTARANUAL;
                ld_mtosubacred := rec.MTOSUBACRED;
                ld_imptoingacum := rec.IMPTOINGACUM;
                ls_empstatus := rec.emp_status;
                BEGIN
                    SELECT pam_cvesec AREAGEOSMG, pam_folini claveEntidad
                    INTO ls_aregeos, ls_cveentidad
                    FROM usrsiho.glcopams
                    WHERE pam_keypar = 'AEN'
                    AND pam_folfin = ls_cvesec;
                    EXCEPTION WHEN no_data_found THEN ls_aregeos := ''; ls_cveentidad := '';
                END;
                ------------------------------------------------------------
                -- Obtiene el dato de mes inicial y final de recibos
                ------------------------------------------------------------
                BEGIN
                    SELECT MIN(EXTRACT(MONTH FROM rec_feccob)), MAX(EXTRACT(MONTH FROM rec_feccob))
                    INTO li_mesinirec, li_mesfinrec
                    FROM usrsiho.holoreci
                    WHERE rec_ejerci = ps_ejercicio
                    AND rec_keyemp = ls_codempl
                    AND rec_keypro = ps_proceso
                    AND rec_stsrec = 3;
                    EXCEPTION WHEN no_data_found THEN li_mesinirec := 0; li_mesfinrec := 0;
                END;
                -- Obtiene el mes min y max de regimen fiscal del empleado
                ------------------------------------------------------------
                BEGIN
                    SELECT MIN(EXTRACT(MONTH FROM his_fecmov)), MAX(EXTRACT(MONTH FROM his_fecmov))
                    INTO  li_mesinihis, li_mesfinhis
                    FROM usrsiho.nmlohism_cons, usrsiho.holoagcp
                    WHERE agc_keyagr IN (11,12,13,14,15,45)
                    AND his_keycon=agc_keycon
                    AND substr(his_ca1aux,1,3) in ('001','501')
                    AND his_keynom not in (103,110)
                    AND SUBSTR(HIS_CA1AUX,4,1) in ('1','3')
                    AND EXTRACT(YEAR FROM his_fecmov) = ps_ejercicio
                    AND his_keyemp = ls_codempl;
                    EXCEPTION WHEN no_data_found THEN li_mesinihis := 0; li_mesfinhis := 0;
                END;
                -- Compara el mes inicial y final de recibos y regimenfiscal para una validacion
                ------------------------------------------------------------
                IF li_mesinirec = li_mesinihis And li_mesfinrec = li_mesfinhis Then
                        li_MesIni := li_mesinirec;
                        li_MesFin := li_mesfinrec;
                ELSE
                        SELECT count(distinct substr(his_ca1aux,1,3))
                                INTO li_ContRegimen
                        FROM usrsiho.nmlohism_cons, holoagcp
                        WHERE agc_keyagr IN (11,12,13,14,15,45)
                                AND his_keycon=agc_keycon
                                AND his_keynom not in (103,110)
                                AND SUBSTR(HIS_CA1AUX,4,1) in ('1','3')
                                AND his_keyemp = ls_codempl;
                        IF li_ContRegimen > 1 Then
                            li_MesIni := li_mesinihis;
                            li_MesFin := li_mesfinhis;
                        ELSE
                            li_MesIni := li_mesinirec;
                            li_MesFin := li_mesfinrec;
                        End IF;
                End IF;
                -- Inserta en la tabla glwkcrys para tabla de paso y seguir en visual el proceso
                ------------------------------------------------------------
                INSERT INTO usrsiho.glwkcrys (cry_nomrep, cry_keyusu,
                                cry_chr001, cry_chr002, cry_dec006, cry_dec007, cry_chr003, cry_chr004, cry_chr005,
                                cry_chr006, cry_chr007, cry_chr008, cry_dec008, cry_dec009, cry_dec010,
                                cry_chr009, cry_chr040, cry_chr010, cry_chr011, cry_chr012,
                                cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_chr017, cry_chr018, cry_chr019, cry_chr020, cry_chr021,
                                cry_chr022, cry_chr023, cry_chr024, cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_dec011, cry_dec012,
                                cry_chr029, cry_chr030, cry_chr031, cry_chr032, cry_chr033, cry_chr034,
                                cry_dec013, cry_chr041, cry_chr035, cry_dec014, cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr042)
                        VALUES(ps_programa, ps_keyusu,
                                ls_cvesec, ls_codempl, li_MesIni, li_MesFin, ls_rfc, ls_curp, ls_paterno,
                                ls_materno, ls_nombres, ls_aregeos, li_calcanual, li_tarifautil, li_tarifa1991,
                                ls_propsub, li_sindicalizado, ls_siesasimsal, ls_cveentidad, ' ',
                                ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ls_vacio1, ls_vacio2, ls_vacio3,
                                ls_vacio4, ls_vacio5, ls_vacio6, ls_vacio7, ld_ingasimasdos, ld_isrretenido,
                                ls_vacio8, ls_vacio9, ls_vacio10, ls_vacio11, ls_vacio12, ls_vacio13,
                                ld_isrconftaranual, ld_mtosubacred, ls_vacio14, ld_imptoingacum, ls_vacio15,
                                ls_vacio16, ls_vacio17, ls_empstatus, ps_proceso);
                ------------------------------------------------------------
                commit;
           END LOOP;
    ELSE --- CASO DE APLICAR FILTRO DE NOT IN - EMPLEADOS (IMPRESION EN EXCEL)
           -- Genera un For de la consulta principal y hacer un insert del resultado
           FOR rec2  IN (SELECT pam_cvesec, emp_keyemp codigo, emp_regrfc RFC, emp_recurp CURP,
                            emp_nomemp,
                            DECODE(dat_valpar,'1','1','2') CALCULOANUAL,
                            SUM(DECODE(agc_keyagr,11,((his_import)*1),0)) IngAsimASdos,
                            SUM(DECODE(agc_keyagr,15,(his_import)*1,0)) ISRRetenido,
                            SUM(DECODE(agc_keyagr,15,((his_import)*1),0))  ISRCONFTARANUAL,
                            SUM(DECODE(agc_keyagr,79,((his_import)*1),0))  MTOSUBACRED,
                            SUM(DECODE(agc_keyagr,15,(his_import)*1,0)) IMPTOINGACUM, emp_status
                 FROM usrsiho.nmlohism_cons h1
                 join usrsiho.nmloperi on per_keypro=h1.his_keypro AND per_keyper = h1.his_keyper
                 join usrsiho.nmcoempl on h1.his_keyemp=emp_keyemp
                 join usrsiho.holoagcp on agc_keyagr IN (11,12,13,14,15,45) AND h1.his_keycon=agc_keycon
                 join usrsiho.glcopams g2 on g2.pam_keypar = 'H2' AND g2.pam_cvesec = per_nu3aux
                 left join usrsiho.nmlodata on dat_keyemp=his_keyemp AND dat_keypar=27
                WHERE per_keypro = ps_proceso
                    AND EXTRACT(YEAR FROM per_fecpag) = ps_ejercicio
                    AND extract(month from per_fecpag) >= ps_MesIni AND extract(month from per_fecpag) <= ps_MesFin
                    AND substr(h1.his_ca1aux,1,3) in ('001','501')
                    AND agc_keyagr IN (11,12,13,15) AND h1.his_keynom not in (103,110)
                    AND SUBSTR(h1.HIS_CA1AUX,4,1) in ('1','3')
                    AND emp_keyemp Not In (SELECT cry_dec006
                                        FROM usrsiho.Glwkcrys
                                        WHERE cry_nomrep = 'SqlNOTIN'
                                        AND cry_keyusu = ps_keyusu)
                GROUP BY pam_cvesec, emp_keyemp, emp_regrfc, emp_recurp ,
                            emp_nomemp, emp_status,dat_valpar
                ORDER BY Curp) LOOP
                -- Area geografica / ClaveEntidad
                ------------------------------------------------------------
                ls_cvesec := rec2.pam_cvesec;
                ls_codempl := rec2.codigo;
                ls_rfc := rec2.RFC;
                ls_curp := rec2.CURP;
                --ls_paterno := rec2.Paterno;
                --ls_materno := rec2.Materno;
                --ls_nombres := rec2.Nombres;
                ls_paterno := sp_delimitador(rec2.emp_nomemp,'/',1);
                ls_materno := sp_delimitador(rec2.emp_nomemp,'/',2);
                ls_nombres := sp_delimitador(rec2.emp_nomemp,'/',3);
                li_calcanual := rec2.CALCULOANUAL;
                ld_ingasimasdos := rec2.IngAsimASdos;
                ld_isrretenido := rec2.ISRRetenido;
                ld_isrconftaranual := rec2.ISRCONFTARANUAL;
                ld_mtosubacred := rec2.MTOSUBACRED;
                ld_imptoingacum := rec2.IMPTOINGACUM;
                ls_empstatus := rec2.emp_status;
                SELECT pam_cvesec AREAGEOSMG, pam_folini claveEntidad
                        INTO ls_aregeos, ls_cveentidad
                FROM usrsiho.glcopams WHERE pam_keypar = 'AEN' AND pam_folfin = ls_cvesec;
                ------------------------------------------------------------
                -- Obtiene el dato de mes inicial y final de recibos
                ------------------------------------------------------------
                BEGIN
                    SELECT MIN(EXTRACT(MONTH FROM rec_feccob)), MAX(EXTRACT(MONTH FROM rec_feccob))
                    INTO li_mesinirec, li_mesfinrec
                    FROM usrsiho.holoreci
                    WHERE rec_ejerci = ps_ejercicio
                    AND rec_keyemp = ls_codempl
                    AND rec_keypro = ps_proceso
                    AND rec_stsrec = 3;
                    EXCEPTION WHEN no_data_found THEN li_mesinirec := 0; li_mesfinrec := 0;
                END;
                -- Obtiene el mes min y max de regimen fiscal del empleado
                ------------------------------------------------------------
                BEGIN
                    SELECT MIN(EXTRACT(MONTH FROM his_fecmov)), MAX(EXTRACT(MONTH FROM his_fecmov))
                    INTO  li_mesinihis, li_mesfinhis
                    FROM usrsiho.nmlohism_cons, usrsiho.holoagcp
                    WHERE agc_keyagr IN (11,12,13,14,15,45)
                    AND his_keycon=agc_keycon
                    AND substr(his_ca1aux,1,3) in ('001','501')
                    AND his_keynom not in (103,110)
                    AND SUBSTR(HIS_CA1AUX,4,1) in ('1','3')
                    AND EXTRACT(YEAR FROM his_fecmov) = ps_ejercicio
                    AND his_keyemp = ls_codempl;
                    EXCEPTION WHEN no_data_found THEN li_mesinihis := 0; li_mesfinhis := 0;
                END;
                -- Compara el mes inicial y final de recibos y regimenfiscal para una validacion
                ------------------------------------------------------------
                IF li_mesinirec = li_mesinihis And li_mesfinrec = li_mesfinhis Then
                        li_MesIni := li_mesinirec;
                        li_MesFin := li_mesfinrec;
                ELSE
                        SELECT count(distinct substr(his_ca1aux,1,3))
                                INTO li_ContRegimen
                        FROM usrsiho.nmlohism_cons, usrsiho.holoagcp
                        WHERE agc_keyagr IN (11,12,13,14,15,45)
                                AND his_keycon=agc_keycon
                                AND his_keynom not in (103,110)
                                AND SUBSTR(HIS_CA1AUX,4,1) in ('1','3')
                                AND his_keyemp = ls_codempl;
                        IF li_ContRegimen > 1 Then
                            li_MesIni := li_mesinihis;
                            li_MesFin := li_mesfinhis;
                        ELSE
                            li_MesIni := li_mesinirec;
                            li_MesFin := li_mesfinrec;
                        End IF;
                End IF;
                -- Inserta en la tabla glwkcrys para tabla de paso y seguir en visual el proceso
                ------------------------------------------------------------
                INSERT INTO usrsiho.glwkcrys (cry_nomrep, cry_keyusu,
                                cry_chr001, cry_chr002, cry_dec006, cry_dec007, cry_chr003, cry_chr004, cry_chr005,
                                cry_chr006, cry_chr007, cry_chr008, cry_dec008, cry_dec009, cry_dec010,
                                cry_chr009, cry_chr040, cry_chr010, cry_chr011, cry_chr012,
                                cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_chr017, cry_chr018, cry_chr019, cry_chr020, cry_chr021,
                                cry_chr022, cry_chr023, cry_chr024, cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_dec011, cry_dec012,
                                cry_chr029, cry_chr030, cry_chr031, cry_chr032, cry_chr033, cry_chr034,
                                cry_dec013, cry_chr041, cry_chr035, cry_dec014, cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr042)
                        VALUES(ps_programa, ps_keyusu,
                                ls_cvesec, ls_codempl, li_MesIni, li_MesFin, ls_rfc, ls_curp, ls_paterno,
                                ls_materno, ls_nombres, ls_aregeos, li_calcanual, li_tarifautil, li_tarifa1991,
                                ls_propsub, li_sindicalizado, ls_siesasimsal, ls_cveentidad, ' ',
                                ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ls_vacio1, ls_vacio2, ls_vacio3,
                                ls_vacio4, ls_vacio5, ls_vacio6, ls_vacio7, ld_ingasimasdos, ld_isrretenido,
                                ls_vacio8, ls_vacio9, ls_vacio10, ls_vacio11, ls_vacio12, ls_vacio13,
                                ld_isrconftaranual, ld_mtosubacred, ls_vacio14, ld_imptoingacum, ls_vacio15,
                                ls_vacio16, ls_vacio17, ls_empstatus, ps_proceso);
                ------------------------------------------------------------
                commit;
           END LOOP;
    END IF;
ELSE   -- CUANDO LA CONSULTA ES DE CONSTANCIAS - WORD / TXT
   -- En caso que sea la consulta para todos los empleados-codigos
    IF ps_BanEMPL = 0 THEN
        IF st_BanSqlNotIN = 0 THEN   -- CASO DE NO APLICAR FILTRO NOT IN - EMPLEADO (IMPRESION WORD)
           -- Genera un For de la consulta principal y hacer un insert del resultado
            FOR rec3  IN (SELECT pam_cvesec, emp_keyemp codigo, emp_regrfc RFC, emp_recurp CURP,
                            emp_nomemp,
                            DECODE(dat_valpar,'1','1','2') CALCULOANUAL,
                            SUM(DECODE(agc_keyagr,11,((his_import)*1),0)) IngAsimASdos,
                            SUM(DECODE(agc_keyagr,15,(his_import)*1,0)) ISRRetenido,
                            SUM(DECODE(agc_keyagr,15,((his_import)*1),0))  ISRCONFTARANUAL,
                            SUM(DECODE(agc_keyagr,79,((his_import)*1),0))  MTOSUBACRED,
                            SUM(DECODE(agc_keyagr,15,(his_import)*1,0)) IMPTOINGACUM, emp_status
                 FROM usrsiho.nmlohism_cons h1
                 join usrsiho.nmloperi on per_keypro=h1.his_keypro AND per_keyper = h1.his_keyper
                 join usrsiho.nmcoempl on h1.his_keyemp=emp_keyemp
                 join usrsiho.holoagcp on agc_keyagr IN (11,12,13,14,15,45) AND h1.his_keycon=agc_keycon
                 join usrsiho.glcopams g2 on g2.pam_keypar = 'H2' AND g2.pam_cvesec = per_nu3aux
                 left join usrsiho.nmlodata on dat_keyemp=his_keyemp AND dat_keypar=27
                WHERE per_keypro = ps_proceso
                    AND EXTRACT(YEAR FROM per_fecpag) = ps_ejercicio
                    AND extract(month from per_fecpag) >= ps_MesIni AND extract(month from per_fecpag) <= ps_MesFin
                    AND substr(h1.his_ca1aux,1,3) in ('001','501')
                    AND agc_keyagr IN (11,12,13,15) AND h1.his_keynom not in (103,110)
                    AND SUBSTR(h1.HIS_CA1AUX,4,1) in ('1','3')
                GROUP BY pam_cvesec, emp_keyemp, emp_regrfc, emp_recurp,
                            emp_nomemp, emp_status,dat_valpar
                ORDER BY Curp) LOOP
                -- Area geografica / ClaveEntidad
                ------------------------------------------------------------
                ls_cvesec := rec3.pam_cvesec;
                ls_codempl := rec3.codigo;
                ls_rfc := rec3.RFC;
                ls_curp := rec3.CURP;
               -- ls_paterno := rec3.Paterno;
               -- ls_materno := rec3.Materno;
               -- ls_nombres := rec3.Nombres;
                ls_paterno := sp_delimitador(rec3.emp_nomemp,'/',1);
                ls_materno := sp_delimitador(rec3.emp_nomemp,'/',2);
                ls_nombres := sp_delimitador(rec3.emp_nomemp,'/',3);
                li_calcanual := rec3.CALCULOANUAL;
                ld_ingasimasdos := rec3.IngAsimASdos;
                ld_isrretenido := rec3.ISRRetenido;
                ld_isrconftaranual := rec3.ISRCONFTARANUAL;
                ld_mtosubacred := rec3.MTOSUBACRED;
                ld_imptoingacum := rec3.IMPTOINGACUM;
                ls_empstatus := rec3.emp_status;
                BEGIN
                    SELECT case when pam_cvesec = 1 then 'A'
                            when pam_cvesec = 2 then 'B'
                            when pam_cvesec = 3 then 'C'
                            end AREAGEOSMG,
                            pam_folini claveEntidad
                            INTO ls_aregeos, ls_cveentidad
                    FROM usrsiho.glcopams
                    WHERE pam_keypar = 'AEN'
                    AND pam_folfin = ls_cvesec;
                    EXCEPTION WHEN no_data_found THEN ls_aregeos := ''; ls_cveentidad := '';
                END;
                ------------------------------------------------------------
                -- Obtiene el dato de mes inicial y final de recibos
                ------------------------------------------------------------
                BEGIN
                    SELECT MIN(EXTRACT(MONTH FROM rec_feccob)), MAX(EXTRACT(MONTH FROM rec_feccob))
                    INTO li_mesinirec, li_mesfinrec
                    FROM usrsiho.holoreci
                    WHERE rec_ejerci = ps_ejercicio
                    AND rec_keyemp = ls_codempl
                    AND rec_keypro = ps_proceso
                    AND rec_stsrec = 3;
                    EXCEPTION WHEN no_data_found THEN li_mesinirec := 0; li_mesfinrec := 0;
                END;
                -- Obtiene el mes min y max de regimen fiscal del empleado
                ------------------------------------------------------------
                BEGIN
                    SELECT MIN(EXTRACT(MONTH FROM his_fecmov)), MAX(EXTRACT(MONTH FROM his_fecmov))
                    INTO  li_mesinihis, li_mesfinhis
                    FROM usrsiho.nmlohism_cons, usrsiho.holoagcp
                    WHERE agc_keyagr IN (11,12,13,14,15,45)
                    AND his_keycon=agc_keycon
                    AND substr(his_ca1aux,1,3) in ('001','501')
                    AND his_keynom not in (103,110)
                    AND SUBSTR(HIS_CA1AUX,4,1) in ('1','3')
                    AND EXTRACT(YEAR FROM his_fecmov) = ps_ejercicio
                    AND his_keyemp = ls_codempl;
                    EXCEPTION WHEN no_data_found THEN li_mesinihis := 0; li_mesfinhis := 0;
                END;
                -- Compara el mes inicial y final de recibos y regimenfiscal para una validacion
                ------------------------------------------------------------
                IF li_mesinirec = li_mesinihis And li_mesfinrec = li_mesfinhis Then
                        li_MesIni := li_mesinirec;
                        li_MesFin := li_mesfinrec;
                ELSE
                        SELECT count(distinct substr(his_ca1aux,1,3))
                                INTO li_ContRegimen
                        FROM usrsiho.nmlohism_cons, usrsiho.holoagcp
                        WHERE agc_keyagr IN (11,12,13,14,15,45)
                                AND his_keycon=agc_keycon
                                AND his_keynom not in (103,110)
                                AND SUBSTR(HIS_CA1AUX,4,1) in ('1','3')
                                AND his_keyemp = ls_codempl;
                        IF li_ContRegimen > 1 Then
                            li_MesIni := li_mesinihis;
                            li_MesFin := li_mesfinhis;
                        ELSE
                            li_MesIni := li_mesinirec;
                            li_MesFin := li_mesfinrec;
                        END IF;
                END IF;
                -- Inserta en la tabla glwkcrys para tabla de paso y seguir en visual el proceso
                ------------------------------------------------------------
                INSERT INTO usrsiho.glwkcrys (cry_nomrep, cry_keyusu,
                                cry_chr001, cry_chr002, cry_dec006, cry_dec007, cry_chr003, cry_chr004, cry_chr005,
                                cry_chr006, cry_chr007, cry_chr008, cry_dec008, cry_dec009, cry_dec010,
                                cry_chr009, cry_chr040, cry_chr010, cry_chr011, cry_chr012,
                                cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_chr017, cry_chr018, cry_chr019, cry_chr020, cry_chr021,
                                cry_chr022, cry_chr023, cry_chr024, cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_dec011, cry_dec012,
                                cry_chr029, cry_chr030, cry_chr031, cry_chr032, cry_chr033, cry_chr034,
                                cry_dec013, cry_chr041, cry_chr035, cry_dec014, cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr042)
                        VALUES(ps_programa, ps_keyusu,
                                ls_cvesec, ls_codempl, li_MesIni, li_MesFin, ls_rfc, ls_curp, ls_paterno,
                                ls_materno, ls_nombres, ls_aregeos, li_calcanual, li_tarifautil, li_tarifa1991,
                                ls_propsub, li_sindicalizado, ls_siesasimsal, ls_cveentidad, ' ',
                                ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ls_vacio1, ls_vacio2, ls_vacio3,
                                ls_vacio4, ls_vacio5, ls_vacio6, ls_vacio7, ld_ingasimasdos, ld_isrretenido,
                                ls_vacio8, ls_vacio9, ls_vacio10, ls_vacio11, ls_vacio12, ls_vacio13,
                                ld_isrconftaranual, ld_mtosubacred, ls_vacio14, ld_imptoingacum, ls_vacio15,
                                ls_vacio16, ls_vacio17, ls_empstatus, ps_proceso);
                ------------------------------------------------------------
                commit;
            END LOOP;
        ELSE    --- CASO DE APLICAR FILTRO DE NOT IN - EMPLEADOS (IMPRESION WORD)
           -- Genera un For de la consulta principal y hacer un insert del resultado
            FOR rec4  IN (SELECT pam_cvesec, emp_keyemp codigo, emp_regrfc RFC, emp_recurp CURP,
                           emp_nomemp,
                            DECODE(dat_valpar,'1','1','2') CALCULOANUAL,
                            SUM(DECODE(agc_keyagr,11,((his_import)*1),0)) IngAsimASdos,
                            SUM(DECODE(agc_keyagr,15,(his_import)*1,0)) ISRRetenido,
                            SUM(DECODE(agc_keyagr,15,((his_import)*1),0))  ISRCONFTARANUAL,
                            SUM(DECODE(agc_keyagr,79,((his_import)*1),0))  MTOSUBACRED,
                            SUM(DECODE(agc_keyagr,15,(his_import)*1,0)) IMPTOINGACUM, emp_status
                FROM usrsiho.nmlohism_cons h1
                join usrsiho.nmloperi on per_keypro=h1.his_keypro AND per_keyper = h1.his_keyper
                join usrsiho.nmcoempl on h1.his_keyemp=emp_keyemp
                join usrsiho.holoagcp on agc_keyagr IN (11,12,13,14,15,45) AND h1.his_keycon=agc_keycon
                join usrsiho.glcopams g2 on g2.pam_keypar = 'H2' AND g2.pam_cvesec = per_nu3aux
                left join usrsiho.nmlodata on dat_keyemp=his_keyemp AND dat_keypar=27
                WHERE per_keypro = ps_proceso
                    AND EXTRACT(YEAR FROM per_fecpag) = ps_ejercicio
                    AND extract(month from per_fecpag) >= ps_MesIni AND extract(month from per_fecpag) <= ps_MesFin
                    AND substr(h1.his_ca1aux,1,3) in ('001','501')
                    AND agc_keyagr IN (11,12,13,15) AND h1.his_keynom not in (103,110)
                    AND SUBSTR(h1.HIS_CA1AUX,4,1) in ('1','3')
                    AND emp_keyemp Not In (SELECT cry_dec006
                                        FROM usrsiho.Glwkcrys
                                        WHERE cry_nomrep = 'SqlNOTIN'
                                        AND cry_keyusu = ps_keyusu)
                GROUP BY pam_cvesec, emp_keyemp , emp_regrfc , emp_recurp ,
                           emp_nomemp, emp_status,dat_valpar
                ORDER BY Curp) LOOP
                -- Area geografica / ClaveEntidad
                ------------------------------------------------------------
                ls_cvesec := rec4.pam_cvesec;
                ls_codempl := rec4.codigo;
                ls_rfc := rec4.RFC;
                ls_curp := rec4.CURP;
                --ls_paterno := rec4.Paterno;
                --ls_materno := rec4.Materno;
                --ls_nombres := rec4.Nombres;
                ls_paterno := sp_delimitador(rec4.emp_nomemp,'/',1);
                ls_materno := sp_delimitador(rec4.emp_nomemp,'/',2);
                ls_nombres := sp_delimitador(rec4.emp_nomemp,'/',3);
                li_calcanual := rec4.CALCULOANUAL;
                ld_ingasimasdos := rec4.IngAsimASdos;
                ld_isrretenido := rec4.ISRRetenido;
                ld_isrconftaranual := rec4.ISRCONFTARANUAL;
                ld_mtosubacred := rec4.MTOSUBACRED;
                ld_imptoingacum := rec4.IMPTOINGACUM;
                ls_empstatus := rec4.emp_status;
                BEGIN
                    SELECT case when pam_cvesec = 1 then 'A'
                        when pam_cvesec = 2 then 'B'
                        when pam_cvesec = 3 then 'C'
                    end AREAGEOSMG,
                    pam_folini claveEntidad
                    INTO ls_aregeos, ls_cveentidad
                    FROM usrsiho.glcopams
                    WHERE pam_keypar = 'AEN'
                    AND pam_folfin = ls_cvesec;
                    EXCEPTION WHEN no_data_found THEN ls_aregeos := ''; ls_cveentidad := '';
                END;
                ------------------------------------------------------------
                -- Obtiene el dato de mes inicial y final de recibos
                ------------------------------------------------------------
                BEGIN
                    SELECT MIN(EXTRACT(MONTH FROM rec_feccob)), MAX(EXTRACT(MONTH FROM rec_feccob))
                    INTO li_mesinirec, li_mesfinrec
                    FROM usrsiho.holoreci
                    WHERE rec_ejerci = ps_ejercicio
                    AND rec_keyemp = ls_codempl
                    AND rec_keypro = ps_proceso
                    AND rec_stsrec = 3;
                    EXCEPTION WHEN no_data_found THEN li_mesinirec := 0; li_mesfinrec := 0;
                END;
                -- Obtiene el mes min y max de regimen fiscal del empleado
                ------------------------------------------------------------
                BEGIN
                    SELECT MIN(EXTRACT(MONTH FROM his_fecmov)), MAX(EXTRACT(MONTH FROM his_fecmov))
                    INTO  li_mesinihis, li_mesfinhis
                    FROM usrsiho.nmlohism_cons, usrsiho.holoagcp
                    WHERE agc_keyagr IN (11,12,13,14,15,45)
                    AND his_keycon=agc_keycon
                    AND substr(his_ca1aux,1,3) in ('001','501')
                    AND his_keynom not in (103,110)
                    AND SUBSTR(HIS_CA1AUX,4,1) in ('1','3')
                    AND EXTRACT(YEAR FROM his_fecmov) = ps_ejercicio
                    AND his_keyemp = ls_codempl;
                    EXCEPTION WHEN no_data_found THEN li_mesinihis := 0; li_mesfinhis := 0;
                END;
                -- Compara el mes inicial y final de recibos y regimenfiscal para una validacion
                ------------------------------------------------------------
                IF li_mesinirec = li_mesinihis And li_mesfinrec = li_mesfinhis Then
                        li_MesIni := li_mesinirec;
                        li_MesFin := li_mesfinrec;
                ELSE
                    SELECT count(distinct substr(his_ca1aux,1,3))
                            INTO li_ContRegimen
                    FROM usrsiho.nmlohism_cons, usrsiho.holoagcp
                    WHERE agc_keyagr IN (11,12,13,14,15,45)
                            AND his_keycon=agc_keycon
                            AND his_keynom not in (103,110)
                            AND SUBSTR(HIS_CA1AUX,4,1) in ('1','3')
                            AND his_keyemp = ls_codempl;
                    IF li_ContRegimen > 1 Then
                        li_MesIni := li_mesinihis;
                        li_MesFin := li_mesfinhis;
                    ELSE
                        li_MesIni := li_mesinirec;
                        li_MesFin := li_mesfinrec;
                    END IF;
                END IF;
                -- Inserta en la tabla glwkcrys para tabla de paso y seguir en visual el proceso
                ------------------------------------------------------------
                INSERT INTO usrsiho.glwkcrys (cry_nomrep, cry_keyusu,
                                cry_chr001, cry_chr002, cry_dec006, cry_dec007, cry_chr003, cry_chr004, cry_chr005,
                                cry_chr006, cry_chr007, cry_chr008, cry_dec008, cry_dec009, cry_dec010,
                                cry_chr009, cry_chr040, cry_chr010, cry_chr011, cry_chr012,
                                cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_chr017, cry_chr018, cry_chr019, cry_chr020, cry_chr021,
                                cry_chr022, cry_chr023, cry_chr024, cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_dec011, cry_dec012,
                                cry_chr029, cry_chr030, cry_chr031, cry_chr032, cry_chr033, cry_chr034,
                                cry_dec013, cry_chr041, cry_chr035, cry_dec014, cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr042)
                        VALUES(ps_programa, ps_keyusu,
                                ls_cvesec, ls_codempl, li_MesIni, li_MesFin, ls_rfc, ls_curp, ls_paterno,
                                ls_materno, ls_nombres, ls_aregeos, li_calcanual, li_tarifautil, li_tarifa1991,
                                ls_propsub, li_sindicalizado, ls_siesasimsal, ls_cveentidad, ' ',
                                ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ls_vacio1, ls_vacio2, ls_vacio3,
                                ls_vacio4, ls_vacio5, ls_vacio6, ls_vacio7, ld_ingasimasdos, ld_isrretenido,
                                ls_vacio8, ls_vacio9, ls_vacio10, ls_vacio11, ls_vacio12, ls_vacio13,
                                ld_isrconftaranual, ld_mtosubacred, ls_vacio14, ld_imptoingacum, ls_vacio15,
                                ls_vacio16, ls_vacio17, ls_empstatus, ps_proceso);
                ------------------------------------------------------------
                commit;
            END LOOP;
        END IF;
   -- En Caso que se haya seleccionado consulta por codigos de las constancias
   --LIMITE DE BEGIN
    ELSE
        IF st_BanSqlNotIN = 0 THEN   -- CASO DE NO APLICAR FILTRO NOT IN - EMPLEADO (IMPRESION WORD)
           -- Genera un For de la consulta principal y hacer un insert del resultado
           FOR rec5  IN (SELECT pam_cvesec, emp_keyemp codigo, emp_regrfc RFC, emp_recurp CURP,
                            emp_nomemp,
                            DECODE(dat_valpar,'1','1','2') CALCULOANUAL,
                            SUM(DECODE(agc_keyagr,11,((his_import)*1),0)) IngAsimASdos,
                            SUM(DECODE(agc_keyagr,15,(his_import)*1,0)) ISRRetenido,
                            SUM(DECODE(agc_keyagr,15,((his_import)*1),0))  ISRCONFTARANUAL,
                            SUM(DECODE(agc_keyagr,79,((his_import)*1),0))  MTOSUBACRED,
                            SUM(DECODE(agc_keyagr,15,(his_import)*1,0)) IMPTOINGACUM, emp_status
                FROM usrsiho.nmlohism_cons h1
                join usrsiho.nmloperi on per_keypro=h1.his_keypro AND per_keyper = h1.his_keyper
                join usrsiho.nmcoempl on h1.his_keyemp=emp_keyemp
                join usrsiho.holoagcp on agc_keyagr IN (11,12,13,14,15,45) AND h1.his_keycon=agc_keycon
                join usrsiho.glcopams g2 on g2.pam_keypar = 'H2' AND g2.pam_cvesec = per_nu3aux
                left join usrsiho.nmlodata on dat_keyemp=his_keyemp AND dat_keypar=27
                WHERE per_keypro = ps_proceso
                    AND EXTRACT(YEAR FROM per_fecpag) = ps_ejercicio
                    AND extract(month from per_fecpag) >= ps_MesIni AND extract(month from per_fecpag) <= ps_MesFin
                    AND substr(h1.his_ca1aux,1,3) in ('001','501')
                    AND agc_keyagr IN (11,12,13,15) AND h1.his_keynom not in (103,110)
                    AND SUBSTR(h1.HIS_CA1AUX,4,1) in ('1','3')
                    AND emp_keyemp in (SELECT cry_dec007
                                        FROM usrsiho.Glwkcrys
                                        WHERE cry_nomrep = 'SqlEmpIN'
                                        AND cry_keyusu = ps_keyusu)
                GROUP BY pam_cvesec, emp_keyemp, emp_regrfc, emp_recurp,
                            emp_nomemp,emp_status,dat_valpar
                ORDER BY Curp) LOOP
                -- Area geografica / ClaveEntidad
                ------------------------------------------------------------
                ls_cvesec := rec5.pam_cvesec;
                ls_codempl := rec5.codigo;
                ls_rfc := rec5.RFC;
                ls_curp := rec5.CURP;
                --ls_paterno := rec5.Paterno;
                --ls_materno := rec5.Materno;
                --ls_nombres := rec5.Nombres;
                ls_paterno := sp_delimitador(rec5.emp_nomemp,'/',1);
                ls_materno := sp_delimitador(rec5.emp_nomemp,'/',2);
                ls_nombres := sp_delimitador(rec5.emp_nomemp,'/',3);
                li_calcanual := rec5.CALCULOANUAL;
                ld_ingasimasdos := rec5.IngAsimASdos;
                ld_isrretenido := rec5.ISRRetenido;
                ld_isrconftaranual := rec5.ISRCONFTARANUAL;
                ld_mtosubacred := rec5.MTOSUBACRED;
                ld_imptoingacum := rec5.IMPTOINGACUM;
                ls_empstatus := rec5.emp_status;
                BEGIN
                    SELECT case when pam_cvesec = 1 then 'A'
                            when pam_cvesec = 2 then 'B'
                            when pam_cvesec = 3 then 'C'
                            end AREAGEOSMG,
                            pam_folini claveEntidad
                    INTO ls_aregeos, ls_cveentidad
                    FROM usrsiho.glcopams
                    WHERE pam_keypar = 'AEN'
                    AND pam_folfin = ls_cvesec;
                    EXCEPTION WHEN no_data_found THEN ls_aregeos := ''; ls_cveentidad := '';
                END;
                ------------------------------------------------------------
                -- Obtiene el dato de mes inicial y final de recibos
                ------------------------------------------------------------
                BEGIN
                    SELECT MIN(EXTRACT(MONTH FROM rec_feccob)), MAX(EXTRACT(MONTH FROM rec_feccob))
                    INTO li_mesinirec, li_mesfinrec
                    FROM usrsiho.holoreci
                    WHERE rec_ejerci = ps_ejercicio
                    AND rec_keyemp = ls_codempl
                    AND rec_keypro = ps_proceso
                    AND rec_stsrec = 3;
                    EXCEPTION WHEN no_data_found THEN li_mesinirec := 0; li_mesfinrec := 0;
                END;
                -- Obtiene el mes min y max de regimen fiscal del empleado
                ------------------------------------------------------------
                BEGIN
                    SELECT MIN(EXTRACT(MONTH FROM his_fecmov)), MAX(EXTRACT(MONTH FROM his_fecmov))
                    INTO  li_mesinihis, li_mesfinhis
                    FROM usrsiho.nmlohism_cons, usrsiho.holoagcp
                    WHERE agc_keyagr IN (11,12,13,14,15,45)
                            AND his_keycon=agc_keycon
                            AND substr(his_ca1aux,1,3) in ('001','501')
                            AND his_keynom not in (103,110)
                            AND SUBSTR(HIS_CA1AUX,4,1) in ('1','3')
                            AND EXTRACT(YEAR FROM his_fecmov) = ps_ejercicio
                            AND his_keyemp = ls_codempl;
                    EXCEPTION WHEN no_data_found THEN li_mesinihis := 0; li_mesfinhis := 0;
                END;
                -- Compara el mes inicial y final de recibos y regimenfiscal para una validacion
                ------------------------------------------------------------
                IF li_mesinirec = li_mesinihis And li_mesfinrec = li_mesfinhis Then
                        li_MesIni := li_mesinirec;
                        li_MesFin := li_mesfinrec;
                ELSE
                        SELECT count(distinct substr(his_ca1aux,1,3))
                                INTO li_ContRegimen
                        FROM usrsiho.nmlohism_cons, usrsiho.holoagcp
                        WHERE agc_keyagr IN (11,12,13,14,15,45)
                                AND his_keycon=agc_keycon
                                AND his_keynom not in (103,110)
                                AND SUBSTR(HIS_CA1AUX,4,1) in ('1','3')
                                AND his_keyemp = ls_codempl;
                        IF li_ContRegimen > 1 Then
                            li_MesIni := li_mesinihis;
                            li_MesFin := li_mesfinhis;
                        ELSE
                            li_MesIni := li_mesinirec;
                            li_MesFin := li_mesfinrec;
                        END IF;
                END IF;
                -- Inserta en la tabla glwkcrys para tabla de paso y seguir en visual el proceso
                ------------------------------------------------------------
                INSERT INTO usrsiho.glwkcrys (cry_nomrep, cry_keyusu,
                                cry_chr001, cry_chr002, cry_dec006, cry_dec007, cry_chr003, cry_chr004, cry_chr005,
                                cry_chr006, cry_chr007, cry_chr008, cry_dec008, cry_dec009, cry_dec010,
                                cry_chr009, cry_chr040, cry_chr010, cry_chr011, cry_chr012,
                                cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_chr017, cry_chr018, cry_chr019, cry_chr020, cry_chr021,
                                cry_chr022, cry_chr023, cry_chr024, cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_dec011, cry_dec012,
                                cry_chr029, cry_chr030, cry_chr031, cry_chr032, cry_chr033, cry_chr034,
                                cry_dec013, cry_chr041, cry_chr035, cry_dec014, cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr042)
                        VALUES(ps_programa, ps_keyusu,
                                ls_cvesec, ls_codempl, li_MesIni, li_MesFin, ls_rfc, ls_curp, ls_paterno,
                                ls_materno, ls_nombres, ls_aregeos, li_calcanual, li_tarifautil, li_tarifa1991,
                                ls_propsub, li_sindicalizado, ls_siesasimsal, ls_cveentidad, ' ',
                                ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ls_vacio1, ls_vacio2, ls_vacio3,
                                ls_vacio4, ls_vacio5, ls_vacio6, ls_vacio7, ld_ingasimasdos, ld_isrretenido,
                                ls_vacio8, ls_vacio9, ls_vacio10, ls_vacio11, ls_vacio12, ls_vacio13,
                                ld_isrconftaranual, ld_mtosubacred, ls_vacio14, ld_imptoingacum, ls_vacio15,
                                ls_vacio16, ls_vacio17, ls_empstatus, ps_proceso);
                ------------------------------------------------------------
                commit;
            END LOOP;
        ELSE    --- CASO DE APLICAR FILTRO DE NOT IN - EMPLEADOS (IMPRESION WORD)
           -- Genera un For de la consulta principal y hacer un insert del resultado
            FOR rec6  IN (SELECT pam_cvesec, emp_keyemp codigo, emp_regrfc RFC, emp_recurp CURP,
                            emp_nomemp,
                            DECODE(dat_valpar,'1','1','2') CALCULOANUAL,
                            SUM(DECODE(agc_keyagr,11,((his_import)*1),0)) IngAsimASdos,
                            SUM(DECODE(agc_keyagr,15,(his_import)*1,0)) ISRRetenido,
                            SUM(DECODE(agc_keyagr,15,((his_import)*1),0))  ISRCONFTARANUAL,
                            SUM(DECODE(agc_keyagr,79,((his_import)*1),0))  MTOSUBACRED,
                            SUM(DECODE(agc_keyagr,15,(his_import)*1,0)) IMPTOINGACUM, emp_status
                FROM usrsiho.nmlohism_cons h1
                join usrsiho.nmloperi on per_keypro=h1.his_keypro AND per_keyper = h1.his_keyper
                join usrsiho.nmcoempl on h1.his_keyemp=emp_keyemp
                join usrsiho.holoagcp on agc_keyagr IN (11,12,13,14,15,45) AND h1.his_keycon=agc_keycon
                join usrsiho.glcopams g2 on g2.pam_keypar = 'H2' AND g2.pam_cvesec = per_nu3aux
                left join usrsiho.nmlodata on dat_keyemp=his_keyemp AND dat_keypar=27
                WHERE per_keypro = ps_proceso
                    AND EXTRACT(YEAR FROM per_fecpag) = ps_ejercicio
                    AND extract(month from per_fecpag) >= ps_MesIni AND extract(month from per_fecpag) <= ps_MesFin
                    AND substr(h1.his_ca1aux,1,3) in ('001','501')
                    AND agc_keyagr IN (11,12,13,15) AND h1.his_keynom not in (103,110)
                    AND SUBSTR(h1.HIS_CA1AUX,4,1) in ('1','3')
                    AND emp_keyemp IN (SELECT cry_dec007
                                        FROM usrsiho.Glwkcrys
                                        WHERE cry_nomrep = 'SqlEmpIN'
                                        AND cry_keyusu = ps_keyusu)
                    AND emp_keyemp Not In (SELECT cry_dec006
                                        FROM usrsiho.Glwkcrys
                                        WHERE cry_nomrep = 'SqlNOTIN'
                                        AND cry_keyusu = ps_keyusu)
                GROUP BY pam_cvesec, emp_keyemp, emp_regrfc, emp_recurp,
                            emp_nomemp, emp_status,dat_valpar
                ORDER BY Curp) LOOP
                -- Area geografica / ClaveEntidad
                ------------------------------------------------------------
                ls_cvesec := rec6.pam_cvesec;
                ls_codempl := rec6.codigo;
                ls_rfc := rec6.RFC;
                ls_curp := rec6.CURP;
                --ls_paterno := rec6.Paterno;
                --ls_materno := rec6.Materno;
                --ls_nombres := rec6.Nombres;
                ls_paterno := sp_delimitador(rec6.emp_nomemp,'/',1);
                ls_materno := sp_delimitador(rec6.emp_nomemp,'/',2);
                ls_nombres := sp_delimitador(rec6.emp_nomemp,'/',3);
                li_calcanual := rec6.CALCULOANUAL;
                ld_ingasimasdos := rec6.IngAsimASdos;
                ld_isrretenido := rec6.ISRRetenido;
                ld_isrconftaranual := rec6.ISRCONFTARANUAL;
                ld_mtosubacred := rec6.MTOSUBACRED;
                ld_imptoingacum := rec6.IMPTOINGACUM;
                ls_empstatus := rec6.emp_status;
                BEGIN
                    SELECT case when pam_cvesec = 1 then 'A'
                            when pam_cvesec = 2 then 'B'
                            when pam_cvesec = 3 then 'C'
                            end AREAGEOSMG,
                            pam_folini claveEntidad
                    INTO ls_aregeos, ls_cveentidad
                    FROM usrsiho.glcopams
                    WHERE pam_keypar = 'AEN'
                    AND pam_folfin = ls_cvesec;
                    EXCEPTION WHEN no_data_found THEN ls_aregeos := ''; ls_cveentidad := '';
                END;
                ------------------------------------------------------------
                -- Obtiene el dato de mes inicial y final de recibos
                ------------------------------------------------------------
                BEGIN
                    SELECT MIN(EXTRACT(MONTH FROM rec_feccob)), MAX(EXTRACT(MONTH FROM rec_feccob))
                            INTO li_mesinirec, li_mesfinrec
                    FROM usrsiho.holoreci
                    WHERE rec_ejerci = ps_ejercicio
                            AND rec_keyemp = ls_codempl
                            AND rec_keypro = ps_proceso
                            AND rec_stsrec = 3;
                    EXCEPTION WHEN no_data_found THEN li_mesinirec := 0; li_mesfinrec := 0;
                END;
                -- Obtiene el mes min y max de regimen fiscal del empleado
                ------------------------------------------------------------
                BEGIN
                    SELECT MIN(EXTRACT(MONTH FROM his_fecmov)), MAX(EXTRACT(MONTH FROM his_fecmov))
                    INTO  li_mesinihis, li_mesfinhis
                    FROM usrsiho.nmlohism_cons, usrsiho.holoagcp
                    WHERE agc_keyagr IN (11,12,13,14,15,45)
                    AND his_keycon=agc_keycon
                    AND substr(his_ca1aux,1,3) in ('001','501')
                    AND his_keynom not in (103,110)
                    AND SUBSTR(HIS_CA1AUX,4,1) in ('1','3')
                    AND EXTRACT(YEAR FROM his_fecmov) = ps_ejercicio
                    AND his_keyemp = ls_codempl;
                    EXCEPTION WHEN no_data_found THEN li_mesinihis := 0; li_mesfinhis := 0;
                END;
                -- Compara el mes inicial y final de recibos y regimenfiscal para una validacion
                ------------------------------------------------------------
                IF li_mesinirec = li_mesinihis And li_mesfinrec = li_mesfinhis Then
                        li_MesIni := li_mesinirec;
                        li_MesFin := li_mesfinrec;
                ELSE
                        SELECT count(distinct substr(his_ca1aux,1,3))
                                INTO li_ContRegimen
                        FROM usrsiho.nmlohism_cons, usrsiho.holoagcp
                        WHERE agc_keyagr IN (11,12,13,14,15,45)
                                AND his_keycon=agc_keycon
                                AND his_keynom not in (103,110)
                                AND SUBSTR(HIS_CA1AUX,4,1) in ('1','3')
                                AND his_keyemp = ls_codempl;
                        IF li_ContRegimen > 1 Then
                            li_MesIni := li_mesinihis;
                            li_MesFin := li_mesfinhis;
                        ELSE
                            li_MesIni := li_mesinirec;
                            li_MesFin := li_mesfinrec;
                        END IF;
                END IF;
                -- Inserta en la tabla glwkcrys para tabla de paso y seguir en visual el proceso
                ------------------------------------------------------------
                INSERT INTO usrsiho.glwkcrys (cry_nomrep, cry_keyusu,
                                cry_chr001, cry_chr002, cry_dec006, cry_dec007, cry_chr003, cry_chr004, cry_chr005,
                                cry_chr006, cry_chr007, cry_chr008, cry_dec008, cry_dec009, cry_dec010,
                                cry_chr009, cry_chr040, cry_chr010, cry_chr011, cry_chr012,
                                cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_chr017, cry_chr018, cry_chr019, cry_chr020, cry_chr021,
                                cry_chr022, cry_chr023, cry_chr024, cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_dec011, cry_dec012,
                                cry_chr029, cry_chr030, cry_chr031, cry_chr032, cry_chr033, cry_chr034,
                                cry_dec013, cry_chr041, cry_chr035, cry_dec014, cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr042)
                        VALUES(ps_programa, ps_keyusu,
                                ls_cvesec, ls_codempl, li_MesIni, li_MesFin, ls_rfc, ls_curp, ls_paterno,
                                ls_materno, ls_nombres, ls_aregeos, li_calcanual, li_tarifautil, li_tarifa1991,
                                ls_propsub, li_sindicalizado, ls_siesasimsal, ls_cveentidad, ' ',
                                ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ls_vacio1, ls_vacio2, ls_vacio3,
                                ls_vacio4, ls_vacio5, ls_vacio6, ls_vacio7, ld_ingasimasdos, ld_isrretenido,
                                ls_vacio8, ls_vacio9, ls_vacio10, ls_vacio11, ls_vacio12, ls_vacio13,
                                ld_isrconftaranual, ld_mtosubacred, ls_vacio14, ld_imptoingacum, ls_vacio15,
                                ls_vacio16, ls_vacio17, ls_empstatus, ps_proceso);
                ------------------------------------------------------------
                commit;
            END LOOP;
        END IF;
    END IF;
END IF;
END;
/
