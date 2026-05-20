CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HOCALFOM" (wn_codigo IN NUMBER, wn_folio IN NUMBER, wn_costot IN NUMBER, wn_numcap IN NUMBER)
RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 ws_puesto usrsiho.holocont.con_keypue %TYPE;
 ws_pertra usrsiho.holocont.con_pertra %TYPE;
 ws_idioma usrsiho.holocont.con_idioma %TYPE;
 ws_nacion usrsiho.holocont.con_keynac %TYPE;
 ln_suma   NUMBER(15,2);
BEGIN
-- Calculo de fomentos a la cultura y eficiencia
-- Duracisn     Tabu  Factor Fomento Activ Idi - Nac
-- 30 minutos   514   0.0312 16.0368 1000  EM
-- 15 minutos   178   0.0312  5.5536 1004  EM
-- 30 minutos   1441  0.0306 44.0946 1009  EE
-- 30 minutos   1103  0.0312 34.4136 1006  OM-OE
-- 150 minutos  3082  0.0302 93.0764 1003  OM-OE
begin
SELECT con_keypue,con_pertra,con_idioma,con_keynac
  INTO ws_puesto, ws_pertra, ws_idioma, ws_nacion
  FROM usrsiho.holocont
 WHERE con_keyemp = wn_codigo
   AND con_keyfol = wn_folio;
   exception
   WHEN NO_DATA_FOUND THEN
        ws_puesto := '';
        ws_pertra := '';
        ws_idioma := '';
        ws_nacion := '';
   END;
 ln_suma := 0;
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
 RETURN ln_suma ;
 ELSE
 RETURN 0;
 END IF;
-- ------------------------------------------------------------------------------------------------
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HOCALFOM" (wn_codigo IN NUMBER, wn_folio IN NUMBER, wn_costot IN NUMBER, wn_numcap IN NUMBER)
RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 ws_puesto usrsiho.holocont.con_keypue %TYPE;
 ws_pertra usrsiho.holocont.con_pertra %TYPE;
 ws_idioma usrsiho.holocont.con_idioma %TYPE;
 ws_nacion usrsiho.holocont.con_keynac %TYPE;
 ln_suma   NUMBER(15,2);
BEGIN
-- Calculo de fomentos a la cultura y eficiencia
-- Duracisn     Tabu  Factor Fomento Activ Idi - Nac
-- 30 minutos   514   0.0312 16.0368 1000  EM
-- 15 minutos   178   0.0312  5.5536 1004  EM
-- 30 minutos   1441  0.0306 44.0946 1009  EE
-- 30 minutos   1103  0.0312 34.4136 1006  OM-OE
-- 150 minutos  3082  0.0302 93.0764 1003  OM-OE
begin
SELECT con_keypue,con_pertra,con_idioma,con_keynac
  INTO ws_puesto, ws_pertra, ws_idioma, ws_nacion
  FROM usrsiho.holocont
 WHERE con_keyemp = wn_codigo
   AND con_keyfol = wn_folio;
   exception
   WHEN NO_DATA_FOUND THEN
        ws_puesto := '';
        ws_pertra := '';
        ws_idioma := '';
        ws_nacion := '';
   END;
 ln_suma := 0;
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
 RETURN ln_suma ;
 ELSE
 RETURN 0;
 END IF;
-- ------------------------------------------------------------------------------------------------
END;
/
