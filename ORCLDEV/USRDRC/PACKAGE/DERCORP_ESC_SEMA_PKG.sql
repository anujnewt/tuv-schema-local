CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_ESC_SEMA_PKG" AS
  PROCEDURE GET_SEMAFORO_STAT_FN (pinIdEmpresa NUMBER,
                                  pinIdFlex    NUMBER,
                                  pstIdMetaRow NUMBER,
                                  poUrlSema    OUT VARCHAR2);
  PROCEDURE GET_SEMAFORO_STATUS_FN (pinIdEmpresa NUMBER,
                                    pinIdFlex    NUMBER,
                                    pstIdMetaRow NUMBER,
                                    poUrlSema    OUT VARCHAR2);
  PROCEDURE SET_ASUNTO_PR (pinIdEmpresa NUMBER,
                           pinIdFlex    NUMBER,
                           pstIdMetaRow NUMBER);
END DERCORP_ESC_SEMA_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_ESC_SEMA_PKG" AS
  PROCEDURE GET_SEMAFORO_STAT_FN (pinIdEmpresa NUMBER,
                                  pinIdFlex    NUMBER,
                                  pstIdMetaRow NUMBER,
                                  poUrlSema    OUT VARCHAR2)
  IS
    lstSemaStat  VARCHAR2(100) := '';
    lstReqPrto   VARCHAR2(100);
    lstInsRPPC   VARCHAR2(100);
    lrcdMetaInfo DERCORP_METATBL_TAB%ROWTYPE;
    lstUrlSemaSt VARCHAR2(100);
  BEGIN
    IF (pinIdFlex = 17 OR
        pinIdFlex = 18) THEN
      BEGIN
        SELECT * INTO lrcdMetaInfo
        FROM   DERCORP_METATBL_TAB
        WHERE  ID_EMPRESA   = pinIdEmpresa
        AND    ID_FLEX_TBL  = pinIdFlex
        AND    ID_META_ROW  = pstIdMetaRow;
      EXCEPTION
        WHEN OTHERS THEN
          lrcdMetaInfo:= NULL;
      END;
      lstSemaStat := 'semaforo_green.png';
      DBMS_OUTPUT.put_line(lstSemaStat);
      DBMS_OUTPUT.put_line(lrcdMetaInfo.VAL_C6);
      --Semaforo en Rojo
      IF(lrcdMetaInfo.VAL_C4 = 'Si' OR
         lrcdMetaInfo.VAL_C5 = 'Si')THEN     --Algun check activado
  --      lstSemaStat := 'ROJO';
        lstSemaStat := 'semaforo_red.png';
      END IF;
      DBMS_OUTPUT.put_line(lstSemaStat);
      --Semforo Amarillo
      IF (lrcdMetaInfo.VAL_C6 IS NOT NULL AND  --Enviada
          lrcdMetaInfo.VAL_C7 IS NOT NULL AND  --Fecha de Envio
          lrcdMetaInfo.VAL_C18 IS NULL) THEN    --RPC
        lstSemaStat := 'semaforo_yellow.png';
      END IF;
      DBMS_OUTPUT.put_line(lstSemaStat);
      --Semforo Verde
      --No requiere Protocolizacion, No requiere inscripcin RPC
      IF (lrcdMetaInfo.VAL_C4 = 'No' AND    --Req Prot
          lrcdMetaInfo.VAL_C5 = 'No')THEN   --Req RPC
        IF(lrcdMetaInfo.VAL_C6 IS NOT NULL AND  --Enviada
          lrcdMetaInfo.VAL_C7 IS NOT NULL ) THEN --Fecha Envio
          lstSemaStat := 'semaforo_green.png';
        END IF;
      END IF;
      DBMS_OUTPUT.put_line(lstSemaStat);
      --Requiere Protocolizacion, No requiere inscripcin RPC
      IF (lrcdMetaInfo.VAL_C4 = 'Si' AND    --Req Prot
          lrcdMetaInfo.VAL_C5 = 'No')THEN   --Req RPC
        IF(--lrcdMetaInfo.VAL_C6 IS NOT NULL AND  --Enviada
          --lrcdMetaInfo.VAL_C7 IS NOT NULL AND  -- Fecha Envio
          lrcdMetaInfo.VAL_C8 IS NOT NULL AND  --Escritura
          lrcdMetaInfo.VAL_C8 != 'N/A' AND  --Escritura
          lrcdMetaInfo.VAL_C9 IS NOT NULL AND  --Fecha Otorgamiento
          lrcdMetaInfo.VAL_C10 IS NOT NULL AND --Licenciado
          lrcdMetaInfo.VAL_C11 IS NOT NULL AND --Notario
          lrcdMetaInfo.VAL_C12 IS NOT NULL --AND --De
          --lrcdMetaInfo.VAL_C14 IS NOT NULL
          ) THEN --Fecha de Firma
            lstSemaStat := 'semaforo_green.png';
        END IF;
      END IF;
      DBMS_OUTPUT.put_line(lstSemaStat);
      --No Requiere Protocolizacion, requiere inscripcin RPC
      IF (lrcdMetaInfo.VAL_C4 = 'No' AND    --Req Prot
          lrcdMetaInfo.VAL_C5 = 'Si')THEN   --Req RPC
        IF(--lrcdMetaInfo.VAL_C6 IS NOT NULL AND  --Enviada
          --lrcdMetaInfo.VAL_C7 IS NOT NULL AND  -- Fecha Envio
          lrcdMetaInfo.VAL_C18 IS NOT NULL AND  --Inscrita RCP de
          lrcdMetaInfo.VAL_C19 IS NOT NULL AND  -- Fecha de registro
          lrcdMetaInfo.VAL_C20 IS NOT NULL ) THEN --Folio
            lstSemaStat := 'semaforo_green.png';
        END IF;
      END IF;
      DBMS_OUTPUT.put_line(lstSemaStat);
      --Requiere Protocolizacion, requiere inscripcin RPC
      IF (lrcdMetaInfo.VAL_C4 = 'Si' AND    --Req Prot
          lrcdMetaInfo.VAL_C5 = 'Si')THEN   --Req RPC
        IF(--lrcdMetaInfo.VAL_C6 IS NOT NULL AND  --Enviada
          --lrcdMetaInfo.VAL_C7 IS NOT NULL AND  -- Fechah Envio
          lrcdMetaInfo.VAL_C8 IS NOT NULL AND  --Escritura
          lrcdMetaInfo.VAL_C8 != 'N/A' AND  --Escritura
          lrcdMetaInfo.VAL_C9 IS NOT NULL AND  --Fecha Otorgamiento
          lrcdMetaInfo.VAL_C10 IS NOT NULL AND --Licenciado
          lrcdMetaInfo.VAL_C11 IS NOT NULL AND --Notario
          lrcdMetaInfo.VAL_C12 IS NOT NULL AND --De
          --lrcdMetaInfo.VAL_C14 IS NOT NULL AND  --Fecha de Firma
          lrcdMetaInfo.VAL_C18 IS NOT NULL AND  --Inscrita RCP de
          lrcdMetaInfo.VAL_C19 IS NOT NULL AND  -- Fecha de registro
          lrcdMetaInfo.VAL_C20 IS NOT NULL) THEN --Folio
            lstSemaStat := 'semaforo_green.png';
        END IF;
      END IF;
      DBMS_OUTPUT.put_line(lstSemaStat);
      UPDATE DERCORP_METATBL_TAB SET VAL_C16 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      --No de Escritura N/A en caso de ser nullo
      IF(( lrcdMetaInfo.VAL_C8 IS NULL) OR ( lrcdMetaInfo.VAL_C8 = '') OR ( lrcdMetaInfo.VAL_C8 = '0')) THEN  -- Escritura
        UPDATE DERCORP_METATBL_TAB SET VAL_C8 = 'N/A'
        WHERE  ID_EMPRESA   = pinIdEmpresa
        AND    ID_FLEX_TBL  = pinIdFlex
        AND    ID_META_ROW  = pstIdMetaRow;
      END IF;
      poUrlSema := lstSemaStat;
    END IF;
    IF (pinIdFlex = 20 OR
        pinIdFlex = 21 OR
        pinIdFlex = 22 OR
        --pinIdFlex = 23
        pinIdFlex = 27 OR
        pinIdFlex = 28 OR
        pinIdFlex = 29 OR
        pinIdFlex = 30 OR
        pinIdFlex = 31 OR
        pinIdFlex = 32 OR
        pinIdFlex = 33 OR
        pinIdFlex = 34 OR
        pinIdFlex = 35 OR
        pinIdFlex = 41 OR
        pinIdFlex = 37 OR-- SE AGREGAN JAMS 09/08/2017
        pinIdFlex = 38-- SE AGREGAN JAMS 09/08/2017
        ) THEN
      BEGIN
        SELECT * INTO lrcdMetaInfo
        FROM   DERCORP_METATBL_TAB
        WHERE  ID_EMPRESA   = pinIdEmpresa
        AND    ID_FLEX_TBL  = pinIdFlex
        AND    ID_META_ROW  = pstIdMetaRow;
      EXCEPTION
        WHEN OTHERS THEN
          lrcdMetaInfo:= NULL;
      END;
      lstSemaStat := 'semaforo_green.png';
      DBMS_OUTPUT.put_line(lstSemaStat);
      DBMS_OUTPUT.put_line(lrcdMetaInfo.VAL_C83);
      --Semaforo en Rojo
      IF(lrcdMetaInfo.VAL_C81 = 'Si' OR
         lrcdMetaInfo.VAL_C82 = 'Si')THEN
        lstSemaStat := 'semaforo_red.png';
      END IF;
      DBMS_OUTPUT.put_line(lstSemaStat);
      --Semforo Verde
     --Se modificacion condiciones en semaforos JAMS 03/08/2017
      --si Requiere Protocolizacin
      IF(lrcdMetaInfo.VAL_C81 = 'Si' AND lrcdMetaInfo.VAL_C82 = 'N/A') THEN --Requiere Protocolizacin:
        IF((lrcdMetaInfo.VAL_C87 IS NOT NULL AND lrcdMetaInfo.VAL_C87 != 'N/A' AND lrcdMetaInfo.VAL_C87 != 'Pendiente' ) AND --Fecha Otorgamiento
        (lrcdMetaInfo.VAL_C93 IS NOT NULL) AND--Escritura Digitalizada:
        (lrcdMetaInfo.VAL_C86 IS NOT NULL AND lrcdMetaInfo.VAL_C86 != 'N/A' AND lrcdMetaInfo.VAL_C86 != 'Pendiente') ---Escritura No:
       )THEN
            lstSemaStat := 'semaforo_green.png';
        END IF;
      END IF;
      --si Requiere inscripcin RPPC
      IF(lrcdMetaInfo.VAL_C82 = 'Si' AND lrcdMetaInfo.VAL_C81 = 'No' ) THEN --Requiere inscripcin RPPC:
         IF((lrcdMetaInfo.VAL_C95 IS NOT NULL AND lrcdMetaInfo.VAL_C95 != 'N/A' AND lrcdMetaInfo.VAL_C95 != 'Pendiente' ) AND --Fecha de Registro:
         lrcdMetaInfo.VAL_C96 IS NOT NULL AND--Folio Mercantil/Folio Mercantil Electrnico:
         lrcdMetaInfo.VAL_C93 IS NOT NULL--Escritura Digitalizada:
         )THEN
         lstSemaStat := 'semaforo_green.png';
         END IF;
      END IF;
       --si Requiere inscripcin RPPC y Protocolizacin
      IF(lrcdMetaInfo.VAL_C81 = 'Si' AND --Requiere Protocolizacin:
         lrcdMetaInfo.VAL_C82 = 'Si') THEN  --Requiere inscripcin RPPC:
         IF((lrcdMetaInfo.VAL_C87 IS NOT NULL AND lrcdMetaInfo.VAL_C87 != 'N/A' AND lrcdMetaInfo.VAL_C87 != 'Pendiente' ) AND --Fecha Otorgamiento
         (lrcdMetaInfo.VAL_C86 IS NOT NULL AND lrcdMetaInfo.VAL_C86 != 'N/A' AND lrcdMetaInfo.VAL_C86 != 'Pendiente') AND ---Escritura No:
         (lrcdMetaInfo.VAL_C95 IS NOT NULL AND lrcdMetaInfo.VAL_C95 != 'N/A' AND lrcdMetaInfo.VAL_C95 != 'Pendiente' ) AND --Fecha de Registro:
         lrcdMetaInfo.VAL_C96 IS NOT NULL AND--Folio Mercantil/Folio Mercantil Electrnico:
         lrcdMetaInfo.VAL_C93 IS NOT NULL--Escritura Digitalizada:
         )THEN
         lstSemaStat := 'semaforo_green.png';
        END IF;
      END IF;
      --terminan modificaiones JAMS 03/08/2017
      DBMS_OUTPUT.put_line(lstSemaStat);
      UPDATE DERCORP_METATBL_TAB SET VAL_C83 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
      --Fecha de registro N/A en caso de no inscribirse
      IF( lrcdMetaInfo.VAL_C82 = 'No' OR lrcdMetaInfo.VAL_C82 = 'N/A') THEN  -- Req RPC
        UPDATE DERCORP_METATBL_TAB SET VAL_C95 = 'N/A'
        WHERE  ID_EMPRESA   = pinIdEmpresa
        AND    ID_FLEX_TBL  = pinIdFlex
        AND    ID_META_ROW  = pstIdMetaRow;
      END IF;
       --Fecha de registro Pendiente en caso inscribirse y valores sean vacios
      IF( lrcdMetaInfo.VAL_C82 = 'Si' AND ( lrcdMetaInfo.VAL_C95 IS NULL OR lrcdMetaInfo.VAL_C95 = '' OR lrcdMetaInfo.VAL_C95 = '0' OR lrcdMetaInfo.VAL_C95 = 'N/A')) THEN  -- Req RPC
        UPDATE DERCORP_METATBL_TAB SET VAL_C95 = 'Pendiente'
        WHERE  ID_EMPRESA   = pinIdEmpresa
        AND    ID_FLEX_TBL  = pinIdFlex
        AND    ID_META_ROW  = pstIdMetaRow;
      END IF;
      --No de Escritura N/A en caso de ser nulo y que check de inscripcion no este seleccionado
      IF((lrcdMetaInfo.VAL_C81 = 'No' OR lrcdMetaInfo.VAL_C81 = 'N/A') AND ( lrcdMetaInfo.VAL_C86 IS NULL OR lrcdMetaInfo.VAL_C86 = '' OR lrcdMetaInfo.VAL_C86 = '0' OR lrcdMetaInfo.VAL_C86 = 'Pendiente')) THEN  -- Escritura
        UPDATE DERCORP_METATBL_TAB SET VAL_C86 = 'N/A'
        WHERE  ID_EMPRESA   = pinIdEmpresa
        AND    ID_FLEX_TBL  = pinIdFlex
        AND    ID_META_ROW  = pstIdMetaRow;
      END IF;
    END IF;
    --No de Escritura N/A en caso de ser nullo y que el check este seleccionado
      IF(lrcdMetaInfo.VAL_C81 = 'Si' AND ( lrcdMetaInfo.VAL_C86 IS NULL OR lrcdMetaInfo.VAL_C86 = '' OR lrcdMetaInfo.VAL_C86 = '0' OR lrcdMetaInfo.VAL_C86 = 'N/A')) THEN  -- Escritura
        UPDATE DERCORP_METATBL_TAB SET VAL_C86 = 'Pendiente'
        WHERE  ID_EMPRESA   = pinIdEmpresa
        AND    ID_FLEX_TBL  = pinIdFlex
        AND    ID_META_ROW  = pstIdMetaRow;
      END IF;
