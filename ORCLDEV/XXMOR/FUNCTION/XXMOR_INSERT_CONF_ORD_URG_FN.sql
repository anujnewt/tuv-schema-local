CREATE OR REPLACE EDITIONABLE FUNCTION "XXMOR"."XXMOR_INSERT_CONF_ORD_URG_FN" 
                                 (
                                     ID_SEG_NEG     NUMBER,
                                     ID_FZA_VTAS    NUMBER,
                                     A_DIA          ARRAY_TVCH2,
                                     A_DIA_CIERRE   ARRAY_TVCH2,
                                     A_HORA_CIERRE   ARRAY_TVCH2,
                                     TOP_CONFIG     NUMBER,
                                     ID_USER        VARCHAR2
                                 ) RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    resultado   NUMBER;
    dia         NUMBER;
    diaCierre   NUMBER;
    horaCierre  DATE;
    BEGIN
        resultado := 1;
        -- insertar usuarios --------
        DELETE FROM XXMOR_CONF_ORDS_URGENTES_TAB WHERE ID_FZA_VENTAS = ID_FZA_VTAS;
        COMMIT;
        if(TOP_CONFIG>0) then
            for i in 1..TOP_CONFIG loop
                dia := to_number(A_DIA(i));
                diaCierre := to_number(A_DIA_CIERRE(i));
                horaCierre := to_date(substr(A_HORA_CIERRE(i),0,19),'YYYY-MM-DD HH24:mi:ss');
                INSERT INTO XXMOR_CONF_ORDS_URGENTES_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, dia, diaCierre, horaCierre, ID_USER, SYSDATE,NULL,NULL);
            end loop;
            COMMIT;
        end if;
        RETURN resultado;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END XXMOR_INSERT_CONF_ORD_URG_FN;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "XXMOR"."XXMOR_INSERT_CONF_ORD_URG_FN" 
                                 (
                                     ID_SEG_NEG     NUMBER,
                                     ID_FZA_VTAS    NUMBER,
                                     A_DIA          ARRAY_TVCH2,
                                     A_DIA_CIERRE   ARRAY_TVCH2,
                                     A_HORA_CIERRE   ARRAY_TVCH2,
                                     TOP_CONFIG     NUMBER,
                                     ID_USER        VARCHAR2
                                 ) RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    resultado   NUMBER;
    dia         NUMBER;
    diaCierre   NUMBER;
    horaCierre  DATE;
    BEGIN
        resultado := 1;
        -- insertar usuarios --------
        DELETE FROM XXMOR_CONF_ORDS_URGENTES_TAB WHERE ID_FZA_VENTAS = ID_FZA_VTAS;
        COMMIT;
        if(TOP_CONFIG>0) then
            for i in 1..TOP_CONFIG loop
                dia := to_number(A_DIA(i));
                diaCierre := to_number(A_DIA_CIERRE(i));
                horaCierre := to_date(substr(A_HORA_CIERRE(i),0,19),'YYYY-MM-DD HH24:mi:ss');
                INSERT INTO XXMOR_CONF_ORDS_URGENTES_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, dia, diaCierre, horaCierre, ID_USER, SYSDATE,NULL,NULL);
            end loop;
            COMMIT;
        end if;
        RETURN resultado;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END XXMOR_INSERT_CONF_ORD_URG_FN;
/
