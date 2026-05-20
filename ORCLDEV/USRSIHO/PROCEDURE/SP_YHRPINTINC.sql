CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_YHRPINTINC" (
        pd_fecsol IN DATE, pi_keyusu IN NUMBER,
        pd_fechaact IN DATE,   pl_unifor IN SMALLINT, pl_transp IN SMALLINT,
        pn_keypro IN SMALLINT, ps_nomrep IN VARCHAR2, ps_idepcc IN VARCHAR2, ps_arefis IN VARCHAR2,
        vi_valret OUT NUMBER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
---sp_yhrpintinc
   -- ---------------------------------------------------------------------------------------------------------------
   -- OJO LA MAYORIA DE LOS PARAMETROS VIENEN VACIOS DEBIDO A QUE ANTES SE PEDIAN EN PANTALLA
   -- REGRESARA EL SECUENCIAL DEL RPH Y A CONTINUACION LOS
   -- SECUENCIALES DE LOS GDP'S.
   -- LOS REGISTROS QUE SE GENERAN DE ESTA INTERFASE SE PODRAN
   -- DISTINGUIR POR MEDIO DEL CAMPO holofrph.frp_pertra = 999
   --
   -- Modifico: Emilio Pulido R. 25.05.06 Modifique para ingnorar lo que se estaba
   -- almacenando en wn_pertra
   -- que se guardaba en frp_pertra. Ahora se guarda en li_fpafin el valor que traiga en tmp_cont_exclu.con_fpafin
   -- --------------------------------------------------------------------------------------------------------------
   li_secrph NUMBER(10);li_secgdp NUMBER(10);li_captot NUMBER(10);li_numcap NUMBER(10);li_capdis NUMBER(10);
          li_plaza NUMBER(10);li_empleado NUMBER(10);li_tipcon NUMBER(10);li_folio NUMBER(10);
   ld_valor NUMBER(16,2);ld_costo NUMBER(16,2);ld_costototal NUMBER(16,2);
   ls_puesto VARCHAR2(16);
   ls_keycon VARCHAR2(4);
   li_valsec NUMBER(10);
   li_emptotal NUMBER(15,0);
   ws_equiva VARCHAR2(1);
   li_keynom NUMBER(5);
   ls_keydep VARCHAR2(16);
   ld_fecpag DATE;
   ls_tipfol VARCHAR2(1);
   wn_pertra NUMBER(10);
   ws_nomrep VARCHAR2(10);
   ws_desnom VARCHAR2(60);
   ws_descen VARCHAR2(60);
   pd_tipcam NUMBER(16,6);
   li_emp_exclu NUMBER(10);
   li_emp_exclu1 NUMBER(10);
   li_numregis NUMBER(10);
   ls_descap VARCHAR2(200);
   li_fpafin NUMBER(5);
   pi_fpagfi NUMBER(5);
   A NUMBER(10);
   ps_programa VARCHAR2(20);
   pi_keynom SMALLINT;
   pd_fechatrab  DATE;
   pi_forpag SMALLINT;
   ps_tiptra  VARCHAR2(20);
   pn_tipcam number(16,6);
