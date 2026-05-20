CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HRPDESIN" (wn_usuario NUMBER,ws_terminal VARCHAR2,
                             wn_proceso NUMBER,ws_periodo VARCHAR2,
                             ws_numemi VARCHAR2,ws_keyapr VARCHAR2,
                             ws_tipfol VARCHAR2,wn_tipmon number,
                             wn_tipcam number,ws_IDprovi VARCHAR2) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	li_keypue NUMBER(10);li_keypue1 NUMBER(10);ln_keyrph NUMBER(10);lnn_keyrph NUMBER(10);ln_keyemp NUMBER(10);ln_numcap NUMBER(10);
	---Variables or Cesar gonzalez
	Li_Porcent NUMBER(10);
	Li_Keysec  VARCHAR2(16);
	Li_Keyemp  NUMBER(10);
	Ls_keyemp  VARCHAR2(16);
	Li_import  number(16,2);
	wi_keyrph NUMBER(10);
	ln_keynom NUMBER(10);
	ln_reg107 NUMBER(10);
	ws_numsec NUMBER(10);
	--termina cesar g
	ls_keycon VARCHAR2(3);
	ls_keydep VARCHAR2(16);
	ln_suma   NUMBER(15,2);
	ln_base_iva1 NUMBER(15,2);
	ln_base_iva2 NUMBER(15,2);
	ln_base_exenta1 NUMBER(15,2);
	ln_base_exenta2 NUMBER(15,2);
	ln_base_fomentos NUMBER(15,2);
	ld_fechasys DATE;
	ln_tipcam NUMBER(16,6);
	ls_diauno VARCHAR2(10);
	ls_diados VARCHAR2(10);
	li_keyagr NUMBER(10);
	ws_puesto holocont.con_keypue%TYPE;
	ws_pertra holocont.con_pertra%TYPE;
	ws_idioma holocont.con_idioma%TYPE;
	ws_nacion holocont.con_keynac%TYPE;
	wn_costot NUMBER(16,6);
	wn_numcap NUMBER(10);
	--Se insertaron estas definiciones para la validacion
	--de Uniformes Grabados y Transportes Grabados, ya que
	--antes estaba los conceptos por codigo duro.
	sUniforme       VARCHAR2(003);
	sTransporte     VARCHAR2(003);
	ls_tiptra       VARCHAR2(001);
	--- se agrego la variable incremento para darle un numero consecutivo al campo inc_diasei LJC 20/05/2008
	incremento NUMBER(10);
	ls_repeti VARCHAR2(003);    --Agrego JDCM 19/MZO/2010 Para validar tipo de Repeticion N, G, VP o GP
	li_Encontrado NUMBER(10);  --Agrego JCRO 20/MZO/2012 Para validar tipo de repeticion incluido como OPCI.
	ls_con_iva VARCHAR2(003);    --Agrego JDCM 06/JUL/2012 Para concepto de IVA nomina 113
	ls_con_rep VARCHAR2(003);    --Agrego JDCM 06/JUL/2012 Para concepto de Repeticion SET nomina 113
	ls_con_repCS VARCHAR2(003);    --Agrego JDCM 06/JUL/2012 Para concepto de Repeticion SET nomina 213
	ln_por_iva NUMBER(16,2); --Agrego JDCM 06/JUL/2012 Para Obtener Porcentaje de IVA
	ln_por_rep NUMBER(16,2); --Agrego JDCM 06/JUL/2012 Para Obtener Porcentaje de Repeticion SET
	ls_rph_retro VARCHAR2(12);    --Agrego JDCM 12/FEB/2014 Para Obtener identificar si es un RPH de RETROACTIVO
	ln_fom_tab_act NUMBER(10);   --Agrego JDCM 12/FEB/2014 Para Obtener fomento con tabulador actual
	ln_fom_tab_ant NUMBER(10);   --Agrego JDCM 12/FEB/2014 Para Obtener fomento con tabulador anterior
	ln_tabact NUMBER(16,2);  --Agrego JDCM 12/FEB/2014 Para Obtener Tabulador tabulador actual
	ln_tabant NUMBER(16,2);  --Agrego JDCM 12/FEB/2014 Para Obtener Tabulador tabulador anterior
	ln_tabpag NUMBER(16,2);  --Agrego JDCM 12/FEB/2014 Para Obtener Tabulador pagado de la Hoja Origen
	ld_fecgra DATE;           --Agrego JDCM 12/FEB/2014 Para Obtener Fecha Grabacion del RPH
	ln_keytab NUMBER(10);        --Agrego JDCM 12/FEB/2014 Para Obtener Clave de Tabulador registrado
	ln_pertra NUMBER(10);        --Agrego JDCM 12/FEB/2014 Para Obtener Periodo de Transmision para Ajustes
	ln_sihay NUMBER(10);
	valores VARCHAR2(40);
	valor VARCHAR2(40);
	posincad NUMBER(10);
	ls_perretro VARCHAR2(12);
	ln_sec_cry NUMBER(10);
	ln_rph_ant NUMBER(10);
	ld_ptjeretro NUMBER(9,6);
BEGIN
   li_Encontrado := 0;
   sUniforme:='';
   sTransporte:='';
   ls_tiptra:='';
   ls_perretro:='';
   begin
   SELECT pam_folini
    INTO ld_ptjeretro
    FROM USRSIHO.GLCOPAMS
    WHERE pam_keypar in (SELECT pam_folini
                        FROM USRSIHO.glcopams
                       WHERE pam_keypar='00'
                         AND pam_cvesec='loretr')
    AND PAM_NOMPAR LIKE '%PORCENTAJE%';
    exception
     when no_data_found then
        ld_ptjeretro := '';
     end;
   -- ELIMINADO DE INCIDENCIAS
   DELETE
   FROM USRSIHO.nmcoinci
   WHERE inc_keyper = ws_periodo AND
         inc_keypro = wn_proceso;
   -- REINICIALIZACION DE RPHS
   UPDATE USRSIHO.HOLOFRPH
   SET frp_stsfol = '0',
       frp_keyper = 0
   WHERE frp_keypro = wn_proceso
     AND frp_keyper = ws_periodo;
   -- LECTURA DE LA FECHA DE PAGO PARA LAS INCIDENCIAS
    begin
   SELECT per_fecpag,per_keynom,per_despol
   INTO ld_fechasys,ln_keynom,ls_perretro
   FROM USRSIHO.nmloperi
   WHERE per_keypro=wn_proceso
   AND per_keyper= ws_periodo;
    exception
     when no_data_found then
        ld_fechasys := '';
        ln_keynom := '';
        ls_perretro := '';
     end;
   -- LECTURA DE DATOS
   FOR rec IN (SELECT gdp.gdp_keyemp,gdp.gdp_keycon,gdp.gdp_keypue,
                  frp.frp_keydep,sum(gdp.gdp_cosuni*gdp.gdp_numcap) suma,
                  frp.frp_tipcam,pue_ca3aux
                     FROM   USRSIHO.hologdpr gdp,USRSIHO.glwkcrys cry,USRSIHO.holofrph frp,USRSIHO.nmcopues pue
           WHERE  frp.frp_keyrph = gdp.gdp_keYrph AND
                  gdp.gdp_keyrph = cry.cry_numsec AND
                  cry.cry_nomrep = 'HODESINC' AND
                  cry.cry_keyusu = wn_usuario AND
                  gdp.gdp_keypue = pue.pue_keypue AND
                  cry.cry_idepcc = ws_terminal AND
                  frp.frp_stsfol <> 2 AND
                  gdp.gdp_cosuni >= 0.01
           GROUP BY gdp.gdp_keyemp,gdp.gdp_keycon,gdp.gdp_keypue,
                    frp.frp_keydep,frp.frp_tipcam,pue_ca3aux) LOOP
----lINEAS ADICIONADAS EL DIA 13/08/2001  CESAR GONZALEZ SANCHEZ
            ln_keyemp := rec.gdp_keyemp;
            ls_keycon := rec.gdp_keycon;
            li_keypue := rec.gdp_keypue;
            ls_keydep := rec.frp_keydep;
            ln_suma := rec.suma;
            ln_tipcam := rec.frp_tipcam;
            ls_diauno := rec.pue_ca3aux;
            Li_Keyemp := 0;
---aedo 04/07/2007 se agrego la lectura del importe
            begin
                SELECT  cus_keyemp,nvl(cus_porcen,0),cus_keysec,nvl(cus_import,0)
                INTO    Li_Keyemp,Li_Porcent,Li_Keysec,Li_import
                FROM    USRSIHO.holocusi
                WHERE   cus_keyemp = ln_keyemp
                AND     cus_keypue = li_keypue
                AND     cus_keycen = ls_keydep;
             exception
              when no_data_found then
                Li_Keyemp := '';
             end;
            --- INSERCCION POR CADA REGISTRO OBTENIDO
            IF  Li_Keyemp IS NULL THEN
                INSERT INTO
                    USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
                             inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
                              VALUES(wn_proceso,ws_periodo,ln_keyemp,ls_keycon,ls_keydep,
                     li_keypue,ln_suma,ld_fechasys,ln_tipcam,to_number(rtrim(ls_diauno)));
            ELSE
                ----Obtiene datos de la tabla holocusi y los inserta en la tabla
                ----aedo  04/07/2007 se agrego la siguiente validacion para mandar
                ----                 el importe o el porcentaje
                if Li_import > 0 then
                  Ls_Diados := Li_import;   ----Importe
                else
                  Ls_Diados := Li_Porcent;  ----Porcentaje
                end if;
                   ---LET ln_keyemp = Li_Keyemp;  ----Clave de empleado
                ls_diauno := Li_Keysec;  ----Clave de seccion
                ---LET Ls_Diados = Li_Porcent;  ----Porcentaje
                INSERT INTO USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
                                inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno,inc_diados)
                VALUES(wn_proceso,ws_periodo,ln_keyemp,ls_keycon,ls_keydep,li_keypue,ln_suma,
                                       ld_fechasys,ln_tipcam,to_number(rtrim(ls_diauno)),to_number(rtrim(Ls_Diados)));
            END IF;
