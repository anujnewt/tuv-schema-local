CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HPGPOCAN" (pn_nomrep VARCHAR2,pn_idepcc VARCHAR2,pn_keyusu NUMBER,pn_keypro NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   ln_keyrec holoreci.rec_keyrec%TYPE;
   ln_keyemp holoreci.rec_keyemp%TYPE;
   ln_keyper nmloperi.per_keyper%TYPE;
   ln_numemi holoreci.rec_numemi%TYPE;
   ln_keyplz holocont.con_keyplz%TYPE;
   ln_keydep holocont.con_keydep%TYPE;
   ln_stspag holocont.con_stspag%TYPE;
   ln_capini holohgdp.hgd_capini%TYPE;
   ln_capfin holohgdp.hgd_capfin%TYPE;
   ln_keytva holocont.con_keytva%TYPE;
   ln_keyrph holofrph.frp_keyrph%TYPE;
---aedo
   ws_feccob VARCHAR2(10);
   ws_keyrec holoreci.rec_keyrec%TYPE;
   ws_keynom holoreci.rec_keyrec%TYPE;
   ws_numemi holoreci.rec_numemi%TYPE;
   ws_ejerci holoreci.rec_ejerci%TYPE;
   ws_keycat glwkrang.ran_keycat%TYPE;
   ws_keypue glwkrang.ran_keypue%TYPE;
   ws_keydep glwkrang.ran_keydep%TYPE;
   ln_num NUMBER(10);
   ln_keycon nmlohism.his_keycon%TYPE;
   ln_keycap holococa.coc_keycap%TYPE;
   ln_ejerci holoreci.rec_ejerci%TYPE;
--NVAS VARIABLES PARA PRESTAMOS
   ln_keycop nmlohism.his_keycon%TYPE;
   ln_keypre nmlopres.pre_keypre%TYPE;
   ln_impre  nmlohism.his_import%TYPE;
--FIN NVAS VARIABLES PRESTAMOS
   ln_acum nmlohism.his_import%TYPE;
   ln_nummes nmloperi.per_nummes%TYPE;
BEGIN
---aedo 14/feb/05
--- Se agrego el siguiente update e insert, asi como el lock, estos venian en el Proyecto y se pidio quitarlos de ahi.
        BEGIN
            select distinct ran_keycen
              into ws_feccob
              from USRSIHO.glwkrang
             where ran_nomrep = pn_nomrep
               and ran_idepcc = pn_idepcc
               and ran_keyusu = pn_keyusu
               and ran_keycen is not null;
            EXCEPTION WHEN no_data_found THEN ws_feccob := '';
        END;
        BEGIN
              select distinct ran_keynom
              INTO ws_keynom
                from USRSIHO.glwkrang
               where ran_nomrep = pn_nomrep
                 and ran_idepcc = pn_idepcc
                 and ran_keyusu = pn_keyusu
                 and ran_keynom is not null;
            EXCEPTION WHEN no_data_found THEN ws_keynom := 0;
        END;
        BEGIN
              select distinct ran_keycat
              INTO ws_keycat
                from USRSIHO.glwkrang
               where ran_nomrep = pn_nomrep
                 and ran_idepcc = pn_idepcc
                 and ran_keyusu = pn_keyusu
                 and ran_keycat is not null;
            EXCEPTION WHEN no_data_found THEN ws_keycat := 0;
        END;
        BEGIN
              select distinct ran_keypue
              INTO ws_keypue
                from USRSIHO.glwkrang
               where ran_nomrep = pn_nomrep
                 and ran_idepcc = pn_idepcc
                 and ran_keyusu = pn_keyusu
                 and ran_keypue is not null;
            EXCEPTION WHEN no_data_found THEN ws_keypue := 0;
        END;
     FOR rec  IN (select distinct ran_keydep
                from USRSIHO.glwkrang
               where ran_nomrep = pn_nomrep
                 and ran_idepcc = pn_idepcc
                 and ran_keyusu = pn_keyusu
                 and ran_keydep is not null) LOOP
                ws_keydep := rec.ran_keydep;
                UPDATE USRSIHO.holoreci
                SET rec_stsrec = 2,
                    rec_feccob = ws_feccob
              WHERE rec_keypro = pn_keypro
                AND rec_keynom = ws_keynom
                AND rec_numemi = ws_keycat
                AND rec_ejerci = ws_keypue
                AND rec_keyrec = ws_keydep;
    END LOOP;
