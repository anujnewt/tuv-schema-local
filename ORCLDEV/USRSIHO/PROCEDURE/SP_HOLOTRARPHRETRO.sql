CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HOLOTRARPHRETRO" (pi_hojatrab NUMBER, pd_fechapag DATE,
pd_fechaact DATE, pi_keyusu NUMBER,
  pd_comidaGM NUMBER, pd_cenaGM NUMBER, pd_desayunoGM NUMBER,
pd_pasajesGM NUMBER, pd_viaticoslocGM NUMBER,li_secrph OUT NUMBER)
 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
--Declaraci??e variables
 ld_ptjeretro NUMBER(9,6);
 li_totcos NUMBER(15,2);
 li_totemp NUMBER(15,0);
 li_rphorigen NUMBER(10);
 li_hojatraborig NUMBER(10);
 w_keydep USRSIHO.HOLOFRPH.FRP_KEYDEP%TYPE;
 w_keynom USRSIHO.HOLOFRPH.FRP_KEYNOM%TYPE;
 w_repeti USRSIHO.HOLOFRPH.frp_repeti%TYPE;
 w_tiptra USRSIHO.HOLOFRPH.frp_tiptra%TYPE;
 w_fecitr USRSIHO.HOLOFRPH.frp_fecitr%TYPE;
 w_fectrab USRSIHO.HOLOFRPH.frp_fectrab%TYPE;
 w_forpag USRSIHO.HOLOFRPH.frp_forpag%TYPE;
 w_tipcam USRSIHO.HOLOFRPH.frp_tipcam%TYPE;
 w_pertra USRSIHO.HOLOFRPH.frp_pertra%TYPE;
 w_tipfol USRSIHO.HOLOFRPH.frp_tipfol%TYPE;
 w_totemp USRSIHO.HOLOFRPH.frp_totemp%TYPE;
 w_keypro USRSIHO.HOLOFRPH.frp_keypro%TYPE;
 w_unifor USRSIHO.HOLOFRPH.frp_unifor%TYPE;
 w_transp USRSIHO.HOLOFRPH.frp_transp%TYPE;
 w_ident USRSIHO.HOLOFRPH.frp_ident%TYPE;
 w_keyare USRSIHO.HOLOFRPH.frp_keyare%TYPE;
 w_desrep USRSIHO.HOLOFRPH.frp_desrep%TYPE;
 w_descap USRSIHO.HOLOFRPH.frp_descap%TYPE;
BEGIN
--Inicializacion de variables
li_secrph := 0;
ld_ptjeretro := 0;
li_totcos := 0.0;
li_totemp := 0;
li_rphorigen := 0;
li_hojatraborig := 0;
--Obtenemos el porcentaje del retroactivo
BEGIN
    SELECT pam_folini
    INTO ld_ptjeretro
    FROM USRSIHO.GLCOPAMS
    WHERE pam_keypar in (SELECT pam_folini
                        FROM USRSIHO.glcopams
                       WHERE pam_keypar='00'
                         AND pam_cvesec='loretr')
    AND PAM_NOMPAR LIKE '%PORCENTAJE%';
    EXCEPTION WHEN no_data_found THEN ld_ptjeretro := 0;
END;
--Obtenemos la hoja origen para obtener el RPH
BEGIN
    SELECT to_number(substr(enc_descap,23,8))
    INTO li_hojatraborig
      FROM USRSIHO.HOLOENCTRA
     WHERE enc_num_id = pi_hojatrab;
     EXCEPTION WHEN no_data_found THEN li_hojatraborig := 0;
END;
--Obtenemos el numero del RPH Origen
BEGIN
    SELECT DISTINCT det_keyrph
    INTO li_rphorigen
    FROM USRSIHO.HOLOENCTRA, USRSIHO.HOLODETTRA, USRSIHO.HOLOFRPH
    WHERE enc_num_id = det_num_id
    AND det_keyrph = frp_keyrph
    AND det_keyrph IS NOT NULL
    AND enc_num_id = li_hojatraborig;
    EXCEPTION WHEN no_data_found THEN li_rphorigen := 0;
