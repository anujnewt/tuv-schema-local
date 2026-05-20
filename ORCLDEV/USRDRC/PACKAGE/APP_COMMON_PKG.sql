CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."APP_COMMON_PKG" AS
    FUNCTION GET_FIELD_TEXT_VALUE(idAddCampo int, idEmpresa int) RETURN VARCHAR2;
    FUNCTION GET_FIELD_VALUE(idAddCampo int, idEmpresa int) return VARCHAR2;
    FUNCTION SIN_ACENTOS_FN(pistText VARCHAR2)  RETURN VARCHAR2;
    FUNCTION SIN_ACENTOS_CLOB_FN(pistText CLOB)  RETURN CLOB;
    FUNCTION SIN_ACENTOS_NI_NN_FN(pistText VARCHAR2)  RETURN VARCHAR2;
    FUNCTION GET_TXT_HTML_FN(pistText VARCHAR2)  RETURN VARCHAR2;
    FUNCTION GET_AS_DATE_FOR_ORDER(pistText VARCHAR2)  RETURN DATE;
    FUNCTION IS_NUMBER_FN (pistText VARCHAR2) RETURN INT;
    --ECM 07 Septiembre 2016 CONTRATOS - CELEBRADO ENTRE PARTES
    FUNCTION GET_CELEBRADO_ENTRE_PARTES_FN(piinIdMetaRow NUMBER)RETURN VARCHAR2;
    --ECM 08 Septiembre 2016 CONTRATOS - CELEBRADO ENTRE PARTES
    FUNCTION GET_SOCIEDADES_ACCIONISTAS_FN(pistIdsSociedades VARCHAR2
                                          ,piinIndTipoCelebra NUMBER
    )RETURN VARCHAR2;