---                    DELETE FROM glwkrang
---             WHERE ran_nomrep = pn_nomrep
---               AND ran_idepcc = pn_idepcc
---               AND ran_keyusu = pn_keyusu;
---  FOREACH   SELECT distinct pn_nomrep,pn_idepcc, pn_keyusu, pn_keypro,
  FOR rec2   IN (SELECT rec_keyrec,rec_keynom,rec_numemi,rec_ejerci
            FROM USRSIHO.holoreci
            WHERE rec_keypro = pn_keypro
            AND rec_keynom = ws_keynom
            AND rec_numemi = ws_keycat
            AND rec_stsrec = 2
            AND rec_feccob = ws_feccob
            AND rec_ejerci = ws_keypue
            AND rec_keyrec IN (select distinct ran_keydep from USRSIHO.glwkrang
                                  where ran_nomrep = 'Extras1'
                                  and ran_idepcc = pn_idepcc
                                  and ran_keyusu = pn_keyusu)) LOOP
             ws_keyrec := rec2.rec_keyrec;
             ws_keynom := rec2.rec_keynom;
             ws_numemi := rec2.rec_numemi;
             ws_ejerci := rec2.rec_ejerci;
             INSERT INTO USRSIHO.glwkrang
                   (ran_nomrep, ran_idepcc, ran_keyusu, ran_keypro, ran_keyemp,
                    ran_keynom, ran_keycen,ran_keycat)
             VALUES(pn_nomrep, pn_idepcc, pn_keyusu, pn_keypro, ws_keyrec,
                    ws_keynom, ws_numemi,ws_ejerci);
    END LOOP;
---        DELETE FROM glwkrang
---        WHERE ran_nomrep ='Extras1'
---        AND ran_idepcc = pn_idepcc
---        AND ran_keyusu = pn_keyusu;
---            delete from glwkrang
---            where ran_nomrep = pn_nomrep
---            and ran_idepcc = pn_idepcc
---            and ran_keyusu = pn_keyusu;
-----AEDO termina cambio
-- BUSQUEDA DE PERIODOS DE LOS RECIBOS
  FOR rec3 IN (SELECT distinct rec_keyrec,rec_keyemp,per_keyper,rec_numemi,per_nummes,rec_ejerci
            FROM USRSIHO.holoreci,
                 USRSIHO.nmloperi,
                 USRSIHO.glwkrang
           WHERE ran_nomrep = pn_nomrep
             AND ran_idepcc = pn_idepcc
             AND ran_keyusu = pn_keyusu
             AND ran_keypro = pn_keypro
             AND trim(ran_keycat) = rec_ejerci
             AND ran_keypro = rec_keypro
             AND ran_keyemp = rec_keyrec
             AND rec_keypro = per_keypro
             AND rec_keyapr = per_nu3aux
             AND rec_keynom = per_keynom
             AND rec_numemi = per_nu4aux) LOOP
-- Nuevo 23/01/2004
      ln_keyrec := rec3.rec_keyrec;
      ln_keyemp := rec3.rec_keyemp;
      ln_keyper := rec3.per_keyper;
      ln_numemi := rec3.rec_numemi;
      ln_nummes := rec3.per_nummes;
      ln_ejerci := rec3.rec_ejerci;
      UPDATE USRSIHO.holoreci SET rec_stsrec=2
    WHERE rec_ejerci = ln_ejerci
      AND rec_keypro = pn_keypro
      AND rec_keyrec = ln_keyrec;
-- Nuevo 20/10/2003
      UPDATE USRSIHO.nmlohism SET his_ca1aux = substr(his_ca1aux,1,3)||'2'||substr(his_ca1aux,5,10) -- HIS_CA1AUX[4]='2'
    WHERE his_keypro = pn_keypro
      AND his_keyper = ln_keyper
      AND his_keyemp = ln_keyemp;
-- BUSQUEDA DE LOS CONTRATOS
     FOR rec4 IN (SELECT con_keyplz,con_keydep,con_stspag, hgd_capini,
                    hgd_capfin,con_keytva,frp_keyrph
        FROM USRSIHO.holohgdp,
             USRSIHO.holocont,
             USRSIHO.holofrph
        WHERE frp_keypro=pn_keypro
          AND frp_keyper=ln_keyper
          AND frp_keyrph=hgd_keyrph
          AND hgd_keyemp=ln_keyemp
          AND hgd_keytco=con_keytco
          AND hgd_keyfol=con_keyfol) LOOP