END;
SELECT frp_keydep,frp_keynom,
        frp_repeti,frp_tiptra,frp_fecitr,frp_fectrab,frp_forpag,frp_tipcam,
        frp_pertra,frp_tipfol,frp_totemp,frp_keypro,frp_unifor,frp_transp,NVL(frp_ident,''),
        frp_keyare,NVL(frp_desrep,''),NVL(frp_descap,'')
  INTO w_keydep,w_keynom,
        w_repeti,w_tiptra,w_fecitr,w_fectrab,w_forpag,w_tipcam,
        w_pertra,w_tipfol,w_totemp,w_keypro,w_unifor,w_transp,w_ident,
        w_keyare,w_desrep,w_descap
  FROM USRSIHO.HOLOFRPH
 WHERE frp_keyrph = li_rphorigen;
INSERT INTO USRSIHO.HOLOFRPH
        (frp_keydep,frp_keyper,frp_fecact,frp_stsfol,frp_totcos,frp_keyusu,frp_keynom,
        frp_repeti,frp_tiptra,frp_fecsol,frp_fecitr,frp_fectrab,frp_forpag,frp_tipcam,
        frp_pertra,frp_tipfol,frp_totemp,frp_keypro,frp_unifor,frp_transp,frp_ident,
        frp_keyare,frp_desrep,frp_descap)
 VALUES (w_keydep,'0',pd_fechaact,'0',0,pi_keyusu,w_keynom,
        w_repeti,w_tiptra,pd_fechapag,w_fecitr,w_fectrab,w_forpag,w_tipcam,
        w_pertra,w_tipfol,w_totemp,w_keypro,w_unifor,w_transp,w_ident,
        w_keyare,w_desrep,w_descap)
 RETURNING frp_keyrph INTO li_secrph;
--Insertamos el detalle del RPH a partir del RPH origen calculando el porcentaje del retroactivo en una tabla temporal
INSERT INTO USRSIHO.HOLOGDPR
(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,
gdp_capini,gdp_capfin,gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,
gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,gdp_minleg,gdp_minsal,gdp_minext,
gdp_mincom)
SELECT hgd_keydep,li_secrph,pd_fechaact,hgd_keyemp,NVL(hgd_regrfc,''),NVL(hgd_recurp,''),hgd_keypue,
  hgd_capini,hgd_capfin,hgd_numcap,hgd_keycon,hgd_marcon,hgd_marcos,ROUND(CASE WHEN holohgdp.hgd_keypue = 1053 THEN ROUND(pd_pasajesGM,0)
                                                                             WHEN holohgdp.hgd_keypue = 1055 THEN ROUND(pd_viaticoslocGM,0)
                                                                             WHEN holohgdp.hgd_keypue = 1056 THEN ROUND(pd_desayunoGM,0)
                                                                             WHEN holohgdp.hgd_keypue = 1060 THEN ROUND(pd_comidaGM,0)
                                                                             WHEN holohgdp.hgd_keypue = 1060 THEN ROUND(pd_cenaGM,0)
                                                                             WHEN holohgdp.hgd_keypue = 1095 THEN ROUND(pd_comidaGM,0)
                                                                             WHEN holohgdp.hgd_keypue = 1096 THEN ROUND(pd_cenaGM,0)
                                                                             WHEN holohgdp.hgd_keycon = 'HE4' THEN ROUND((hgd_costog * (4.5/100)),2)
                                                                             WHEN holohgdp.hgd_keycon = 'HIT' THEN ROUND((hgd_costog * (4.5/100)),2)
                                                                        ELSE
                                                                             ROUND(hgd_costog * (ld_ptjeretro/100),0)
                                                                        END,2),
  NVL(hgd_keysue,''),NVL(hgd_keytco,0),NVL(hgd_keyfol,0),pi_keyusu,NVL(hgd_minleg,0),NVL(hgd_minsal,0),NVL(hgd_minext,0),
  NVL(hgd_mincom,0)