----------TERMINA C.G.S
----           INSERT INTO nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
----                            inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
----          VALUES(wn_proceso,ws_periodo,ln_keyemp,ls_keycon,ls_keydep,li_keypue,ln_suma,ld_fechasys,ln_tipcam,ls_diauno);
           --ACTUALIZACIO DEL AREA DE PRODUCCION Y DEL PERIODO EN NMLOPERI
           UPDATE USRSIHO.nmloperi
           SET per_nu3aux = ws_keyapr,
               per_nu4aux = ws_numemi,
               per_nu5aux = ws_tipfol,
               per_nu1aux = wn_tipcam,
               per_nu2aux = wn_tipmon
               --per_keypol = ws_IDprovi
           WHERE per_keyper = ws_periodo
             AND per_keypro = wn_proceso;
   END LOOP;
   --PARA FRP.FRP_UNIFOR > 0
   FOR rec2
    IN (SELECT gdp.gdp_keyemp,gdp.gdp_keypue,
           frp.frp_keydep,SUM(frp_unifor) suma,
           frp.frp_tipcam,pue.pue_ca3aux,frp.frp_tiptra
           FROM USRSIHO.hologdpr gdp,USRSIHO.glwkcrys cry,USRSIHO.holofrph frp,USRSIHO.nmcopues pue
     WHERE frp.frp_keyrph = gdp.gdp_keyrph AND
           gdp.gdp_keyrph = cry.cry_numsec AND
           cry.cry_nomrep = 'HODESINC' AND
           cry.cry_keyusu = wn_usuario AND
           frp.frp_unifor > 0 AND
           gdp.gdp_keypue = pue.pue_keypue AND
           substr(pue_ca4aux,6, 1) = '1' AND --SOLO LOSQUE TENGAN ACTIVIADO CAMPO D UNIFORME
           cry.cry_idepcc = ws_terminal AND
           frp.frp_stsfol <> 2 AND
           gdp.gdp_cosuni >= 0.01
  GROUP BY gdp.gdp_keyemp,gdp.gdp_keypue,
           frp.frp_keydep,frp.frp_tipcam,
           pue.pue_ca3aux,frp.frp_tiptra) LOOP
           --Asigno variable Transporte
           ln_keyemp := rec2.gdp_keyemp;
           li_keypue := rec2.gdp_keypue;
           ls_keydep := rec2.frp_keydep;
           ln_suma := rec2.suma;
           ln_tipcam := rec2.frp_tipcam;
           ls_diauno := rec2.pue_ca3aux;
           ls_tiptra := rec2.frp_tiptra;
           sUniforme:='H09';
           -- Si trae una G el valor debe de ser 'HE9', Transportes
           IF ls_tiptra='G' THEN
             sUniforme:='HE9';
           END IF;
           ls_tiptra:='';
           -- INSERCCION POR CADA REGISTRO OBTENIDO
           INSERT INTO USRSIHO.nmcoinci(
              inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
              inc_keypue,inc_import,inc_cantid,inc_fecmov,inc_diauno)
           VALUES(
              wn_proceso,ws_periodo,ln_keyemp,sUniforme,ls_keydep,
              li_keypue,ln_suma,ln_tipcam,ld_fechasys,to_number(trim(ls_diauno)));
   END LOOP;
   --PARA FRP.FRP_TRANSP > 0
   FOR rec3
     IN (SELECT gdp.gdp_keyemp,gdp.gdp_keypue,
            frp.frp_keydep,sum(frp_transp) suma,
            frp.frp_tipcam,pue.pue_ca3aux,
            pue.pue_nu4aux,frp.frp_tiptra
             FROM USRSIHO.hologdpr gdp,USRSIHO.glwkcrys cry,USRSIHO.holofrph frp,USRSIHO.nmcopues pue
      WHERE frp.frp_keyrph=gdp.gdp_keyrph AND
            gdp.gdp_keyrph=cry.cry_numsec AND
            cry.cry_nomrep='HODESINC' AND
            cry.cry_keyusu=wn_usuario AND
            frp.frp_transp > 0 AND
            gdp.gdp_keypue=pue.pue_keypue AND
            substr(pue_ca4aux,5, 1)='1' AND --SOLO LOS QUE TENGAN ACTIVIADO CAMPO TRANSP.
            cry.cry_idepcc=ws_terminal AND
            gdp.gdp_cosuni >= 0.01
   GROUP BY gdp.gdp_keyemp,gdp.gdp_keypue,
            frp.frp_keydep,frp.frp_tipcam,
            PUE.pue_ca3aux,pue.pue_nu4aux
            ,frp.frp_tiptra) LOOP
           --Asigno variable Transporte
           ln_keyemp := rec3.gdp_keyemp;
           li_keypue := rec3.gdp_keypue;
           ls_keydep := rec3.frp_keydep;
           ln_suma := rec3.suma;
           ln_tipcam := rec3.frp_tipcam;
           ls_diauno := rec3.pue_ca3aux;
           ls_diados := rec3.pue_nu4aux;
           ls_tiptra := rec3.frp_tiptra;
           sTransporte:='H08';
           -- Si trae una G el valor debe de ser 'HE8', Transportes
           IF ls_tiptra='G' THEN
             sTransporte:='HE8';
           END IF;
           -- INSERCCION POR CADA REGISTRO OBTENIDO
           INSERT INTO USRSIHO.nmcoinci(
                  inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
                  inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,
                  inc_diados)
           VALUES
                 (wn_proceso,ws_periodo,ln_keyemp,sTransporte,ls_keydep,
                  li_keypue,ln_suma,ln_tipcam,ld_fechasys,to_number(trim(ls_diauno)),
                  to_number(trim(ls_diados)));
   END LOOP;
   --PARA PRESTACIONES DE MUSICOS
   FOR rec4 IN (SELECT gdp.gdp_keyrph,gdp.gdp_keyemp,gdp.gdp_keypue,
                  frp.frp_keydep,sum(gdp_cosuni*gdp_numcap) suma,
                  frp.frp_tipcam,agc_keyagr,frp_repeti
           FROM USRSIHO.hologdpr gdp,USRSIHO.glwkcrys cry,USRSIHO.holofrph frp,USRSIHO.holoagcp
           WHERE frp.frp_keyrph=gdp.gdp_keyrph AND
                 gdp.gdp_keyrph=cry.cry_numsec AND
                 cry.cry_nomrep='HODESINC' AND
                 cry.cry_keyusu=wn_usuario AND
                 gdp_keycon = agc_keycon AND
                 agc_keyagr IN (19,20) AND
                 cry.cry_idepcc=ws_terminal AND
                 frp.frp_stsfol<>2 AND
                 gdp.gdp_cosuni >= 0.01
           GROUP BY gdp.gdp_keyrph,gdp.gdp_keyemp,gdp.gdp_keypue,
                 frp.frp_keydep,frp.frp_tipcam,agc_keyagr,frp_repeti) LOOP
           -- INSERCCION POR CADA REGISTRO OBTENIDO
           ln_keyrph := rec4.gdp_keyrph;
           ln_keyemp := rec4.gdp_keyemp;
           li_keypue := rec4.gdp_keypue;
           ls_keydep := rec4.frp_keydep;
           ln_suma := rec4.suma;
           ln_tipcam := rec4.frp_tipcam;
           li_keyagr := rec4.agc_keyagr;
           ls_repeti := rec4.frp_repeti;
           IF li_keyagr = 19 THEN
                 INSERT INTO USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
                                      inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
                 VALUES(wn_proceso,ws_periodo,ln_keyemp,'H10',ls_keydep,li_keypue,ln_suma,ln_tipcam,ld_fechasys,
                        NULL,NULL);
                 INSERT INTO USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
                                      inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
                 VALUES(wn_proceso,ws_periodo,ln_keyemp,'H07',ls_keydep,li_keypue,ln_suma,ln_tipcam,ld_fechasys,
                        NULL,NULL);
           ELSE
                  INSERT INTO USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
                                       inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
                  VALUES(wn_proceso,ws_periodo,ln_keyemp,'HE6',ls_keydep,li_keypue,ln_suma,ln_tipcam,ld_fechasys,
                         NULL,NULL);
                  INSERT INTO USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
                                       inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
                  VALUES(wn_proceso,ws_periodo,ln_keyemp,'HE7',ls_keydep,li_keypue,ln_suma,ln_tipcam,ld_fechasys,
                         NULL,NULL);
           END IF;
--INSERT INTO paso VALUES('sp_hrpdesin','li_Encontrado',li_Encontrado,0,'','');
-- JCRO 20/MZO/2012 Para validar tipo de repeticion incluido como OPCI
           begin
           SELECT nvl(pam_folfin,0)
             INTO li_Encontrado
             FROM USRSIHO.glcopams
            WHERE pam_keypar IN
                  (SELECT pam_folini
                     FROM USRSIHO.glcopams
                    WHERE pam_cvesec = 'pdesin')
              AND pam_cvesec = 'OPCI12'
              AND pam_folini = ls_repeti;
            EXCEPTION WHEN NO_DATA_FOUND then
                li_Encontrado := '';
            end;
