CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HRPCAPAU" (ps_programa VARCHAR2,
       pi_tipcont VARCHAR2, pd_fecsol DATE,      pd_fechatrab DATE,
       pi_capini SMALLINT,  pi_capfin SMALLINT,  pi_keyusu INTEGER,
       pi_keynom SMALLINT,  ps_tiptra VARCHAR2,  pi_forpag SMALLINT,
       pd_fechaact DATE,    pl_unifor SMALLINT,  pl_transp SMALLINT,
       PN_TIPCAM DECIMAL,   pn_keypro SMALLINT,  pd_fechatrabhas DATE,
       pdk_keyare VARCHAR2, vi_valret OUT INTEGER)
   -- se agrego pd_fechatrabdes para guardar la fecha hasta para el RPH
   -- Ultima Modificacion 12-ABRIL-2004 Cesar Gonzalez Sanchez
   -- Se agrego funcionalidad para que se puedan asignar varios conrtratos a un mismo RPH
   -- REGRESARA EL SECUENCIAL DEL RPH Y A CONTINUACION LOS
   -- SECUENCIALES DE LOS GDP'S.
   -- RETURNING INTEGER;
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   li_secrph     INTEGER;
   li_secgdp     INTEGER;
   li_captot     INTEGER;
   li_numcap     INTEGER;
   li_capdis     INTEGER;
   li_plaza      INTEGER;
   li_empleado   INTEGER;
   li_tipcon     INTEGER;
   li_folio      INTEGER;
   ld_valor      DECIMAL(16,2);
   ld_costo      DECIMAL(16,2);
   ld_costototal DECIMAL(16,2);
   ls_puesto     VARCHAR2(16);
   ls_keycon     VARCHAR2(4);
   li_valsec     INTEGER;
   li_emptotal   DECIMAL(15,0);
   ws_equiva    VARCHAR2(1);
BEGIN
   li_secrph     := -1;
   li_emptotal   := 0;
   ld_costototal := 0;
   vi_valret := 0;