BEGIN
   li_secrph     := -1;
   li_emptotal   := 0;
   ld_costototal := 0;
   pd_tipcam     := 0;
   li_numregis   := 0;
   a  := 0;
   pi_fpagfi     := 0;
 --DELETE FROM BORRA;
   -- ---------------------------------------------------------------------------------
   -- Incializamos la Variable con el nombre del RPT para el listado de RPH's Generados
   -- ---------------------------------------------------------------------------------
   ws_nomrep := 'hrpintinc3';
   -- -----------------------------------------------------------------------
   -- Borramos de la glwkcrys la informacion anterior de los RPH's Generados
   -- ----------------------------------------------------------------------
     DELETE FROM USRSIHO.glwkcrys
     WHERE cry_nomrep = ws_nomrep
       AND cry_idepcc = ps_idepcc
       AND cry_keyusu = pi_keyusu;
   -- Ignore el 25.05.06
   -- -------------------------------
   -- Asignamos el valor de wn_pertra
   -- -------------------------------
   -- LET wn_pertra = 0;
   -- SELECT nvl(max(frp_pertra),0)+1
   --   INTO wn_pertra
   --   FROM holofrph
   --  WHERE frp_keypro = pn_keypro --100   --pn_keypro
   --    AND frp_fecact = today
   --    AND frp_pertra >= 900;
   -- IF wn_pertra < 900 THEN
   --    LET wn_pertra = 900;
   -- END IF
 --INSERT into borra VALUES ('FASE 1',0);
   -- ----------------------------------------------------------------------------
   -- Entramos al FOREACH PRINCIPAL TOMANDO DATOS DE LA GLWKRANG GRABADOS DESDE VB
   -- ----------------------------------------------------------------------------
   FOR rec IN (SELECT ran_keynom, ran_keydep,
                  ran_keycen, ran_keycon,
                  ran_keypro, ran_keyper,
                  ran_keycat, ran_keyemp
                         FROM USRSIHO.glwkrang
            WHERE ran_nomrep = ps_nomrep
              AND ran_idepcc = ps_idepcc
              AND ran_keyusu = pi_keyusu) LOOP
    pi_keynom := rec.ran_keynom;
    ps_programa := rec.ran_keydep;
    pd_fechatrab := rec.ran_keycen;
    ls_tipfol := rec.ran_keycon;
    pi_forpag := rec.ran_keypro;
    ps_tiptra := rec.ran_keyper;
    pd_tipcam := rec.ran_keycat;
    pi_fpagfi := rec.ran_keyemp;
    a := a + 1;
--INSERT into borra VALUES ('FASE 1 ciclo 1',a);
   -- -----------------------------------------------------
   -- Creamos la tabla temporal con los empleados a excluir
   -- -----------------------------------------------------