--INSERT INTO paso VALUES('sp_hrpdesin','ls_repeti',ls_repeti,0,'','');
--INSERT INTO paso VALUES('sp_hrpdesin','li_Encontrado',li_Encontrado,0,'','');
--           IF ls_repeti = 'VP' OR ls_repeti = 'GP' THEN
-- JCRO 20/MZO/2012 Para validar tipo de repeticion incluido como OPCI
           IF li_Encontrado > 0 THEN
              INSERT INTO USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
                                     inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados,inc_diacin)
              VALUES(wn_proceso,ws_periodo,ln_keyemp,'H20',ls_keydep,li_keypue,ln_suma,ln_tipcam,ld_fechasys,
                       NULL,NULL,li_Encontrado);
           ELSE
              INSERT INTO USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
                                     inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
              VALUES(wn_proceso,ws_periodo,ln_keyemp,'H20',ls_keydep,li_keypue,ln_suma,ln_tipcam,ld_fechasys,
                       NULL,NULL);
             END IF;
           INSERT INTO USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
                                  inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
         --  VALUES(wn_proceso,ws_periodo,ln_keyemp,'H04',ls_keydep,li_keypue,ln_suma,ln_keyrph,ld_fechasys,
--                  NULL,NULL);
             VALUES(wn_proceso,ws_periodo,ln_keyemp,'H4D',ls_keydep,li_keypue,ln_suma,ln_keyrph,ld_fechasys,
                    NULL,NULL);
            INSERT INTO USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
                       inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
         VALUES(wn_proceso,ws_periodo,ln_keyemp,'H4R',ls_keydep,li_keypue,ln_suma,ln_keyrph,ld_fechasys,
                NULL,NULL);
   END LOOP;
   -- CALCULO DE PREVISISN SOCIAL DE ANDA E INSERCISN DE LAS INCIDENCIAS
   FOR rec5 IN (SELECT gdp.gdp_keyemp,gdp.gdp_keypue,
                  frp.frp_keydep,sum(gdp_cosuni * gdp_numcap * 0.18) suma,
                  frp.frp_tipcam,frp_repeti
           FROM USRSIHO.hologdpr gdp,USRSIHO.glwkcrys cry,USRSIHO.holofrph frp,USRSIHO.nmcopues
           WHERE frp.frp_keyrph=gdp.gdp_keyrph AND
                 gdp.gdp_keyrph=cry.cry_numsec AND
                 cry.cry_nomrep='HODESINC' AND
                 cry.cry_keyusu=wn_usuario AND
                 pue_keypue = gdp_keypue AND
                 substr(pue_ca4aux,2, 1) = '1' AND
                 cry.cry_idepcc=ws_terminal AND
                 gdp.gdp_cosuni >= 0.01
            GROUP BY gdp.gdp_keyemp,gdp.gdp_keypue,frp.frp_keydep,frp.frp_tipcam,frp_repeti) LOOP
-- JCRO 20/MZO/2012 Para validar tipo de repeticion incluido como OPCI
--INSERT INTO paso VALUES('sp_hrpdesin','li_Encontrado',li_Encontrado,0,'','');
           ln_keyemp := rec5.gdp_keyemp;
           li_keypue := rec5.gdp_keypue;
           ls_keydep := rec5.frp_keydep;
           ln_suma := rec5.suma;
           ln_tipcam := rec5.frp_tipcam;
           ls_repeti := rec5.frp_repeti;
          BEGIN
            SELECT COUNT(*)
             INTO li_Encontrado
             FROM USRSIHO.glcopams
            WHERE pam_keypar IN
                  (SELECT pam_folini
                     FROM USRSIHO.glcopams
                    WHERE pam_cvesec = 'pdesin'
                  )
              AND pam_cvesec = 'OPCI12'
              AND pam_folini = ls_repeti;
               EXCEPTION WHEN NO_DATA_FOUND then
                li_Encontrado :='';
            end;
-- JCRO 20/MZO/2012 Para validar tipo de repeticion incluido como OPCI
           -- INSERCION DE LA PREVISISN SOCIAL POR CADA REGISTRO OBTENIDO
--           IF ls_repeti = 'VP' OR ls_repeti = 'GP' THEN     --se usa campo inc_diacin para validar en formula
--INSERT INTO paso VALUES('sp_hrpdesin','li_Encontrado',li_Encontrado,1,'','');
           IF li_Encontrado > 0 THEN
              INSERT INTO USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
                       inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados,inc_diacin)
              VALUES(wn_proceso,ws_periodo,ln_keyemp,'H20',ls_keydep,
                       li_keypue,ln_suma,ln_tipcam,ld_fechasys,NULL,NULL,1);
           ELSE
              INSERT INTO USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
                       inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
              VALUES(wn_proceso,ws_periodo,ln_keyemp,'H20',ls_keydep,
                       li_keypue,ln_suma,ln_tipcam,ld_fechasys,NULL,NULL);
           END IF;
   END LOOP;
   -- CALCULO DE FOMENTOS DE ANDA E INSERCION DE LAS INCIDENCIAS
   incremento := 1;
   ln_sec_cry := 0;
   FOR rec6 IN (SELECT gdp.gdp_keyemp,pue_ca2aux,pue_ca3aux,
                  frp.frp_keydep,frp.frp_tipcam,
                  gdp_keypue,con_pertra,con_idioma,con_keynac,
                  gdp_cosuni,gdp_numcap,
                  gdp.gdp_keyrph, cry.cry_numsec,frp.frp_fecitr
                     FROM USRSIHO.hologdpr gdp
                join glwkcrys cry on cry.cry_nomrep = 'HODESINC' AND cry.cry_keyusu = wn_usuario and gdp.gdp_keyrph = cry.cry_numsec
                join holofrph frp on frp.frp_keyrph = gdp.gdp_keyrph
                join nmcopues on pue_keypue = gdp_keypue and substr(pue_ca4aux,1, 1) = '1'
                left join USRSIHO.holocont on  gdp_keyfol = con_keyfol AND gdp_keytco = con_keytco
           WHERE  cry.cry_idepcc = ws_terminal
             AND frp.frp_stsfol <> 2
             AND gdp.gdp_cosuni >= 0.01
           ORDER BY gdp_keyrph,gdp_keyemp,gdp_keypue) LOOP
           -- Calculo de fomentos a la cultura y eficiencia
           -- Duracisn     Tabu  Factor Fomento Activ Idi - Nac
           -- 30 minutos   514   0.0312 16.0368 1000  EM
           -- 15 minutos   178   0.0312  5.5536 1004  EM
           -- 30 minutos   1441  0.0306 44.0946 1009  EE
           -- 30 minutos   1103  0.0312 34.4136 1006  OM-OE
           -- 150 minutos  3082  0.0302 93.0764 1003  OM-OE
           ln_keyemp := rec6.gdp_keyemp;
           li_keypue := rec6.pue_ca2aux;
           li_keypue1 := rec6.pue_ca3aux;
           ls_keydep := rec6.frp_keydep;
           ln_tipcam := rec6.frp_tipcam;
           ws_puesto := rec6.gdp_keypue;
           ws_pertra := rec6.con_pertra;
           ws_idioma := rec6.con_idioma;
           ws_nacion := rec6.con_keynac;
           wn_costot := rec6.gdp_cosuni;
           wn_numcap := rec6.gdp_numcap;
           wi_keyrph := rec6.gdp_keyrph;
           ws_numsec := rec6.cry_numsec;
           ld_fecgra := rec6.frp_fecitr;
           ln_sec_cry := ln_sec_cry + 1;
           --INSERT INTO glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) VALUES ('RETRO',ln_sec_cry,wi_keyrph,'0 INICIO',ws_puesto,ln_keyemp);
           ln_suma := NULL;
           ls_rph_retro := '';
           ln_fom_tab_act := 0;
           ln_fom_tab_ant := 0;
           ln_keytab := 0;
           ln_sihay := 0;
           IF TRIM(ws_puesto) = '1000' AND
              TRIM(ws_pertra) = '30'   AND
              TRIM(ws_idioma) = 'E'    AND
              TRIM(ws_nacion) = 'M'    THEN
              ln_suma := ROUND(wn_costot * 0.0300) * wn_numcap;
           ELSIF TRIM(ws_puesto) = '1004'   AND
                TRIM(ws_pertra) = '15'   AND
                TRIM(ws_idioma) = 'E'    AND
                TRIM(ws_nacion) = 'M'    THEN
              ln_suma := ROUND(wn_costot * 0.0300) * wn_numcap;
           ELSIF TRIM(ws_puesto) = '1009' AND
                TRIM(ws_pertra) = '30'   AND
                TRIM(ws_idioma) = 'E'    AND
                TRIM(ws_nacion) = 'E'    THEN
              ln_suma := ROUND(wn_costot * 0.0300) * wn_numcap;
            ELSIF TRIM(ws_puesto) = '1006' AND
                 TRIM(ws_pertra) = '30'   AND
               ((TRIM(ws_idioma) = 'O' AND TRIM(ws_nacion) = 'M') OR
                (TRIM(ws_idioma) = 'O' AND TRIM(ws_nacion) = 'E')) THEN
               ln_suma := ROUND(wn_costot * 0.0300) * wn_numcap;
            ELSIF TRIM(ws_puesto) = '1003' AND
                 TRIM(ws_pertra) = '150'  AND
               ((TRIM(ws_idioma) = 'O' AND TRIM(ws_nacion) = 'M') OR
                (TRIM(ws_idioma) = 'O' AND TRIM(ws_nacion) = 'E')) THEN
               ln_suma := ROUND(wn_costot * 0.0300) * wn_numcap;
           ELSE
               ln_suma := ROUND(wn_costot * 0.0300) * wn_numcap;
           END IF;
           IF ln_suma >= 1 THEN
