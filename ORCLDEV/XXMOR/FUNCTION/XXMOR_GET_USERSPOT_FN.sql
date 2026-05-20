CREATE OR REPLACE EDITIONABLE FUNCTION "XXMOR"."XXMOR_GET_USERSPOT_FN" 
                                (       pist_string    VARCHAR2,
                                        piin_element   INTEGER,
                                        pist_separator VARCHAR2
                                ) RETURN  VARCHAR2 AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    lst_string     VARCHAR2(32767);
BEGIN
    lst_string := pist_string || pist_separator;
    FOR i IN 1 .. piin_element - 1 LOOP
        lst_string := SUBSTR(lst_string,INSTR(lst_string,pist_separator)+1);
    END LOOP;
    RETURN SUBSTR(lst_string,1,INSTR(lst_string,pist_separator)-1);
END XXMOR_GET_USERSPOT_FN;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "XXMOR"."XXMOR_GET_USERSPOT_FN" 
                                (       pist_string    VARCHAR2,
                                        piin_element   INTEGER,
                                        pist_separator VARCHAR2
                                ) RETURN  VARCHAR2 AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    lst_string     VARCHAR2(32767);
BEGIN
    lst_string := pist_string || pist_separator;
    FOR i IN 1 .. piin_element - 1 LOOP
        lst_string := SUBSTR(lst_string,INSTR(lst_string,pist_separator)+1);
    END LOOP;
    RETURN SUBSTR(lst_string,1,INSTR(lst_string,pist_separator)-1);
END XXMOR_GET_USERSPOT_FN;
/
