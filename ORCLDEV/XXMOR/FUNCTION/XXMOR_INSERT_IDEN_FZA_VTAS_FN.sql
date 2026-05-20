CREATE OR REPLACE EDITIONABLE FUNCTION "XXMOR"."XXMOR_INSERT_IDEN_FZA_VTAS_FN" 
                                 (
                                         ID_SEG_NEG     NUMBER,
                                         ID_FZA_VTAS    NUMBER,
                                         AP_I_AGRUPADOR   ARRAY_TVCH2, TOP_AGRUPADOR NUMBER,
                                         AP_I_REGION      ARRAY_TVCH2, TOP_REGION NUMBER,
                                         AP_I_SUFIJO      ARRAY_TVCH2, TOP_SUFIJO NUMBER,
                                         AP_I_COMPLEM     ARRAY_TVCH2, TOP_COMPLEM NUMBER,
                                         AP_I_ACCTHDRID   ARRAY_TVCH2, TOP_ACCTHDRID NUMBER,
                                         AP_I_TIPO_SERV   ARRAY_TVCH2, TOP_TIPO_SERV NUMBER,
                                         P_I_INCLUSION  NUMBER
                                 ) RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    userChar VARCHAR2(2);
    spotChar VARCHAR2(2);
    resultado NUMBER;
    BEGIN
        resultado := 1;
        DELETE FROM XXMOR_FZAS_VTAS_IDENT_TAB WHERE ID_FZA_VENTAS = ID_FZA_VTAS;
        COMMIT;
        -- insertar AGRUPADOR --------
        IF(TOP_AGRUPADOR>0) THEN
            FOR i IN 1..TOP_AGRUPADOR LOOP
                IF(AP_I_AGRUPADOR(i) IS NOT NULL) THEN
                    INSERT INTO XXMOR_FZAS_VTAS_IDENT_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, 'G' ,AP_I_AGRUPADOR(i));
                END IF;
            END LOOP;
            COMMIT;
        END IF;
        -- insertar PREFIJOS --------
        IF(TOP_REGION>0) THEN
            FOR i IN 1..TOP_REGION LOOP
                IF(AP_I_REGION(i) IS NOT NULL) THEN
                    INSERT INTO XXMOR_FZAS_VTAS_IDENT_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, 'P' ,AP_I_REGION(i));
                END IF;
            END LOOP;
            COMMIT;
        END IF;
        -- insertar SUFIJOS --------
        IF(TOP_SUFIJO>0) THEN
            FOR i IN 1..TOP_SUFIJO LOOP
                IF(AP_I_SUFIJO(i) IS NOT NULL) THEN
                    INSERT INTO XXMOR_FZAS_VTAS_IDENT_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, 'S' ,AP_I_SUFIJO(i));
                END IF;
            END LOOP;
            COMMIT;
        END IF;
        -- insertar COMPLEMENTOS --------
        IF(TOP_COMPLEM>0) THEN
            FOR i IN 1..TOP_COMPLEM LOOP
                IF(AP_I_COMPLEM(i) IS NOT NULL) THEN
                    INSERT INTO XXMOR_FZAS_VTAS_IDENT_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, 'C' ,AP_I_COMPLEM(i));
                END IF;
            END LOOP;
            COMMIT;
        END IF;
        -- insertar ACCOUNT --------
        IF(TOP_ACCTHDRID>0) THEN
            FOR i IN 1..TOP_ACCTHDRID LOOP
                IF(AP_I_ACCTHDRID(i) IS NOT NULL) THEN
                    INSERT INTO XXMOR_FZAS_VTAS_IDENT_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, 'A' ,AP_I_ACCTHDRID(i));
                END IF;
            END LOOP;
            COMMIT;
        END IF;
        -- insertar TIPO SERVICIO --------
        DELETE FROM XXMOR_CONF_TIPO_SRV_TAB WHERE ID_FZA_VENTAS = ID_FZA_VTAS;
        COMMIT;
        IF(TOP_TIPO_SERV>0) THEN
            FOR i IN 1..TOP_TIPO_SERV LOOP
                IF(AP_I_TIPO_SERV(i) IS NOT NULL) THEN
                    userChar := XXMOR_GET_USERSPOT_FN(AP_I_TIPO_SERV(i),1,'|');
                    spotChar := XXMOR_GET_USERSPOT_FN(AP_I_TIPO_SERV(i),2,'|');
                    INSERT INTO XXMOR_CONF_TIPO_SRV_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, XXMOR_ID_TIPOSERVICIO_SQ.NEXTVAL, P_I_INCLUSION,spotChar,userChar);
                END IF;
            END LOOP;
            COMMIT;
        END IF;
        RETURN resultado;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END XXMOR_INSERT_IDEN_FZA_VTAS_FN;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "XXMOR"."XXMOR_INSERT_IDEN_FZA_VTAS_FN" 
                                 (
                                         ID_SEG_NEG     NUMBER,
                                         ID_FZA_VTAS    NUMBER,
                                         AP_I_AGRUPADOR   ARRAY_TVCH2, TOP_AGRUPADOR NUMBER,
                                         AP_I_REGION      ARRAY_TVCH2, TOP_REGION NUMBER,
                                         AP_I_SUFIJO      ARRAY_TVCH2, TOP_SUFIJO NUMBER,
                                         AP_I_COMPLEM     ARRAY_TVCH2, TOP_COMPLEM NUMBER,
                                         AP_I_ACCTHDRID   ARRAY_TVCH2, TOP_ACCTHDRID NUMBER,
                                         AP_I_TIPO_SERV   ARRAY_TVCH2, TOP_TIPO_SERV NUMBER,
                                         P_I_INCLUSION  NUMBER
                                 ) RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    userChar VARCHAR2(2);
    spotChar VARCHAR2(2);
    resultado NUMBER;
    BEGIN
        resultado := 1;
        DELETE FROM XXMOR_FZAS_VTAS_IDENT_TAB WHERE ID_FZA_VENTAS = ID_FZA_VTAS;
        COMMIT;
        -- insertar AGRUPADOR --------
        IF(TOP_AGRUPADOR>0) THEN
            FOR i IN 1..TOP_AGRUPADOR LOOP
                IF(AP_I_AGRUPADOR(i) IS NOT NULL) THEN
                    INSERT INTO XXMOR_FZAS_VTAS_IDENT_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, 'G' ,AP_I_AGRUPADOR(i));
                END IF;
            END LOOP;
            COMMIT;
        END IF;
        -- insertar PREFIJOS --------
        IF(TOP_REGION>0) THEN
            FOR i IN 1..TOP_REGION LOOP
                IF(AP_I_REGION(i) IS NOT NULL) THEN
                    INSERT INTO XXMOR_FZAS_VTAS_IDENT_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, 'P' ,AP_I_REGION(i));
                END IF;
            END LOOP;
            COMMIT;
        END IF;
        -- insertar SUFIJOS --------
        IF(TOP_SUFIJO>0) THEN
            FOR i IN 1..TOP_SUFIJO LOOP
                IF(AP_I_SUFIJO(i) IS NOT NULL) THEN
                    INSERT INTO XXMOR_FZAS_VTAS_IDENT_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, 'S' ,AP_I_SUFIJO(i));
                END IF;
            END LOOP;
            COMMIT;
        END IF;
        -- insertar COMPLEMENTOS --------
        IF(TOP_COMPLEM>0) THEN
            FOR i IN 1..TOP_COMPLEM LOOP
                IF(AP_I_COMPLEM(i) IS NOT NULL) THEN
                    INSERT INTO XXMOR_FZAS_VTAS_IDENT_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, 'C' ,AP_I_COMPLEM(i));
                END IF;
            END LOOP;
            COMMIT;
        END IF;
        -- insertar ACCOUNT --------
        IF(TOP_ACCTHDRID>0) THEN
            FOR i IN 1..TOP_ACCTHDRID LOOP
                IF(AP_I_ACCTHDRID(i) IS NOT NULL) THEN
                    INSERT INTO XXMOR_FZAS_VTAS_IDENT_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, 'A' ,AP_I_ACCTHDRID(i));
                END IF;
            END LOOP;
            COMMIT;
        END IF;
        -- insertar TIPO SERVICIO --------
        DELETE FROM XXMOR_CONF_TIPO_SRV_TAB WHERE ID_FZA_VENTAS = ID_FZA_VTAS;
        COMMIT;
        IF(TOP_TIPO_SERV>0) THEN
            FOR i IN 1..TOP_TIPO_SERV LOOP
                IF(AP_I_TIPO_SERV(i) IS NOT NULL) THEN
                    userChar := XXMOR_GET_USERSPOT_FN(AP_I_TIPO_SERV(i),1,'|');
                    spotChar := XXMOR_GET_USERSPOT_FN(AP_I_TIPO_SERV(i),2,'|');
                    INSERT INTO XXMOR_CONF_TIPO_SRV_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, XXMOR_ID_TIPOSERVICIO_SQ.NEXTVAL, P_I_INCLUSION,spotChar,userChar);
                END IF;
            END LOOP;
            COMMIT;
        END IF;
        RETURN resultado;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END XXMOR_INSERT_IDEN_FZA_VTAS_FN;
/