END APP_COMMON_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."APP_COMMON_PKG" AS
    FUNCTION IS_NUMBER_FN (pistText VARCHAR2) RETURN INT
    AS
      v_new_num NUMBER;
    BEGIN
        v_new_num := TO_NUMBER(pistText);
        RETURN 1;
      EXCEPTION
      WHEN VALUE_ERROR THEN
      RETURN 0;
    END IS_NUMBER_FN;
    --
    --
    --
    FUNCTION GET_FIELD_TEXT_VALUE(idAddCampo int, idEmpresa int) RETURN VARCHAR2
    AS
      val VARCHAR2(1000);
    BEGIN
          SELECT /*+ index(DERCORP_ADD_CAMPO_TAB (ID_ADD_CAMPO)) + index(DERCORP_ADD_CAMPO_VALOR_TAB (ID_ADD_CAMPO)) */
            NVL(CAT.VAL_CAT_VAL,CV.VAL_VALOR) VALOR_TEXTUAL INTO val
         /* FROM
            DERCORP_ADD_CAMPO_VALOR_TAB CV
            INNER JOIN DERCORP_ADD_CAMPO_TAB AC ON AC.ID_ADD_CAMPO = CV.ID_ADD_CAMPO
            LEFT JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT ON TO_NUMBER(CAT.ID_CATALOGO) = TO_NUMBER(NVL(TRIM(AC.ID_CATALOGO),'0'))
                                                        AND TO_CHAR(CAT.ID_CATALOGO_VALOR) = CV.VAL_VALOR */
            FROM
            DERCORP_ADD_CAMPO_VALOR_TAB CV
            INNER JOIN DERCORP_ADD_CAMPO_TAB AC ON AC.ID_ADD_CAMPO = CV.ID_ADD_CAMPO
            LEFT JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT ON CAT.ID_CATALOGO = AC.ID_CATALOGO
                                                        AND TO_CHAR(CAT.ID_CATALOGO_VALOR) = CV.VAL_VALOR
          WHERE
            CV.ID_EMPRESA = idEmpresa
            AND
            AC.ID_ADD_CAMPO = idAddCampo
          ;
          RETURN val;
    END GET_FIELD_TEXT_VALUE;
    --Antonio Mandujano
    FUNCTION GET_FIELD_VALUE(idAddCampo int, idEmpresa int) return VARCHAR2
    AS
        val varchar2(255);
    BEGIN
      SELECT
        VAL_VALOR INTO val
      FROM
        DERCORP_ADD_CAMPO_VALOR_TAB
      WHERE
        ID_EMPRESA = idEmpresa
        AND
        ID_ADD_CAMPO = idAddCampo
      ;
      RETURN val;
    END GET_FIELD_VALUE;
    --
    --
    --
    FUNCTION SIN_ACENTOS_FN(pistText VARCHAR2)  RETURN VARCHAR2
    --FUNCTION SIN_ACENTOS_FN(pistText CLOB)  RETURN CLOB
    IS
      listText VARCHAR2(3000);
    BEGIN
      listText := pistText;
      listText := REPLACE(listText,'A','A');
      listText := REPLACE(listText,'E','E');
      listText := REPLACE(listText,'I','I');
      listText := REPLACE(listText,'O','O');
      listText := REPLACE(listText,'U','U');
      listText := REPLACE(listText,'a','a');
      listText := REPLACE(listText,'e','e');
      listText := REPLACE(listText,'i','i');
      listText := REPLACE(listText,'o','o');
      listText := REPLACE(listText,'u','u');
      listText := REPLACE(listText,'?!','a');
      listText := REPLACE(listText,'??','e');
      listText := REPLACE(listText,'?-','i');
      listText := REPLACE(listText,'??','o');
      listText := REPLACE(listText,'??','u');
      --listText := REPLACE(listText,'?','N');
      --listText := REPLACE(listText,'?','n');
      return listText;
    END SIN_ACENTOS_FN;
  FUNCTION SIN_ACENTOS_CLOB_FN(pistText CLOB)  RETURN CLOB
    IS
      listText CLOB;
    BEGIN
      listText := pistText;
      listText := REPLACE(listText,'A','A');
      listText := REPLACE(listText,'E','E');
      listText := REPLACE(listText,'I','I');
      listText := REPLACE(listText,'O','O');
      listText := REPLACE(listText,'U','U');
      listText := REPLACE(listText,'a','a');
      listText := REPLACE(listText,'e','e');
      listText := REPLACE(listText,'i','i');
      listText := REPLACE(listText,'o','o');
      listText := REPLACE(listText,'u','u');
      listText := REPLACE(listText,'?!','a');
      listText := REPLACE(listText,'??','e');
      listText := REPLACE(listText,'?-','i');
      listText := REPLACE(listText,'??','o');
      listText := REPLACE(listText,'??','u');
      --listText := REPLACE(listText,'?','N');
      --listText := REPLACE(listText,'?','n');
      return listText;
    END SIN_ACENTOS_CLOB_FN;
    --
    --
    --
    FUNCTION SIN_ACENTOS_NI_NN_FN(pistText VARCHAR2)  RETURN VARCHAR2
    IS
      listText VARCHAR2(255);
    BEGIN
      listText := pistText;
      listText := REPLACE(listText,'A','A');
      listText := REPLACE(listText,'E','E');
      listText := REPLACE(listText,'I','I');
      listText := REPLACE(listText,'O','O');
      listText := REPLACE(listText,'U','U');
      listText := REPLACE(listText,'?','N');
      listText := REPLACE(listText,'a','a');
      listText := REPLACE(listText,'e','e');
      listText := REPLACE(listText,'i','i');
      listText := REPLACE(listText,'o','o');
      listText := REPLACE(listText,'u','u');
      listText := REPLACE(listText,'?','n');
      --listText := REPLACE(listText,'?','N');
      --listText := REPLACE(listText,'?','n');
      return listText;
    END SIN_ACENTOS_NI_NN_FN;
    --
    --
    --
    FUNCTION GET_TXT_HTML_FN(pistText VARCHAR2)  RETURN VARCHAR2
    IS
      listText VARCHAR2(32000);
    BEGIN
      listText := pistText;
      listText := REPLACE(listText,'A','A');
      listText := REPLACE(listText,'E','E');
      listText := REPLACE(listText,'I','I');
      listText := REPLACE(listText,'O','O');
      listText := REPLACE(listText,'U','U');
      listText := REPLACE(listText,'a','a');
      listText := REPLACE(listText,'e','e');
      listText := REPLACE(listText,'i','i');
      listText := REPLACE(listText,'o','o');
      listText := REPLACE(listText,'u','u');
      listText := REPLACE(listText,'?','N');
      listText := REPLACE(listText,'?','n');
      return listText;
    END GET_TXT_HTML_FN;
