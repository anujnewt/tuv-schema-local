CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."NOMBREEMP" 
(
nombre in varchar2
) RETURN VARCHAR2 AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
resultado varchar(60);
pos int;
BEGIN
  pos := INSTR(Nombre,'/',1,2);
  IF pos = 0 THEN
    resultado := '';
  ELSE
    resultado := SUBSTR(Nombre,pos + 1,60);
  END IF;
  RETURN resultado;
END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."NOMBREEMP" 
(
nombre in varchar2
) RETURN VARCHAR2 AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
resultado varchar(60);
pos int;
BEGIN
  pos := INSTR(Nombre,'/',1,2);
  IF pos = 0 THEN
    resultado := '';
  ELSE
    resultado := SUBSTR(Nombre,pos + 1,60);
  END IF;
  RETURN resultado;
END;
/