--        SELECT max(coc_numsec)
--         INTO ln_num
--         FROM holococa
--         WHERE coc_keyplz = ln_keyplz
--         AND coc_keycap BETWEEN ln_capini AND ln_capfin;
       ln_keyplz := rec4.con_keyplz;
       ln_keydep := rec4.con_keydep;
       ln_stspag := rec4.con_stspag;
       ln_capini := rec4.hgd_capini;
       ln_capfin := rec4.hgd_capfin;
       ln_keytva := rec4.con_keytva;
       ln_keyrph := rec4.frp_keyrph;
       UPDATE USRSIHO.holocont
          SET con_numcdi = con_numcdi + (ln_capfin - ln_capini + 1),con_stspag='V'
        WHERE con_keyplz = ln_keyplz;
       UPDATE USRSIHO.holococa
          SET coc_stspag = 'C'
        WHERE coc_keyplz = ln_keyplz
        AND coc_keycap between ln_capini and ln_capfin
        AND coc_keyrph=ln_keyrph;
	--Se cancela la hoja de trabajo JCRO 20 Noviembre 2009
      -- -----------------------------------------------------
       UPDATE USRSIHO.holodettra
	    SET det_stsreg = 'C'
        WHERE det_serial IN (
                             SELECT coc_reghja
                               FROM USRSIHO.holococa
                              WHERE coc_keyplz = ln_keyplz
                                AND coc_keycap between ln_capini and ln_capfin
                                AND coc_keyrph=ln_keyrph
                            );
      -- -----------------------------------------------------
       -- -------------------- Nuevo 20 Mzo de 2003
       IF ln_keytva = 1 THEN
--          INSERT INTO holocanc
--          SELECT *
--            FROM USRSIHO.holococa
--           WHERE 1 = 0
--           ;
          FOR rec5 IN (SELECT coc_keycap,max(coc_numsec) maximo
                    FROM USRSIHO.holococa
                   WHERE coc_keyplz = ln_keyplz
                     AND coc_keycap BETWEEN ln_capini AND ln_capfin
                GROUP BY coc_keycap) LOOP
                ln_keycap := rec5.coc_keycap;
                ln_num := rec5.maximo;
                INSERT INTO USRSIHO.holocanc
                  SELECT *
                    FROM USRSIHO.holococa
                   WHERE coc_keyplz = ln_keyplz
                     AND coc_keycap =ln_keycap
                     AND coc_numsec =ln_num;
          END LOOP;
          -- --------------------------------------
          UPDATE USRSIHO.holocanc
             SET coc_hjatra=null,coc_reghja=null,coc_keyrph=null, coc_keygdp=null, coc_stspag='V', coc_numsec=coc_numsec + 1;
          INSERT INTO USRSIHO.holococa
          SELECT * FROM USRSIHO.holocanc;
        END IF;
    END LOOP;
-- ELIMINACION DE ISPT
   FOR rec6 IN (SELECT his_keycon,his_import
    FROM USRSIHO.nmlohism
   WHERE his_keypro = pn_keypro
     AND his_keyper = ln_keyper
     AND his_keyemp = ln_keyemp
     AND his_keycon in (
                        Select Upper(pam_folini) pam_folini
                        From USRSIHO.glcopams
                        Where pam_keypar = 'PACA'
                       )) LOOP