---AEDO 22/02/2008 se agrego a los insert de los conceptos HF1 y HF2, los valores del RPH, Numero de Secuencia
         --**********BUSCA si Es un RPH de ********** RETROACTIVO ***********  JDCM
         IF (ln_keynom = 110 OR ln_keynom = 210) AND ls_perretro='RETROACTIVO' THEN
             --INSERT INTO glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) VALUES ('RETRO',ln_sec_cry,wi_keyrph,'01',ws_puesto,ln_keyemp);
             begin
              SELECT substr(enc_descap,1,11)
                INTO ls_rph_retro
                FROM USRSIHO.holoenctra
               WHERE enc_num_id IN(SELECT DISTINCT det_num_id
                                     FROM USRSIHO.holodettra
                                    WHERE det_keyrph=wi_keyrph);
                 EXCEPTION WHEN NO_DATA_FOUND then
                ls_rph_retro := '';
            end;
              IF ls_rph_retro = 'RETROACTIVO' THEN
                 IF ws_pertra IS NULL OR ws_pertra=' ' THEN
                    ln_keytab := 5;
           --INSERT INTO glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) VALUES ('RETRO',ln_sec_cry,wi_keyrph,'02',ws_puesto,ln_keyemp);
                    begin
                    SELECT ald_pertra,ald_idioma,'M'
                      INTO ws_pertra,ws_idioma,ws_nacion
                      FROM USRSIHO.nmloalde
                     WHERE ald_keydep=ls_keydep;
                    EXCEPTION WHEN NO_DATA_FOUND then
                        ws_pertra := '';
                        ws_idioma := '';
                        ws_nacion := '';
                    end;
           --INSERT INTO glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) VALUES ('RETRO',ln_sec_cry,wi_keyrph,'03',ws_puesto,ln_keyemp);
                     begin
                     SELECT nvl(to_number(substr(det_auxca2,12,3)),0)
                       INTO ln_pertra
                       FROM USRSIHO.holodettra
                      WHERE det_num_id=(SELECT DISTINCT det_num_id
                                          FROM USRSIHO.holodettra
                                         WHERE det_keyrph=wi_keyrph)
                        AND det_keyemp=ln_keyemp
                        AND det_keypue=ws_puesto
                        AND det_stsreg='V';
                         EXCEPTION WHEN NO_DATA_FOUND then
                            ln_pertra := 0;
                        end;
                     IF ln_pertra = 0 THEN
                         ln_pertra := ws_pertra;
                     END IF;
                 ELSE
                    ln_keytab := 1;
                    ln_pertra := ws_pertra;
                 END IF;
           --INSERT INTO glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) VALUES ('RETRO',ln_sec_cry,wi_keyrph,'04',ws_puesto,ln_keyemp);
                  --Tabulador ACTUAL
                  begin
                  SELECT (ROUND(MAX(tab_import) * 0.0300) * wn_numcap),MAX(tab_import)
                    INTO ln_fom_tab_act,ln_tabact
                    FROM USRSIHO.holotabs
                   WHERE tab_keypro=138
                     AND tab_keytab=ln_keytab
                     AND tab_keypue=ws_puesto
                     --AND tab_pertra=ws_pertra
                     AND to_number(tab_pertra)<=ln_pertra
                     AND tab_idioma=ws_idioma
                     AND tab_keynac=ws_nacion
                     AND EXTRACT(YEAR FROM tab_fecfin) = EXTRACT(YEAR FROM ld_fecgra)+1;
                  EXCEPTION WHEN NO_DATA_FOUND then
                        ln_fom_tab_act := 0;
                        ln_tabact := 0;
                 end;
           --INSERT INTO glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) VALUES ('RETRO',ln_sec_cry,wi_keyrph,'05',ws_puesto,ln_keyemp);
                  --Tabulador Anterior
                 begin
                  SELECT (ROUND(MAX(tab_import) * 0.0300) * wn_numcap),MAX(tab_import)
                    INTO ln_fom_tab_ant,ln_tabant
                    FROM USRSIHO.holotabs
                   WHERE tab_keypro=138
                     AND tab_keytab=ln_keytab
                     AND tab_keypue=ws_puesto
                     --AND tab_pertra=ws_pertra
                     AND to_number(tab_pertra)<=ln_pertra
                     AND tab_idioma=ws_idioma
                     AND tab_keynac=ws_nacion
                     AND EXTRACT(YEAR FROM tab_fecfin) = EXTRACT(YEAR FROM ld_fecgra);
                      EXCEPTION WHEN NO_DATA_FOUND then
                        ln_fom_tab_ant := 0;
                        ln_tabant := 0;
                 end;
                  IF ln_fom_tab_act>0 AND ln_fom_tab_ant>0 THEN
           --INSERT INTO glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) VALUES ('RETRO',ln_sec_cry,wi_keyrph,'06',ws_puesto,ln_keyemp);
                    begin
                      SELECT COUNT(*)
                        INTO ln_sihay
                        FROM USRSIHO.holotabs
                        WHERE tab_keypro=138
                          AND tab_keytab=5
                          AND tab_keypue=ws_puesto;
                    EXCEPTION WHEN NO_DATA_FOUND then
                        ln_sihay := 0;
                    end;
                      IF ln_sihay > 0 THEN
           --INSERT INTO glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) VALUES ('RETRO',ln_sec_cry,wi_keyrph,'07',ws_puesto,ln_keyemp);
                          begin
                          SELECT nvl(det_cosuni,0)
                            INTO ln_tabpag
                            FROM USRSIHO.holodettra
                           WHERE det_num_id=(SELECT substr(enc_descap,24,5)
                                               FROM USRSIHO.holoenctra
                                              WHERE enc_num_id IN(SELECT DISTINCT det_num_id
                                                                    FROM USRSIHO.holodettra
                                                                   WHERE det_keyrph=wi_keyrph
                                                                     AND det_keyemp=ln_keyemp
                                                                     AND det_stsreg='V'))
                             AND det_keyemp=ln_keyemp
                             AND det_keypue=ws_puesto
                             AND det_stsreg='V';
                              EXCEPTION WHEN NO_DATA_FOUND then
                                ln_tabpag := 0;
                            end;
                          IF ln_tabpag=ln_tabant THEN
                             ln_suma := ln_fom_tab_act - ln_fom_tab_ant;
                          ELSE
                             ln_suma := ROUND(wn_costot * 0.0300) * wn_numcap;
                          END IF;
                      ELSE
                         ln_suma := ln_fom_tab_act - ln_fom_tab_ant;
                      END IF;
                  ELSE
                     --Para las actividades que no tienen tabulador, calcular la diferencia del fomento con el costo anterior
                     -- y el fomento con el costo nuevo
                     --Obtener el RPH Anterior
                     begin
                     SELECT DISTINCT det_keyrph  --RPH anterior
                       INTO ln_rph_ant
                       FROM USRSIHO.holodettra
                       WHERE det_num_id=(SELECT to_number(substr(enc_descap,23,8))  --HT anterior
                                           FROM USRSIHO.HOLOENCTRA
                                           WHERE enc_num_id=(SELECT DISTINCT det_num_id
                                                              FROM USRSIHO.holodettra
                                                              WHERE det_keyrph = wi_keyrph
                                                                AND det_keyemp = ln_keyemp
                                                             )
                                         )  --HT Neva
                          AND det_keyemp = ln_keyemp
                          AND det_stsreg='V';
                   EXCEPTION WHEN NO_DATA_FOUND then
                        ln_rph_ant := 0;
                    end;
                      --Del RPH anterior obtener el costo
                     begin
                      SELECT MAX(hgd_costog)
                        INTO wn_costot
                        FROM USRSIHO.holohgdp
                        WHERE hgd_keyrph = ln_rph_ant
                          AND hgd_keyemp = ln_keyemp
                          AND hgd_keypue = ws_puesto;
                    EXCEPTION WHEN NO_DATA_FOUND then
                        wn_costot := 0;
                    end;
                      ln_fom_tab_ant := ROUND(wn_costot * 0.0300) * wn_numcap;
                      ln_fom_tab_act := ROUND(wn_costot * (1 + (ld_ptjeretro / 100)) * 0.03) * wn_numcap;
                      ln_suma := ln_fom_tab_act - ln_fom_tab_ant;
                  END IF;
              END IF;
         END IF;   --Solo Retroactivo
 		 --**********TERMINA Busca si Es un RPH de ********** RETROACTIVO ***********   JDCM
		 --INSERT INTO glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006,cry_dec007) VALUES ('RETRO_FOM',ln_sec_cry,wi_keyrph,'07',ws_puesto,ln_keyemp,ln_suma);
		 -- ELJM 16.03.2021 Se quita HF1 y HF2 para la nomina 109
		 IF ln_keynom <> 109 THEN
			-- INSERCION DE LOS FOMENTOS POR CADA REGISTRO OBTENIDO
			INSERT INTO USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
								inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados,
								INC_NUMFOL,INC_KEYINC,INC_DIASIE,inc_diasei)
			VALUES(wn_proceso,ws_periodo,ln_keyemp,'HF1',ls_keydep,
					li_keypue,ln_suma,ln_tipcam,ld_fechasys,NULL,NULL,
					wi_keyrph,ws_numsec,wn_costot,incremento);
			incremento:= incremento + 1;
			INSERT INTO USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
								inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados,
								INC_NUMFOL,INC_KEYINC,INC_DIASIE,inc_diasei)
			VALUES(wn_proceso,ws_periodo,ln_keyemp,'HF2',ls_keydep,li_keypue1,ln_suma,ln_tipcam,ld_fechasys,
					NULL,NULL,
					wi_keyrph,ws_numsec,wn_costot,incremento);
			incremento:= incremento + 1;
         END IF;
      END IF;
   END LOOP;
--*********************NOMINAS  113 Y 213 ***********************
-------calculo codigo eje
--JDCM Se Obtiene la Nomina
begin
SELECT per_keynom
  INTO ln_keynom
  FROM USRSIHO.nmloperi
 WHERE per_keypro=wn_proceso
   AND per_keyper=ws_periodo;
