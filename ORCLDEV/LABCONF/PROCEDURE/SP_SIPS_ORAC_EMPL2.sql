CREATE OR REPLACE EDITIONABLE PROCEDURE "LABCONF"."SP_SIPS_ORAC_EMPL2" 
(vn_keyemp in integer, vp_nomemp in varchar2, vp_cvesex in varchar2, vp_regrfc in varchar2, vp_recurp in varchar2, vp_regims in varchar2, vp_fecing in date,
 vp_tipemp in varchar2, vp_fecbaj in date, vp_status in integer, vo_nomemp in varchar2, vo_cvesex in varchar2, vo_regrfc in varchar2, vo_recurp in varchar2,
vo_regims in varchar2, vo_fecing in date, vo_tipemp in varchar2, vo_fecbaj in date, vo_status in integer, tipo in varchar2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
vn_apelli varchar2(150);
vn_nomemp varchar2(150);
vn_cvesex varchar2(1);
vn_fecnac date;
vn_tipemp varchar2(16);
vn_status varchar2(16);
vn_keypro integer;
--Igneos.I --necesita variable temporal en Oracle
temporal date;
BEGIN
SELECT emp_keypro INTO vn_keypro
FROM   nmcoempl where emp_keyemp = vn_keyemp;
IF vn_keypro = 81 OR vn_keypro = 17 OR vn_keypro = 18 OR vn_keypro = 3  OR vn_keypro = 77 OR vn_keypro = 8  OR vn_keypro = 66 THEN
  IF tipo = 'IN' THEN
    SELECT trim(sp_delimitador(emp_nomemp,'/',1)) || '/' || trim(sp_delimitador(emp_nomemp,'/',2)),
        trim(sp_delimitador(emp_nomemp,'/',3)), decode(emp_cvesex,'1','M','F'),
        sp_fecnac(emp_regrfc), decode(emp_tipemp,'1','CONFIANZA','SINDICALIZADO')
    INTO
        vn_apelli, vn_nomemp, vn_cvesex, vn_fecnac, vn_tipemp
    FROM nmcoempl
    WHERE emp_keyemp=vn_keyemp;
    INSERT INTO com_sips_orac_empl
    VALUES (0,'','',vn_apelli,vn_nomemp,vn_tipemp,vn_cvesex,vp_regrfc, vp_recurp,vp_regims,vp_fecing,vn_fecnac,'PQH_MX',81,'','','EMP');
  ELSIF  vp_nomemp != vo_nomemp OR vp_cvesex != vo_cvesex OR vp_recurp != vo_recurp OR vp_regims != vo_regims OR
         vp_fecing != vo_fecing OR vp_tipemp != vo_tipemp OR vp_status != vo_status OR vp_fecbaj != vo_fecbaj THEN
    SELECT trim(sp_delimitador(emp_nomemp,'/',1))||'/'|| trim(sp_delimitador(emp_nomemp,'/',2)),
        trim(sp_delimitador(emp_nomemp,'/',3)), decode(emp_cvesex,'1','M','F'),
        sp_fecnac(emp_regrfc), decode(emp_tipemp,'1','CONFIANZA','SINDICALIZADO'), trim(decode(emp_status,1,'','EX_EMP'))
    INTO
      vn_apelli, vn_nomemp, vn_cvesex, vn_fecnac, vn_tipemp, vn_status
    FROM nmcoempl
    WHERE emp_keyemp=vn_keyemp;
    IF vn_status = 'EMP' THEN
      temporal := NULL;
    ELSE
      temporal := vp_fecbaj;
    END IF;
    INSERT INTO com_sips_orac_empl
    VALUES (0,'','',vn_apelli,vn_nomemp,vn_tipemp,vn_cvesex,vp_regrfc,vp_recurp,vp_regims,vp_fecing,vn_fecnac,'PQH_MX',81,'', temporal,vn_status);
  ELSIF vp_regrfc != vo_regrfc THEN
    INSERT INTO com_sips_orac_bita
    VALUES ('com_sips,orac_empl', vo_regrfc,vp_regrfc,vn_keyemp, SYSDATE, 'RFC ES EL CAMPO LLAVE Y CAMBIO',0,'');
  END IF;
END IF;
END;
/
