CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_TRANSF_ACTORES" (pi_hoja_trab NUMBER,ps_seriales VARCHAR2,pi_ANDA_Pens NUMBER,
ps_numreg out number)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-- CREACION:                    COMENTARIO:                                                              FECHA:
-- Juan Carlos Reyes Olivera    sp_transf_actores: Este stored procedure es el que utiliza para
--                              la tranferencia de registros de una hoja de trabajo a otra.
--                              Recibe en numero de la hoja de trabajo origen y sus registros a mover,
--                              con el detalle de los registros crea la nueva hoja de trabajo.
--
-- MODIFICO:                    COMENTARIO:                                                              FECHA:
-- Juan Carlos Reyes Olivera    Se agrego la cancelaci??n de los registros del control de capitulos       15/05/2011
--                              para que al generar la nueva hoja permita volverlos a asignarlos a la
--                              nueva hoja de trabajo.
-- -----------------------------------------------------------------
 ps_det_sindkto VARCHAR2(15);
 pi_enc_num_id NUMBER(10);
 pi_lencad NUMBER(10);
 ps_caracter VARCHAR2(1);
 pi_inicial NUMBER(10);
 pi_final NUMBER(10);
 pi_capini NUMBER(10);
 pi_auxiliar NUMBER(10);
 pi_continuos NUMBER(10);
 pi_numcap NUMBER(10);
   -- //INICIO CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 15/05/2011
--Variables para la acualizaci??n de la holococa
 Li_Reg_Min NUMBER(10);
 Li_Reg_Max NUMBER(10);
 Li_Orig_Ser NUMBER(10);
 Li_Dest_Ser NUMBER(10);
BEGIN
   -- //FIN CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 15/05/2011
pi_lencad := 0;
ps_caracter := '';
pi_inicial := 1;
pi_final := 1;
pi_capini := 1;
pi_auxiliar := 1;
pi_continuos := 1;
pi_numcap := 1;
ps_det_sindkto := 'ANDA PENSIONADA';
pi_enc_num_id := 0;
   -- //INICIO CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 15/05/2011
--Inicializaci??n de las variables para actualizar la holococa
Li_Reg_Min := 0;
Li_Reg_Max := 0;
Li_Orig_Ser := 0;
Li_Dest_Ser := 0;
   -- //FIN CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 15/05/2011
--
pi_lencad := LENGTH(TRIM(ps_seriales));
WHILE pi_final <= pi_lencad LOOP
        ps_caracter := SUBSTR(ps_seriales , pi_final , 1);
        IF ps_caracter = ',' OR pi_final = pi_lencad THEN
                IF pi_lencad = pi_final THEN pi_auxiliar := pi_final + 1; ELSE pi_auxiliar := pi_final; END IF;
                pi_capini := to_number(SUBSTR(ps_seriales , pi_inicial , pi_auxiliar - pi_inicial));
                --Se ingresan los datos a la tabla temporal
                INSERT INTO USRSIHO.TMP_AUXILIAR VALUES(pi_capini);
                pi_inicial := pi_final + 1;
        END IF;
        pi_final := pi_final + 1;
END LOOP;
--Crea tabla temporal del encabezado de la hoja de trabajo
INSERT INTO USRSIHO.TMP_HOLOENCTRA
SELECT
enc_keydep, enc_fecgra, enc_fecpag, enc_keytpr, enc_nomprd, enc_feccap,
enc_horcom, enc_keypro, enc_usuori, enc_stsrep, enc_feclib, enc_horlib,
enc_gcxxii, enc_entcom, enc_salcom, enc_auxnu1, enc_auxca1, enc_desscc,
enc_numlla, enc_conlla, 'descap'
FROM USRSIHO.holoenctra
WHERE   enc_num_id = pi_hoja_trab
;
--Crea tabla temporal del detalle de la hoja de trabajo
INSERT INTO USRSIHO.TMP_HOLODETTRA
SELECT
det_num_id,det_keydep, det_fecgra, det_keytco, det_sindkto,
det_keyfol, det_keyemp, det_nomcor, det_person, det_keypue, det_keycon,
det_noforo, det_hralla, det_hraent, det_hrasal, det_hrstra, det_capgra,
det_stsreg, det_stspag, det_keyaut, det_inanda, det_ultact, det_fecpag,
det_keyrph, det_keynom, det_cdilla, det_capini, det_capfin, det_auxnu1,
det_auxnu2, det_auxca1, det_auxca2, det_usuori, det_fecori, det_usufin,
det_fecfin, det_tipinc, det_cosuni, det_numlla
FROM  USRSIHO.holodettra
WHERE   det_num_id = pi_hoja_trab AND
        det_serial IN (SELECT det_serial FROM USRSIHO.TMP_AUXILIAR)
