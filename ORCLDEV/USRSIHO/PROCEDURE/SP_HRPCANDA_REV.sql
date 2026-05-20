CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HRPCANDA_REV" (pn_nomrep VARCHAR2,pn_idepcc VARCHAR2,pn_keyusu NUMBER,pn_keypro NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   ln_keyrec holoreci_ter.rec_keyrec%TYPE;
   ln_keyemp holoreci_ter.rec_keyemp%TYPE;
   ln_keyper nmloperi.per_keyper%TYPE;
   ln_numemi holoreci_ter.rec_numemi%TYPE;
   ln_keyplz holocont.con_keyplz%TYPE;
   ln_keydep holocont.con_keydep%TYPE;
   ln_stspag holocont.con_stspag%TYPE;
   ln_capini holohgdp.hgd_capini%TYPE;
   ln_capfin holohgdp.hgd_capfin%TYPE;
   ln_keytva holocont.con_keytva%TYPE;
   ln_keyrph holofrph.frp_keyrph%TYPE;
---aedo
   ws_feccob VARCHAR2 (10);
   ws_keyrec holoreci_ter.rec_keyrec%TYPE;
   ws_keynom holoreci_ter.rec_keyrec%TYPE;
   ws_numemi holoreci_ter.rec_numemi%TYPE;
   ws_ejerci holoreci_ter.rec_ejerci%TYPE;
   ws_keycat glwkrang.ran_keycat%TYPE;
   ws_keypue glwkrang.ran_keypue%TYPE;
   ws_keydep glwkrang.ran_keydep%TYPE;
   ln_num NUMBER(10);
   ln_keycon nmlohism.his_keycon%TYPE;
   ln_keycap holococa.coc_keycap%TYPE;
   ln_ejerci holoreci_ter.rec_ejerci%TYPE;
--NVAS VARIABLES PARA PRESTAMOS
   ln_keycop nmlohism.his_keycon%TYPE;
   ln_keypre nmlopres.pre_keypre%TYPE;
   ln_impre  nmlohism.his_import%TYPE;
--FIN NVAS VARIABLES PRESTAMOS
   ln_acum nmlohism.his_import%TYPE;
   ln_nummes nmloperi.per_nummes%TYPE;
BEGIN
---aedo 14/feb/05
--- Se agrego el siguiente update e INSERT, asi como el lock, estos venian en el Proyecto y se pidio quitarlos de ahi.
--SET lock mode to wait;
-- BUSQUEDA DE PERIODOS DE LOS RECIBOS
  FOR rec IN (SELECT distinct rec_keyrec, rec_keyemp, per_keyper, rec_numemi, per_nummes, rec_ejerci
            FROM USRSIHO.holoreci, USRSIHO.nmloperi, USRSIHO.glwkrang
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
--Si es P, es el registro activo que va a PROCESAR
-- Nuevo 20/10/2003
   ln_keyrec := rec.rec_keyrec;
   ln_keyemp := rec.rec_keyemp;
   ln_keyper := rec.per_keyper;
   ln_numemi := rec.rec_numemi;
   ln_nummes := rec.per_nummes;
   ln_ejerci := rec.rec_ejerci;
   UPDATE USRSIHO.nmlohism SET HIS_CA1AUX = TRIM(SUBSTR(HIS_CA1AUX, 1, 3) || '4' || NVL(SUBSTR(HIS_CA1AUX, 5, 12), ' '))
    WHERE his_keypro = pn_keypro
      AND his_keyper = ln_keyper
      AND his_keyemp = ln_keyemp;
--BUSQUEDA DE PRESTAMOS A ACTUALIZAR
    FOR rec2 IN (SELECT his_keycon, his_import, his_rowide
              FROM USRSIHO.nmlohism
             WHERE his_keyemp = ln_keyemp
               AND his_keyper = ln_keyper
               AND his_keypro = pn_keypro
               AND his_keycon in (SELECT distinct pre_keycon
                                    FROM USRSIHO.nmlopres
                                   WHERE pre_keycon <> 'HPA')) LOOP
             ln_keycop := rec2.his_keycon;
             ln_impre := rec2.his_import;
             ln_keypre := rec2.his_rowide;
             UPDATE USRSIHO.nmlopres
                SET pre_impsal = pre_impsal + ln_impre,
                    pre_impamo = pre_impamo - ln_impre
              WHERE pre_keyemp = ln_keyemp
                AND pre_keycon = ln_keycop
                AND pre_keypro = pn_keypro
                AND pre_keypre = ln_keypre;
             INSERT INTO USRSIHO.NMLOAMOR_TMP
             SELECT *
                FROM nmloamor
               WHERE amo_keyemp = ln_keyemp
                 AND amo_keycon = ln_keycop
                 AND amo_keypre = ln_keypre
                 AND amo_keyper = ln_keyper
               ;
                INSERT INTO USRSIHO.nmloamor
                    (amo_keyemp, amo_keycon, amo_keypre, amo_refere, amo_keypro,
                     amo_keydep, amo_keypue, amo_keycat, amo_keyubi, amo_keyper,
                     amo_keynom, amo_numpag, amo_tiptra, amo_refpag,
                     amo_fecpag, amo_imppag, amo_unipag, amo_intpag,
                     amo_porint, amo_uniope)
                SELECT amo_keyemp, amo_keycon, amo_keypre, amo_refere, amo_keypro,
                       amo_keydep, amo_keypue, amo_keycat, amo_keyubi, amo_keyper,
                       amo_keynom, amo_numpag, 'E', 'CANCEL',
                       amo_fecpag, (amo_imppag *(-1)), amo_unipag, amo_intpag,
                       amo_porint, amo_uniope
                FROM USRSIHO.NMLOAMOR_TMP
               WHERE amo_keyemp = ln_keyemp
                 AND amo_keycon = ln_keycop
                 AND amo_keypre = ln_keypre
                 AND amo_keyper = ln_keyper;
    END LOOP;
  END LOOP;
END;
/