EXCEPTION WHEN NO_DATA_FOUND then
ln_keynom := 0;
end;
--JDCM Termina se obtiene la Nomina
-- JDCM Obtiene el porcentaje de IVA
begin
SELECT nvl(to_number(pam_folini),0)
  INTO ln_por_iva
  FROM USRSIHO.glcopams
 WHERE pam_keypar IN
                (SELECT pam_folini
                   FROM USRSIHO.glcopams
                  WHERE pam_cvesec = 'pdesin')
   AND pam_cvesec = 'OPCI10';
 EXCEPTION WHEN NO_DATA_FOUND then
ln_por_iva := 0;
end;
IF ln_por_iva = 0 THEN
   ln_por_iva := 0.16;
END IF;
ln_por_iva := ln_por_iva/100;
-- JDCM Termina Obtiene el porcentaje de IVA
--JDCM Obtiene el % Repeticion para el concepto SET
   begin
        SELECT nvl(to_number(pam_nompar),0)
          INTO ln_por_rep
          FROM USRSIHO.glcopams
         WHERE pam_keypar IN(SELECT pam_folini
                          FROM USRSIHO.glcopams
                         WHERE pam_cvesec = 'pdesin')
           AND pam_folini = 'Porc_Repet'
           AND pam_folfin = ln_keynom;
    exception
  when no_data_found then
    ln_por_rep := 0;
 end;
IF ln_por_rep = 0 THEN
   ln_por_rep:=0.12;
END IF;
ln_por_rep := ln_por_rep/100;
-- JDCM Obtiene el % Repeticion para el concepto SET
--JDCM Busca si Existe Parametrizado concepto IVA para la nomina que se esta ejecutando
ls_con_iva := '000';
    begin
        SELECT pam_nompar
          INTO ls_con_iva
          FROM USRSIHO.glcopams
         WHERE pam_keypar IN (SELECT pam_folini
                                FROM USRSIHO.glcopams
                               WHERE pam_cvesec = 'pdesin')
           AND pam_folini='Concepto_IVA'
           AND pam_folfin=ln_keynom;
    exception
          when no_data_found then
            ls_con_iva := '000';
     end;
--JDCM Termina Busca si Existe Parametrizado concepto IVA
--JDCM Busca si Existe Parametrizado concepto SET para la nomina que se esta ejecutando
ls_con_rep := '000';
    begin
        SELECT pam_nompar
          INTO ls_con_rep
          FROM USRSIHO.glcopams
         WHERE pam_keypar IN (SELECT pam_folini
                                FROM USRSIHO.glcopams
                               WHERE pam_cvesec = 'pdesin')
           AND pam_folini='Concepto_Repet'
           AND pam_folfin=ln_keynom;
    exception
          when no_data_found then
            ls_con_rep := '000';
     end;
--JDCM Termina Busca si Existe Parametrizado concepto SET
--JDCM Busca si Existe Parametrizado concepto SE2 para la nomina que se esta ejecutando
ls_con_repCS := '000';
    begin
        SELECT pam_nompar
          INTO ls_con_repCS
          FROM USRSIHO.glcopams
         WHERE pam_keypar IN (SELECT pam_folini
                                FROM USRSIHO.glcopams
                               WHERE pam_cvesec = 'pdesin')
           AND pam_folini='Conc_Repet_CS'
           AND pam_folfin=ln_keynom;
    exception
          when no_data_found then
            ls_con_repCS := '000';
     end;