/*
    FUNCTION GET_AS_DATE_FOR_ORDER(pistText VARCHAR2)  RETURN DATE
    IS
    BEGIN
        BEGIN
            RETURN TO_DATE(pistText,'dd/mm/yyyy');
        EXCEPTION
            WHEN OTHERS THEN
              RETURN SYSDATE;
        END;
    END;
*/
    FUNCTION GET_AS_DATE_FOR_ORDER(pistText VARCHAR2)  RETURN DATE
    IS
    BEGIN
        BEGIN
            IF pistText IS NULL THEN
                RETURN TO_DATE('01/01/0001','dd/mm/yyyy');
            ELSE
                RETURN TO_DATE(pistText,'dd/mm/yyyy');
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
              RETURN SYSDATE;
        END;
    END GET_AS_DATE_FOR_ORDER;
    --ECM 07 Septiembre 2016 CONTRATOS - CELEBRADO ENTRE PARTES
    FUNCTION GET_CELEBRADO_ENTRE_PARTES_FN(piinIdMetaRow NUMBER)RETURN VARCHAR2
    IS
        pstNombre1     VARCHAR2(32000);
        pstSociedades1 VARCHAR2(32000);
        pstNombre2     VARCHAR2(32000);
        pstSociedades2 VARCHAR2(32000);
    BEGIN
        BEGIN
            SELECT  NVL(VAL_C6,'0') AS Nombres1
            INTO    pstNombre1
            FROM    DERCORP_METATBL_TAB
            WHERE   1=1
            AND     ID_META_ROW = piinIdMetaRow
            ;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            --pstNombre1 := NULL;
            pstNombre1 := '0';
        END;
        BEGIN
            SELECT  NVL(VAL_C7,'0') AS Sociedades1
            INTO    pstSociedades1
            FROM    DERCORP_METATBL_TAB
            WHERE   1=1
            AND     ID_META_ROW = piinIdMetaRow
            ;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            --pstSociedades1 := NULL;
            pstSociedades1 := '0';
        END;
    --------------------------------------------------------------------------------
        BEGIN
            SELECT  NVL(VAL_C10,'0') AS Nombres2
            INTO    pstNombre2
            FROM    DERCORP_METATBL_TAB
            WHERE   1=1
            AND     ID_META_ROW = piinIdMetaRow
            ;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            --pstNombre2 := NULL;
            pstNombre2 := '0';
        END;
        BEGIN
            SELECT  NVL(VAL_C11,'0') AS Sociedades2
            INTO    pstSociedades2
            FROM    DERCORP_METATBL_TAB
            WHERE   1=1
            AND     ID_META_ROW = piinIdMetaRow
            ;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            --pstSociedades2 := NULL;
            pstSociedades2 := '0';
        END;
        --JJAQ 11/01/2019 SE COMENTA PORQUE AHORA QUIEREN QUE SE JUNTE TODOS CONTRA TODOS. NUMERO 5 DE LA PROPUESTA DE PUNTOS PRIORITARIOS
/*
        IF pstNombre1 IS NOT NULL THEN
                IF pstNombre2 IS NOT NULL THEN
                  RETURN GET_SOCIEDADES_ACCIONISTAS_FN(pstNombre1||', '||pstNombre2, 1);
                ELSE
                   RETURN GET_SOCIEDADES_ACCIONISTAS_FN(pstNombre1, 1);
                END IF;
        END IF;
        IF pstSociedades1 IS NOT NULL THEN
                IF pstSociedades2 IS NOT NULL THEN
                  RETURN GET_SOCIEDADES_ACCIONISTAS_FN(pstSociedades1||', '||pstSociedades2,2);
                ELSE
                  RETURN GET_SOCIEDADES_ACCIONISTAS_FN(pstSociedades1, 2);
                END IF;
        END IF;
        IF pstNombre2 IS NOT NULL THEN
            RETURN GET_SOCIEDADES_ACCIONISTAS_FN(pstNombre1||', '||pstNombre2, 1);
        END IF;
        IF pstSociedades2 IS NOT NULL THEN
            RETURN GET_SOCIEDADES_ACCIONISTAS_FN(pstSociedades1||', '||pstSociedades2, 2);
        END IF;
*/
        RETURN APP_COMMON_PKG.GET_SOCIEDADES_ACCIONISTAS_FN(pstNombre1,1) || ' ' ||
               APP_COMMON_PKG.GET_SOCIEDADES_ACCIONISTAS_FN(pstSociedades1,2) || ' ' ||
               APP_COMMON_PKG.GET_SOCIEDADES_ACCIONISTAS_FN(pstNombre2,1)||' ' ||
               APP_COMMON_PKG.GET_SOCIEDADES_ACCIONISTAS_FN(pstSociedades2,2);
    END GET_CELEBRADO_ENTRE_PARTES_FN;
    --ECM 08 Septiembre 2016 CONTRATOS - CELEBRADO ENTRE PARTES
    FUNCTION GET_SOCIEDADES_ACCIONISTAS_FN(pistIdsSociedades VARCHAR2
                                          ,piinIndTipoCelebra NUMBER
    )RETURN VARCHAR2
    IS
        pstSociedades    VARCHAR2(32000);
        pstSociedad      VARCHAR2(32000);
        pstIdsSociedades VARCHAR2(32000);
        pinNumOcurencias NUMBER;
        pinNumOcurrencia NUMBER;
        pinIdUnico       NUMBER;
    BEGIN
        pstIdsSociedades := pistIdsSociedades;
