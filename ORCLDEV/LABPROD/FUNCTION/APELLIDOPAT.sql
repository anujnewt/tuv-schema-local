CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."APELLIDOPAT" 
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
  pos := INSTR(Nombre,'/');
  IF pos = 0 THEN
    resultado := '';
  ELSE
    resultado := SUBSTR(Nombre,1,pos - 1);
  END IF;
  RETURN resultado;
END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."APELLIDOPAT" 
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
  pos := INSTR(Nombre,'/');
  IF pos = 0 THEN
    resultado := '';
  ELSE
    resultado := SUBSTR(Nombre,1,pos - 1);
  END IF;
  RETURN resultado;
END;
/