/*   INSERT INTO USRSIHO.emp_excluir
   SELECT con_keyemp exc_keyemp,COUNT(con_tipcam) exc_numinci
     FROM USRSIHO.tmp_cont_exclu
    WHERE con_stscon = 'P'
      AND con_keynom = pi_keynom
      AND con_fecpag = pd_fechatrab
      AND con_forpag = 2
      AND con_keypro = pn_keypro
      AND con_arefis = ps_arefis
    GROUP BY con_keyemp
   HAVING COUNT(*) > 1 ;*/
      li_secrph     := -1;
      li_emptotal   := 0;
      ld_costototal := 0;
      li_numregis   := 0;
      li_empleado := 0;
      ld_costo := 0;
      ls_puesto := '';
      li_folio := 0;
      li_numcap := 0;
      ls_keycon := '';
      ls_descap := '';
      -- ----------------------------------------------------------------
      -- Entramos al SEGUNDO FOREACH TOMANDO DATOS DEL FROREACH PRINCIPAL
      -- ----------------------------------------------------------------
      -- 25.05.06 Agregue con_fpafin en el SELECT y li_fpafin en el INTO y el ORDER 8 para grabarlo en la holofrph.frp_pertra
      FOR rec2 IN (SELECT con_keyemp, con_cosuni,
                     con_keypue, con_keyfol,
                     pue_ca5aux, con_tipcam,
                     NVL(con_descap,'') descap, NVL(con_fpafin,0) fpafin,
                     count(*) suma
                               FROM USRSIHO.tmp_cont_exclu, USRSIHO.nmcopues
               WHERE con_keydep = ps_programa
                 AND con_keynom = pi_keynom
                 AND con_fecpag = pd_fechatrab
                 AND con_tipfol = ls_tipfol
                 AND con_forpag = pi_forpag
                 AND con_tiptra = ps_tiptra
                 AND con_stscon = 'A'
                 AND con_keypue = pue_keypue
                 AND con_tipcam = pd_tipcam
                 AND con_keypro = pn_keypro
                 AND con_arefis = ps_arefis
                 AND con_fpafin = pi_fpagfi  ---AEDO Forma de pago final
                /* AND NOT EXISTS (SELECT exc_keyemp
                                   FROM USRSIHO.emp_excluir
                                  WHERE con_keyemp = exc_keyemp)*/
              GROUP BY con_keyemp, con_cosuni,con_keypue, con_keyfol,pue_ca5aux, con_tipcam,
                     NVL(con_descap,''), NVL(con_fpafin,0)
               ) LOOP
 --INSERT into borra VALUES ('FASE 1 ciclo 2',a);
 li_empleado := rec2.con_keyemp;
 ld_costo := rec2.con_cosuni;
 ls_puesto := rec2.con_keypue;
 li_folio := rec2.con_keyfol;
 ls_keycon := rec2.pue_ca5aux;
 pn_tipcam := rec2.con_tipcam;
 ls_descap := rec2.descap;
 li_fpafin := rec2.fpafin;
 li_numcap := rec2.suma;
 a := a + 1;
         -- ---------------------------------
         -- Si ENCONTRAMOS MAS DE UN REGISTRO
         -- ---------------------------------
         IF li_numcap > 0 THEN
            -- ------------------------------------------------------------------
            -- SI LA PRIMERA VEZ li_secrph VALE -1 ENTONCES INSERTAMOS EL HEADER
            -- ------------------------------------------------------------------
             --INSERT into borra VALUES ('FASE 1 inserta header?',a);
            IF li_secrph = -1 THEN
                --INSERT into borra VALUES ('FASE 1 inserto header',a);
               -- ------------------------------------------------------------------
               -- Definicion de la equivalencia y concepto, dependiendo de la nomina
               -- ------------------------------------------------------------------
               IF pi_keynom = 102 THEN
                  ws_equiva := 'I';
               ELSE
                  ws_equiva := 'N';
               END IF;
               ld_valor := ld_costo;
               -- -----------------------------------------------
               -- INSERTAMOS EN LA HOLOFRPH EL ENCABEZADO DEL RPH
               -- -----------------------------------------------
               INSERT INTO USRSIHO.holofrph(frp_keydep,frp_keyper,frp_fecact,frp_stsfol,
                                 frp_totcos,frp_keyusu,frp_keynom,frp_repeti,
                                 frp_tiptra,frp_fecsol,frp_fectrab,frp_forpag,
                                 frp_pertra,frp_tipfol,frp_unifor,frp_transp,
                                 frp_tipcam,frp_keypro,frp_fecitr,frp_keyare)
                          VALUES(ps_programa,null,trunc(sysdate),'0',
                              ld_valor,pi_keyusu,pi_keynom,ws_equiva  ,
                              ps_tiptra,pd_fechatrab,pd_fechatrab,pi_forpag,
                              li_fpafin,ls_tipfol,pl_unifor,pl_transp,
                              pn_tipcam,pn_keypro,pd_fechatrab,ps_arefis);
               -- ---------------------------------
               -- LECTURA DEL SECUENCIAL DEL RPH =>
               -- ---------------------------------
               --li_secrph := li_secrph + 1;
               select max(frp_keyrph) into li_secrph from USRSIHO.holofrph;
               -- RETURN li_secrph WITH RESUME;
               vi_valret := 1;
                --insert into borra VALUES (li_secrph,a);
            --ELSE
                    --INSERT into borra VALUES ('FASE 1 no inserta header',a);
            END IF;
            -- -----------------
            -- CAPITULOS TOTALES
            -- -----------------
            li_captot := li_numcap;
            -- --------------------------------------
            -- INCREMENTAMOS LAS VARIABLES DE TOTALES
            -- --------------------------------------
            ld_valor := ld_costo;
            ld_costototal := ld_costototal + ld_valor  * (li_captot);
            li_emptotal := li_emptotal + li_empleado;
            li_numregis := li_numregis + 1;
    -- ---------------------------------
    -- AEDO  11/08/06 se agrego el siguiente update para guardar el numero del RPH en el que se genero el registro
    -- ---------------------------------
          update USRSIHO.tmp_cont_exclu set con_keyrph = li_secrph
          WHERE con_keydep = ps_programa
            AND con_keynom = pi_keynom
            AND con_fecpag = pd_fechatrab
            AND con_tipfol = ls_tipfol
            AND con_forpag = pi_forpag
            AND con_tiptra = ps_tiptra
            AND con_stscon = 'A'
            AND con_keyemp = li_empleado
            AND con_tipcam = pd_tipcam
            AND con_keypro = pn_keypro
            AND con_arefis = ps_arefis
            AND con_fpafin = pi_fpagfi;  ---AEDO Forma de pago final