/*
        BEGIN
            SELECT  APP_COMMON_PKG.GET_CELEBRADO_ENTRE_PARTES_FN(ID_META_ROW)
            INTO    pstIdsSociedades
            FROM    DERCORP_METATBL_TAB
            WHERE   1=1
            AND     ID_META_ROW = piinIdMetaRow
            ;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            pstIdsSociedades := 0;
        END;
*/
/*
        BEGIN
          SELECT LENGTH(APP_COMMON_PKG.GET_CELEBRADO_ENTRE_PARTES_FN(ID_META_ROW))
          - LENGTH(REPLACE(APP_COMMON_PKG.GET_CELEBRADO_ENTRE_PARTES_FN(ID_META_ROW),','))
          INTO    pinNumOcurencias
          FROM    DERCORP_METATBL_TAB
                  WHERE   1=1
                  AND     ID_META_ROW = piinIdMetaRow
          ;
          DBMS_OUTPUT.PUT_LINE('Total Ocurrencias:'||pinNumOcurencias);
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
          NULL;
        END;
*/
        BEGIN
          SELECT LENGTH(pistIdsSociedades) - LENGTH(REPLACE(pistIdsSociedades,','))
          INTO    pinNumOcurencias
          FROM    DUAL
          ;
          DBMS_OUTPUT.PUT_LINE('Total Ocurrencias:'||pinNumOcurencias);
          /*
          IF pinNumOcurencias > 5
          THEN
            pinNumOcurencias := 5;
            pstIdsSociedades := SUBSTR(pstIdsSociedades,1,INSTR(pstIdsSociedades,',', 1, 5) - 1);
            DBMS_OUTPUT.PUT_LINE('pstIdsSociedades :'||pstIdsSociedades);
          END IF;
            */
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
          NULL;
        END;
        FOR i IN 1..pinNumOcurencias
        LOOP
            SELECT INSTR(pstIdsSociedades,',', 1, 1)
            INTO   pinNumOcurrencia
            FROM   DUAL;
            DBMS_OUTPUT.PUT_LINE('Num Ocurrencia: '||pinNumOcurrencia);
            SELECT SUBSTR(pstIdsSociedades,1,pinNumOcurrencia-1)
            INTO   pinIdUnico
            FROM   DUAL;
            DBMS_OUTPUT.PUT_LINE('Id Unico: '||pinIdUnico);
            SELECT SUBSTR(pstIdsSociedades,pinNumOcurrencia+1)
            INTO   pstIdsSociedades
            FROM   DUAL;
            DBMS_OUTPUT.PUT_LINE('Id Restante: '||pstIdsSociedades);
            IF piinIndTipoCelebra = 1 THEN
                BEGIN
                    SELECT NOMBRE
                    INTO    pstSociedad
                    FROM   DERCORP_CAT_PERSONAS_TOTAL_TAB
                    WHERE  1=1
                    AND    PERSON_ID IN (pinIdUnico)
                    ;
                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    pstSociedad := '';
                END;
            ELSE
                BEGIN
                  SELECT  VAL_CAT_VAL
                  INTO    pstSociedad
                  FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
                  WHERE   1=1
                  AND     ID_CATALOGO = 40
                  AND     ID_CATALOGO_VALOR IN (pinIdUnico)
                  ;
                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    pstSociedad := '';
                END;
            END IF;
            DBMS_OUTPUT.PUT_LINE('Sociedad: '||pstSociedad);
            pstSociedades := pstSociedades||CHR(13)||pstSociedad;
        END LOOP;
        IF piinIndTipoCelebra = 1 THEN
            BEGIN
                SELECT NOMBRE
                INTO    pstSociedad
                FROM   DERCORP_CAT_PERSONAS_TOTAL_TAB
                WHERE  1=1
                AND    PERSON_ID IN (pstIdsSociedades)
                ;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                pstSociedad := '';
            END;
        ELSE
            BEGIN
                SELECT  VAL_CAT_VAL
                INTO    pstSociedad
                FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
                WHERE   1=1
                AND     ID_CATALOGO = 40
                AND     ID_CATALOGO_VALOR IN (pstIdsSociedades)
                ;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                pstSociedad := '';
            END;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Sociedad: '||pstSociedad);
        pstSociedades := pstSociedades||CHR(13)||pstSociedad;
        DBMS_OUTPUT.PUT_LINE('Sociedades: '||pstSociedades);
        /*
         IF pinNumOcurencias = 5
          THEN
            pstSociedades := pstSociedades || ' ...';
          END IF;
          */
        RETURN pstSociedades;
    END GET_SOCIEDADES_ACCIONISTAS_FN;
END APP_COMMON_PKG;
/;
