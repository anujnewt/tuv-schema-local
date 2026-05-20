CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."FN_DECODE" (CADENA VARCHAR2) RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
valor VARCHAR2(255);
r raw(25676);
BEGIN
IF (cadena = '' or cadena is null) then
    valor := null;
    else
    r := utl_raw.cast_to_raw(CADENA);
    r := utl_encode.base64_decode(r);
    valor := utl_raw.cast_to_varchar2(r);
    valor := convert(valor,'WE8MSWIN1252','AL32UTF8') ;
end if;
   RETURN valor;
END FN_DECODE;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."FN_DECODE" (CADENA VARCHAR2) RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
valor VARCHAR2(255);
r raw(25676);
BEGIN
IF (cadena = '' or cadena is null) then
    valor := null;
    else
    r := utl_raw.cast_to_raw(CADENA);
    r := utl_encode.base64_decode(r);
    valor := utl_raw.cast_to_varchar2(r);
    valor := convert(valor,'WE8MSWIN1252','AL32UTF8') ;
end if;
   RETURN valor;
END FN_DECODE;
/
