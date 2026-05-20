CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_REPORT_TENCASC_PKG" 
AS
/**************************************************************************************/
/* NOMBRE: DER_CORP.DER_CORP_REPORT_TENCASC_PKG                                       */
/* APLICACION: Derecho corporativo                                                    */
/* MODULO: Derecho corporativo                                                        */
/* -----------------------------------------------------------------------------------*/
/* Descripcion: Paquete para realizar la extraccion del reporte de derecho            */
/*              corporativo llamado Tenencia en Cascada                               */
/* -----------------------------------------------------------------------------------*/
/* Autor: Kaz Consulting - NOFM                                                       */
/* -----------------------------------------------------------------------------------*/
/* REVISION HISTORICA                                                                 */
/* -----------------------------------------------------------------------------------*/
/* Fecha          Autor                       Motivo del Cambio                       */
/*                                                                                    */
/* -----------------------------------------------------------------------------------*/
/*                                                                                    */
/*                                                                                    */
/**************************************************************************************/
    -- Declaracion del tipo de arrglo que se utilizara en el paquete.
    TYPE TEN_CASC_TYP IS RECORD
        (
            ROW_NUM  NUMBER,
            Dato1    VARCHAR2(3000),
            Dato2    VARCHAR2(3000),
            Dato3    VARCHAR2(3000),
            Dato4    VARCHAR2(3000),
            Dato5    VARCHAR2(3000),
            Dato6    VARCHAR2(3000),
            Dato7    VARCHAR2(3000),
            Dato8    VARCHAR2(3000),
            Dato9    VARCHAR2(3000),
            Dato10   VARCHAR2(3000)
        );
    TYPE ARR_TEN_CASC_TYP IS TABLE OF TEN_CASC_TYP INDEX BY PLS_INTEGER;
    gRgTenCasc ARR_TEN_CASC_TYP;
    ginCountArr    NUMBER := 0;
    -- Procedimeinto principal del paquete armar reporte
    PROCEDURE DO_REPORT_PR ( postArrTenCasc  OUT SYS_REFCURSOR
                           , pistOutType     IN  VARCHAR2
                           , pistEmpresa     IN  VARCHAR2);