--JDCM Termina Busca si Existe Parametrizado concepto SE2
	FOR rec7 IN
		(SELECT gdp.gdp_keycon,gdp.gdp_keypue,
				frp.frp_keydep,sum(gdp.gdp_cosuni*gdp.gdp_numcap) suma,
				frp.frp_tipcam,pue_ca3aux
		FROM  	USRSIHO.hologdpr gdp,USRSIHO.glwkcrys cry,USRSIHO.holofrph frp,USRSIHO.nmcopues pue
		WHERE  	frp.frp_keyrph = gdp.gdp_keYrph AND
				gdp.gdp_keyrph = cry.cry_numsec AND
				cry.cry_nomrep = 'HODESINC' AND
				cry.cry_keyusu = wn_usuario AND
				gdp.gdp_keypue = pue.pue_keypue AND
				cry.cry_idepcc = ws_terminal AND
				frp.frp_stsfol <> 2 AND
				frp.frp_keynom=113 AND     --JDCM Comenta Linea con Nomina Fija
				-- frp.frp_keynom=ln_keynom AND --JDCM Agrega Variable Nomina
				gdp.gdp_cosuni >= 0.01
		GROUP BY gdp.gdp_keycon,gdp.gdp_keypue,frp.frp_keydep,frp.frp_tipcam,pue_ca3aux) LOOP
		ls_keycon := rec7.gdp_keycon;
		li_keypue := rec7.gdp_keypue;
		ls_keydep := rec7.frp_keydep;
		ln_suma := rec7.suma;
		ln_tipcam := rec7.frp_tipcam;
		ls_diauno := rec7.pue_ca3aux;
		IF ls_con_iva <> '000' THEN --JDCM Condicion Para insertar Concepto IVA
			Li_Keyemp := 0;
			-- ELJM CODIGO PARA NOMINA 113 --
			-- ln_keyemp := 490195711;
			IF ln_keynom = 113 THEN
				ln_keyemp := 195711;
			ELSE
				-- ELJM CODIGO PARA NOMINA 109
				-- ln_keyemp := 490195711;
				ln_keyemp := 83496;
			END IF;
			-- LET ln_suma = ln_suma * 0.15;
			-- LET ln_suma = ln_suma * 0.16;
			ln_suma := ln_suma * ln_por_iva;  --JDCM Reemplaza Linea de arriba por esta
			--- INSERCCION POR CADA REGISTRO OBTENIDO
			INSERT INTO
					USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
					inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
					--VALUES(wn_proceso,ws_periodo,ln_keyemp,'IVA',ls_keydep,
			VALUES(wn_proceso,ws_periodo,ln_keyemp,ls_con_iva,ls_keydep,  --JDCM Reemplazo linea de arriba por esta
					li_keypue,ln_suma,ld_fechasys,ln_tipcam,to_number(rtrim(ls_diauno)));
					ln_suma := 0;
		END IF;
	END LOOP;
	-- calculo CONCEPTOS segunda Trasmision 12%
	-- -------------------------------------------------------------------------------------------------------
	FOR rec8 IN
		(SELECT gdp.gdp_keyrph,gdp.gdp_keyemp,gdp.gdp_keycon,gdp.gdp_keypue,frp.frp_keydep,
				(gdp.gdp_cosuni*gdp.gdp_numcap) producto,frp.frp_tipcam,pue_ca3aux
		FROM   	USRSIHO.hologdpr gdp,USRSIHO.glwkcrys cry,USRSIHO.holofrph frp,USRSIHO.nmcopues pue
		WHERE  	frp.frp_keyrph = gdp.gdp_keYrph AND
				gdp.gdp_keyrph = cry.cry_numsec AND
				cry.cry_nomrep = 'HODESINC' AND
				cry.cry_keyusu = wn_usuario AND
				gdp.gdp_keypue = pue.pue_keypue AND
				cry.cry_idepcc = ws_terminal AND
				frp.frp_stsfol <> 2 AND
				--frp.frp_keynom=113 AND      --JDCM Comenta Linea con Nomina Fija
				frp.frp_keynom=ln_keynom AND  --JDCM Agrega Variable Nomina
				gdp.gdp_cosuni >= 0.01 AND
				--gdp.gdp_keycon='H82'        --JDCM Comenta Linea con Concepto Fijo
				gdp.gdp_keycon IN (SELECT 	pam_nompar
							FROM 	USRSIHO.glcopams
							WHERE	pam_keypar IN (SELECT pam_folini
													 FROM USRSIHO.glcopams
													WHERE pam_cvesec = 'pdesin')
													  AND pam_folini = 'Base_Para_Repet'
													  AND pam_folfin = (SELECT per_keynom
																		  FROM USRSIHO.nmloperi
																		 WHERE per_keypro = wn_proceso
																		   AND per_keyper = ws_periodo))) LOOP
		ln_keyrph := rec8.gdp_keyrph;
		ln_keyemp := rec8.gdp_keyemp;
		ls_keycon := rec8.gdp_keycon;
		li_keypue := rec8.gdp_keypue;
		ls_keydep := rec8.frp_keydep;
		ln_suma := rec8.producto;
		ln_tipcam := rec8.frp_tipcam;
		ls_diauno := rec8.pue_ca3aux;
		IF ls_con_rep <> '000' THEN --JDCM Condicion Para insertar Concepto SET
			--LET ln_suma = ln_suma * 0.12;
			ln_suma := ln_suma * ln_por_rep;   --JDCM Reemplazo esta linea por la de arriba
			--- INSERCCION POR CADA REGISTRO OBTENIDO
			INSERT INTO
					USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
					inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
			--VALUES(wn_proceso,ws_periodo,ln_keyemp,'SET',ls_keydep,
			VALUES(wn_proceso,ws_periodo,ln_keyemp,ls_con_rep,ls_keydep,   --JDCM Reemplaza linea de arriba por esta
					li_keypue,ln_suma,ld_fechasys,ln_keyrph,to_number(rtrim(ls_diauno)));
		END IF;
		IF ls_con_iva <> '000' THEN  --JDCM Condicion Para insertar Concepto IVA
			--LET ln_suma = ln_suma * 0.15;
			--LET ln_suma = ln_suma * 0.16;
			ln_suma := ln_suma * ln_por_iva;  --JDCM Reemplaza Linea de arriba por esta
			-- ELJM CODIGO PARA NOMINA 113 --
			 ln_keyemp := 195711;
			-- IF ln_keynom = 113 THEN
			-- 	ln_keyemp := 195711;
			-- ELSE
			-- 	ln_keyemp := 490195711;
			-- END IF;
			-- -----------------------------------------------
			--- INSERCCION POR CADA REGISTRO OBTENIDO
			INSERT INTO
					USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
					inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
			--VALUES(wn_proceso,ws_periodo,ln_keyemp,'IVA',ls_keydep,
			VALUES(wn_proceso,ws_periodo,ln_keyemp,ls_con_iva,ls_keydep,  --JDCM Reemplazo linea de arriba por esta
					li_keypue,ln_suma,ld_fechasys,ln_keyrph,to_number(rtrim(ls_diauno)));
			ln_suma := 0;
		END IF;
	END LOOP;
FOR rec9 IN (SELECT gdp.gdp_keyrph,gdp.gdp_keyemp,gdp.gdp_keycon,gdp.gdp_keypue,
                  frp.frp_keydep,(gdp.gdp_cosuni*gdp.gdp_numcap) producto,
                  frp.frp_tipcam,pue_ca3aux
                     FROM   USRSIHO.hologdpr gdp,USRSIHO.glwkcrys cry,USRSIHO.holofrph frp,USRSIHO.nmcopues pue
           WHERE  frp.frp_keyrph = gdp.gdp_keYrph AND
                  gdp.gdp_keyrph = cry.cry_numsec AND
                  cry.cry_nomrep = 'HODESINC' AND
                  cry.cry_keyusu = wn_usuario AND
                  gdp.gdp_keypue = pue.pue_keypue AND
                  cry.cry_idepcc = ws_terminal AND
                  frp.frp_stsfol <> 2 AND
                  --frp.frp_keynom=113 AND      --JDCM Comenta Linea con Nomina Fija
                  frp.frp_keynom=ln_keynom AND  --JDCM Agrega Variable Nomina
                  gdp.gdp_cosuni >= 0.01 AND
                  --gdp.gdp_keycon='CSR'        --JDCM Comenta Linea con Concepto Fijo
                  gdp.gdp_keycon IN (SELECT pam_nompar
                                      FROM USRSIHO.glcopams
                                     WHERE pam_keypar IN
                                              (SELECT pam_folini
                                                 FROM USRSIHO.glcopams
                                                WHERE pam_cvesec = 'pdesin')
                                                  AND pam_folini = 'Base_Repet_CS'
                                                  AND pam_folfin = (SELECT per_keynom
                                                                      FROM USRSIHO.nmloperi
                                                                     WHERE per_keypro = wn_proceso
                                                                       AND per_keyper = ws_periodo))) LOOP
           ln_keyrph := rec9.gdp_keyrph;
           ln_keyemp := rec9.gdp_keyemp;
           ls_keycon := rec9.gdp_keycon;
           li_keypue := rec9.gdp_keypue;
           ls_keydep := rec9.frp_keydep;
           ln_suma := rec9.producto;
           ln_tipcam := rec9.frp_tipcam;
           ls_diauno := rec9.pue_ca3aux;
           IF ls_con_repCS <> '000' THEN --JDCM Condicion Para insertar Concepto SE2
               --LET ln_suma = ln_suma * 0.12;
              ln_suma := ln_suma * ln_por_rep;   --JDCM Reemplazo esta linea por la de arriba
               --- INSERCCION POR CADA REGISTRO OBTENIDO
                   INSERT INTO
                       USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
                                inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
                         --VALUES(wn_proceso,ws_periodo,ln_keyemp,'SE2',ls_keydep,
                         VALUES(wn_proceso,ws_periodo,ln_keyemp,ls_con_repCS,ls_keydep,   --JDCM Reemplaza linea de arriba por esta
                        li_keypue,ln_suma,ld_fechasys,ln_keyrph,to_number(rtrim(ls_diauno)));
           END IF;
           IF ls_con_iva <> '000' THEN --JDCM Condicion Para insertar Concepto IVA
              --LET ln_suma = ln_suma * 0.15;
              --LET ln_suma = ln_suma * 0.16;
              ln_suma := ln_suma * ln_por_iva;  --JDCM Reemplaza Linea de arriba por esta
				-- ELJM CODIGO PARA NOMINA 113 --
				-- ln_keyemp := 490195711;
                ln_keyemp := 195711;
				-- IF ln_keynom = 113 THEN
				--	ln_keyemp := 195711;
				-- ELSE
				--	ln_keyemp := 490195711;
				-- END IF;
				-- -----------------------------------------------
                  --- INSERCCION POR CADA REGISTRO OBTENIDO
                      INSERT INTO
                          USRSIHO.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
                                   inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
                            --VALUES(wn_proceso,ws_periodo,ln_keyemp,'IVA',ls_keydep,
                            VALUES(wn_proceso,ws_periodo,ln_keyemp,ls_con_iva,ls_keydep,  --JDCM Reemplazo linea de arriba por esta
                           li_keypue,ln_suma,ld_fechasys,ln_keyrph,to_number(rtrim(ls_diauno)));
              ln_suma := 0;
           END IF;
   END LOOP;
  --*************JDCM
  -------CALCULA CONCEPTOS IVA 16% PARA LA ANDI
 -- IG-ANDI, EJE, MUSICOS
 -- Comentado para c??lculo del PBE y PBI
 -- FOREACH SELECT 490083496,'600999',1000,0,'',frp.frp_keynom,SUM(gdp.gdp_cosuni*gdp.gdp_numcap)*.16
 --    INTO  ln_keyemp,ls_keydep,li_keypue,ln_keyrph,ls_diauno,ln_keynom,ln_suma
 --    FROM hologdpr gdp,glwkcrys cry,holofrph frp,nmcopues pue
 --   WHERE frp.frp_keyrph = gdp.gdp_keYrph AND
 --         gdp.gdp_keyrph = cry.cry_numsec AND
 --         cry.cry_nomrep = 'HODESINC' AND
 --         cry.cry_keyusu = wn_usuario AND
 --         gdp.gdp_keypue = pue.pue_keypue AND
 --         cry.cry_idepcc = ws_terminal    AND
 --         frp.frp_stsfol <> 2 AND
 --         frp.frp_keynom=109 AND
 --         gdp.gdp_cosuni >= 0.01 AND
 --         gdp.gdp_keycon IN('H93','HA4')
 --   GROUP BY frp.frp_keynom
 --     IF ln_keynom = 109 THEN
 --        LET Ln_Keyemp = 490083496;
 --            --- INSERCCION POR CADA REGISTRO OBTENIDO
 --                INSERT INTO
 --                    nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
 --                             inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
 --                              VALUES(wn_proceso,ws_periodo,ln_keyemp,'IVA',ls_keydep,
 --                     li_keypue,ln_suma,ld_fechasys,ln_keyrph,ls_diauno);
 --        LET ln_suma = 0;
 --     END IF
 --   END FOREACH
 -- Comentado para c??lculo del PBE y PBI
	IF ln_keynom = 109 THEN
		-- CONSTRUYE Regimen Fiscal
		-- -----------------------------------------------------------------
		begin
			SELECT  trim(pam_nompar) INTO valores		-- 001,002
			FROM    glcopams
			WHERE   pam_keypar='Z037'
			AND pam_cvesec = 'OPCI14'
			AND pam_folini = 'Regimen Fiscal'
			AND pam_folfin = '109';
			EXCEPTION WHEN NO_DATA_FOUND then valores := '';
		end;
		--CREATE TEMP TABLE REGFIS ( reg VARCHAR2(40) );
		posincad := 1;
		valor := '';
		WHILE ( posincad <= LENGTH(valores)) LOOP
			IF ( SUBSTR( valores, posincad, 1) <> ',') THEN
				valor := Trim(valor) || SUBSTR( valores, posincad, 1);
			ELSE
				IF ( LENGTH(valor) > 0 ) THEN
					INSERT INTO REGFIS (reg) VALUES (valor);
					valor := '';
				END IF;
			END IF;
			posincad := posincad + 1;
		END LOOP;
		IF ( LENGTH(valor) > 0 ) THEN
			INSERT INTO REGFIS (reg) VALUES (valor);
			valor := '';
		END IF;
		-- CONSTRUYE Base_Grav_Musico
		-- ---------------------------------------------------------------------
		begin
			SELECT 	trim(pam_nompar) INTO valores		-- H93,HA4,HA7,HF4,H82
			FROM   	glcopams
			WHERE  	pam_keypar='Z037'
			AND 	pam_cvesec = 'OPCI15'
			AND 	pam_folini = 'Base_Grav_Musico'
			AND 	pam_folfin = '109';
			EXCEPTION WHEN NO_DATA_FOUND then valores := '';
		end;
		-- CREATE TEMP TABLE CONCEPTOS( con VARCHAR2(40) );
		posincad := 1;
		valor := '';
		WHILE ( posincad <= LENGTH(valores)) LOOP
			IF ( SUBSTR( valores, posincad, 1) <> ',') THEN
				valor := Trim(valor) || SUBSTR( valores, posincad, 1);
			ELSE
				IF ( LENGTH(valor) > 0 ) THEN
					INSERT INTO CONCEPTOS(con) VALUES (valor);
					valor := '';
				END IF;
			END IF;
			posincad := posincad + 1;
		END LOOP;
		IF ( LENGTH(valor) > 0 ) THEN
			INSERT INTO CONCEPTOS(con) VALUES (valor);
			valor := '';
		END IF;
		FOR rec10 IN
			(SELECT frp.frp_keynom,SUM(gdp.gdp_cosuni*gdp.gdp_numcap)*.16 suma
			FROM  	hologdpr gdp,glwkcrys cry,holofrph frp,nmcopues pue,nmcoempl
			WHERE   frp.frp_keyrph = gdp.gdp_keYrph AND
					gdp.gdp_keyrph = cry.cry_numsec AND
					cry.cry_nomrep = 'HODESINC' AND
					cry.cry_keyusu = wn_usuario AND
					gdp.gdp_keypue = pue.pue_keypue AND
					cry.cry_idepcc = ws_terminal    AND
					frp.frp_stsfol <> 2 AND
					-- frp.frp_keynom = 109 AND
					frp.frp_keynom = ln_keynom AND
					gdp.gdp_cosuni >= 0.01 AND
					-- gdp.gdp_keycon IN ( SELECT con FROM CONCEPTOS ) AND
					gdp.gdp_keycon IN ( 'H93','HA4','HA7','HF4','H82') AND
					emp_keyemp = gdp_keyemp -- AND
					-- emp_ca2aux NOT IN ( SELECT  reg FROM REGFIS )
					-- emp_ca2aux NOT IN ('001','002')
			GROUP BY frp.frp_keynom) LOOP
			-- ELJM 10.01.2023
			-- ln_keyemp := 490083496;
			ln_keyemp := 83496;
			ls_keydep := '600999';
			li_keypue := 1000;
			ln_keyrph := 0;
			ls_diauno := '';
			ln_keynom := rec10.frp_keynom;
			ln_suma := rec10.suma;
			--- INSERCCION POR CADA REGISTRO OBTENIDO
			INSERT INTO nmcoinci(
					inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
					inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
			VALUES(
					wn_proceso,ws_periodo,ln_keyemp,'IVA',ls_keydep,
					li_keypue,ln_suma,ld_fechasys,ln_keyrph,to_number(rtrim(ls_diauno)));
		END LOOP;		-- CICLO DE FOR rec10
		-- CALCULA EL PBI
		-- ----------------------------------------------------------------------------------
		IF ln_suma > 0 AND ln_keynom = 109 THEN
			begin
				SELECT  sum(gdp.gdp_cosuni * gdp.gdp_numcap)
				INTO    ln_suma
				FROM  	hologdpr gdp,glwkcrys cry,holofrph frp,nmcopues pue, nmcoempl
				WHERE   frp.frp_keyrph = gdp.gdp_keYrph AND
						gdp.gdp_keyrph = cry.cry_numsec AND
						cry.cry_nomrep = 'HODESINC' AND
						cry.cry_keyusu = wn_usuario AND
						gdp.gdp_keypue = pue.pue_keypue AND
						cry.cry_idepcc = ws_terminal AND
						frp.frp_stsfol <> 2 AND
						frp.frp_keynom = ln_keynom AND
						gdp.gdp_cosuni >= 0.01 AND
						-- gdp.gdp_keycon IN ( SELECT con FROM CONCEPTOS ) AND
						gdp.gdp_keycon IN ( 'H93','HA4','HA7','HF4','H82') AND
						emp_keyemp = gdp_keyemp; -- AND
						-- emp_ca2aux NOT IN   ( SELECT  reg FROM REGFIS );
						-- emp_ca2aux NOT IN  ('001','002' );
				EXCEPTION WHEN NO_DATA_FOUND then ln_suma := 0;
			end;
			Li_Keyemp := 0;
			-- ln_keyemp := 490083496;
            ln_keyemp := 83496;
			INSERT INTO nmcoinci(
					inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
					inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno, inc_diados)
			VALUES(
					wn_proceso,ws_periodo,ln_keyemp,'PBI',ls_keydep,
					li_keypue,ln_suma,ld_fechasys,ln_tipcam,to_number(rtrim(ls_diauno)),8);
			END IF;
			-- CALCULA EL PBE
			-- ------------------------------------------------------------------------------
			IF ln_suma > 0 and ln_keynom = 109 THEN
				begin
					SELECT  sum(gdp.gdp_cosuni*gdp.gdp_numcap)
					INTO  	ln_suma
					FROM  	hologdpr gdp,glwkcrys cry,holofrph frp,nmcopues pue, nmcoempl
					WHERE   frp.frp_keyrph = gdp.gdp_keYrph AND
						gdp.gdp_keyrph = cry.cry_numsec AND
						cry.cry_nomrep = 'HODESINC' AND
						cry.cry_keyusu = wn_usuario AND
						gdp.gdp_keypue = pue.pue_keypue AND
						cry.cry_idepcc = ws_terminal AND
						frp.frp_stsfol <> 2 AND
						frp.frp_keynom=ln_keynom AND
						gdp.gdp_cosuni >= 0.01 AND
						-- gdp.gdp_keycon IN ( SELECT con FROM CONCEPTOS ) AND
						gdp.gdp_keycon IN ( 'H93','HA4','HA7','HF4','H82') AND
						emp_keyemp = gdp_keyemp AND
						-- emp_ca2aux IN   ( SELECT  reg FROM REGFIS );
						emp_ca2aux IN  ('001','002' );
					EXCEPTION WHEN NO_DATA_FOUND then ln_suma := 0;
				end;
				Li_Keyemp := 0;
				ln_keyemp := 490083496;
				INSERT INTO nmcoinci(
						inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
						inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno, inc_diados)
				VALUES(
						wn_proceso,ws_periodo,ln_keyemp,'PBE',ls_keydep,
						li_keypue,ln_suma,ld_fechasys,ln_tipcam,to_number(rtrim(ls_diauno)),8);
				ln_suma := 0;
			END IF;
		END IF;
		-- NOMINA 110 ANDA
		-- -----------------------------------------------------
		begin
			SELECT per_keynom
			INTO ln_keynom
			FROM nmloperi
			WHERE per_keypro=wn_proceso
			AND per_keyper=ws_periodo;
			EXCEPTION WHEN NO_DATA_FOUND then ln_keynom := 0;
		end;
		-- INSERT INTO paso VALUES('sp_hrpdesin','','',1,'','');
		IF ln_keynom = 110 THEN
			--INSERT INTO paso VALUES('sp_hrpdesin','','',2,'','');
			---********PERCEPCION BASE IVA  E  IVA 16%  SIN EXTRANJEROS 25% **********010311 se sustituyo CC 600999 x un 0
			--FOREACH SELECT 490041032,'0',1000,0,'',frp.frp_keynom,SUM(gdp.gdp_cosuni*gdp.gdp_numcap),SUM(gdp.gdp_cosuni*gdp.gdp_numcap)*.16
			begin
				SELECT 	490041032,'0',1000,0,'',frp.frp_keynom,SUM(gdp.gdp_cosuni*gdp.gdp_numcap),SUM(gdp.gdp_cosuni*gdp.gdp_numcap)*.16
				INTO  	ln_keyemp, ls_keydep, li_keypue, ln_keyrph, ls_diauno, ln_keynom, ln_base_iva1 , ln_suma
				FROM 	hologdpr gdp,glwkcrys cry,holofrph frp,nmcopues pue, nmcoempl emp
				WHERE 	frp.frp_keyrph = gdp.gdp_keYrph
				AND 	gdp.gdp_keyrph = cry.cry_numsec
				AND 	cry.cry_nomrep = 'HODESINC'
				AND 	cry.cry_keyusu = wn_usuario
				AND 	gdp.gdp_keypue = pue.pue_keypue
				AND 	cry.cry_idepcc = ws_terminal
				AND 	gdp.gdp_keyemp = emp.emp_keyemp
				AND 	emp.emp_ca2aux NOT IN('107')
				AND 	frp.frp_stsfol <> 2
				AND 	frp.frp_keynom=110
				AND 	gdp.gdp_cosuni >= 0.01
				AND 	gdp.gdp_keycon IN('HA4','H15','HA6','HA7','HE4','HF1','HF2','HTI','HIT')
				GROUP BY frp.frp_keynom;
				EXCEPTION WHEN NO_DATA_FOUND then
						ln_keyemp := 490041032;
						ls_keydep := '0';
						li_keypue := 1000;
						ln_keyrph := 0;
						ls_diauno := '';
						ln_keynom := 0;
						ln_base_iva1 := 0;
						ln_suma := 0;
			end;
			--INSERT INTO paso VALUES('sp_hrpdesin','','',3,'','');
			Ln_Keyemp := 490041032;
			-- INSERCCION POR CADA REGISTRO OBTENIDO
			IF ln_suma > 0 THEN
				INSERT INTO nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
						inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
				VALUES(wn_proceso,ws_periodo,ln_keyemp,'IVA',ls_keydep,
						li_keypue,ln_suma,ld_fechasys,ln_keyrph,to_number(rtrim(ls_diauno)));
			END IF;
			ln_suma := 0;
			--INSERT INTO paso VALUES('sp_hrpdesin','','',4,'','');
			--IVA FOMENTOS
			begin
				SELECT 	490041032,'0',1000,0,'',110,SUM(inc_import),SUM(inc_import)*.16
				INTO  	ln_keyemp,ls_keydep,li_keypue,ln_keyrph,ls_diauno,ln_keynom,ln_base_iva2, ln_suma
				FROM 	nmcoinci,nmcoempl
				WHERE 	inc_keyemp=emp_keyemp
				AND 	emp_ca2aux NOT IN('107')
				AND 	inc_keypro=138
				AND 	inc_keyper=ws_periodo
				AND 	inc_keycon IN('HF1','HF2');
				EXCEPTION WHEN NO_DATA_FOUND then
						ln_keyemp := 490041032;
						ls_keydep := '0';
						li_keypue := 1000;
						ln_keyrph := 0;
						ls_diauno := '';
						ln_keynom := 0;
						ln_base_iva1 := 0;
						ln_suma := 0;
			end;
			Ln_Keyemp := 490041032;
			--- INSERCCION POR CADA REGISTRO OBTENIDO
			IF ln_suma > 0 THEN
				INSERT INTO nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
						inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
				VALUES(wn_proceso,ws_periodo,ln_keyemp,'IVA',ls_keydep,
						li_keypue,ln_suma,ld_fechasys,ln_keyrph,to_number(rtrim(ls_diauno)));
			END IF;
			--- aedo 23-02-2011
			--- INSERCCION POR CADA REGISTRO OBTENIDO para el PBI
			--- PERCEPCISN BASE IVA  = Percepciones de Empleados con situacisn fiscal diferente a .25% EXTRANJEROS.
			ln_suma := 0;
			ln_suma := ln_base_iva1 + ln_base_iva2;
			IF ln_suma > 0 THEN
				INSERT INTO nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
						inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
				VALUES(wn_proceso,ws_periodo,ln_keyemp,'PBI',ls_keydep,
						li_keypue,ln_suma,ld_fechasys,ln_keyrph,to_number(rtrim(ls_diauno)));
			END IF;
			-- *******************PERCEPCION BASE EXENTA***********************
			ln_base_exenta1 := 0;
			ln_base_exenta2 := 0;
			---SOLO EXTRANJEROS 25%     PER_BASE_EXENTA
			begin
				SELECT  490041032,'0',1000,0,'',frp.frp_keynom,SUM(gdp.gdp_cosuni*gdp.gdp_numcap)
				INTO 	ln_keyemp, ls_keydep, li_keypue, ln_keyrph, ls_diauno, ln_keynom, ln_base_exenta1
				FROM 	hologdpr gdp,glwkcrys cry,holofrph frp,nmcopues pue, nmcoempl emp
				WHERE 	frp.frp_keyrph = gdp.gdp_keYrph
				AND 	gdp.gdp_keyrph = cry.cry_numsec
				AND 	cry.cry_nomrep = 'HODESINC'
				AND 	cry.cry_keyusu = wn_usuario
				AND 	gdp.gdp_keypue = pue.pue_keypue
				AND 	cry.cry_idepcc = ws_terminal
				AND 	gdp.gdp_keyemp = emp.emp_keyemp
				AND 	emp.emp_ca2aux IN('107')
				AND 	frp.frp_stsfol <> 2
				AND 	frp.frp_keynom = 110
				AND 	gdp.gdp_cosuni >= 0.01
				AND 	gdp.gdp_keycon IN('HA4','H15','HA6','HA7','HE4','HF1','HF2','HTI','HIT')
				GROUP BY frp.frp_keynom;
				exception when no_data_found then
						ln_keyemp := 490041032;
						ls_keydep := '0';
						li_keypue := 1000;
						ln_keyrph := 0;
						ls_diauno := '';
			end;
			-- IG-CONS-0823
			-- Comenta para cambio de separar base exenta de cuota de transito
			-- CUOTA DE TRANSITO                     PER_BASE_EXENTA_CT
			-- SELECT 490041032,'0',1000,0,'',110,SUM(inc_import)
			--   INTO ln_keyemp,ls_keydep,li_keypue,ln_keyrph,ls_diauno,ln_keynom,ln_base_exenta2
			--   FROM nmcoinci
			--  WHERE inc_keypro = 138
			--    AND inc_keyper = ws_periodo
			--    AND inc_keycon = 'H42';
			-- Termina Comenta para cambio de separar base exenta de cuota de transito
			----*******************BASE FOMENTOS EXENTOS***********************
			----FOMENTOS   SOLO EXTRANJEROS 25%       BASE_FOMENTOS_EXENTA
			ln_base_fomentos := 0;
			begin
				SELECT    490041032,'0',1000,0,'',110,SUM(inc_import)
				INTO      ln_keyemp,ls_keydep,li_keypue,ln_keyrph,ls_diauno,ln_keynom,ln_base_fomentos
				FROM      nmcoinci,nmcoempl
				WHERE     inc_keyemp = emp_keyemp
				AND emp_ca2aux IN('107')
				AND inc_keypro = 138
				AND inc_keyper = ws_periodo
				AND inc_keycon IN('HF1','HF2');
				exception when no_data_found then
						ln_keyemp := 490041032;
						ls_keydep := '0';
						li_keypue := 1000;
						ln_keyrph := 0;
						ln_keyrph := '';
						ln_Keynom := 0;
						ln_base_fomentos := 0;
			end;
			--- aedo 23-02-2011
			--- INSERCCION POR CADA REGISTRO OBTENIDO para el PBE
			--- PBE    PERCEPCISN BASE EXENTA = Cuotas de Transito + Percepciones de Empleados con situacisn fiscal .25% EXTRANJEROS.
			--- IG-CONS-0823 CAMBIA: PERCEPCISN BASE EXENTA = Base fomentos excentos + Percepciones de Empleados con situacisn fiscal .25% EXTRANJEROS.
			ln_suma := 0;
			IF ln_base_exenta1 IS NULL THEN
				ln_base_exenta1 := 0;
			END IF;
			--IG-CONS-0823
			--Comenta para cambio de separar base exenta de cuota de transito
			-- IF ln_base_exenta2 IS NULL THEN
			--     LET ln_base_exenta2 = 0;
			-- END IF
			-- LET ln_suma = ln_base_exenta1 + ln_base_exenta2;
			--Termina Comenta para cambio de separar base exenta de cuota de transito
			--IG-CONS-0823
			--Substituye para cambio sumar PBE con BFE
			IF ln_base_fomentos IS NULL THEN
				ln_base_fomentos := 0;
			END IF;
			ln_suma := ln_base_exenta1 + ln_base_fomentos;
			--Substituye para cambio sumar PBE con BFE
			IF ln_suma > 0 THEN
				INSERT INTO nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
						inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
				VALUES(wn_proceso,ws_periodo,ln_keyemp,'PBE',ls_keydep,
						li_keypue,ln_suma,ld_fechasys,ln_keyrph,to_number(rtrim(ls_diauno)));
			END IF;
			----*******************CUOTA DE TRANSITO EXENTA***********************
			--IG-CONS-0823
			--Inserta para cambio de separar base exenta de cuota de transito y adicionarla con el nuevo concepto auxiliar
			---CUOTA DE TRANSITO                     PER_BASE_EXENTA_CT
			begin
				SELECT  490041032,'0',1000,0,'',110,SUM(inc_import)
				INTO    ln_keyemp,ls_keydep,li_keypue,ln_keyrph,ls_diauno,ln_keynom,ln_base_exenta2
				FROM    nmcoinci
				WHERE   inc_keypro = 138
				AND 	inc_keyper = ws_periodo
				AND 	inc_keycon = 'H42';
				exception when no_data_found then
						ln_keyemp := 490041032;
						ls_keydep := '0';
						li_keypue := 1000;
						ln_keyrph := 0;
						ln_keyrph := '';
						ln_keynom := 110;
			end;
			IF ln_base_exenta2 IS NULL THEN
				ln_base_exenta2 := 0;
			END IF;
			IF ln_base_exenta2 > 0 THEN
				INSERT INTO nmcoinci
						(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
						inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
				VALUES
						(wn_proceso,ws_periodo,ln_keyemp,'CTA',ls_keydep,
						li_keypue,ln_base_exenta2,ld_fechasys,ln_keyrph,to_number(rtrim(ls_diauno)));
			END IF;
			-- Termina Inserta para cambio de separar base exenta de cuota de transito y adicionarla con el nuevo concepto auxiliar
            ----*******************BASE FOMENTOS EXENTOS***********************
            ---- FOMENTOS   SOLO EXTRANJEROS 25%       BASE_FOMENTOS_EXENTA
            -- IG-CONS-0823
            -- Comentado para cambio cambio sumar PBE con BFE
            -- LET ln_base_fomentos = 0;
            --  SELECT 490041032,'0',1000,0,'',110,SUM(inc_import)
            --    INTO ln_keyemp,ls_keydep,li_keypue,ln_keyrph,ls_diauno,ln_keynom,ln_base_fomentos
            --    FROM nmcoinci,nmcoempl
            --   WHERE inc_keyemp = emp_keyemp
            --     AND emp_ca2aux IN('107')
            --     AND inc_keypro = 138
            --     AND inc_keyper = ws_periodo
            --     AND inc_keycon IN('HF1','HF2');
            --   IF ln_base_fomentos > 0 THEN
            --      INSERT INTO nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
            --                           inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
            --                    VALUES(wn_proceso,ws_periodo,ln_keyemp,'BFE',ls_keydep,
            --                           li_keypue,ln_base_fomentos,ld_fechasys,ln_keyrph,ls_diauno);
            --   END IF
            -- Termina Comentado para cambio cambio sumar PBE con BFE
            -- se limpian las variables
            ln_base_iva1 := 0;
            ln_base_iva2 := 0;
            ln_base_exenta1 := 0;
            ln_base_exenta2 := 0;
            ln_base_fomentos := 0;
            ln_suma := 0;
		-- END FOREACH;
		END IF;
		-- ACTUALZACION DE RPH
		UPDATE 	holofrph
		SET 	frp_stsfol='1',
				frp_keyper=ws_periodo,
				frp_keypro=wn_proceso
		WHERE EXISTS (	SELECT 	cry_numsec
						FROM 	glwkcrys cry
						WHERE 	cry_numsec = frp_keyrph AND
								cry.cry_nomrep = 'HODESINC' AND
								cry.cry_keyusu = wn_usuario AND
								cry.cry_idepcc = ws_terminal);
		--ELIMINCAION DE REGISTROS DE LA TABLA DE PASO
		--DELETE  FROM glwkcrys  WHERE cry_nomrep = 'HODESINC' AND cry_keyusu = wn_usuario AND cry_idepcc = ws_terminal;
END;
/
