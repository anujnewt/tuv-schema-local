CREATE OR REPLACE EDITIONABLE FUNCTION "XXMOR"."XXMOR_INSERT_CONF_FZA_VTAS_FN" 
                                 (
                                         ID_SEG_NEG     NUMBER,
                                         ID_FZA_VTAS    NUMBER,
                                         A_ID_USER      ARRAY_TVCH2,
                                         A_ADMINITRADOR ARRAY_TVCH2,
                                         TOP_AUSERS     NUMBER,
                                         THECANAL       VARCHAR2,
                                         A_CANALES      ARRAY_TVCH2,
                                         A_PORCENTAJES  ARRAY_TVCH2,
                                         TOP_ACANALES   NUMBER,
                                         ID_USER        VARCHAR2
                                 ) RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    resultado     NUMBER;
    adminYes      VARCHAR2(2);
    porcentaje    NUMBER;
    banderaUser   NUMBER;
    banderaAdmon  NUMBER;
    loggedUser    VARCHAR2(100);
    BEGIN
        resultado := 1;
        FOR i IN 1..TOP_AUSERS LOOP
            adminYes   := TO_CHAR(A_ADMINITRADOR(i));
            loggedUser := ID_USER;
            -- Verificar si el idUsuario en cuestion ya existe en la bd
            banderaUser := 0;
            SELECT COUNT(1)
            INTO   banderaUser
            FROM   XXMOR_FZAS_VTAS_USUARIOS_TAB
            WHERE  ID_SEG_NEG    = 1
            AND    ID_FZA_VENTAS = ID_FZA_VTAS
            AND    TRIM(ID_USER) = TRIM(A_ID_USER(i));
            IF(banderaUser > 0) THEN --UPDATE
              SELECT DISTINCT ADMINISTRADOR
              INTO   banderaAdmon
              FROM   XXMOR_FZAS_VTAS_USUARIOS_TAB
              WHERE  ID_SEG_NEG    = 1
              AND    ID_FZA_VENTAS = ID_FZA_VTAS
              AND    TRIM(ID_USER) = TRIM(A_ID_USER(i));
              IF(banderaAdmon <> adminYes) THEN
                UPDATE XXMOR_FZAS_VTAS_USUARIOS_TAB
                  SET  ADMINISTRADOR = adminYes,
                       UPDATED_BY    = loggedUser,
                       UPDATED_DATE  = SYSDATE
                  WHERE ID_SEG_NEG    = 1
                    AND ID_FZA_VENTAS = ID_FZA_VTAS
                    AND TRIM(ID_USER) = TRIM(A_ID_USER(i));
                    COMMIT;
              END IF;
            ELSE -- INSERT
                INSERT INTO XXMOR_FZAS_VTAS_USUARIOS_TAB
                  VALUES (ID_SEG_NEG,ID_FZA_VTAS, A_ID_USER(I),adminYes,loggedUser,SYSDATE,NULL,NULL);
                COMMIT;
            END IF;
        END LOOP;
        COMMIT;
        -- insertar canales
        /*
        DELETE FROM XXMOR_FZAS_VTAS_CANALES_TAB WHERE ID_FZA_VENTAS = ID_FZA_VTAS;
        COMMIT;
        if(TOP_ACANALES>0) then
            for i in 1..TOP_ACANALES loop
                porcentaje := to_number(A_PORCENTAJES(i));
                INSERT INTO XXMOR_FZAS_VTAS_CANALES_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, THECANAL, A_CANALES(i),PORCENTAJE,ID_USER,SYSDATE,NULL,NULL);
            end loop;
            COMMIT;
        end if;
        */
        RETURN resultado;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END XXMOR_INSERT_CONF_FZA_VTAS_FN;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "XXMOR"."XXMOR_INSERT_CONF_FZA_VTAS_FN" 
                                 (
                                         ID_SEG_NEG     NUMBER,
                                         ID_FZA_VTAS    NUMBER,
                                         A_ID_USER      ARRAY_TVCH2,
                                         A_ADMINITRADOR ARRAY_TVCH2,
                                         TOP_AUSERS     NUMBER,
                                         THECANAL       VARCHAR2,
                                         A_CANALES      ARRAY_TVCH2,
                                         A_PORCENTAJES  ARRAY_TVCH2,
                                         TOP_ACANALES   NUMBER,
                                         ID_USER        VARCHAR2
                                 ) RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    resultado     NUMBER;
    adminYes      VARCHAR2(2);
    porcentaje    NUMBER;
    banderaUser   NUMBER;
    banderaAdmon  NUMBER;
    loggedUser    VARCHAR2(100);
    BEGIN
        resultado := 1;
        FOR i IN 1..TOP_AUSERS LOOP
            adminYes   := TO_CHAR(A_ADMINITRADOR(i));
            loggedUser := ID_USER;
            -- Verificar si el idUsuario en cuestion ya existe en la bd
            banderaUser := 0;
            SELECT COUNT(1)
            INTO   banderaUser
            FROM   XXMOR_FZAS_VTAS_USUARIOS_TAB
            WHERE  ID_SEG_NEG    = 1
            AND    ID_FZA_VENTAS = ID_FZA_VTAS
            AND    TRIM(ID_USER) = TRIM(A_ID_USER(i));
            IF(banderaUser > 0) THEN --UPDATE
              SELECT DISTINCT ADMINISTRADOR
              INTO   banderaAdmon
              FROM   XXMOR_FZAS_VTAS_USUARIOS_TAB
              WHERE  ID_SEG_NEG    = 1
              AND    ID_FZA_VENTAS = ID_FZA_VTAS
              AND    TRIM(ID_USER) = TRIM(A_ID_USER(i));
              IF(banderaAdmon <> adminYes) THEN
                UPDATE XXMOR_FZAS_VTAS_USUARIOS_TAB
                  SET  ADMINISTRADOR = adminYes,
                       UPDATED_BY    = loggedUser,
                       UPDATED_DATE  = SYSDATE
                  WHERE ID_SEG_NEG    = 1
                    AND ID_FZA_VENTAS = ID_FZA_VTAS
                    AND TRIM(ID_USER) = TRIM(A_ID_USER(i));
                    COMMIT;
              END IF;
            ELSE -- INSERT
                INSERT INTO XXMOR_FZAS_VTAS_USUARIOS_TAB
                  VALUES (ID_SEG_NEG,ID_FZA_VTAS, A_ID_USER(I),adminYes,loggedUser,SYSDATE,NULL,NULL);
                COMMIT;
            END IF;
        END LOOP;
        COMMIT;
        -- insertar canales
        /*
        DELETE FROM XXMOR_FZAS_VTAS_CANALES_TAB WHERE ID_FZA_VENTAS = ID_FZA_VTAS;
        COMMIT;
        if(TOP_ACANALES>0) then
            for i in 1..TOP_ACANALES loop
                porcentaje := to_number(A_PORCENTAJES(i));
                INSERT INTO XXMOR_FZAS_VTAS_CANALES_TAB VALUES (ID_SEG_NEG,ID_FZA_VTAS, THECANAL, A_CANALES(i),PORCENTAJE,ID_USER,SYSDATE,NULL,NULL);
            end loop;
            COMMIT;
        end if;
        */
        RETURN resultado;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END XXMOR_INSERT_CONF_FZA_VTAS_FN;
/