;
    --Inserta encabezado de la hoja de trabajo
    INSERT INTO USRSIHO.holoenctra
    (enc_keydep, enc_fecgra, enc_fecpag, enc_keytpr, enc_nomprd, enc_feccap,
    enc_horcom, enc_keypro, enc_usuori, enc_stsrep, enc_feclib, enc_horlib,
    enc_gcxxii, enc_entcom, enc_salcom, enc_auxnu1, enc_auxca1, enc_desscc,
    enc_numlla, enc_conlla)
    SELECT
    enc_keydep, enc_fecgra, enc_fecpag, enc_keytpr, enc_nomprd, enc_feccap,
    enc_horcom, enc_keypro, enc_usuori, enc_stsrep, enc_feclib, enc_horlib,
    enc_gcxxii, enc_entcom, enc_salcom, enc_auxnu1, enc_auxca1, enc_desscc,
    enc_numlla, enc_conlla
    FROM USRSIHO.TMP_HOLOENCTRA;
-- --------------------------------------------
-- Lectura del secuencial de la hoja de trabajo
-- --------------------------------------------
SELECT holoenctra_seq.currval INTO pi_enc_num_id FROM dual;
ps_numreg:=pi_enc_num_id;
--Inserta detalle de la hoja de trabajo
INSERT INTO USRSIHO.holodettra
(det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto,
det_keyfol, det_keyemp, det_nomcor, det_person, det_keypue, det_keycon,
det_noforo, det_hralla, det_hraent, det_hrasal, det_hrstra, det_capgra,
det_stsreg, det_stspag, det_keyaut, det_inanda, det_ultact, det_fecpag,
det_keyrph, det_keynom, det_cdilla, det_capini, det_capfin, det_auxnu1,
det_auxnu2, det_auxca1, det_auxca2, det_usuori, det_fecori, det_usufin,
det_fecfin, det_tipinc, det_cosuni, det_numlla)
SELECT
pi_enc_num_id, det_keydep, det_fecgra, det_keytco, case when pi_ANDA_Pens = 1 then ps_det_sindkto else det_sindkto end,
det_keyfol, det_keyemp, det_nomcor, det_person, det_keypue, det_keycon,
det_noforo, det_hralla, det_hraent, det_hrasal, det_hrstra, det_capgra,
det_stsreg, det_stspag, det_keyaut, det_inanda, det_ultact, det_fecpag,
det_keyrph, det_keynom, det_cdilla, det_capini, det_capfin, det_auxnu1,
det_auxnu2, det_auxca1, det_auxca2, det_usuori, det_fecori, det_usufin,
det_fecfin, det_tipinc, det_cosuni, det_numlla
FROM  USRSIHO.TMP_HOLODETTRA;
--Actualiza los registros que se transfirieron a otra hoja como 'E' Eliminados
UPDATE USRSIHO.holodettra
SET det_stsreg = 'E'
WHERE   det_num_id = pi_hoja_trab AND
        det_serial IN (SELECT det_serial FROM USRSIHO.TMP_AUXILIAR);
   -- //INICIO CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 15/05/2011
--Actualiza los registros de la holococa para asignarles su nueva hoja
INSERT INTO USRSIHO.TMP_ACT_COC
SELECT ORIG.DET_SERIAL,DEST.DET_SERIAL
  FROM USRSIHO.HOLODETTRA ORIG,USRSIHO.HOLODETTRA DEST
 WHERE ORIG.DET_KEYDEP = DEST.DET_KEYDEP
 AND ORIG.DET_KEYFOL = DEST.DET_KEYFOL
 AND ORIG.DET_KEYEMP = DEST.DET_KEYEMP
 AND ORIG.DET_CAPGRA = DEST.DET_CAPGRA
 AND ORIG.DET_KEYDEP = DEST.DET_KEYDEP
 AND ORIG.DET_FECGRA = DEST.DET_FECGRA
 AND ORIG.DET_NOMCOR = DEST.DET_NOMCOR
 AND ORIG.DET_NUM_ID = pi_hoja_trab
 AND DEST.DET_NUM_ID = pi_enc_num_id
 AND ORIG.DET_SERIAL IN (SELECT det_serial FROM USRSIHO.TMP_AUXILIAR);
-- ORIG.DET_SINDKTO = DEST.DET_SINDKTO
 SELECT MIN(ORIG_SERIAL),MAX(ORIG_SERIAL)
   INTO Li_Reg_Min,Li_Reg_Max
   FROM USRSIHO.TMP_ACT_COC;
 WHILE Li_Reg_Min <= Li_Reg_Max LOOP
         SELECT ORIG_SERIAL,DEST_SERIAL
           INTO Li_Orig_Ser,Li_Dest_Ser
           FROM USRSIHO.TMP_ACT_COC
          WHERE ORIG_SERIAL = Li_Reg_Min;
         UPDATE USRSIHO.HOLOCOCA
            SET coc_hjatra = pi_enc_num_id,
                coc_reghja = Li_Dest_Ser
          WHERE coc_hjatra = pi_hoja_trab
            AND coc_reghja = Li_Orig_Ser;
         SELECT MIN(ORIG_SERIAL)
           INTO Li_Reg_Min
           FROM USRSIHO.TMP_ACT_COC
          WHERE ORIG_SERIAL > Li_Reg_Min;
 END LOOP;
   -- //INICIO CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 15/05/2011
--Borra la tabla temporal
--DROP TABLE TMP_AUXILIAR;
--EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_HOLOENCTRA';
--EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_HOLODETTRA';-
--DROP TABLE TMP_ACT_COC;  --//CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 15/05/2011
END;
/