IF pi_keynom <> 102 THEN
-- DBMS_OUTPUT.put_line('entrar');
   -- FOREACH
   FOR cur_01
        IN (SELECT con.con_keyemp, con.con_keytco,con.con_cosuni,
                   con.con_keypue,con.con_keyplz,con.con_keyfol,
                   con.con_numcdi, count(*) cuantos, onc.con_keycon
            -- INTO   li_empleado, li_tipcon, ld_costo, ls_puesto,
            --        li_plaza,li_folio,
            --        li_capdis, li_numcap,ls_keycon
            FROM   USRSIHO.holocont con, USRSIHO.holococa coc, USRSIHO.nmloconc onc, USRSIHO.nmcoempl empl,
                   USRSIHO.nmcopues pues, USRSIHO.holoalem ale                               -- nuevo holoalem Emilio
            WHERE  con.con_keydep = ps_programa AND
                   con.con_keytco in (select contratos from USRSIHO.contratos_tmp) AND
                   con.con_stspag = 'V' AND
                   con.con_fecini <= pd_fechatrab AND
                   (con.con_fecven >= pd_fechatrabhas OR con.con_fecven IS NULL) AND
                   con.con_keytva = 1 AND
                   con.con_keyplz = coc.coc_keyplz AND
                   coc.coc_stspag = 'V' AND
                   coc.coc_keyrph IS NULL AND
                   -- coc.coc_keygdp IS NULL AND
                   coc.coc_keycap BETWEEN pi_capini AND pi_capfin AND
                   con.con_keyemp = empl.emp_keyemp AND
                   empl.emp_keyemp = ale.ale_keyemp AND                          -- nuevo Emilio
                   con.con_keypue = pues.pue_keypue AND
                   onc.con_keycon = pues.pue_ca5aux AND
                   -- pues.pue_ca4aux[7]='1' AND
                   SUBSTR(pues.pue_ca4aux, 7, 1) = '1' AND
                   empl.emp_status = 1 AND                                       -- AND nuevo Emilio
                   NVL(ale.ale_keyem2,0) = 0                                   -- nuevo Emilio
          GROUP BY con.con_keyemp,con.con_keytco,con.con_cosuni,con.con_keypue,
                   con.con_keyplz,con.con_keyfol,con.con_numcdi,onc.con_keycon)
      LOOP
 --DBMS_OUTPUT.put_line('loop');
         li_empleado := cur_01.con_keyemp;
         li_tipcon   := cur_01.con_keytco;
         ld_costo    := cur_01.con_cosuni;
         ls_puesto   := cur_01.con_keypue;
         li_plaza    := cur_01.con_keyplz;
         li_folio    := cur_01.con_keyfol;
         li_capdis   := cur_01.con_numcdi;
         li_numcap   := cur_01.cuantos;
         ls_keycon   := cur_01.con_keycon;
         IF li_numcap = pi_capfin - pi_capini + 1 THEN
            -- INSERCCION DEL HEADER
            IF li_secrph = -1 THEN
            -- Definicion de la equivalencia y concepto, dependiendo de la nomina
               IF pi_keynom = 102 THEN
                  ws_equiva := 'I';
				  BEGIN
					  SELECT cpf_keycof
					  INTO ls_keycon
					  FROM USRSIHO.nmloconc,USRSIHO.nmcopues,USRSIHO.holocpfj
					  WHERE pue_ca5aux = cpf_keycon AND
							cpf_keycon = con_keycon AND
							cpf_repeti = 'I' AND
							pue_keypue = ls_puesto;
					  EXCEPTION WHEN no_data_found THEN ls_keycon := '';
				  END;
               ELSE
                  ws_equiva := 'N';
               END IF;
               ld_valor := ld_costo;
         ---AEDO  14/08/06   Claudia Islas pidio que se actualizara el campo frp_pertra con el valor 1, en lugar del NULL.
               INSERT INTO USRSIHO.holofrph(frp_keydep,frp_keyper,frp_fecact,frp_stsfol,
                                 frp_totcos,frp_keyusu,frp_keynom,frp_repeti,
                                 frp_tiptra,frp_fecsol,frp_fectrab,frp_forpag,
                                 frp_pertra,frp_tipfol,frp_unifor,frp_transp,
                                 frp_tipcam,frp_keypro,frp_fecitr,frp_keyare)
                        VALUES(  ps_programa,null,pd_fechaact,'0'      ,
                                 ld_valor ,pi_keyusu,pi_keynom,ws_equiva  ,
                                 ps_tiptra,pd_fecsol,pd_fechatrabhas,pi_forpag,
                                 1, 'N' ,pl_unifor,pl_transp  ,pn_tipcam,
                                 pn_keypro,pd_fechatrab,pdk_keyare)
                    returning FRP_KEYRPH into li_secrph ;
              -- LECTURA DEL SECUENCIAL DEL RPH =>
              -- li_secrph := DBINFO('SQLCA.SQLERRD1');
              -- RETURN li_secrph WITH RESUME;
              --li_secrph := SQLCODE;
             --DBMS_OUTPUT.put_line('salida '||to_char(li_secrph));
              vi_valret := li_secrph;
            END IF;
            -- CAPITULOS TOTALES
            li_captot := pi_capfin - pi_capini + 1;
            -- INSERCION DE GASTOS DE PRODUCCION
            ld_valor := ld_costo;
            ld_costototal := ld_costototal + ld_valor  * ( pi_capfin - pi_capini + 1 );
            li_emptotal := li_emptotal + li_empleado;
            -- CESAR GONZALEZ SANCHEZ   ABRIL 2004
            -- se cambio pi_tipcont x li_tipcon  para que se puedan insertar los contratos que regrese el SELECT
            INSERT INTO USRSIHO.hologdpr (gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_keypue,gdp_capini,
                                  gdp_capfin,gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,
                                  gdp_keysue,gdp_keytco,gdp_keyfol,gdp_minleg,gdp_minsal,gdp_minext,
                                  gdp_mincom,gdp_keyusu)
            VALUES(               ps_programa,li_secrph,pd_fechatrab,li_empleado,ls_puesto,pi_capini,
                                  pi_capfin  ,li_captot,ls_keycon   ,'S'        ,'S'      ,ld_valor ,
                                  NULL       ,li_tipcon,li_folio   ,0          ,0        ,0        ,
                                  0          ,pi_keyusu)
            returning GDP_KEYSEC into li_secgdp;
            -- LECTURA DEL SECUENCIAL DEL  GDP =>
            -- li_secgdp := DBINFO('SQLCA.SQLERRD1');
            -- RETURN LI_SECGDP WITH RESUME;
            --li_secgdp := SQLCODE;
            --vi_valret := li_secgdp;
            -- ACTUALIZACION DE CAPITULOS
            UPDATE USRSIHO.holococa
               SET coc_keyrph = li_secrph ,
                   coc_keygdp = li_secgdp
             WHERE coc_keyplz = li_plaza AND
                   coc_keycap BETWEEN pi_capini AND pi_capfin;
            -- ACTUALIZACION DE CONTRATOS
            UPDATE USRSIHO.holocont
               SET con_numcdi = con_numcdi - ( pi_capfin - pi_capini + 1 )
             WHERE con_keyplz=li_plaza AND
                   Con_Keytco=li_tipcon;
       END IF;
   -- END FOREACH
   END LOOP;
   --SI EL CURSOR INSERTO UN RPH --> ACTUALIZAR EL TOTAL COSTO Y EL TOTAL EMPLEADO EN ESTE CON LAS SUMAS DE LOS DETALLES
   IF li_secrph > -1 THEN
      UPDATE USRSIHO.holofrph
         SET frp_totcos = ld_costototal,
             frp_totemp = li_emptotal
       WHERE frp_keyrph = li_secrph;
   END IF;
