CREATE OR REPLACE EDITIONABLE FUNCTION "XXMOR"."XXMOR_EXISTE_FZA_VTAS_ARRAY_FN" 
                                 (
                                         P_I_ID_FZA_VTAS NUMBER,
                                         AP_I_AGRUPADOR   ARRAY_TVCH2, TOP_AGRUPADOR NUMBER,
                                         AP_I_REGION      ARRAY_TVCH2, TOP_REGION NUMBER,
                                         AP_I_SUFIJO      ARRAY_TVCH2, TOP_SUFJO NUMBER,
                                         AP_I_ACCTHDRID   ARRAY_TVCH2, TOP_ACCTHDRID NUMBER,
                                         AP_I_TIPO_SERV   ARRAY_TVCH2, TOP_TIPO_SERV NUMBER,
                                         P_I_INCLUSION   IN NUMBER
                                 ) RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    userChar VARCHAR2(5);
    spotChar VARCHAR2(5);
    response NUMBER;
    resultado VARCHAR2(10000);
    valFzaVentas  VARCHAR2(10000);
    BEGIN
        resultado := NULL;
        FOR i IN 1..TOP_AGRUPADOR LOOP
            FOR j IN 1..TOP_REGION LOOP
                FOR K IN 1..TOP_SUFJO LOOP
                    FOR l IN 1..TOP_ACCTHDRID LOOP
                        FOR M IN 1..TOP_TIPO_SERV LOOP
                            userChar := XXMOR_GET_USERSPOT_FN(AP_I_TIPO_SERV(M),1,'|');
                            spotChar := XXMOR_GET_USERSPOT_FN(AP_I_TIPO_SERV(M),2,'|');
                            SELECT XXMOR_EXISTE_FZA_VTAS_FN(P_I_ID_FZA_VTAS,
                                                            AP_I_AGRUPADOR(i),
                                                            AP_I_REGION(j),
                                                            AP_I_SUFIJO(K),
                                                            AP_I_ACCTHDRID(l),
                                                            userChar,
                                                            spotChar,
                                                            P_I_INCLUSION)
                            INTO response
                            FROM dual;
                            IF(response <> 0) THEN
                                IF(response <> P_I_ID_FZA_VTAS) THEN
                                    SELECT TRIM(NOMBRE_FZA_VENTAS)
                                    INTO valFzaVentas
                                    FROM XXMOR_FZAS_VTAS_TAB
                                    WHERE ID_FZA_VENTAS=response;
                                    resultado :=  resultado||'Fuerza de Ventas ['||
                                                valFzaVentas||']# Agrupador['||
                                                AP_I_AGRUPADOR(i)||']# Prefijo['||
                                                AP_I_REGION(j)||']# Sufijo['||
                                                AP_I_SUFIJO(K)||']# AccHdr['||
                                                AP_I_ACCTHDRID(l)||']# UserChar['||
                                                userChar||']# SpotChar['||
                                                spotChar||']# Inclusion['||
                                                P_I_INCLUSION||']|';
                                END IF;
                            END IF;
                        END LOOP;
                    END LOOP;
                END LOOP;
            END LOOP;
        END LOOP;
        RETURN resultado;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END XXMOR_EXISTE_FZA_VTAS_ARRAY_FN;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "XXMOR"."XXMOR_EXISTE_FZA_VTAS_ARRAY_FN" 
                                 (
                                         P_I_ID_FZA_VTAS NUMBER,
                                         AP_I_AGRUPADOR   ARRAY_TVCH2, TOP_AGRUPADOR NUMBER,
                                         AP_I_REGION      ARRAY_TVCH2, TOP_REGION NUMBER,
                                         AP_I_SUFIJO      ARRAY_TVCH2, TOP_SUFJO NUMBER,
                                         AP_I_ACCTHDRID   ARRAY_TVCH2, TOP_ACCTHDRID NUMBER,
                                         AP_I_TIPO_SERV   ARRAY_TVCH2, TOP_TIPO_SERV NUMBER,
                                         P_I_INCLUSION   IN NUMBER
                                 ) RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    userChar VARCHAR2(5);
    spotChar VARCHAR2(5);
    response NUMBER;
    resultado VARCHAR2(10000);
    valFzaVentas  VARCHAR2(10000);
    BEGIN
        resultado := NULL;
        FOR i IN 1..TOP_AGRUPADOR LOOP
            FOR j IN 1..TOP_REGION LOOP
                FOR K IN 1..TOP_SUFJO LOOP
                    FOR l IN 1..TOP_ACCTHDRID LOOP
                        FOR M IN 1..TOP_TIPO_SERV LOOP
                            userChar := XXMOR_GET_USERSPOT_FN(AP_I_TIPO_SERV(M),1,'|');
                            spotChar := XXMOR_GET_USERSPOT_FN(AP_I_TIPO_SERV(M),2,'|');
                            SELECT XXMOR_EXISTE_FZA_VTAS_FN(P_I_ID_FZA_VTAS,
                                                            AP_I_AGRUPADOR(i),
                                                            AP_I_REGION(j),
                                                            AP_I_SUFIJO(K),
                                                            AP_I_ACCTHDRID(l),
                                                            userChar,
                                                            spotChar,
                                                            P_I_INCLUSION)
                            INTO response
                            FROM dual;
                            IF(response <> 0) THEN
                                IF(response <> P_I_ID_FZA_VTAS) THEN
                                    SELECT TRIM(NOMBRE_FZA_VENTAS)
                                    INTO valFzaVentas
                                    FROM XXMOR_FZAS_VTAS_TAB
                                    WHERE ID_FZA_VENTAS=response;
                                    resultado :=  resultado||'Fuerza de Ventas ['||
                                                valFzaVentas||']# Agrupador['||
                                                AP_I_AGRUPADOR(i)||']# Prefijo['||
                                                AP_I_REGION(j)||']# Sufijo['||
                                                AP_I_SUFIJO(K)||']# AccHdr['||
                                                AP_I_ACCTHDRID(l)||']# UserChar['||
                                                userChar||']# SpotChar['||
                                                spotChar||']# Inclusion['||
                                                P_I_INCLUSION||']|';
                                END IF;
                            END IF;
                        END LOOP;
                    END LOOP;
                END LOOP;
            END LOOP;
        END LOOP;
        RETURN resultado;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END XXMOR_EXISTE_FZA_VTAS_ARRAY_FN;
/
