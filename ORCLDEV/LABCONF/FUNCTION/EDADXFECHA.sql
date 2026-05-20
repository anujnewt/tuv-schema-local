CREATE OR REPLACE EDITIONABLE FUNCTION "LABCONF"."EDADXFECHA" (ws_reg in varchar2,wd_fec IN DATE)
RETURN integer IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Variables para la carga de la tabla de Conceptos por Proceso.
    wn_edad integer;
    ws_ani varchar2(4);
    wd_fec_nac date;
BEGIN
  IF ((LENGTH(ws_reg)<10) or (LENGTH(ws_reg)>13)) OR ws_reg IS NULL THEN
    wn_edad:=0;
  ELSE
    ws_ani:=substr(ws_reg,5,2);
    IF (cast(ws_ani as integer) > 20) THEN
      ws_ani:='19'||ws_ani;
    ELSE
      ws_ani:='20'||ws_ani;
    END IF;
    wd_fec_nac := TO_DATE(substr(ws_reg,7,2) ||'/'|| substr(ws_reg,9,2) ||'/'|| ws_ani,'MM/DD/YYYY');
    wn_edad := trunc(months_between( wd_fec, wd_fec_nac ) /12);
  END IF;
	RETURN wn_edad;
  EXCEPTION WHEN OTHERS THEN
    RETURN 0;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "LABCONF"."EDADXFECHA" (ws_reg in varchar2,wd_fec IN DATE)
RETURN integer IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Variables para la carga de la tabla de Conceptos por Proceso.
    wn_edad integer;
    ws_ani varchar2(4);
    wd_fec_nac date;
BEGIN
  IF ((LENGTH(ws_reg)<10) or (LENGTH(ws_reg)>13)) OR ws_reg IS NULL THEN
    wn_edad:=0;
  ELSE
    ws_ani:=substr(ws_reg,5,2);
    IF (cast(ws_ani as integer) > 20) THEN
      ws_ani:='19'||ws_ani;
    ELSE
      ws_ani:='20'||ws_ani;
    END IF;
    wd_fec_nac := TO_DATE(substr(ws_reg,7,2) ||'/'|| substr(ws_reg,9,2) ||'/'|| ws_ani,'MM/DD/YYYY');
    wn_edad := trunc(months_between( wd_fec, wd_fec_nac ) /12);
  END IF;
	RETURN wn_edad;
  EXCEPTION WHEN OTHERS THEN
    RETURN 0;
END;
/