--     'HPG','H53','H76','28D')
         ln_keycon := rec6.his_keycon;
         ln_acum := rec6.his_import;
         IF ln_nummes = 1 THEN
           UPDATE USRSIHO.nmloacum SET acu_impuno = acu_impuno - ln_acum
            WHERE acu_keyemp = ln_keyemp
              AND acu_keycon = ln_keycon;
         END IF;
         IF ln_nummes = 2 THEN
           UPDATE USRSIHO.nmloacum SET acu_impdos = acu_impdos - ln_acum
            WHERE acu_keyemp = ln_keyemp
              AND acu_keycon = ln_keycon;
         END IF;
         IF ln_nummes = 3 THEN
           UPDATE USRSIHO.nmloacum SET acu_imptre = acu_imptre - ln_acum
            WHERE acu_keyemp = ln_keyemp
              AND acu_keycon = ln_keycon;
         END IF;
         IF ln_nummes = 4 THEN
           UPDATE USRSIHO.nmloacum SET acu_impcua = acu_impcua- ln_acum
            WHERE acu_keyemp = ln_keyemp
              AND acu_keycon = ln_keycon;
         END IF;
         IF ln_nummes = 5 THEN
           UPDATE USRSIHO.nmloacum SET acu_impcin = acu_impcin - ln_acum
            WHERE acu_keyemp = ln_keyemp
              AND acu_keycon = ln_keycon;
         END IF;
         IF ln_nummes = 6 THEN
           UPDATE USRSIHO.nmloacum SET acu_impsei = acu_impsei - ln_acum
            WHERE acu_keyemp = ln_keyemp
              AND acu_keycon = ln_keycon;
         END IF;
         IF ln_nummes = 7 THEN
           UPDATE USRSIHO.nmloacum SET acu_impsie = acu_impsie - ln_acum
            WHERE acu_keyemp = ln_keyemp
              AND acu_keycon = ln_keycon;
         END IF;
         IF ln_nummes = 8 THEN
           UPDATE USRSIHO.nmloacum SET acu_impoch = acu_impoch - ln_acum
            WHERE acu_keyemp = ln_keyemp
              AND acu_keycon = ln_keycon;
         END IF;
         IF ln_nummes = 9 THEN
           UPDATE USRSIHO.nmloacum SET acu_impnue = acu_impnue - ln_acum
            WHERE acu_keyemp = ln_keyemp
              AND acu_keycon = ln_keycon;
         END IF;
         IF ln_nummes = 10 THEN
           UPDATE USRSIHO.nmloacum SET acu_impdie = acu_impdie - ln_acum
            WHERE acu_keyemp = ln_keyemp
              AND acu_keycon = ln_keycon;
         END IF;
         IF ln_nummes = 11 THEN
           UPDATE USRSIHO.nmloacum SET acu_imponc = acu_imponc - ln_acum
            WHERE acu_keyemp = ln_keyemp
              AND acu_keycon = ln_keycon;
         END IF;
         IF ln_nummes = 12 THEN
           UPDATE USRSIHO.nmloacum SET acu_impdoc = acu_impdoc - ln_acum
            WHERE acu_keyemp = ln_keyemp
              AND acu_keycon = ln_keycon;
         END IF;
    END LOOP;
--BUSQUEDA DE PRESTAMOS A ACTUALIZAR
    FOR rec7 IN (SELECT his_keycon,his_import,his_rowide
       FROM USRSIHO.nmlohism
      WHERE his_keyemp = ln_keyemp
        AND his_keyper = ln_keyper
        AND his_keycon in (SELECT distinct pre_keycon
                             FROM USRSIHO.nmlopres
                            WHERE pre_keycon <> 'HPA')) LOOP
     ln_keycop := rec7.his_keycon;
     ln_impre := rec7.his_import;
     ln_keypre := rec7.his_rowide;
     UPDATE USRSIHO.nmlopres
        SET pre_impsal = pre_impsal + ln_impre,
            pre_impamo = pre_impamo - ln_impre
      WHERE pre_keyemp = ln_keyemp
        AND pre_keycon = ln_keycop
        AND pre_keypre = ln_keypre;
     INSERT INTO USRSIHO.PRECAN
     SELECT *
        FROM USRSIHO.nmloamor
       WHERE amo_keyemp = ln_keyemp
         AND amo_keycon = ln_keycop
         AND amo_keypre = ln_keypre
         AND amo_keyper = ln_keyper
       ;
        insert into USRSIHO.nmloamor
            (amo_keyemp,amo_keycon,amo_keypre,amo_refere,amo_keypro,
             amo_keydep,amo_keypue,amo_keycat,amo_keyubi,amo_keyper,
             amo_keynom,amo_numpag,amo_tiptra,amo_refpag,
             amo_fecpag,amo_imppag, amo_unipag,amo_intpag,
             amo_porint,amo_uniope)
        SELECT amo_keyemp,amo_keycon,amo_keypre,amo_refere,amo_keypro,
             amo_keydep,amo_keypue,amo_keycat,amo_keyubi,amo_keyper,
             amo_keynom,amo_numpag,'E','CANCELACIO',
             amo_fecpag,(amo_imppag *(-1)),amo_unipag,amo_intpag,
             amo_porint,amo_uniope
        FROM USRSIHO.PRECAN
       WHERE amo_keyemp = ln_keyemp
         AND amo_keycon = ln_keycop
         AND amo_keypre = ln_keypre
         AND amo_keyper = ln_keyper;
    END LOOP;
  END LOOP;
END;
/
