CREATE OR REPLACE EDITIONABLE PROCEDURE "ADMP"."ADMP_CODIGO_MEMO_PR" (
                                piinIdCanal         IN NUMBER
                                ,piinNumAnio        In NUMBER
                                ,poinNumCodigo      OUT NUMBER
                                )
    IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
        BEGIN
            SELECT  COD_MEMO + 1
            INTO    poinNumCodigo
            FROM    ADMP.ADMP_MEMO_COD_TAB
            WHERE   ID_CANAL = piinIdCanal
            AND     NUM_ANIO =  piinNumAnio;
            UPDATE  ADMP.ADMP_MEMO_COD_TAB SET  COD_MEMO = COD_MEMO + 1
            WHERE   ID_CANAL = piinIdCanal
            AND     NUM_ANIO =  piinNumAnio;
        EXCEPTION WHEN NO_DATA_FOUND THEN
        INSERT INTO ADMP.ADMP_MEMO_COD_TAB
            (ID_MEMO_COD,
            NUM_ANIO,
            ID_CANAL,
            COD_MEMO,
            NUM_CREATED_BY,
            FEC_CREATION_DATE,
            NUM_LAST_UPDATE,
            FEC_LAST_UPDATE,
            NUM_LAST_UPDATE_LOGIN)
    	VALUES
            (0,
            piinNumAnio,
            piinIdCanal,
            1,
            0,
            SYSDATE,
            0,
            SYSDATE,
            0);
        poinNumCodigo := 1;
    WHEN OTHERS THEN
    ROLLBACK;
    raise_application_error(-20001
        ,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END;
/