END DERCORP_REPORT_TENCASC_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_REPORT_TENCASC_PKG" 
AS
/**************************************************************************************/
/* NOMBRE: DER_CORP.DER_CORP_REPORT_TENCASC_PKG                                       */
/* APLICACION: Derecho corporativo                                                    */
/* MODULO: Derecho corporativo                                                        */
/* -----------------------------------------------------------------------------------*/
/* Descripcion: Paquete para realizar la extraccion del reporte de derecho            */
/*              corporativo llamado Tenencia en Cascada                               */
/* -----------------------------------------------------------------------------------*/
/* Autor: Kaz Consulting - NOFM                                                       */
/* -----------------------------------------------------------------------------------*/
/* REVISION HISTORICA                                                                 */
/* -----------------------------------------------------------------------------------*/
/* Fecha          Autor                       Motivo del Cambio                       */
/*                                                                                    */
/* -----------------------------------------------------------------------------------*/
/*                                                                                    */
/*                                                                                    */
/**************************************************************************************/
    -- Inicio - Declaracion de variables globales
    gstDbms   VARCHAR2(4) := 'DBMS';
    gstLog    VARCHAR2(3) := 'LOG';
    gstOutPut VARCHAR2(6) := 'OUTPUT';
    -- Fin - Declaracion de variables globales
    -- Procedimiento para imprimir el log o registro
    PROCEDURE PRINT_MESSAGE_PR (pistSalida   IN  VARCHAR2,
                                pistMensaje  IN  VARCHAR2)
    IS
    BEGIN
        IF pistSalida = 'LOG'
        THEN
            --FND_FILE.PUT_LINE (FND_FILE.LOG, pistMensaje);
            Null;
        ELSIF pistSalida = 'OUTPUT'
        THEN
            --FND_FILE.PUT_LINE (FND_FILE.OUTPUT, pistMensaje);
            Null;
        ELSIF pistSalida = 'DBMS'
        THEN
            DBMS_OUTPUT.PUT_LINE(pistMensaje);
            Null;
        END IF;
    END PRINT_MESSAGE_PR;
    PROCEDURE INSERT_ROW_PR(prginRow DERCORP_REPORTE_TENCASC_TMP%ROWTYPE)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO USRDRC.DERCORP_REPORTE_TENCASC_TMP
             (
                DES_Dato1,
                DES_Dato2,
                DES_Dato3,
                DES_Dato4,
                DES_Dato5,
                DES_Dato6,
                DES_Dato7,
                DES_Dato8,
                DES_Dato9,
                DES_Dato10
            )
        VALUES
             (
                prginRow.DES_Dato1,
                prginRow.DES_Dato2,
                prginRow.DES_Dato3,
                prginRow.DES_Dato4,
                prginRow.DES_Dato5,
                prginRow.DES_Dato6,
                prginRow.DES_Dato7,
                prginRow.DES_Dato8,
                prginRow.DES_Dato9,
                prginRow.DES_Dato10
            );
        COMMIT;
    END INSERT_ROW_PR;
    PROCEDURE GET_REFCURSOR_PR( pistEmpresa   IN  NUMBER)
    IS
        -- Declaracion de variables
        lrginRow DERCORP_REPORTE_TENCASC_TMP%ROWTYPE;
        -- Declaracion de cursores
        CURSOR cur_get_childs (piIdEmpresa NUMBER)
        IS
        SELECT  ID_EMPRESA,NVL(VAL_C5,0) VAL_C5
        FROM    DERCORP_METATBL_TAB
        WHERE   ID_FLEX_TBL = (SELECT  ID_FLEX_TBL
                               FROM    DERCORP_FLEX_TBLS_TAB
                               WHERE   COD_FLEX    = 'FLEX7')
            AND ID_EMPRESA != piIdEmpresa
            AND VAL_C1      = (SELECT  ID_CATALOGO_VALOR
                               FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
                               WHERE   ID_CATALOGO = 40
                                   AND VAL_CAT_VAL = (SELECT  NOM_EMPRESA
                                                      FROM    DERCORP_EMPRESA_TAB
                                                      WHERE   ID_EMPRESA = piIdEmpresa))
            --NAVA
            AND
              TO_NUMBER(VAL_C5) > (SELECT
                          TO_NUMBER(VAL_CONFIG)
                        FROM APP_CONFIG_TAB
                        WHERE
                          COD_CONFIG = 'MIN_P_TC')
        -- INICIO Codigo agregado 13-OCT-15 JFPS
        AND NOT EXISTS
        (
         SELECT 1
         FROM   USRDRC.DERCORP_REPORTE_TENCASC_TMP
         WHERE  DES_DATO1 = ID_EMPRESA
         AND    DES_DATO4 = piIdEmpresa
        )
        -- FIN C''odigo agregado  13-OCT-15 JFPS
        ;
        CURSOR cur_get_desc_childs (piIdEmpresa NUMBER)
        IS
        SELECT  ID_EMPRESA, CVE_EMPRESA, NOM_EMPRESA
        FROM    DERCORP_EMPRESA_TAB
        WHERE   ID_EMPRESA = piIdEmpresa;
    BEGIN
        --ginCountArr := 0;
        -- Traemos los datos requeridos
        FOR rgGetChilds IN cur_get_childs (pistEmpresa) LOOP
            FOR rgGetDescChilds IN cur_get_desc_childs (rgGetChilds.ID_EMPRESA) LOOP
                -- Imprimimos informacion
                --print_message_pr('DBMS', '        ROW_NUM: '||to_char(ginCountArr+1));
                --print_message_pr('DBMS', '     ID_EMPRESA: '||rgGetDescChilds.ID_EMPRESA);
                --print_message_pr('DBMS', '    CVE_EMPRESA: '||rgGetDescChilds.CVE_EMPRESA);
                --print_message_pr('DBMS', '    NOM_EMPRESA: '||rgGetDescChilds.NOM_EMPRESA);
                --print_message_pr('DBMS', 'FROM ID_EMPRESA: '||pistEmpresa);
                lrginRow.DES_Dato1   := rgGetDescChilds.ID_EMPRESA;
                lrginRow.DES_Dato2   := rgGetDescChilds.CVE_EMPRESA;
                lrginRow.DES_Dato3   := rgGetDescChilds.NOM_EMPRESA;
                lrginRow.DES_Dato4   := pistEmpresa;
                lrginRow.DES_Dato5   := RTRIM(LTRIM(TO_CHAR(rgGetChilds.val_c5,'999.999999')));
                -- Insertamos en la temporal
                INSERT_ROW_PR (lrginRow);
                -- Iniciamos la recursividad
                GET_REFCURSOR_PR ( pistEmpresa   => rgGetChilds.ID_EMPRESA);
            END LOOP;
            ginCountArr := ginCountArr +1;
        END LOOP;
    END GET_REFCURSOR_PR;
    -- Procedimiento principal para reclasificar las ordenes de compra
    PROCEDURE DO_REPORT_PR ( postArrTenCasc  OUT SYS_REFCURSOR
                           , pistOutType     IN  VARCHAR2
                           , pistEmpresa     IN  VARCHAR2)
    IS
        -- Inicio - Declaracion de variables locales
        lrcData     sys_refcursor;
        lstDesDato6 VARCHAR2(20);
        linContador VARCHAR2(10):=0;
        linSum      VARCHAR2(10):=0;
        -- Fin - Declaracion de variables locales
        -- Cursor para calcular porcentajes directos e indirectos
        CURSOR CUR_CALC_PORC_INDIRECTO (piinIdEmpresa NUMBER)
        IS
        SELECT DES_DATO1,
               DES_DATO2,
               LPAD(DES_DATO2,LENGTH(DES_DATO2) + LEVEL * 5 - 5,' ') AS NOM_EMPRESA,
               DES_DATO4,
               DES_DATO5,
               DES_DATO6,
               LEVEL
        FROM   USRDRC.DERCORP_REPORTE_TENCASC_TMP
        START WITH DES_DATO4       = piinIdEmpresa
        CONNECT BY PRIOR DES_DATO1 = DES_DATO4;
        -- Recupera niveles mayores a 1
        CURSOR CUR_NIVELES
        IS
        SELECT DES_DATO1,DES_DATO7
        FROM   USRDRC.DERCORP_REPORTE_TENCASC_TMP
        GROUP BY DES_DATO1,DES_DATO7
        HAVING COUNT (DES_DATO1) > 1;
        -- Recupera los registros de los
        -- niveles mayores a 1
        CURSOR CUR_NIVELES_HIJOS (
                                  pinpadre NUMBER
                                 ,piiLevel NUMBER
                                 )
        IS
        SELECT DISTINCT DES_DATO1,DES_DATO4,DES_DATO5
        FROM   USRDRC.DERCORP_REPORTE_TENCASC_TMP
        WHERE  DES_DATO1                          = pinpadre
        AND    DES_DATO7                          = piiLevel;
        -- Recupera registros los cuales tienen
        -- mas de una empresa padre en un nivel diferente
        -- del arbol.
        CURSOR CUR_MULTIPLE
        IS
        SELECT DES_DATO1
        FROM   USRDRC.DERCORP_REPORTE_TENCASC_TMP
        WHERE  DES_DATO8 IS NULL
        GROUP BY DES_DATO1
        HAVING COUNT (DES_DATO1) > 1;
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''. ''';
        print_message_pr(pistOutType, 'Inicia proceso ...');
        print_message_pr(pistOutType, 'Hora: '||
                         TO_CHAR(SYSDATE, 'DD-MON-RRRR HH24:MI:SS'));
        -- Inserta el registro de la empresa BASE
        INSERT INTO USRDRC.DERCORP_REPORTE_TENCASC_TMP
        (
         DES_DATO1
        ,DES_DATO2
        ,DES_DATO3
        )
        SELECT
         ID_EMPRESA
        ,NOM_EMPRESA
        ,NOM_EMPRESA
        FROM   DERCORP_EMPRESA_TAB
        WHERE  ID_EMPRESA          = pistEmpresa;
        ginCountArr    := 0;
        -- Insert code here
        GET_REFCURSOR_PR (pistEmpresa => pistEmpresa);
        OPEN lrcData
        FOR  SELECT  ROWNUM ROW_NUM
                    ,DES_DATO1,DES_DATO2,DES_DATO3
                    ,DES_DATO4,DES_DATO5,DES_DATO6
                    ,DES_DATO7,DES_DATO8,DES_DATO9
                    ,DES_DATO10
             FROM    USRDRC.DERCORP_REPORTE_TENCASC_TMP;
             postArrTenCasc := lrcData;
             COMMIT;
        -- Actualiza el % indirecto con el mismo valor del % directo
        -- para las empresas del primer nivel
        FOR GET_INFO IN CUR_CALC_PORC_INDIRECTO(pistEmpresa)
        LOOP
            -- Actualiza el campo DES_DATO7 con el Nivel
            -- que le corresponde a cada registro
            UPDATE USRDRC.DERCORP_REPORTE_TENCASC_TMP
            SET    DES_DATO7          =  GET_INFO.LEVEL
            WHERE  DES_DATO1          =
                   GET_INFO.DES_DATO1
            AND    DES_DATO4          =
                   GET_INFO.DES_DATO4;
            -- Actualiza solo sobre los niveles 1
            IF GET_INFO.LEVEL = 1
            THEN
                UPDATE USRDRC.DERCORP_REPORTE_TENCASC_TMP
                SET    DES_DATO6                         =
                       RTRIM(LTRIM(TO_CHAR(DES_DATO5,'999.999999')))
                WHERE  DES_DATO4                         =
                       GET_INFO.DES_DATO4;
            END IF;
        END LOOP;
        COMMIT;
        -- Registros mayores a Nivel 1
        FOR GET_NIVELES IN CUR_NIVELES
        LOOP
            FOR GET_NIVELES_HIJOS IN CUR_NIVELES_HIJOS (GET_NIVELES.DES_DATO1,GET_NIVELES.DES_DATO7)
            LOOP
                lstDesDato6 := NULL;
                -- Recupera el % indirecto del nivel superior
                BEGIN
                    SELECT DES_DATO6
                    INTO   lstDesDato6
                    FROM   USRDRC.DERCORP_REPORTE_TENCASC_TMP
                    WHERE  DES_DATO1                         =
                           GET_NIVELES_HIJOS.DES_DATO4;
                EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                        print_message_pr('DBMS', '1.- No se encontro el % indirecto del nivel superior');
                    WHEN TOO_MANY_ROWS
                    THEN
                        print_message_pr('DBMS', '1.- Se encontraron mas de un registro en la consulta.');
                END;
                -- Actualiza registros que tienen mas de una empresa base
                -- en un nivel superior inmediato
                -- y el campo DES_DATO8 con el valor de Y para identificar estos casos.
                UPDATE USRDRC.DERCORP_REPORTE_TENCASC_TMP
                SET    DES_DATO6 = NVL(DES_DATO6,0) +
                       RTRIM(LTRIM(TO_CHAR((GET_NIVELES_HIJOS.DES_DATO5 * NVL(lstDesDato6,0)) / 100,'999.999999')))
                      ,DES_DATO8 = 'Y'
                WHERE  DES_DATO1 =
                       GET_NIVELES_HIJOS.DES_DATO1;
            END LOOP;
        END LOOP;
        COMMIT;
        -- Recupera todos los registros del arbol
        FOR GET_INFO IN CUR_CALC_PORC_INDIRECTO(pistEmpresa)
        LOOP
            lstDesDato6 := NULL;
            linSum      := NULL;
            -- Recupera el % indirecto del nivel superior
            BEGIN
                SELECT DES_DATO6
                INTO   lstDesDato6
                FROM   USRDRC.DERCORP_REPORTE_TENCASC_TMP
                WHERE  DES_DATO1                         =
                       GET_INFO.DES_DATO4
                AND    ROWNUM = 1;
            EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                    print_message_pr('DBMS', '2.- No se encontro el % indirecto del nivel superior');
                WHEN TOO_MANY_ROWS
                THEN
                    print_message_pr('DBMS', '2.- Se encontraron mas de un registro en la consulta.');
            END;
            -- Actualiza el valor del % indirecto para los registros
            -- que aun no tienen este calculo.
            UPDATE USRDRC.DERCORP_REPORTE_TENCASC_TMP
            SET    DES_DATO6 =
                   RTRIM(LTRIM(TO_CHAR((GET_INFO.DES_DATO5 * lstDesDato6) / 100,'999.999999')))
            WHERE  DES_DATO1 =
                   GET_INFO.DES_DATO1
            AND    DES_DATO4 =
                   GET_INFO.DES_DATO4
            AND    DES_DATO6 IS NULL;
        END LOOP;
        -- Recupera registros los cuales tienen
        -- mas de una empresa padre en un nivel diferente
        -- del arbol.
        FOR J IN CUR_MULTIPLE
        LOOP
            linSum := NULL;
            -- Recupera la suma de los % indirectos
            -- de los registros que tienen mas de una empresa padre
            -- en diferente nivel del arbol.
            SELECT SUM(DES_DATO6)
            INTO   linSum
            FROM   USRDRC.DERCORP_REPORTE_TENCASC_TMP
            WHERE  DES_DATO1                          = J.DES_DATO1;
            -- Actualiza el % indirecto de
            -- de los registros que tienen mas de una empresa padre
            -- en diferente nivel del arbol.
            UPDATE USRDRC.DERCORP_REPORTE_TENCASC_TMP
            SET    DES_DATO6                          = linSum
            WHERE  DES_DATO1                          = J.DES_DATO1;
        END LOOP;
        --Nava
        /*
        DELETE FROM DERCORP_REPORTE_TENCASC_FIS;
        INSERT INTO DERCORP_REPORTE_TENCASC_FIS
        SELECT * FROM DERCORP_REPORTE_TENCASC_TMP;
        */
        -- End Nava
        COMMIT;
        print_message_pr(pistOutType, 'Hora: '||
                         TO_CHAR(SYSDATE, 'DD-MON-RRRR HH24:MI:SS'));
        print_message_pr(pistOutType, 'Termina proceso ...');
    EXCEPTION
        WHEN OTHERS
        THEN
            print_message_pr(pistOutType, 'ERROR: '||sqlerrm);
            print_message_pr(pistOutType, 'Hora: '||
                         TO_CHAR(SYSDATE, 'DD-MON-RRRR HH24:MI:SS'));
            print_message_pr(pistOutType, 'Termina proceso ...');
    END DO_REPORT_PR;
END DERCORP_REPORT_TENCASC_PKG;
/;
