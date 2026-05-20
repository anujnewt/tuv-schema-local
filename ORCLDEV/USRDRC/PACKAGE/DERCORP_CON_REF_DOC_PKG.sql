CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_CON_REF_DOC_PKG" AS
    PROCEDURE GET_VALUES_ESC_OTROS_PR(porcRSEscriturasOtros OUT SYS_REFCURSOR
                                     ,piinIdMetaRow IN NUMBER
    );
    PROCEDURE GET_VALUES_CONTRATOS_PR(porcRSContratos OUT SYS_REFCURSOR
                                     ,piinIdMetaRow IN NUMBER
    );
    PROCEDURE GET_VALUES_ACTA_OTROS_PR(porcRSActaOtros OUT SYS_REFCURSOR
                                       ,piinIdMetaRow IN NUMBER
    );
    PROCEDURE GET_VALUES_AUMENTO_CAPITAL_PR(porcRSAumentoCapital OUT SYS_REFCURSOR
                                            ,piinIdMetaRow IN NUMBER
    );
    PROCEDURE GET_VALUES_DECRETO_DIVIDEN_PR(porcRSDecretoDividendo OUT SYS_REFCURSOR
                                            ,piinIdMetaRow IN NUMBER
    );
    PROCEDURE GET_VALUES_DISMINUCION_CAP_PR(porcRSDisminucionCap OUT SYS_REFCURSOR
                                            ,piinIdMetaRow IN NUMBER
    );
    PROCEDURE GET_VALUES_ESCISION_PR(porcRSEscision OUT SYS_REFCURSOR
                                     ,piinIdMetaRow IN NUMBER
    );
    PROCEDURE GET_VALUES_FUSION_PR(porcRSFusion OUT SYS_REFCURSOR
                                  ,piinIdMetaRow IN NUMBER
    );
    PROCEDURE GET_VALUES_SESION_CONSEJO_PR(porcRSSesionConsejo OUT SYS_REFCURSOR
                                   ,piinIdMetaRow IN NUMBER
    );
    PROCEDURE GET_VALUES_COMITES_PR(porcRSComites OUT SYS_REFCURSOR
                            ,piinIdMetaRow IN NUMBER
    );