--insert into borra VALUES ('inserta en hologdpr',a);
            -- ---------------------------------
            -- INSERCION DE GASTOS DE PRODUCCION
            -- ---------------------------------
            INSERT INTO USRSIHO.hologdpr (gdp_keydep, gdp_keyrph, gdp_fechag, gdp_keyemp, gdp_keypue, gdp_capini,
                                  gdp_capfin, gdp_numcap, gdp_keycon, gdp_marcon, gdp_marcos, gdp_cosuni,
                                  gdp_keysue, gdp_keytco, gdp_keyfol, gdp_minleg, gdp_minsal, gdp_minext,
                                  gdp_mincom, gdp_keyusu)
                           VALUES(ps_programa, li_secrph, pd_fechatrab, li_empleado, ls_puesto, 1,
                                  1,li_captot, ls_keycon   ,'S'        ,'S'      ,ld_valor ,
                                  NULL       , 0,li_folio   ,0          ,0        ,0        ,
                                  0          , pi_keyusu);
            -- -----------------------------------
            -- LECTURA DEL SECUENCIAL DEL  GDP =>
            -- -----------------------------------
            --     li_secgdp := li_secgdp+ 1;
			BEGIN
				SELECT max(GDP_KEYSEC )
				INTO li_secgdp
				FROM USRSIHO.hologdpr;
				EXCEPTION WHEN no_data_found THEN li_secgdp := 0;
			END;
            -- RETURN li_secgdp WITH RESUME;
            vi_valret := 1;
            -- -------------------------------------------------------------------------
            -- INSERTAMOS EN LA TABLA rhdesreciap PARA LAS DESCRIPCIONES DE LOS RECIBOS
            -- -------------------------------------------------------------------------
            IF ls_descap IS NOT NULL THEN
               INSERT INTO USRSIHO.rhdesreciap (iap_keysec, iap_descap)
                                VALUES (li_secgdp , ls_descap);
            END IF;
             --insert into borra VALUES (li_secgdp,a);
             --insert into borra VALUES ('Termina empleado',a);
         END IF;
      END LOOP;
      -- ----------------------------
      -- SI EL CURSOR INSERTO UN RPH
      -- ----------------------------
      IF li_secrph > -1 THEN
         -- ------------------------------------------------------------------------------------------
         -- ACTUALIZAMOS EN HOLOFRPH EL TOTAL COSTO Y EL TOTAL EMPLEADO CON LAS SUMAS DE LOS DETALLES
         -- ------------------------------------------------------------------------------------------
         -- Ignore el 25.05.06
         -- UPDATE holofrph
         --    SET frp_totcos = ld_costototal,
         --        frp_totemp = li_emptotal,
         --        frp_pertra = wn_pertra
         --  WHERE frp_keyrph = li_secrph;
         --- Agregue el 25.05.06
         UPDATE USRSIHO.holofrph
            SET frp_totcos = ld_costototal,
                frp_totemp = li_emptotal
          WHERE frp_keyrph = li_secrph;
         -- ---------------------------------------------------------------------------------------------
         -- ACTUALIZAMOS EN TMP_CONT_EXCLU EL CON_STSCON CON  'P' PARA INDICAR QUE ESTE YA FUE PROCESADO
         -- ---------------------------------------------------------------------------------------------
         UPDATE USRSIHO.tmp_cont_exclu
            SET con_stscon = 'P',
                con_keyusu = pn_keypro,
                con_fecmod = pd_fechaact
          WHERE con_keydep = ps_programa
            AND con_keynom = pi_keynom
            AND con_fecpag = pd_fechatrab
            AND con_tipfol = ls_tipfol
            AND con_forpag = pi_forpag
            AND con_tiptra = ps_tiptra
            AND con_stscon = 'A'
            AND con_tipcam = pd_tipcam
            AND con_keypro = pn_keypro
            AND con_arefis = ps_arefis
            AND con_fpafin = pi_fpagfi  ---AEDO Forma de pago final
          /*  AND NOT EXISTS (SELECT exc_keyemp
                              FROM USRSIHO.emp_excluir
                             WHERE con_keyemp = exc_keyemp)*/;
         -- --------------------------------------------------------------------------
         -- Obtenemos la descripcion de la Nomina para efectos del reporte hrpintinc3
         -- -------------------------------------------------------------------------
         ws_desnom := '';
         ws_descen := '';
		BEGIN
			SELECT nom_destip
			INTO ws_desnom
			FROM USRSIHO.nmlonomi
			WHERE nom_keynom = pi_keynom;
			EXCEPTION WHEN no_data_found THEN ws_desnom := '';
		END;
         -- ---------------------------------------------------------------------------------
         -- Obtenemos la descripcion del Centro de Costos para efectos del reporte hrpintinc3
         -- ---------------------------------------------------------------------------------
		BEGIN
			SELECT dep_desdep
			INTO ws_descen
			FROM USRSIHO.nmcodeps
			WHERE dep_keydep = ps_programa;
			EXCEPTION WHEN no_data_found THEN ws_descen := '';
		END;
         -- ----------------------------------------------------------------------------
         -- Grabamos en la glwkcrys la Informaci??ara el reporte de RPH'S Generados --
         -- ----------------------------------------------------------------------------
                INSERT INTO USRSIHO.glwkcrys (cry_nomrep,
                                     cry_idepcc,
                                     cry_keyusu,
                                     cry_numsec,
                                     cry_dec006,
                                     cry_chr003,
                                     cry_chr012,
                                     cry_chr001,
                                     cry_chr014,
                                     cry_chr018,
                                     cry_chr017,
                                     cry_chr019,
                                      cry_chr015,
                                     cry_dec001,
                                     cry_dec011,
                                     cry_dec007,
                                     cry_dec009,
                                      cry_chr016)
                       SELECT ws_nomrep,
                                     ps_idepcc,
                                     pi_keyusu,
                                     li_secrph,
                                     pi_keynom,
                                     ws_desnom,
                                     ps_programa,
                                     ws_descen,
                                     pd_fechatrab,
                                     ls_tipfol,
                                     ps_tiptra,
                                     pi_forpag,
                                      a.pam_folini,
                                     pn_tipcam,
                                     ld_costototal,
                                     li_numregis,
                                     li_fpafin,
                                     b.pam_folini
                        FROM USRSIHO.glcopams a, USRSIHO.glcopams b
                       WHERE a.pam_keypar = 'H10'
                         AND a.pam_cvesec = pi_forpag
                         AND b.pam_keypar = 'H10'
                         AND b.pam_cvesec = li_fpafin ;
      END IF;
   END LOOP;
 ---INSERT into borra VALUES ('FASE 2',a);
   -- -------------------------------------------------------------------------------------------------
   -- -------------------------------------------------------------------------------------------------
   -- ENTRAMOS A LA SEGUNDA PARTE DE LA DESCARGA, PROCESANDO AHORA LOS EMPLEADOS QUE ANTES EXCLUIMOS --
   -- -------------------------------------------------------------------------------------------------
   -- -------------------------------------------------------------------------------------------------
   li_secrph     := -1;
   li_emptotal   := 0;
   ld_costototal := 0;
   pd_tipcam     := 0;
   li_numregis   := 0;
   -- ----------------------------------------------------------------------------------------
   -- Entramos al FOREACH PRINCIPAL TOMANDO EL CODIGO DEL EMPLEADO DE LA TABLA TEMPORAL  -----
   -- ----------------------------------------------------------------------------------------
   FOR rec3 IN (SELECT exc_keyemp
             FROM USRSIHO.emp_excluir)
             LOOP
     li_emp_exclu := rec3.exc_keyemp;
     a := a + 1;
      -- --------------------------------------------------------------
      -- Entramos al SEGUNDO FOREACH TOMANDO DATOS DE LA TMP_CONT_EXCLU
      -- --------------------------------------------------------------
      FOR rec4 IN (SELECT DISTINCT con_keyemp, con_keynom,
                              con_keydep, con_fecpag,
                              con_tipfol, con_forpag,
                              con_tiptra, con_tipcam,
                              NVL(con_fpafin,0) fpafin
                                                 FROM USRSIHO.tmp_cont_exclu
                        WHERE con_keynom = pi_keynom
                          AND con_stscon = 'A'
                          AND con_forpag = 2
                          AND con_fecpag = pd_fechatrab
                          AND con_keyemp = li_emp_exclu
                          AND con_keypro = pn_keypro
                          AND con_arefis = ps_arefis) LOOP
         li_emp_exclu1 := rec4.con_keyemp;
         pi_keynom := rec4.con_keynom;
         ps_programa := rec4.con_keydep;
         pd_fechatrab := rec4.con_fecpag;
         ls_tipfol := rec4.con_tipfol;
         pi_forpag := rec4.con_forpag;
         ps_tiptra := rec4.con_tiptra;
         pd_tipcam := rec4.con_tipcam;
         pi_fpagfi := rec4.fpafin;
         li_secrph     := -1;
         li_emptotal   := 0;
         ld_costototal := 0;
         li_numregis   := 0;
         li_empleado := 0;
         ld_costo := 0;
         ls_puesto := '';
         li_folio := 0;
         li_numcap := 0;
         ls_keycon := '';
         ls_descap := '';
