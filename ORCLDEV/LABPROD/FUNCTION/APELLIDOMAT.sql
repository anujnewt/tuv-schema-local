CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."APELLIDOMAT" 
(
nombre in varchar2
) RETURN VARCHAR2 AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
resultado varchar(60);
pos1 int;
pos2 int;
BEGIN
  pos1 := INSTR(Nombre,'/');
  pos2 := INSTR(Nombre,'/',1,2);
  IF pos1 = 0 OR pos2 = 0 THEN
    resultado := '';
  ELSE
    resultado := SUBSTR(Nombre,pos1 + 1,pos2 - pos1 -1);
  END IF;
  RETURN resultado;
END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."APELLIDOMAT" 
(
nombre in varchar2
) RETURN VARCHAR2 AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
resultado varchar(60);
pos1 int;
pos2 int;
BEGIN
  pos1 := INSTR(Nombre,'/');
  pos2 := INSTR(Nombre,'/',1,2);
  IF pos1 = 0 OR pos2 = 0 THEN
    resultado := '';
  ELSE
    resultado := SUBSTR(Nombre,pos1 + 1,pos2 - pos1 -1);
  END IF;
  RETURN resultado;
END;
/