END DERCORP_CON_REF_DOC_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_CON_REF_DOC_PKG" IS
  PROCEDURE GET_VALUES_ESC_OTROS_PR(porcRSEscriturasOtros OUT SYS_REFCURSOR
                                   ,piinIdMetaRow         IN NUMBER
  )
  IS
  BEGIN
      OPEN porcRSEscriturasOtros FOR
      SELECT  MTL.VAL_C10 AS SOLICITUD,
              MTL.VAL_C11 AS FEC_DOC,--Documento solicitud
              MTL.VAL_C119 AS SOL_POR,
              MTL.VAL_C12 AS FEC_REC,
              MTL.VAL_C13 AS FOL_NUM,
              MTL.VAL_C14 AS NUM_DOC_SOL,
              MTL.VAL_C15 AS DOC_ENT,
              MTL.VAL_C16 AS NUM_DOC_DOC_ENT,
              MTL.VAL_C120 AS FEC_DOC_E,
              MTL.VAL_C121 AS FEC_REC_E,
              (SELECT COUNT(*) FROM PENDIUM_EJERCICIO_SOCIAL_TAB WHERE ID_META_ROW=MTL.ID_META_ROW) AS AGREG_DOC
      FROM    DERCORP_METATBL_TAB MTL
      WHERE   1=1
      AND     ID_META_ROW = piinIdMetaRow
      --AND     ID_FLEX_TBL = 27
      --AND     ID_EMPRESA = piindEmpresa
      ;
  END GET_VALUES_ESC_OTROS_PR;
  PROCEDURE GET_VALUES_CONTRATOS_PR(porcRSContratos OUT SYS_REFCURSOR
                                    ,piinIdMetaRow IN NUMBER
  )
  IS
  BEGIN
      OPEN porcRSContratos FOR
       SELECT   MTL.VAL_C20 AS SOLICITUD
              ,MTL.VAL_C119 AS SOL_POR
              ,MTL.VAL_C21 AS FEC_DOC
              ,MTL.VAL_C22 AS FEC_REC
              ,MTL.VAL_C23 AS FOL_NUM
              --,MTL.VAL_C138 AS NUM_DOC_SOL
              ,MTL.VAL_C24 AS NUM_DOC_SOL--Solicitud JAMS 26/02/2018 se modifica
              ,MTL.VAL_C25 AS CONTRATO_ENT
              --,MTL.VAL_C26 AS NUM_CONT_CONT_ENT
              ,MTL.VAL_C138 AS NUM_CONT_CONT_ENT--Documento de Entrega JAMS 26/02/2018 se modifica
              ,MTL.VAL_C120 AS FEC_DOC_E
              ,MTL.VAL_C121 AS FEC_REC_E
              ,(SELECT COUNT(*) FROM PENDIUM_EJERCICIO_SOCIAL_TAB WHERE ID_META_ROW=MTL.ID_META_ROW) AS AGREG_DOC
      FROM    DERCORP_METATBL_TAB MTL
      WHERE   1=1
      AND     ID_META_ROW = piinIdMetaRow
      ;
  END GET_VALUES_CONTRATOS_PR;
  PROCEDURE GET_VALUES_ACTA_OTROS_PR(porcRSActaOtros OUT SYS_REFCURSOR
                                     ,piinIdMetaRow IN NUMBER
  )
  IS
  BEGIN
    OPEN porcRSActaOtros FOR
        SELECT MTL.VAL_C13 AS SOLICITUD
              ,MTL.VAL_C119 AS SOL_POR
              ,MTL.VAL_C14 AS FEC_DOC
              ,MTL.VAL_C15 AS FEC_REC
              ,MTL.VAL_C16 AS FOL_NUM
              ,MTL.VAL_C17 AS NUM_DOC_SOL
              ,MTL.VAL_C18 AS ACTA_RESOLUCIONES
              ,MTL.VAL_C19 AS NUM_DOC_ACTA_RESOL
              ,MTL.VAL_C20 AS CONVOCATORIA
              ,MTL.VAL_C21 AS NUM_DOC_CONVOCATORIA
              ,MTL.VAL_C22 AS PUBLICACIONES
              ,MTL.VAL_C23 AS NUM_DOC_PUB
              ,MTL.VAL_C24 AS DOC_ENTREGADO
              ,MTL.VAL_C25 AS NUM_DOC_DOC_ENT
              ,MTL.VAL_C120 AS FEC_DOC_E
              ,MTL.VAL_C121 AS FEC_REC_E
              ,(SELECT COUNT(*) FROM PENDIUM_EJERCICIO_SOCIAL_TAB WHERE ID_META_ROW=MTL.ID_META_ROW) AS AGREG_DOC
        FROM    DERCORP_METATBL_TAB MTL
        WHERE   1=1
        AND     ID_META_ROW = piinIdMetaRow
        ;
  END GET_VALUES_ACTA_OTROS_PR;
  PROCEDURE GET_VALUES_AUMENTO_CAPITAL_PR(porcRSAumentoCapital OUT SYS_REFCURSOR
                                          ,piinIdMetaRow IN NUMBER
  )
  IS
  BEGIN
    OPEN porcRSAumentoCapital FOR
        SELECT   MTL.VAL_C25 AS SOLICITUD
                ,MTL.VAL_C119 AS SOL_POR
                ,MTL.VAL_C26 AS FEC_DOC
                ,MTL.VAL_C27 AS FEC_REC
                ,MTL.VAL_C28 AS FOL_NUM
                ,MTL.VAL_C29 AS NUM_DOC_SOL
                ,MTL.VAL_C30 AS ACTA_RESOL
                ,MTL.VAL_C31 AS NUM_DOC_ACTA_RESOL
                ,MTL.VAL_C32 AS CONVOCATORIA
                ,MTL.VAL_C33 AS NUM_DOC_CONV
                ,MTL.VAL_C34 AS PUBLICACIONES
                ,MTL.VAL_C35 AS NUM_DOC_PUB
                ,MTL.VAL_C36 AS DOC_ENT
                ,MTL.VAL_C37 AS NUM_DOC_DOC_ENT
                ,MTL.VAL_C120 AS FEC_DOC_E
                ,MTL.VAL_C121 AS FEC_REC_E
                ,(SELECT COUNT(*) FROM PENDIUM_EJERCICIO_SOCIAL_TAB WHERE ID_META_ROW=MTL.ID_META_ROW) AS AGREG_DOC
        FROM    DERCORP_METATBL_TAB MTL
        WHERE   1=1
        AND     ID_META_ROW = piinIdMetaRow
        ;
  END GET_VALUES_AUMENTO_CAPITAL_PR;
  PROCEDURE GET_VALUES_DECRETO_DIVIDEN_PR(porcRSDecretoDividendo OUT SYS_REFCURSOR
                                          ,piinIdMetaRow IN NUMBER
  )
  IS
  BEGIN
      OPEN porcRSDecretoDividendo FOR
          SELECT MTL.VAL_C15 AS SOLICITUD
                ,MTL.VAL_C119 AS SOL_POR
                ,MTL.VAL_C16 AS FEC_DOC
                ,MTL.VAL_C17 AS FEC_REC
                ,MTL.VAL_C18 AS FOL_NUM
                ,MTL.VAL_C19 AS NUM_DOC_SOL
                ,MTL.VAL_C20 AS ACTA_RESOL
                ,MTL.VAL_C21 AS NUM_DOC_ACTA_RESOL
                ,MTL.VAL_C22 AS DOCUMENTO_ENTREGADO
                ,MTL.VAL_C23 AS NUM_DOC_DOC_ENT
                ,MTL.VAL_C120 AS FEC_DOC_E
                ,MTL.VAL_C121 AS FEC_REC_E
                ,(SELECT COUNT(*) FROM PENDIUM_EJERCICIO_SOCIAL_TAB WHERE ID_META_ROW=MTL.ID_META_ROW) AS AGREG_DOC
          FROM   DERCORP_METATBL_TAB MTL
          WHERE  1=1
          AND    ID_META_ROW = piinIdMetaRow
          ;
  END;
    PROCEDURE GET_VALUES_DISMINUCION_CAP_PR(porcRSDisminucionCap OUT SYS_REFCURSOR
                                            ,piinIdMetaRow IN NUMBER
    )
    IS
    BEGIN
        OPEN porcRSDisminucionCap FOR
            SELECT   MTL.VAL_C25 AS SOLICITUD
                    ,MTL.VAL_C119 AS SOL_POR
                    ,MTL.VAL_C26 AS FEC_DOC
                    ,MTL.VAL_C27 AS FEC_REC
                    ,MTL.VAL_C28 AS FOL_NUM
                    ,MTL.VAL_C29 AS NUM_DOC_SOL
                    ,MTL.VAL_C30 AS ACTA_RESOL
                    ,MTL.VAL_C31 AS NUM_DOC_ACTA_RESOL
                    ,MTL.VAL_C32 AS CONVOCATORIA
                    ,MTL.VAL_C33 AS NUM_DOC_CONV
                    ,MTL.VAL_C34 AS PUBLICACIONES
                    ,MTL.VAL_C35 AS NUM_DOC_PUBLI
                    ,MTL.VAL_C36 AS DOCUMENTO_ENTREGADO
                    ,MTL.VAL_C37 AS NUM_DOC_DOC_ENT
                    ,MTL.VAL_C120 AS FEC_DOC_E
                    ,MTL.VAL_C121 AS FEC_REC_E
                    ,(SELECT COUNT(*) FROM PENDIUM_EJERCICIO_SOCIAL_TAB WHERE ID_META_ROW=MTL.ID_META_ROW) AS AGREG_DOC
            FROM    DERCORP_METATBL_TAB MTL
            WHERE   1=1
            AND     ID_META_ROW = piinIdMetaRow
            ;
    END;
    PROCEDURE GET_VALUES_ESCISION_PR(porcRSEscision OUT SYS_REFCURSOR
                                     ,piinIdMetaRow IN NUMBER
    )
    IS
    BEGIN
        OPEN PORCRSEscision FOR
            SELECT   MTL.VAL_C27 AS SOLICITUD
                    ,MTL.VAL_C119 AS SOL_POR
                    ,MTL.VAL_C28 AS FEC_DOC
                    ,MTL.VAL_C29 AS FEC_REC
                    ,MTL.VAL_C30 AS FOLIO_NUM
                    ,MTL.VAL_C31 AS NUM_DOC_SOL
                    ,MTL.VAL_C32 AS ACTA_RESOL
                    ,MTL.VAL_C33 AS NUM_DOC_ACTA_RESOL
                    ,MTL.VAL_C34 AS CONVOCATORIA
                    ,MTL.VAL_C35 AS NUM_DOC_CONVOC
                    ,MTL.VAL_C36 AS PUBLICACIONES
                    ,MTL.VAL_C37 AS NUM_DOC_PUBLIC
                    ,MTL.VAL_C38 AS DOCUMENTO_ENTREGADO
                    ,MTL.VAL_C39 AS NUM_DOC_DOC_ENT
                    ,MTL.VAL_C120 AS FEC_DOC_E
                    ,MTL.VAL_C121 AS FEC_REC_E
                    ,(SELECT COUNT(*) FROM PENDIUM_EJERCICIO_SOCIAL_TAB WHERE ID_META_ROW=MTL.ID_META_ROW) AS AGREG_DOC
            FROM    DERCORP_METATBL_TAB MTL
            WHERE   1=1
            AND     ID_META_ROW = piinIdMetaRow
            ;
    END GET_VALUES_ESCISION_PR;
    PROCEDURE GET_VALUES_FUSION_PR(porcRSFusion OUT SYS_REFCURSOR
                                  ,piinIdMetaRow IN NUMBER
    )
    IS
    BEGIN
        OPEN porcRSFusion FOR
            SELECT   MTL.VAL_C29    AS    SOLICITUD
                    ,MTL.VAL_C119 AS SOL_POR
                    ,MTL.VAL_C30    AS    FEC_DOC
                    ,MTL.VAL_C31    AS    FEC_REC
                    ,MTL.VAL_C32    AS    FOLIO_NUM
                    ,MTL.VAL_C33    AS    NUM_DOC_SOL
                    ,MTL.VAL_C34    AS    ACTA_RESOL
                    ,MTL.VAL_C35    AS    NUM_DOC_ACTA_RESOL
                    ,MTL.VAL_C36    AS    CONVOCATORIA
                    ,MTL.VAL_C37    AS    NUM_DOC_CONVOC
                    ,MTL.VAL_C38    AS    PUBLICACIONES
                    ,MTL.VAL_C39    AS    NUM_DOC_PUBLIC
                    ,MTL.VAL_C40    AS    DOCUMENTO_ENTREGADO
                    ,MTL.VAL_C41    AS    NUM_DOC_DOC_ENT
                    ,MTL.VAL_C69  AS  CONVENIO_FUSION
                    ,MTL.VAL_C70  AS  NUM_DOC_CONVEN_FUSION
                    ,MTL.VAL_C120 AS FEC_DOC_E
                    ,MTL.VAL_C121 AS FEC_REC_E
                    ,(SELECT COUNT(*) FROM PENDIUM_EJERCICIO_SOCIAL_TAB WHERE ID_META_ROW=MTL.ID_META_ROW) AS AGREG_DOC
            FROM    DERCORP_METATBL_TAB MTL
            WHERE   1=1
            AND     ID_META_ROW = piinIdMetaRow
            ;
    END GET_VALUES_FUSION_PR;
    PROCEDURE GET_VALUES_SESION_CONSEJO_PR(porcRSSesionConsejo OUT SYS_REFCURSOR
                                   ,piinIdMetaRow IN NUMBER
    )
    IS
    BEGIN
        OPEN porcRSSesionConsejo FOR
            SELECT   MTL.VAL_C14    AS    SOLICITUD
                    ,MTL.VAL_C119 AS SOL_POR
                    ,MTL.VAL_C15    AS    FEC_DOC
                    ,MTL.VAL_C16    AS    FEC_REC
                    ,MTL.VAL_C17    AS    FOLIO_NUM
                    ,MTL.VAL_C18    AS    NUM_DOC_SOL
                    ,MTL.VAL_C19    AS    ACTA_RESOL
                    ,MTL.VAL_C20    AS    NUM_DOC_ACTA_RESOL
                    ,MTL.VAL_C21    AS    CONVOCATORIA
                    ,MTL.VAL_C22    AS    NUM_DOC_CONVOC
                    ,MTL.VAL_C23    AS    DOCUMENTO_ENTREGADO
                    ,MTL.VAL_C24    AS    NUM_DOC_DOC_ENT
                    ,MTL.VAL_C120 AS FEC_DOC_E
                    ,MTL.VAL_C121 AS FEC_REC_E
                    ,(SELECT COUNT(*) FROM PENDIUM_EJERCICIO_SOCIAL_TAB WHERE ID_META_ROW=MTL.ID_META_ROW) AS AGREG_DOC
            FROM    DERCORP_METATBL_TAB MTL
            WHERE   1=1
            AND     ID_META_ROW = piinIdMetaRow
            ;
    END;
    PROCEDURE GET_VALUES_COMITES_PR(porcRSComites OUT SYS_REFCURSOR
                            ,piinIdMetaRow IN NUMBER
    )
    IS
    BEGIN
        OPEN porcRSComites FOR
        SELECT   VAL_C14    AS    SOLICITUD
                ,VAL_C15    AS    FEC_DOC
                ,VAL_C16    AS    FEC_REC
                ,VAL_C17    AS    FOLIO_NUM
                ,VAL_C18    AS    NUM_DOC_SOL
                ,VAL_C19    AS    ACTA_RESOL
                ,VAL_C20    AS    NUM_DOC_ACTA_RESOL
                ,VAL_C21    AS    CONVOCATORIA
                ,VAL_C22    AS    NUM_DOC_CONVOC
                ,VAL_C23    AS    DOCUMENTO_ENTREGADO
                ,VAL_C24    AS    NUM_DOC_DOC_ENT
        FROM    DERCORP_METATBL_TAB
        WHERE   1=1
        AND     ID_META_ROW = piinIdMetaRow
        ;
    END;
END DERCORP_CON_REF_DOC_PKG;
/;