ELSE   -- CUANDO LA NOMINA ES 102 INTERNOS
   -- FOREACH
   FOR cur_02
       IN ( SELECT con.con_keyemp, con.con_keytco, con.con_cosuni,
                   con.con_keypue,con.con_keyplz,con.con_keyfol,
                   con.con_numcdi, count(*) cuantos, onc.con_keycon
            FROM   USRSIHO.holocont con,USRSIHO.holococa coc,USRSIHO.nmloconc onc,USRSIHO.nmcoempl empl,
                   USRSIHO.nmcopues pues,USRSIHO.holoalem ale                               -- nuevo holoalem Emilio
            WHERE  con.con_keydep=ps_programa AND
                   con.con_keytco in (select contratos from USRSIHO.contratos_tmp) AND
                   con.con_stspag = 'V' AND
                   con.con_fecini <= pd_fechatrab AND
                   (con.con_fecven >= pd_fechatrabhas OR con.con_fecven IS NULL) AND
                   con.con_keytva = 1 AND
                   con.con_keyplz = coc.coc_keyplz AND
                   coc.coc_stspag = 'V' AND
                   coc.coc_keyrph IS NULL AND
                   --coc.coc_keygdp IS NULL AND
                   coc.coc_keycap BETWEEN pi_capini AND pi_capfin AND
                   con.con_keyemp=empl.emp_keyemp AND
                   empl.emp_keyemp=ale.ale_keyemp AND                          -- nuevo Emilio
                   con.con_keypue=pues.pue_keypue AND
                   onc.con_keycon=pues.pue_ca5aux AND
                   -- pues.pue_ca4aux[7]='1' AND
                   SUBSTR(pues.pue_ca4aux, 7, 1) = '1' AND
                   empl.emp_status=1 AND                                       -- AND nuevo Emilio
                   NVL(ale.ale_keyem2,0) > 0                                   -- nuevo Emilio
          GROUP BY con.con_keyemp,con.con_keytco,con.con_cosuni,con.con_keypue,
                   con.con_keyplz,con.con_keyfol,con.con_numcdi,onc.con_keycon)
    LOOP
       li_empleado := cur_02.con_keyemp;
       li_tipcon   := cur_02.con_keytco;
       ld_costo    := cur_02.con_cosuni;
       ls_puesto   := cur_02.con_keypue;
       li_plaza    := cur_02.con_keyplz;
       li_folio    := cur_02.con_keyfol;
       li_capdis   := cur_02.con_numcdi;
       li_numcap   := cur_02.cuantos;
       ls_keycon   := cur_02.con_keycon;
       IF li_numcap = pi_capfin - pi_capini + 1 THEN
         -- INSERCCION DEL HEADER
            IF li_secrph = -1 THEN
         -- Definicion de la equivalencia y concepto, dependiendo de la nomina
               IF pi_keynom = 102 THEN
                  ws_equiva := 'I';
                  BEGIN
					  SELECT cpf_keycof
					  INTO ls_keycon
					  FROM USRSIHO.nmloconc,USRSIHO.nmcopues,USRSIHO.holocpfj
					  WHERE pue_ca5aux = cpf_keycon AND
							cpf_keycon = con_keycon AND
							cpf_repeti = 'I' AND
							pue_keypue = ls_puesto;
					  EXCEPTION WHEN no_data_found THEN ls_keycon := '';
				  END;
               ELSE
                  ws_equiva := 'N';
               END IF;
               ld_valor := ld_costo;
               -- AEDO  14/08/06   Claudia Islas pidio que se actualizara el campo frp_pertra con el valor 1, en lugar del NULL.
               INSERT INTO USRSIHO.holofrph(frp_keydep,frp_keyper,frp_fecact,frp_stsfol,
                                 frp_totcos,frp_keyusu,frp_keynom,frp_repeti,
                                 frp_tiptra,frp_fecsol,frp_fectrab,frp_forpag,
                                 frp_pertra,frp_tipfol,frp_unifor,frp_transp,
                                 frp_tipcam,frp_keypro,frp_fecitr,frp_keyare)
                        VALUES(  ps_programa,null     ,pd_fechaact,'0'      ,
                                 ld_valor   ,pi_keyusu,pi_keynom,ws_equiva  ,
                                 ps_tiptra  ,pd_fecsol,pd_fechatrabhas,pi_forpag,
                                 1, 'N'   ,pl_unifor,pl_transp  ,pn_tipcam,
                                 pn_keypro  ,pd_fechatrab, pdk_keyare)
                   returning FRP_KEYRPH into li_secrph ;
               -- LECTURA DEL SECUENCIAL DEL RPH =>
               -- li_secrph := DBINFO('SQLCA.SQLERRD1');
               -- RETURN li_secrph WITH RESUME;
               --li_secrph := SQLCODE;
               vi_valret := li_secrph;
            END IF;
            -- CAPITULOS TOTALES
            li_captot := pi_capfin - pi_capini + 1;
            -- INSERCION DE GASTOS DE PRODUCCION
            ld_valor := ld_costo;
            ld_costototal := ld_costototal + ld_valor  * ( pi_capfin - pi_capini + 1 );
            li_emptotal := li_emptotal + li_empleado;
            -- CESAR GONZALEZ SANCHEZ   ABRIL 2004
            -- se cambio pi_tipcont x li_tipcon  para que se puedan insertar los contratos que regrese el SELECT
            INSERT INTO USRSIHO.hologdpr (gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_keypue,gdp_capini,
                                  gdp_capfin,gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,
                                  gdp_keysue,gdp_keytco,gdp_keyfol,gdp_minleg,gdp_minsal,gdp_minext,
                                  gdp_mincom,gdp_keyusu)
                          VALUES( ps_programa,li_secrph,pd_fechatrab,li_empleado,ls_puesto,pi_capini,
                                  pi_capfin  ,li_captot,ls_keycon   ,'S'        ,'S'      ,ld_valor ,
                                  NULL       ,li_tipcon,li_folio   ,0          ,0        ,0        ,
                                  0          ,pi_keyusu)
             returning GDP_KEYSEC into li_secgdp;
            -- LECTURA DEL SECUENCIAL DEL  GDP =>
            -- li_secgdp := DBINFO('SQLCA.SQLERRD1');
            -- RETURN LI_SECGDP WITH RESUME;
            --li_secgdp := SQLCODE;
            --vi_valret := li_secgdp;
            -- ACT  UALIZACION DE CAPITULOS
            UPDATE USRSIHO.holococa
               SET coc_keyrph = li_secrph ,
                   coc_keygdp = li_secgdp
             WHERE coc_keyplz = li_plaza AND
                   coc_keycap BETWEEN pi_capini AND pi_capfin;
            -- ACTUALIZACION DE CONTRATOS
            UPDATE USRSIHO.holocont
               SET con_numcdi = con_numcdi - ( pi_capfin - pi_capini + 1 )
             WHERE con_keyplz = li_plaza AND
                   Con_Keytco = li_tipcon;
       END IF;
   -- END FOREACH
   END LOOP;
   --SI EL CURSOR INSERTO UN RPH --> ACTUALIZAR EL TOTAL COSTO Y EL TOTAL EMPLEADO EN ESTE CON LAS SUMAS DE LOS DETALLES
   IF li_secrph > -1 THEN
      UPDATE USRSIHO.holofrph
         SET frp_totcos = ld_costototal,
             frp_totemp = li_emptotal
      WHERE frp_keyrph = li_secrph;
   END IF;
END IF;
END;
-- -----------------------------------------------------------------------------------------------------------
/