a := a + 1;
         -- ------------------------------------------------------------
         -- Entramos al TERCER FOREACH TOMANDO DATOS DEL SEGUNDO FOREACH
         -- ------------------------------------------------------------
         -- 25.05.06 Agregue con_fpafin en el SELECT y li_fpafin en el INTO y el ORDER 8 para grabarlo en la holofrph.frp_pertra
         FOR rec5 IN (SELECT con_keyemp, con_cosuni,
                        con_keypue, con_keyfol,
                        pue_ca5aux, con_tipcam,
                        NVL(con_descap,'') descap, NVL(con_fpafin,0) fpafin,
                        count(*) suma
                                     FROM USRSIHO.tmp_cont_exclu, USRSIHO.nmcopues
                  WHERE con_keydep = ps_programa
                    AND con_keynom = pi_keynom
                    AND con_fecpag = pd_fechatrab
                    AND con_tipfol = ls_tipfol
                    AND con_forpag = pi_forpag
                    AND con_tiptra = ps_tiptra
                    AND con_stscon = 'A'
                    AND con_keypue = pue_keypue
                    AND con_tipcam = pd_tipcam
                    AND con_keyemp = li_emp_exclu1
                    AND con_keypro = pn_keypro
                    AND con_arefis = ps_arefis
                    AND con_fpafin = pi_fpagfi
                 GROUP BY con_keyemp, con_cosuni,
                        con_keypue, con_keyfol,
                        pue_ca5aux, con_tipcam,
                        NVL(con_descap,''), NVL(con_fpafin,0)) LOOP