--FLEX 23
    IF (pinIdFlex = 23) THEN
      BEGIN
        SELECT * INTO lrcdMetaInfo
        FROM   DERCORP_METATBL_TAB
        WHERE  ID_EMPRESA   = pinIdEmpresa
        AND    ID_FLEX_TBL  = pinIdFlex
        AND    ID_META_ROW  = pstIdMetaRow;
      EXCEPTION
        WHEN OTHERS THEN
          lrcdMetaInfo:= NULL;
      END;
      ----JAMS
      lstSemaStat := 'semaforo_green.png';
      DBMS_OUTPUT.put_line(lstSemaStat);
      DBMS_OUTPUT.put_line(lrcdMetaInfo.VAL_C104);
      --Semaforo en Rojo
      IF(lrcdMetaInfo.VAL_C101 = 'Si' OR
         lrcdMetaInfo.VAL_C102 = 'Si')THEN
        lstSemaStat := 'semaforo_red.png';
      END IF;
      DBMS_OUTPUT.put_line(lstSemaStat);
      --Semforo Verde
     --Se modificacion condiciones en semaforos JAMS 03/08/2017
      --si Requiere Protocolizacin
      IF(lrcdMetaInfo.VAL_C101 = 'Si' AND lrcdMetaInfo.VAL_C102 = 'N/A') THEN --Requiere Protocolizacin:
        IF((lrcdMetaInfo.VAL_C107 IS NOT NULL AND lrcdMetaInfo.VAL_C107 != 'N/A' AND lrcdMetaInfo.VAL_C107 != 'Pendiente' ) AND --Fecha Otorgamiento
        (lrcdMetaInfo.VAL_C113 IS NOT NULL) AND--Escritura Digitalizada:
        (lrcdMetaInfo.VAL_C106 IS NOT NULL AND lrcdMetaInfo.VAL_C106 != 'N/A' AND lrcdMetaInfo.VAL_C106 != 'Pendiente') ---Escritura No:
       )THEN
            lstSemaStat := 'semaforo_green.png';
        END IF;
      END IF;
      --si Requiere inscripcin RPPC
      IF(lrcdMetaInfo.VAL_C102 = 'Si' AND lrcdMetaInfo.VAL_C101 = 'No' ) THEN --Requiere inscripcin RPPC:
         IF((lrcdMetaInfo.VAL_C115 IS NOT NULL AND lrcdMetaInfo.VAL_C115 != 'N/A' AND lrcdMetaInfo.VAL_C115 != 'Pendiente' ) AND --Fecha de Registro:
         lrcdMetaInfo.VAL_C116 IS NOT NULL AND--Folio Mercantil/Folio Mercantil Electrnico:
         lrcdMetaInfo.VAL_C113 IS NOT NULL--Escritura Digitalizada:
         )THEN
         lstSemaStat := 'semaforo_green.png';
         END IF;
      END IF;
       --si Requiere inscripcin RPPC y Protocolizacin
      IF(lrcdMetaInfo.VAL_C101 = 'Si' AND --Requiere Protocolizacin:
         lrcdMetaInfo.VAL_C102 = 'Si') THEN  --Requiere inscripcin RPPC:
         IF((lrcdMetaInfo.VAL_C107 IS NOT NULL AND lrcdMetaInfo.VAL_C107 != 'N/A' AND lrcdMetaInfo.VAL_C107 != 'Pendiente' ) AND --Fecha Otorgamiento
         (lrcdMetaInfo.VAL_C106 IS NOT NULL AND lrcdMetaInfo.VAL_C106 != 'N/A' AND lrcdMetaInfo.VAL_C106 != 'Pendiente') AND ---Escritura No:
         (lrcdMetaInfo.VAL_C115 IS NOT NULL AND lrcdMetaInfo.VAL_C115 != 'N/A' AND lrcdMetaInfo.VAL_C115 != 'Pendiente' ) AND --Fecha de Registro:
         lrcdMetaInfo.VAL_C116 IS NOT NULL AND--Folio Mercantil/Folio Mercantil Electrnico:
         lrcdMetaInfo.VAL_C113 IS NOT NULL--Escritura Digitalizada:
         )THEN
         lstSemaStat := 'semaforo_green.png';
        END IF;
      END IF;
      --terminan modificaiones JAMS 03/08/2017
      DBMS_OUTPUT.put_line(lstSemaStat);
      UPDATE DERCORP_METATBL_TAB SET VAL_C103 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
       --Fecha de registro Pendiente en caso inscribirse y valores sean vacios
      IF( lrcdMetaInfo.VAL_C102 = 'Si' AND ( lrcdMetaInfo.VAL_C115 IS NULL OR lrcdMetaInfo.VAL_C115 = '' OR lrcdMetaInfo.VAL_C115 = '0' OR lrcdMetaInfo.VAL_C115 = 'N/A')) THEN  -- Req RPC
        UPDATE DERCORP_METATBL_TAB SET VAL_C115 = 'Pendiente'
        WHERE  ID_EMPRESA   = pinIdEmpresa
        AND    ID_FLEX_TBL  = pinIdFlex
        AND    ID_META_ROW  = pstIdMetaRow;
      END IF;
      --Fecha de registro N/A en caso de no inscribirse
      IF( lrcdMetaInfo.VAL_C102 = 'No' OR lrcdMetaInfo.VAL_C102='N/A') THEN  --Req RPC
        UPDATE DERCORP_METATBL_TAB SET VAL_C115 = 'N/A'
        WHERE  ID_EMPRESA   = pinIdEmpresa
        AND    ID_FLEX_TBL  = pinIdFlex
        AND    ID_META_ROW  = pstIdMetaRow;
      END IF;
      --No de Escritura N/A en caso de ser nullo y que el check NO este seleccionado
      IF((lrcdMetaInfo.VAL_C101 = 'No' OR lrcdMetaInfo.VAL_C101 = 'N/A') AND ( lrcdMetaInfo.VAL_C106 IS NULL OR lrcdMetaInfo.VAL_C106 = '' OR lrcdMetaInfo.VAL_C106 = '0' OR lrcdMetaInfo.VAL_C106 = 'N/A')) THEN  -- Escritura
      --IF(( lrcdMetaInfo.VAL_C106 IS NULL)OR ( lrcdMetaInfo.VAL_C106 = '')  OR ( lrcdMetaInfo.VAL_C106 = '0')) THEN  -- Escritura
        UPDATE DERCORP_METATBL_TAB SET VAL_C106 = 'N/A'
        WHERE  ID_EMPRESA   = pinIdEmpresa
        AND    ID_FLEX_TBL  = pinIdFlex
        AND    ID_META_ROW  = pstIdMetaRow;
      END IF;
      --No de Escritura N/A en caso de ser nullo y que el check este seleccionado
      IF(lrcdMetaInfo.VAL_C101 = 'Si' AND ( lrcdMetaInfo.VAL_C106 IS NULL OR lrcdMetaInfo.VAL_C106 = '' OR lrcdMetaInfo.VAL_C106 = '0' OR lrcdMetaInfo.VAL_C106 = 'N/A')) THEN  -- Escritura
      --IF(( lrcdMetaInfo.VAL_C106 IS NULL)OR ( lrcdMetaInfo.VAL_C106 = '')  OR ( lrcdMetaInfo.VAL_C106 = '0')) THEN  -- Escritura
        UPDATE DERCORP_METATBL_TAB SET VAL_C106 = 'Pendiente'
        WHERE  ID_EMPRESA   = pinIdEmpresa
        AND    ID_FLEX_TBL  = pinIdFlex
        AND    ID_META_ROW  = pstIdMetaRow;
      END IF;
    END IF;
    GET_SEMAFORO_STATUS_FN(pinIdEmpresa,pinIdFlex,pstIdMetaRow,lstUrlSemaSt);
    --SET_ASUNTO_PR(pinIdEmpresa,pinIdFlex,pstIdMetaRow);
  END;
  PROCEDURE GET_SEMAFORO_STATUS_FN (pinIdEmpresa NUMBER,
                                    pinIdFlex    NUMBER,
                                    pstIdMetaRow NUMBER,
                                    poUrlSema    OUT VARCHAR2)
  IS
    lstSemaStat  VARCHAR2(100) := '';
    lstReqPrto   VARCHAR2(100);
    lstInsRPPC   VARCHAR2(100);
    lrcdMetaInfo DERCORP_METATBL_TAB%ROWTYPE;
  BEGIN
    BEGIN
        SELECT * INTO lrcdMetaInfo
        FROM   DERCORP_METATBL_TAB
        WHERE  ID_EMPRESA   = pinIdEmpresa
        AND    ID_FLEX_TBL  = pinIdFlex
        AND    ID_META_ROW  = pstIdMetaRow;
    EXCEPTION
      WHEN OTHERS THEN
        lrcdMetaInfo:= NULL;
    END;
    lstSemaStat := 'semaforo_red.png';
    --Poderes Generales
    IF (pinIdFlex = 17) THEN
      --Aplica / No aplica Status
      IF (lrcdMetaInfo.VAL_C76 = 'No')THEN
         lstSemaStat := 'semaforo_green.png';
      END IF;
      --Semaforo en Verde
      IF(lrcdMetaInfo.VAL_C72 = 'Si' OR
         --lrcdMetaInfo.VAL_C54 IS NOT NULL AND
         lrcdMetaInfo.VAL_C73 <> '0'  AND
         lrcdMetaInfo.VAL_C74 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
      /*
      IF lrcdMetaInfo.VAL_C1 = '12342' THEN
          UPDATE DERCORP_METATBL_TAB SET VAL_C3 = NULL
          WHERE  ID_EMPRESA   = pinIdEmpresa
          AND    ID_FLEX_TBL  = pinIdFlex
          AND    ID_META_ROW  = pstIdMetaRow;
      END IF;
      */
    END IF;
    --Poderes Especiales
    IF (pinIdFlex = 18) THEN
      --Aplica / No aplica Status
      IF (lrcdMetaInfo.VAL_C76 = 'No')THEN
         lstSemaStat := 'semaforo_green.png';
      END IF;
      --Semaforo en Verde
      IF(lrcdMetaInfo.VAL_C72 = 'Si' OR
         --lrcdMetaInfo.VAL_C54 IS NOT NULL AND
         lrcdMetaInfo.VAL_C73 <> '0'  AND
         lrcdMetaInfo.VAL_C74 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
/*
      IF lrcdMetaInfo.VAL_C1 = '12342' THEN
          UPDATE DERCORP_METATBL_TAB SET VAL_C3 = NULL
          WHERE  ID_EMPRESA   = pinIdEmpresa
          AND    ID_FLEX_TBL  = pinIdFlex
          AND    ID_META_ROW  = pstIdMetaRow;
      END IF;
*/
    END IF;
    --Reforma Total De Estatuos
    IF (pinIdFlex = 20) THEN
      --Aplica / No aplica Status
      IF (lrcdMetaInfo.VAL_C59 = 'No')THEN
         lstSemaStat := 'semaforo_green.png';
      END IF;
      --Semaforo en Verde
      IF(lrcdMetaInfo.VAL_C53 = 'Si' OR
         --lrcdMetaInfo.VAL_C54 IS NOT NULL AND
         lrcdMetaInfo.VAL_C54 <> '0'  AND
         lrcdMetaInfo.VAL_C55 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
    --Reforma Parcial de Estatutos
    IF (pinIdFlex = 21) THEN
      --Semaforo en Verde
      --Aplica / No aplica Status
      IF (lrcdMetaInfo.VAL_C49 = 'No')THEN
         lstSemaStat := 'semaforo_green.png';
      END IF;
      IF(lrcdMetaInfo.VAL_C44 = 'Si' OR
         lrcdMetaInfo.VAL_C45 <> '0' AND
         lrcdMetaInfo.VAL_C46 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
     --Transformacion
    IF (pinIdFlex = 22) THEN
      --Semaforo en Verde
      --Aplica / No aplica Status
      IF (lrcdMetaInfo.VAL_C55 = 'No')THEN
         lstSemaStat := 'semaforo_green.png';
      END IF;
      IF(lrcdMetaInfo.VAL_C51 = 'Si' OR
         lrcdMetaInfo.VAL_C52 <> '0' AND
         lrcdMetaInfo.VAL_C53 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
    --Aprobacion Ejercicio Social
    IF (pinIdFlex = 23) THEN
      --Semaforo en Verde
      --Aplica / No aplica Status
      IF (lrcdMetaInfo.VAL_C98 = 'No')THEN
         lstSemaStat := 'semaforo_green.png';
      END IF;
      IF(lrcdMetaInfo.VAL_C83 = 'Si' OR
         lrcdMetaInfo.VAL_C84 <> '0' AND
         lrcdMetaInfo.VAL_C85 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
    --Escrituras Otros
    IF (pinIdFlex = 27) THEN
      --Semaforo en Verde
      --Aplica / No aplica Status
      IF (lrcdMetaInfo.VAL_C17 = 'No')THEN
         lstSemaStat := 'semaforo_green.png';
      END IF;
      --IF(lrcdMetaInfo.VAL_C8 IS NOT NULL)THEN
      IF(lrcdMetaInfo.VAL_C136 = 'Si' OR
         lrcdMetaInfo.VAL_C137 <> '0' AND
         lrcdMetaInfo.VAL_C8 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
    --Acta Otros
    IF (pinIdFlex = 28) THEN
      --Semaforo en Verde
      --Aplica / No aplica Status
      IF (lrcdMetaInfo.VAL_C26 = 'No')THEN
         lstSemaStat := 'semaforo_green.png';
      END IF;
      IF(lrcdMetaInfo.VAL_C136 = 'Si' OR--Entregada::
         lrcdMetaInfo.VAL_C137 <> '0' AND--Responsable:
         lrcdMetaInfo.VAL_C11 IS NOT NULL)THEN --Cumplimiento:
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
    --Aumento de Capital
    IF (pinIdFlex = 29) THEN
      --Semaforo en Verde
      --Aplica / No aplica Status
      IF (lrcdMetaInfo.VAL_C45 = 'No')THEN
         lstSemaStat := 'semaforo_green.png';
      END IF;
      IF(lrcdMetaInfo.VAL_C136 = 'Si' OR
         lrcdMetaInfo.VAL_C137 <> '0' AND
         lrcdMetaInfo.VAL_C23 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
     --Contrato
    IF (pinIdFlex = 30) THEN
      --Semaforo en Verde
      --Aplica / No aplica Status
      IF (lrcdMetaInfo.VAL_C28 = 'No')THEN
         lstSemaStat := 'semaforo_green.png';
      END IF;
      IF(lrcdMetaInfo.VAL_C136 = 'Si' OR
         lrcdMetaInfo.VAL_C137 <> '0' AND
         lrcdMetaInfo.VAL_C18 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
     --Decreto de Dividendos
    IF (pinIdFlex = 31) THEN
      --Semaforo en Verde
      --Aplica / No aplica Status
      IF(lrcdMetaInfo.VAL_C25 = 'No')THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      IF(lrcdMetaInfo.VAL_C136 = 'Si' OR
         lrcdMetaInfo.VAL_C137 <> '0' AND
         lrcdMetaInfo.VAL_C13 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
     --Disminucion de Capital
    IF (pinIdFlex = 32) THEN
      --Semaforo en Verde
      --Aplica / No aplica Status
      IF (lrcdMetaInfo.VAL_C45 = 'No')THEN
         lstSemaStat := 'semaforo_green.png';
      END IF;
      IF(lrcdMetaInfo.VAL_C136 = 'Si' OR
         lrcdMetaInfo.VAL_C137 <> '0' AND
         lrcdMetaInfo.VAL_C23 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
     --Escision
    IF (pinIdFlex = 33) THEN
      --Semaforo en Verde
      --Aplica / No aplica Status
      IF (lrcdMetaInfo.VAL_C47 = 'No')THEN
         lstSemaStat := 'semaforo_green.png';
      END IF;
      IF(lrcdMetaInfo.VAL_C136 = 'Si' OR
         lrcdMetaInfo.VAL_C137 <> '0' AND
         lrcdMetaInfo.VAL_C25 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
    --Fusion
    IF (pinIdFlex = 34) THEN
      --Semaforo en Verde
      --Aplica / No aplica Status
      IF (lrcdMetaInfo.VAL_C68 = 'No')THEN
         lstSemaStat := 'semaforo_green.png';
      END IF;
      IF(lrcdMetaInfo.VAL_C136 = 'Si' OR
         lrcdMetaInfo.VAL_C137 <> '0' AND
         lrcdMetaInfo.VAL_C27 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
     --Sesion de Consejo
    IF (pinIdFlex = 35) THEN
      --Semaforo en Verde
      --Aplica / No aplica Status
      IF (lrcdMetaInfo.VAL_C25 = 'No')THEN
         lstSemaStat := 'semaforo_green.png';
      END IF;
      IF(lrcdMetaInfo.VAL_C136 = 'Si' OR
         lrcdMetaInfo.VAL_C137 <> '0' AND
         lrcdMetaInfo.VAL_C12 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
     --Comits
    IF (pinIdFlex = 41) THEN
      --Semaforo en Verde
      --Aplica / No aplica Status
      IF (lrcdMetaInfo.VAL_C25 = 'No')THEN
         lstSemaStat := 'semaforo_green.png';
      END IF;
      IF(lrcdMetaInfo.VAL_C136 = 'Si' OR
         lrcdMetaInfo.VAL_C137 <> '0' AND
         lrcdMetaInfo.VAL_C12 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
    --Poder General
    IF (pinIdFlex = 17) THEN
      --Semaforo en Verde
      IF(lrcdMetaInfo.VAL_C72 = 'Si' OR
         lrcdMetaInfo.VAL_C73 IS NOT NULL AND
         lrcdMetaInfo.VAL_C74 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
    --Poder Especial
    IF (pinIdFlex = 18) THEN
      --Semaforo en Verde
      IF(lrcdMetaInfo.VAL_C72 = 'Si' OR
         lrcdMetaInfo.VAL_C73 IS NOT NULL AND
         lrcdMetaInfo.VAL_C74 IS NOT NULL)THEN
        lstSemaStat := 'semaforo_green.png';
      END IF;
      UPDATE DERCORP_METATBL_TAB SET VAL_C150 = lstSemaStat
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
      poUrlSema := lstSemaStat;
    END IF;
  END;
  PROCEDURE SET_ASUNTO_PR (pinIdEmpresa NUMBER,
                           pinIdFlex    NUMBER,
                           pstIdMetaRow NUMBER)
  IS
    lstAsunto VARCHAR2(3000);
  BEGIN
    IF(pinIdFlex = 17) THEN
      lstAsunto:= 'Poderes Generales';
    ELSIF(pinIdFlex = 18) THEN
      lstAsunto:= 'Poderes Especiales';
    ELSIF(pinIdFlex = 20) THEN
      lstAsunto:= 'Reforma Total de Estatutos';
    ELSIF(pinIdFlex = 21) THEN
      lstAsunto:= 'Reforma Parcial de Estatutos';
    ELSIF(pinIdFlex = 22) THEN
      lstAsunto:= 'Transformacin';
    ELSIF(pinIdFlex = 23) THEN
      lstAsunto:= 'Aprobacin de Ejercicio Social';
    ELSIF(pinIdFlex = 27) THEN
      lstAsunto:= 'Escrituras Otros';
    ELSIF(pinIdFlex = 28) THEN
      lstAsunto:= 'Acta Otros';
    ELSIF(pinIdFlex = 29) THEN
      lstAsunto:= 'Aumento de Capital';
    ELSIF(pinIdFlex = 30) THEN
      lstAsunto:= 'Contrato';
    ELSIF(pinIdFlex = 31) THEN
      lstAsunto:= 'Decreto de Dividendos';
    ELSIF(pinIdFlex = 32) THEN
      lstAsunto:= 'Disminucin de Capital';
    ELSIF(pinIdFlex = 33) THEN
      lstAsunto:= 'Escisin';
    ELSIF(pinIdFlex = 34) THEN
      lstAsunto:= 'Fusin';
    ELSIF(pinIdFlex = 35) THEN
      lstAsunto:= 'Sesin de Consejo';
    ELSIF(pinIdFlex = 41) THEN
      lstAsunto:= 'Comits';
    END IF;
    UPDATE DERCORP_METATBL_TAB SET VAL_C149 = lstAsunto
      WHERE  ID_EMPRESA   = pinIdEmpresa
      AND    ID_FLEX_TBL  = pinIdFlex
      AND    ID_META_ROW  = pstIdMetaRow;
  END;
END DERCORP_ESC_SEMA_PKG;
/;
