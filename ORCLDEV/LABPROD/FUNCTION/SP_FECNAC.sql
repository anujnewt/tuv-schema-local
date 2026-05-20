CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."SP_FECNAC" (vn_regrfc in varchar2) RETURN date IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
ANIO varchar2(2);
MES  varchar2(2);
DIA  varchar2(2);
vs_fecnac varchar2(10);
vd_fecnac DATE;
BEGIN
ANIO := substr(vn_regrfc,5,2);
MES  := substr(vn_regrfc,7,2);
DIA  := substr(vn_regrfc,9,2);
IF to_number(MES)  =  0 OR
   to_number(DIA)  =  0 OR
   to_number(ANIO) =  0
THEN
  MES := '01';
  DIA := '01';
  ANIO := '51';
END IF;
IF (ANIO > 01) AND ANIO < 99 THEN
 IF MES > 0 AND MES < 13 THEN
  IF DIA > 0 AND DIA < 32 THEN
      vs_fecnac := DIA||'/'||MES||'/19'||ANIO;
      vd_fecnac := to_date(vs_fecnac,'dd/mm/yyyy');
  ELSE
     vd_fecnac := '01/01/1951';
  END IF;
 ELSE
     vd_fecnac := '01/01/1951';
 END IF;
ELSE
    vd_fecnac := '01/01/1951';
END IF;
RETURN vd_fecnac;
END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."SP_FECNAC" (vn_regrfc in varchar2) RETURN date IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
ANIO varchar2(2);
MES  varchar2(2);
DIA  varchar2(2);
vs_fecnac varchar2(10);
vd_fecnac DATE;
BEGIN
ANIO := substr(vn_regrfc,5,2);
MES  := substr(vn_regrfc,7,2);
DIA  := substr(vn_regrfc,9,2);
IF to_number(MES)  =  0 OR
   to_number(DIA)  =  0 OR
   to_number(ANIO) =  0
THEN
  MES := '01';
  DIA := '01';
  ANIO := '51';
END IF;
IF (ANIO > 01) AND ANIO < 99 THEN
 IF MES > 0 AND MES < 13 THEN
  IF DIA > 0 AND DIA < 32 THEN
      vs_fecnac := DIA||'/'||MES||'/19'||ANIO;
      vd_fecnac := to_date(vs_fecnac,'dd/mm/yyyy');
  ELSE
     vd_fecnac := '01/01/1951';
  END IF;
 ELSE
     vd_fecnac := '01/01/1951';
 END IF;
ELSE
    vd_fecnac := '01/01/1951';
END IF;
RETURN vd_fecnac;
END;
/
