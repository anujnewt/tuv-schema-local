CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABCONF"."EDAD" (ws_reg in varchar2)
RETURN integer IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Variables para la carga de la tabla de Conceptos por Proceso.
    wn_edad integer;
    ws_ani varchar2(4);
BEGIN
  IF ((LENGTH(ws_reg)<10) or (LENGTH(ws_reg)>13)) THEN
    wn_edad:=0;
  ELSE
    ws_ani:=substr(ws_reg,5,2);
    IF (cast(ws_ani as integer) > 20) THEN
      ws_ani:='19'||ws_ani;
    ELSE
      ws_ani:='20'||ws_ani;
    END IF;
    select cast(((sysdate)-cast(substr(ws_reg,7,2) ||'/'|| substr(ws_reg,9,2) ||'/'|| ws_ani as date))/365 as integer) into wn_edad
    from dual;
  END IF;
	RETURN wn_edad;
END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABCONF"."EDAD" (ws_reg in varchar2)
RETURN integer IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Variables para la carga de la tabla de Conceptos por Proceso.
    wn_edad integer;
    ws_ani varchar2(4);
BEGIN
  IF ((LENGTH(ws_reg)<10) or (LENGTH(ws_reg)>13)) THEN
    wn_edad:=0;
  ELSE
    ws_ani:=substr(ws_reg,5,2);
    IF (cast(ws_ani as integer) > 20) THEN
      ws_ani:='19'||ws_ani;
    ELSE
      ws_ani:='20'||ws_ani;
    END IF;
    select cast(((sysdate)-cast(substr(ws_reg,7,2) ||'/'|| substr(ws_reg,9,2) ||'/'|| ws_ani as date))/365 as integer) into wn_edad
    from dual;
  END IF;
	RETURN wn_edad;
END;
/