FROM USRSIHO.HOLOHGDP
  WHERE hgd_keyrph = li_rphorigen
   AND (hgd_keycon NOT IN ('HE4','HIT') OR hgd_keypue NOT IN (SELECT pue_ca1aux FROM USRSIHO.nmcopues WHERE pue_ca1aux IS NOT NULL));
--Calcula el Importe Extra Retroactivo
INSERT INTO USRSIHO.hex_hologdpr
SELECT gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,pue_ca1aux gdp_keypue,
MAX(gdp_capini) gdp_capini,MAX(gdp_capfin) gdp_capfin,SUM(gdp_numcap) gdp_numcap,gdp_keycon,'X' gdp_marcon,'X' gdp_marcos,
0 gdp_cosuni,
gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom,frp_fecitr,gdp_cosuni hex_salario
FROM USRSIHO.hologdpr,USRSIHO.holofrph,USRSIHO.nmcopues
WHERE gdp_keyrph=frp_keyrph
   AND gdp_keypue=pue_keypue
   AND gdp_keyrph= li_secrph
   AND (gdp_minleg>0 OR gdp_minsal>0)
   AND gdp_keycon IN('HA4','HTI')
   AND gdp_keyemp IN(SELECT ret.hgd_keyemp FROM USRSIHO.HOLOHGDP ret WHERE ret.hgd_keyrph= li_rphorigen
                                                               AND ret.hgd_keycon IN ('HE4','HIT')
                                                               AND ret.hgd_keypue IN (SELECT pue_ca1aux FROM USRSIHO.nmcopues))
   AND pue_ca1aux IS NOT NULL
GROUP BY gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,pue_ca1aux,gdp_keycon,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom,frp_fecitr,gdp_cosuni
;
INSERT INTO USRSIHO.hologdpr (gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,
gdp_capini,gdp_capfin,gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,
gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
SELECT gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,
gdp_capfin,gdp_capfin,1,
CASE WHEN gdp_keycon = 'HA4' THEN 'HE4'
     WHEN gdp_keycon = 'HTI' THEN 'HIT'
END,
gdp_marcon,gdp_marcos,
sp_calimptiext(gdp_minleg,gdp_minsal,gdp_mincom,1,gdp_numcap,gdp_keydep,gdp_keyfol,gdp_keypue,hex_salario,gdp_keytco,gdp_keyemp,frp_fecitr,1,pi_hojatrab) gdp_cosuni,
gdp_keysue,0,0,gdp_keyusu,gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom
FROM USRSIHO.hex_hologdpr;
--**************
--sp_calimptiext(gdp_minleg,gdp_minsal,gdp_mincom,1,gdp_numcap,gdp_keydep,gdp_keyfol,gdp_keypue,gdp_keytco,gdp_keyemp,frp_fecitr,1,pi_hojatrab) gdp_cosuni,
--Elimina los registros que tengan monto cero
DELETE
  FROM USRSIHO.HOLOGDPR
 WHERE gdp_keyrph = li_secrph
   AND gdp_cosuni = 0;
--Consulta para obtener los campos frp_totcos y frp_totemp del encabezado del RPH
SELECT SUM(NVL(gdp_numcap,0)*NVL(gdp_cosuni,0)),SUM(NVL(gdp_keyemp,0))
  INTO li_totcos,li_totemp
  FROM USRSIHO.HOLOGDPR
 WHERE gdp_keyrph = li_secrph;
--Actualiza el importe total y el total de empleados del nuevo RPH
UPDATE USRSIHO.HOLOFRPH
   SET frp_totcos = NVL(li_totcos,0),
       frp_totemp = NVL(li_totemp,0)
 WHERE frp_keyrph = li_secrph;
--Actualiza la hoja de trabajo del retroactivo con el n??o del RPH generado.
UPDATE USRSIHO.HOLODETTRA
   SET det_keyrph = li_secrph
 WHERE det_num_id = pi_hojatrab;
--Actualiza el estatus de la hoja de trabajo.
UPDATE USRSIHO.HOLOENCTRA
   SET enc_stsrep = 3
WHERE enc_num_id = pi_hojatrab;
COMMIT;
END;
/
