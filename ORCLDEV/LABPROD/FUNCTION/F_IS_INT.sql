CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."F_IS_INT" (p_cadena IN VARCHAR2)
   RETURN int -- Validar si es entero o no, depende del tipo de dato a retornar.
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   v_numero int;
BEGIN
 IF p_cadena IS NOT NULL THEN
   v_numero := TO_NUMBER( REPLACE(p_cadena, ',', '') );
   if v_numero = 0 then
   v_numero :=1;
   end if;
   RETURN v_numero;
 ELSE
  RETURN 0;
 END IF;
EXCEPTION
WHEN VALUE_ERROR THEN
   RETURN 0;
END F_IS_INT;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."F_IS_INT" (p_cadena IN VARCHAR2)
   RETURN int -- Validar si es entero o no, depende del tipo de dato a retornar.
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   v_numero int;
BEGIN
 IF p_cadena IS NOT NULL THEN
   v_numero := TO_NUMBER( REPLACE(p_cadena, ',', '') );
   if v_numero = 0 then
   v_numero :=1;
   end if;
   RETURN v_numero;
 ELSE
  RETURN 0;
 END IF;
EXCEPTION
WHEN VALUE_ERROR THEN
   RETURN 0;
END F_IS_INT;
/