li_empleado := rec5.con_keyemp;
ld_costo := rec5.con_cosuni;
ls_puesto := rec5.con_keypue;
li_folio := rec5.con_keyfol;
ls_keycon := rec5.pue_ca5aux;
pn_tipcam := rec5.con_tipcam;
ls_descap := rec5.descap;
li_fpafin := rec5.fpafin;
li_numcap := rec5.suma;
a := a + 1;
            -- ---------------------------------
            -- Si ENCONTRAMOS MAS DE UN REGISTRO
            -- ---------------------------------
            IF li_numcap > 0 THEN
               -- ------------------------------------------------------------------
               -- SI LA PRIMERA VEZ li_secrph VALE -1 ENTONCES INSERTAMOS EL HEADER
               -- ------------------------------------------------------------------
               IF li_secrph = -1 THEN
                  -- ------------------------------------------------------------------
                  -- Definicion de la equivalencia y concepto, dependiendo de la nomina
                  -- ------------------------------------------------------------------
                  IF pi_keynom = 102 THEN
                     ws_equiva := 'I';
                  ELSE
                     ws_equiva := 'N';
                  END IF;
                  ld_valor := ld_costo;
                  -- -----------------------------------------------
                  -- INSERTAMOS EN LA HOLOFRPH EL ENCABEZADO DEL RPH
                  -- -----------------------------------------------
                  --  25.05.06 Cambie en el values parametro 13 el NULL por li_fpafin
                  INSERT INTO USRSIHO.holofrph(frp_keydep, frp_keyper, frp_fecact, frp_stsfol,
                                       frp_totcos, frp_keyusu, frp_keynom, frp_repeti,
                                       frp_tiptra, frp_fecsol, frp_fectrab, frp_forpag,
                                       frp_pertra, frp_tipfol, frp_unifor, frp_transp,
                                       frp_tipcam, frp_keypro, frp_fecitr,frp_keyare)
                                 VALUES(ps_programa, null, trunc(sysdate), '0',
                                        ld_valor, pi_keyusu, pi_keynom, ws_equiva  ,
                                        ps_tiptra, pd_fechatrab, pd_fechatrab, pi_forpag,
                                        li_fpafin, ls_tipfol, pl_unifor, pl_transp,
                                        pn_tipcam, pn_keypro, pd_fechatrab,ps_arefis);
                  -- ---------------------------------
                  -- LECTURA DEL SECUENCIAL DEL RPH =>
                  -- ---------------------------------
                    --li_secrph := li_secrph + 1;
                    select max(frp_keyrph) into li_secrph from USRSIHO.holofrph;
                   -- RETURN li_secrph WITH RESUME;
                   vi_valret := 1;
                   --insert into borra VALUES (li_secrph,a);
               END IF;
               -- -----------------
               -- CAPITULOS TOTALES
               -- -----------------
               li_captot := li_numcap;
               -- --------------------------------------
               -- INCREMENTAMOS LAS VARIABLES DE TOTALES
               -- --------------------------------------
               ld_valor := ld_costo;
               ld_costototal := ld_costototal + ld_valor  * (li_captot);
               li_emptotal := li_emptotal + li_empleado;
               li_numregis := li_numregis + 1;
       -- ---------------------------------
       -- AEDO  11/08/06 se agrego el siguiente update para guardar el numero del RPH en el que se genero el registro
       -- ---------------------------------
          update USRSIHO.tmp_cont_exclu set con_keyrph = li_secrph
          WHERE con_keydep = ps_programa
            AND con_keynom = pi_keynom
            AND con_fecpag = pd_fechatrab
            AND con_tipfol = ls_tipfol
            AND con_forpag = pi_forpag
            AND con_tiptra = ps_tiptra
            AND con_stscon = 'A'
            AND con_keyemp = li_empleado
            AND con_tipcam = pd_tipcam
            AND con_keypro = pn_keypro
            AND con_arefis = ps_arefis
            AND con_fpafin = pi_fpagfi;  ---AEDO Forma de pago final
               -- ---------------------------------
               -- INSERCION DE GASTOS DE PRODUCCION
               -- ---------------------------------
               INSERT INTO USRSIHO.hologdpr (gdp_keydep, gdp_keyrph, gdp_fechag, gdp_keyemp, gdp_keypue, gdp_capini,
                                     gdp_capfin, gdp_numcap, gdp_keycon, gdp_marcon, gdp_marcos, gdp_cosuni,
                                     gdp_keysue, gdp_keytco, gdp_keyfol, gdp_minleg, gdp_minsal, gdp_minext,
                                     gdp_mincom, gdp_keyusu)
                              VALUES(ps_programa, li_secrph, pd_fechatrab, li_empleado, ls_puesto, 1,
                                     1, li_captot, ls_keycon   ,'S'        ,'S'       , ld_valor ,
                                     NULL       , 0, li_folio   ,0          ,0        , 0        ,
                                     0          , pi_keyusu);
               -- -----------------------------------
               -- LECTURA DEL SECUENCIAL DEL  GDP =>
               -- -----------------------------------
                  li_secgdp := li_secgdp+ 1;
                -- RETURN li_secgdp WITH RESUME;
                vi_valret := 1;
               -- -------------------------------------------------------------------------
               -- INSERTAMOS EN LA TABLA rhdesreciap PARA LAS DESCRIPCIONES DE LOS RECIBOS
               -- -------------------------------------------------------------------------
               IF ls_descap <> '' THEN
                  INSERT INTO USRSIHO.rhdesreciap (iap_keysec, iap_descap)
                                   VALUES (li_secgdp , ls_descap);
               END IF;
               ------------------------------------------------------------------------------
                --insert into borra VALUES (li_secgdp,a);
            END IF;
         END LOOP;
         -- ----------------------------
         -- SI EL CURSOR INSERTO UN RPH
         -- ----------------------------
         IF li_secrph > -1 THEN
            -- ------------------------------------------------------------------------------------------
            -- ACTUALIZAMOS EN HOLOFRPH EL TOTAL COSTO Y EL TOTAL EMPLEADO CON LAS SUMAS DE LOS DETALLES
            -- ------------------------------------------------------------------------------------------
            -- Ignore el 25.05.06
            -- UPDATE holofrph
            --    SET frp_totcos = ld_costototal,
            --        frp_totemp = li_emptotal,
            --        frp_pertra = wn_pertra
            --  WHERE frp_keyrph = li_secrph;
            -- Agregue el 25.05.06
            UPDATE USRSIHO.holofrph
               SET frp_totcos = ld_costototal,
                   frp_totemp = li_emptotal
             WHERE frp_keyrph = li_secrph;
            -- ---------------------------------------------------------------------------------------------
            -- ACTUALIZAMOS EN TMP_CONT_EXCLU EL CON_STSCON CON  'P' PARA INDICAR QUE ESTE YA FUE PROCESADO
            -- ---------------------------------------------------------------------------------------------
            UPDATE USRSIHO.tmp_cont_exclu
               SET con_stscon = 'P',
                   con_keyusu = pn_keypro,
                   con_fecmod = pd_fechaact
             WHERE con_keydep = ps_programa
               AND con_keynom = pi_keynom
               AND con_fecpag = pd_fechatrab
               AND con_tipfol = ls_tipfol
               AND con_forpag = pi_forpag
               AND con_tiptra = ps_tiptra
               AND con_stscon = 'A'
               AND con_tipcam = pd_tipcam
               AND con_keyemp = li_emp_exclu1
               AND con_keypro = pn_keypro
               AND con_arefis = ps_arefis
               AND con_fpafin = pi_fpagfi;  ---AEDO Forma de pago final
            -- --------------------------------------------------------------------------
            -- Obtenemos la descripcion de la Nomina para efectos del reporte hrpintinc3
            -- -------------------------------------------------------------------------
            ws_desnom := '';
            ws_descen := '';
            SELECT nom_destip
              INTO ws_desnom
              FROM USRSIHO.nmlonomi
             WHERE nom_keynom = pi_keynom;
            -- ---------------------------------------------------------------------------------
            -- Obtenemos la descripcion del Centro de Costos para efectos del reporte hrpintinc3
            -- ---------------------------------------------------------------------------------
			BEGIN
				SELECT dep_desdep
				INTO ws_descen
				FROM USRSIHO.nmcodeps
				WHERE dep_keydep = ps_programa;
				EXCEPTION WHEN no_data_found THEN ws_descen := '';
			END;
                  INSERT INTO USRSIHO.glwkcrys (cry_nomrep,
                                        cry_idepcc,
                                        cry_keyusu,
                                        cry_numsec,
                                        cry_dec006,
                                        cry_chr003,
                                        cry_chr012,
                                        cry_chr001,
                                        cry_chr014,
                                        cry_chr018,
                                        cry_chr017,
                                        cry_chr019,
                                        cry_chr015,
                                        cry_dec001,
                                        cry_dec011,
                                        cry_dec007,
                                        cry_dec009,
                                        cry_chr016)
                                 SELECT ws_nomrep,
                                        ps_idepcc,
                                        pi_keyusu,
                                        li_secrph,
                                        pi_keynom,
                                        ws_desnom,
                                        ps_programa,
                                        ws_descen,
                                        pd_fechatrab,
                                        ls_tipfol,
                                        ps_tiptra,
                                        pi_forpag,
                                        a.pam_folini,
                                        pn_tipcam,
                                        ld_costototal,
                                        li_numregis,
                                        li_fpafin,
                                        b.pam_folini
                        FROM USRSIHO.glcopams a, USRSIHO.glcopams b
                       WHERE a.pam_keypar = 'H10'
                         AND a.pam_cvesec = pi_forpag
                         AND b.pam_keypar = 'H10'
                         AND b.pam_cvesec = li_fpafin ;
         END IF;
      END LOOP;
   END LOOP;
END;
/
