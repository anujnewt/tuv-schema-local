CREATE OR REPLACE EDITIONABLE FUNCTION "XXMOR"."XXMOR_INSERT_CONF_NOTIF_FN" 
                                 (
                                     ID_SEG_NEG         NUMBER,
                                     ID_FZA_VTAS        NUMBER,
                                     ID_NOTIFICACION    ARRAY_TVCH2,
                                     U_INTERNO          ARRAY_TVCH2,
                                     U_AGENCIA          ARRAY_TVCH2,
                                     U_FACTUR          ARRAY_TVCH2,
                                     TOP_CONFIG     NUMBER,
                                     ID_USER        VARCHAR2
                                 ) RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    resultado   NUMBER;
    flagAction  NUMBER;
    idNot       NUMBER;
    usrInterno  NUMBER;
    usrAgencia  NUMBER;
    usrFactur  NUMBER;
BEGIN
    resultado := 1;
    IF (TOP_CONFIG > 0) THEN
        FOR i IN 1..TOP_CONFIG LOOP
            -- primero ver si es update or insert
            -- busca con llave:
            idNot := TO_NUMBER(ID_NOTIFICACION(i));
            usrInterno := TO_NUMBER(U_INTERNO(i));
            usrAgencia := TO_NUMBER(U_AGENCIA(i));
            usrFactur := TO_NUMBER(U_FACTUR(i));
            SELECT COUNT(1)
            INTO   flagAction
            FROM   XXMOR_CONF_NOTIFIC_TAB
            WHERE  id_seg_neg      = ID_SEG_NEG
            AND    id_fza_ventas   = ID_FZA_VTAS
            AND    id_notificacion = idNot;
            IF (flagAction > 0) THEN
                --update
                UPDATE XXMOR_CONF_NOTIFIC_TAB
                SET    usuario_interno = usrInterno,
                       usuario_agencia = usrAgencia,
                       usuario_factur  = usrFactur,
                       updated_date    = sysdate,
                       updated_by      = ID_USER
                WHERE  id_seg_neg      = ID_SEG_NEG
                AND    id_fza_ventas   = ID_FZA_VTAS
                AND    id_notificacion = idNot;
                COMMIT;
            ELSE
                --insert
                INSERT INTO XXMOR_CONF_NOTIFIC_TAB
                VALUES ( ID_SEG_NEG,
                         ID_FZA_VTAS,
                         idNot,
                         usrInterno,
                         usrAgencia,
                         id_user,
                         sysdate,
                         null,
                         null,
                         usrFactur
                       );
                COMMIT;
            END IF;
        END LOOP;
        -- COMMIT;
    END IF;
    RETURN resultado;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END XXMOR_INSERT_CONF_NOTIF_FN;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "XXMOR"."XXMOR_INSERT_CONF_NOTIF_FN" 
                                 (
                                     ID_SEG_NEG         NUMBER,
                                     ID_FZA_VTAS        NUMBER,
                                     ID_NOTIFICACION    ARRAY_TVCH2,
                                     U_INTERNO          ARRAY_TVCH2,
                                     U_AGENCIA          ARRAY_TVCH2,
                                     U_FACTUR          ARRAY_TVCH2,
                                     TOP_CONFIG     NUMBER,
                                     ID_USER        VARCHAR2
                                 ) RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    resultado   NUMBER;
    flagAction  NUMBER;
    idNot       NUMBER;
    usrInterno  NUMBER;
    usrAgencia  NUMBER;
    usrFactur  NUMBER;
BEGIN
    resultado := 1;
    IF (TOP_CONFIG > 0) THEN
        FOR i IN 1..TOP_CONFIG LOOP
            -- primero ver si es update or insert
            -- busca con llave:
            idNot := TO_NUMBER(ID_NOTIFICACION(i));
            usrInterno := TO_NUMBER(U_INTERNO(i));
            usrAgencia := TO_NUMBER(U_AGENCIA(i));
            usrFactur := TO_NUMBER(U_FACTUR(i));
            SELECT COUNT(1)
            INTO   flagAction
            FROM   XXMOR_CONF_NOTIFIC_TAB
            WHERE  id_seg_neg      = ID_SEG_NEG
            AND    id_fza_ventas   = ID_FZA_VTAS
            AND    id_notificacion = idNot;
            IF (flagAction > 0) THEN
                --update
                UPDATE XXMOR_CONF_NOTIFIC_TAB
                SET    usuario_interno = usrInterno,
                       usuario_agencia = usrAgencia,
                       usuario_factur  = usrFactur,
                       updated_date    = sysdate,
                       updated_by      = ID_USER
                WHERE  id_seg_neg      = ID_SEG_NEG
                AND    id_fza_ventas   = ID_FZA_VTAS
                AND    id_notificacion = idNot;
                COMMIT;
            ELSE
                --insert
                INSERT INTO XXMOR_CONF_NOTIFIC_TAB
                VALUES ( ID_SEG_NEG,
                         ID_FZA_VTAS,
                         idNot,
                         usrInterno,
                         usrAgencia,
                         id_user,
                         sysdate,
                         null,
                         null,
                         usrFactur
                       );
                COMMIT;
            END IF;
        END LOOP;
        -- COMMIT;
    END IF;
    RETURN resultado;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END XXMOR_INSERT_CONF_NOTIF_FN;
/
