CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_APODERADOS_PKG" AS
  PROCEDURE GET_REVOCADOS_PR(pinIdEmpresa NUMBER,
                          pinTipoPoder NUMBER,
                          pstEscritura VARCHAR2,
                          pstLeyenda   OUT VARCHAR2
                          --,pstGrupo     VARCHAR2
                          );
  PROCEDURE GET_REVOCADOS_FINAL_PR(pinIdEmpresa NUMBER,
                        pinTipoPoder NUMBER,
                        pstEscritura VARCHAR2,
                        pstLeyenda   OUT VARCHAR2
                        );
PROCEDURE GET_UPDATE_REVOCADOS_PR(pstFchaBaja             VARCHAR2,
                                  pstTipoBaja             VARCHAR2,
                                  pstNumDocumento         VARCHAR2,
                                  pstDocumentum           VARCHAR2,
                                  pstCheckRevocado        VARCHAR2,
                                  pstDesProtoMedEsc       VARCHAR2,
                                  pstFecProtoMedEsc       VARCHAR2,
                                  pstDesRevocadoMediante  VARCHAR2,
                                  pstFec_revocado_mediante VARCHAR2,
                                  pinIdCatalogoValor      NUMBER,
                                  pinIdEmpresa            NUMBER,
                                  pinIdCatalogo           NUMBER,
                                  pinTipoPoder            NUMBER,
                                  pstGrupo                VARCHAR2,
                                  pstEscritura            VARCHAR2,
                                  pstElijeRev             VARCHAR2
                                  );
  FUNCTION GET_APODERADOS(pinIdEmpresa NUMBER,
                          pinTipoPoder NUMBER,
                          pstEscritura VARCHAR2,
                          pstGrupo     VARCHAR2,
                          pstAtributo3 VARCHAR2)
  RETURN VARCHAR2;
  FUNCTION GET_APODERADOS_REVOCADOS(pinIdEmpresa NUMBER,
                                    pinTipoPoder NUMBER,
                                    pstEscritura VARCHAR2,
                                    pstGrupo     VARCHAR2,
                                    pstAtributo3 VARCHAR2)
  RETURN VARCHAR2;
  FUNCTION GET_DOMINIO   (pinIdEmpresa NUMBER,
                          pinTipoPoder NUMBER,
                          pstEscritura VARCHAR2,
                          pstGrupo     VARCHAR2)
  RETURN VARCHAR2;
  FUNCTION GET_ADMINISTRACION(pinIdEmpresa NUMBER,
                              pinTipoPoder NUMBER,
                              pstEscritura VARCHAR2,
                              pstGrupo     VARCHAR2)
  RETURN VARCHAR2;
  FUNCTION GET_CREDITO    (pinIdEmpresa NUMBER,
                          pinTipoPoder NUMBER,
                          pstEscritura VARCHAR2,
                          pstGrupo     VARCHAR2)
  RETURN VARCHAR2;
  FUNCTION GET_PLEITO    (pinIdEmpresa NUMBER,
                          pinTipoPoder NUMBER,
                          pstEscritura VARCHAR2,
                          pstGrupo     VARCHAR2)
  RETURN VARCHAR2;
  FUNCTION GET_ESPECIAL   (pinIdEmpresa NUMBER,
                          pinTipoPoder NUMBER,
                          pstEscritura VARCHAR2,
                          pstGrupo     VARCHAR2)
  RETURN VARCHAR2;
  PROCEDURE COPY_ESTRUCTURA_PR(pstEscrituraFrom       VARCHAR2,
                               pstEscrituraTo         VARCHAR2,
                               pinIdEmpresaHasta      NUMBER,
                               pinIdEmpresaDesde      NUMBER);
  FUNCTION GET_GRUPO_UNION   (pinIdEmpresa NUMBER,
                              pinTipoPoder NUMBER,
                              pstEscritura VARCHAR2,
                              pstGrupo     VARCHAR2)
  RETURN VARCHAR2;
  FUNCTION GET_GRUPO_UNION_REVOCADO   ( pinIdEmpresa NUMBER,
                                        pinTipoPoder NUMBER,
                                        pstEscritura VARCHAR2,
                                        pstGrupo     VARCHAR2)
  RETURN VARCHAR2;
  PROCEDURE COPY_ESTRUCTURA_WK_TBL_PR(pinIdEmpresa  NUMBER);
  PROCEDURE COPY_ESTRUCTURA_FINAL_PR(pinIdEmpresa  NUMBER,
                                     pstEscritura VARCHAR2,
                                     pstTipoPoder VARCHAR2,
                                     pstgrupoApod VARCHAR2,
                                     pstNumOrden  VARCHAR2);
  FUNCTION GET_GRUPO_UNION_REVOCADO_SNUM   ( pinIdEmpresa NUMBER,
                                             pinTipoPoder NUMBER,
                                             pstEscritura VARCHAR2,
                                             pstGrupo     VARCHAR2)
  RETURN VARCHAR2;
END DERCORP_APODERADOS_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_APODERADOS_PKG" AS
PROCEDURE GET_UPDATE_REVOCADOS_PR(pstFchaBaja             VARCHAR2,
                                  pstTipoBaja             VARCHAR2,
                                  pstNumDocumento         VARCHAR2,
                                  pstDocumentum           VARCHAR2,
                                  pstCheckRevocado        VARCHAR2,
                                  pstDesProtoMedEsc       VARCHAR2,
                                  pstFecProtoMedEsc       VARCHAR2,
                                  pstDesRevocadoMediante  VARCHAR2,
                                  pstFec_revocado_mediante   VARCHAR2,
                                  pinIdCatalogoValor      NUMBER,
                                  pinIdEmpresa            NUMBER,
                                  pinIdCatalogo           NUMBER,
                                  pinTipoPoder            NUMBER,
                                  pstGrupo                VARCHAR2,
                                  pstEscritura            VARCHAR2,
                                  pstElijeRev             VARCHAR2
                                 )
AS
linIdrevocacion     NUMBER := 0;
linEncontroIgual    NUMBER := 0;
BEGIN
              --Obtiene el Id de revocacion
              SELECT  NVL(MAX(id_revocacion) + 1,1) INTO linIdrevocacion
					  	FROM dercorp_apoderados_wk_tab
					  	WHERE id_empresa = pinIdEmpresa
					  	AND id_catalogo = pinIdCatalogo
					  	AND Num_Tipo_Poder = pinTipoPoder
					  	--AND des_grupo = pstGrupo
					  	AND des_escritura = pstEscritura;
              IF pstElijeRev = 'esc'
              THEN
                  SELECT count(*) INTO linEncontroIgual
                  FROM dercorp_apoderados_wk_tab
                  WHERE id_empresa                  = pinIdEmpresa
                  AND id_catalogo                   = pinIdCatalogo
                  AND Num_Tipo_Poder                = pinTipoPoder
                  --AND des_grupo                   = pstGrupo
                  AND des_escritura                 = pstEscritura
                  AND des_proto_med_esc             = pstDesProtoMedEsc
                  AND fec_proto_med_esc             = pstFecProtoMedEsc;
                  --AND TRIM(des_revocado_mediante)   = TRIM(pstDesRevocadoMediante)
                  --ANd fec_revocado_mediante   = pstFec_revocado_mediante;
                  IF linEncontroIgual > 0
                  THEN
                      SELECT distinct id_revocacion INTO linIdrevocacion
                        FROM dercorp_apoderados_wk_tab
                        WHERE id_empresa                  = pinIdEmpresa
                        AND id_catalogo                   = pinIdCatalogo
                        AND Num_Tipo_Poder                = pinTipoPoder
                        --AND des_grupo                   = pstGrupo
                        AND des_escritura                 = pstEscritura
                        AND des_proto_med_esc             = pstDesProtoMedEsc
                        AND fec_proto_med_esc             = pstFecProtoMedEsc;
                       -- AND TRIM(des_revocado_mediante)   = TRIM(pstDesRevocadoMediante)
                       -- AND fec_revocado_mediante   = pstFec_revocado_mediante;
                  END IF;
              END IF;
              IF pstElijeRev = 'otro'
              THEN
                  SELECT count(*) INTO linEncontroIgual
                  FROM dercorp_apoderados_wk_tab
                  WHERE id_empresa                  = pinIdEmpresa
                  AND id_catalogo                   = pinIdCatalogo
                  AND Num_Tipo_Poder                = pinTipoPoder
                  --AND des_grupo                   = pstGrupo
                  AND des_escritura                 = pstEscritura
                  --AND des_proto_med_esc             = pstDesProtoMedEsc
                  --AND fec_proto_med_esc             = pstFecProtoMedEsc
                  AND TRIM(des_revocado_mediante)   = TRIM(pstDesRevocadoMediante)
                  ANd fec_revocado_mediante   = pstFec_revocado_mediante;
                  IF linEncontroIgual > 0
                  THEN
                      SELECT distinct id_revocacion INTO linIdrevocacion
                        FROM dercorp_apoderados_wk_tab
                        WHERE id_empresa                  = pinIdEmpresa
                        AND id_catalogo                   = pinIdCatalogo
                        AND Num_Tipo_Poder                = pinTipoPoder
                        --AND des_grupo                   = pstGrupo
                        AND des_escritura                 = pstEscritura
                        --AND des_proto_med_esc             = pstDesProtoMedEsc
                        --AND fec_proto_med_esc             = pstFecProtoMedEsc
                        AND TRIM(des_revocado_mediante)   = TRIM(pstDesRevocadoMediante)
                        AND fec_revocado_mediante   = pstFec_revocado_mediante;
                  END IF;
              END IF;
            IF pstCheckRevocado = 'No'
            THEN
              linIdrevocacion := NULL;
            END IF;
            UPDATE dercorp_apoderados_wk_tab
            SET     fec_fecha_baja          = pstFchaBaja,
                    des_tipo_baja           = pstTipoBaja,
                    des_documento           = pstNumDocumento,
                    atributo1               = pstDocumentum,
                    COD_REVOCADO            = pstCheckRevocado,
                    DES_PROTO_MED_ESC       = pstDesProtoMedEsc,
                    FEC_PROTO_MED_ESC       = pstFecProtoMedEsc,
                    DES_REVOCADO_MEDIANTE   = TRIM(pstDesRevocadoMediante),
                    FEC_REVOCADO_MEDIANTE   = pstFec_revocado_mediante,
                    ID_REVOCACION           = linIdrevocacion,
                    ATRIBUTO15              = pstElijeRev
            WHERE id_catalogo_valor         = pinIdCatalogoValor
            AND   ID_EMPRESA                = pinIdEmpresa
            AND   ID_CATALOGO               = pinIdCatalogo
            AND   NUM_TIPO_PODER            = pinTipoPoder
            AND   ATRIBUTO3                 = pstGrupo
            AND   DES_ESCRITURA             = pstEscritura
            ;
END GET_UPDATE_REVOCADOS_PR;
PROCEDURE GET_REVOCADOS_FINAL_PR(pinIdEmpresa NUMBER,
                        pinTipoPoder NUMBER,
                        pstEscritura VARCHAR2,
                        pstLeyenda   OUT VARCHAR2
                        )
IS
    --lstArmaLeyenda VARCHAR2(3000);
  BEGIN
    pstLeyenda := '<br>';
    FOR i IN (SELECT  Des_Proto_Med_Esc,
                      (SELECT     NVL(VAL_C9,'')
                       FROM       DERCORP_METATBL_TAB
                       WHERE
                          VAL_C8 = Des_Proto_Med_Esc
                          AND
                          ID_EMPRESA = pinIdEmpresa
                          AND
                          ROWNUM = 1)AS Fec_Proto_Med_Esc,
                      Des_Revocado_Mediante,
                      Fec_Revocado_Mediante,
                      Id_Revocacion,
                      atributo15
              --FROM dercorp_apoderados_tab
              --ECM 06 MAYO 2016 Captura Apoderados Cambiar de la tabla final a la tabla de trabajo
              FROM DERCORP_APODERADOS_TAB
              WHERE id_empresa    = pinIdEmpresa
              AND Num_Tipo_Poder  = pinTipoPoder
              --AND des_grupo       = pstGrupo
              AND des_escritura   = pstEscritura
              AND cod_revocado = 'Si'
              GROUP BY  Des_Proto_Med_Esc,
                        Fec_Proto_Med_Esc,
                        Des_Revocado_Mediante,
                        Fec_Revocado_Mediante,
                        id_revocacion,
                        atributo15
              ORDER BY id_revocacion )
   LOOP
        IF i.atributo15 = 'esc'
        THEN
           pstLeyenda := pstLeyenda||'<spam class=id_revocacion>'||i.Id_Revocacion||'</spam>'||
                             ' Revocado mediante Escritura '||i.Des_Proto_Med_Esc||
                             ' de fecha '||i.Fec_Proto_Med_Esc||'</br><hr/>';
        ELSE IF i.atributo15 = 'otro'
        THEN
            pstLeyenda := pstLeyenda||'<spam class=id_revocacion>'||i.Id_Revocacion||'</spam>'||
                             ' Revocado mediante '||i.Des_Revocado_Mediante || ' de fecha '||
                             i.Fec_Revocado_Mediante ||'</br><hr/>';
        END IF;
        END IF;
    /* pstLeyenda := pstLeyenda||'<spam class=id_revocacion>'||i.Id_Revocacion||'</spam>'||
                       ' Revocado mediante '||i.Des_Revocado_Mediante || ' de fecha '||
                       i.Fec_Revocado_Mediante || ' Protocolizado mediante Esc. '||i.Des_Proto_Med_Esc||
                       ' de fecha '||i.Fec_Proto_Med_Esc||'</br><hr/>';*/
   END LOOP;
   pstLeyenda := pstLeyenda||'<br>';
  END;
  PROCEDURE GET_REVOCADOS_PR( pinIdEmpresa NUMBER,
                          pinTipoPoder NUMBER,
                          pstEscritura VARCHAR2,
                          pstLeyenda   OUT VARCHAR2
                          --,pstGrupo     VARCHAR2
                          )
  IS
    --lstArmaLeyenda VARCHAR2(3000);
  BEGIN
    pstLeyenda := '<br>';
    FOR i IN (SELECT  Des_Proto_Med_Esc,
                      --Fec_Proto_Med_Esc,
                      (SELECT     NVL(VAL_C9,'')
                       FROM       DERCORP_METATBL_TAB
                       WHERE
                          VAL_C8 = Des_Proto_Med_Esc
                          AND
                          ID_EMPRESA = pinIdEmpresa
                          AND
                          ROWNUM = 1)AS Fec_Proto_Med_Esc,
                      Des_Revocado_Mediante,
                      Fec_Revocado_Mediante,
                      Id_Revocacion,
                      atributo15
              --FROM dercorp_apoderados_tab
              --ECM 06 MAYO 2016 Captura Apoderados Cambiar de la tabla final a la tabla de trabajo
              FROM DERCORP_APODERADOS_WK_TAB wk
              WHERE id_empresa    = pinIdEmpresa
              AND Num_Tipo_Poder  = pinTipoPoder
              --AND des_grupo       = pstGrupo
              AND des_escritura   = pstEscritura
              AND cod_revocado = 'Si'
              GROUP BY  Des_Proto_Med_Esc,
                        Fec_Proto_Med_Esc,
                        Des_Revocado_Mediante,
                        Fec_Revocado_Mediante,
                        id_revocacion,
                        atributo15
              ORDER BY id_revocacion )
   LOOP
      IF i.atributo15 = 'esc'
      THEN
         pstLeyenda := pstLeyenda||'<spam class=id_revocacion>'||i.Id_Revocacion||'</spam>'||
                           ' Revocado mediante Escritura '||i.Des_Proto_Med_Esc||
                           ' de fecha '||i.Fec_Proto_Med_Esc||'</br><hr/>';
      ELSE IF i.atributo15 = 'otro'
      THEN
          pstLeyenda := pstLeyenda||'<spam class=id_revocacion>'||i.Id_Revocacion||'</spam>'||
                           ' Revocado mediante '||i.Des_Revocado_Mediante || ' de fecha '||
                           i.Fec_Revocado_Mediante ||'</br><hr/>';
      END IF;
      END IF;
   END LOOP;
   pstLeyenda := pstLeyenda||'<br>';
  END;
  FUNCTION GET_APODERADOS_REVOCADOS(pinIdEmpresa NUMBER,
                          pinTipoPoder NUMBER,
                          pstEscritura VARCHAR2,
                          pstGrupo     VARCHAR2,
                          pstAtributo3 VARCHAR2)
  RETURN VARCHAR2
  AS
    lstApoderados VARCHAR2(3000);
  BEGIN
    --lstApoderados := '<b>'||pstGrupo||'</b><UL>';
    lstApoderados := '<b>'||pstAtributo3||'</b><br><!-- X1 -->';  -- NAVA 23/Feb/2016 - Para quitar la sangria
    FOR i IN (SELECT * FROM (SELECT APO.DES_GRUPO,
                     (SELECT VAL_CAT_VAL ||' '||CASE WHEN APO.ID_REVOCACION = 0
                                                                               THEN ''
                                                                               ELSE '<spam class=id_revocacion>' || APO.ID_REVOCACION || '</spam>' END --JJAQ agregar id de revocacion
                      FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB
                      WHERE  ID_CATALOGO_VALOR = APO.ID_CATALOGO_VALOR) AS APODERADO,
              APO.FEC_FECHA_BAJA,
              APO.DES_TIPO_BAJA,
              APO.DES_DOCUMENTO
              FROM  DERCORP_APODERADOS_TAB APO
              WHERE APO.ID_EMPRESA      = pinIdEmpresa
              AND   APO.ID_CATALOGO     = 32
              AND   APO.NUM_TIPO_PODER  = pinTipoPoder
              AND   APO.DES_ESCRITURA   = pstEscritura
              AND   APO.DES_GRUPO       = pstGrupo) TAB
              ORDER BY TAB.APODERADO)
   LOOP
     lstApoderados := lstApoderados||'</br><LI>'||i.APODERADO;
     /*IF i.FEC_FECHA_BAJA IS NOT NULL
     THEN
       lstApoderados := lstApoderados||'(Fec. Baja:'||i.FEC_FECHA_BAJA||' ,Tipo Baja:'
                            ||i.DES_TIPO_BAJA||' ,Doc:'||i.DES_DOCUMENTO||')';
     END IF;*/
   END LOOP;
   --lstApoderados := lstApoderados||'</UL>';
   lstApoderados := lstApoderados||'<br><br><!-- X2 -->';    -- NAVA 23/Feb/2016 - Para quitar la sangria
   return lstApoderados;
  END;
  FUNCTION GET_APODERADOS(pinIdEmpresa NUMBER,
                          pinTipoPoder NUMBER,
                          pstEscritura VARCHAR2,
                          pstGrupo     VARCHAR2,
                          pstAtributo3 VARCHAR2)
  RETURN VARCHAR2
  AS
    lstApoderados VARCHAR2(3000);
  BEGIN
    --lstApoderados := '<b>'||pstGrupo||'</b><UL>';
    lstApoderados := '<b>'||pstGrupo||'</b><br><!-- X1 -->';  -- NAVA 23/Feb/2016 - Para quitar la sangria
    --lstApoderados := '<b>'||pstAtributo3||'</b><br><!-- X1 -->';  -- NAVA 23/Feb/2016 - Para quitar la sangria
                                                                  --JJAQ 19/05/2016 muestre grupo S/N
    FOR i IN (SELECT * FROM (SELECT APO.DES_GRUPO,
                     (SELECT VAL_CAT_VAL
                      FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB
                      WHERE  ID_CATALOGO_VALOR = APO.ID_CATALOGO_VALOR) AS APODERADO,
              APO.FEC_FECHA_BAJA,
              APO.DES_TIPO_BAJA,
              APO.DES_DOCUMENTO
              FROM  DERCORP_APODERADOS_TAB APO
              WHERE APO.ID_EMPRESA      = pinIdEmpresa
              AND   APO.ID_CATALOGO     = 32
              AND   APO.NUM_TIPO_PODER  = pinTipoPoder
              AND   APO.DES_ESCRITURA   = pstEscritura
              AND   APO.DES_GRUPO       = pstGrupo) TAB
              ORDER BY TAB.APODERADO)
   LOOP
     lstApoderados := lstApoderados||'</br><LI>'||i.APODERADO;
     /*IF i.FEC_FECHA_BAJA IS NOT NULL
     THEN
       lstApoderados := lstApoderados||'(Fec. Baja:'||i.FEC_FECHA_BAJA||' ,Tipo Baja:'
                            ||i.DES_TIPO_BAJA||' ,Doc:'||i.DES_DOCUMENTO||')';
     END IF;*/
   END LOOP;
   --lstApoderados := lstApoderados||'</UL>';
   lstApoderados := lstApoderados||'<br><br><!-- X2 -->';    -- NAVA 23/Feb/2016 - Para quitar la sangria
   return lstApoderados;
  END;
  FUNCTION GET_DOMINIO   (pinIdEmpresa NUMBER,
                          pinTipoPoder NUMBER,
                          pstEscritura VARCHAR2,
                          pstGrupo     VARCHAR2)
  RETURN VARCHAR2
  AS
    lstDominio VARCHAR2(3000);
  BEGIN
    --lstDominio := '<UL type= disk>';
    lstDominio := '<br>'; --NAVA
    FOR i IN (SELECT * FROM (SELECT APO.DES_GRUPO,
                     (SELECT VAL_CAT_VAL
                      FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB
                      WHERE  ID_CATALOGO_VALOR = APO.ID_CATALOGO_VALOR) AS DOMINIO
              FROM  DERCORP_APODERADOS_TAB APO
              WHERE APO.ID_EMPRESA      = pinIdEmpresa
              AND   APO.ID_CATALOGO     = 33
              AND   APO.NUM_TIPO_PODER  = pinTipoPoder
              AND   APO.DES_ESCRITURA   = pstEscritura
              AND   APO.DES_GRUPO       = pstGrupo)TAB
              ORDER BY TAB.DOMINIO)
   LOOP
     lstDominio := lstDominio||'</br><LI>'||i.DOMINIO;
   END LOOP;
   --lstDominio := lstDominio||'</UL>';
   lstDominio := lstDominio||'<br>';--NAVA
   return lstDominio;
  END;
  FUNCTION GET_ADMINISTRACION(pinIdEmpresa NUMBER,
                              pinTipoPoder NUMBER,
                              pstEscritura VARCHAR2,
                              pstGrupo     VARCHAR2)
  RETURN VARCHAR2
  AS
    lstAdministracion VARCHAR2(3000);
  BEGIN
    --lstAdministracion := '<UL type= disk>';
    lstAdministracion := '<br>'; --NAVA
    FOR i IN (SELECT * FROM (SELECT APO.DES_GRUPO,
                     (SELECT VAL_CAT_VAL
                      FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB
                      WHERE  ID_CATALOGO_VALOR = APO.ID_CATALOGO_VALOR) AS ADMINISTRACION
              FROM  DERCORP_APODERADOS_TAB APO
              WHERE APO.ID_EMPRESA      = pinIdEmpresa
              AND   APO.ID_CATALOGO     = 34
              AND   APO.NUM_TIPO_PODER  = pinTipoPoder
              AND   APO.DES_ESCRITURA   = pstEscritura
              AND   APO.DES_GRUPO       = pstGrupo)TAB
              ORDER BY TAB.ADMINISTRACION)
   LOOP
     lstAdministracion := lstAdministracion||'</br><LI>'||i.ADMINISTRACION;
   END LOOP;
   --lstAdministracion := lstAdministracion||'</UL>';
   lstAdministracion := lstAdministracion||'<br>';--NAVA
   return lstAdministracion;
  END;
  FUNCTION GET_CREDITO    (pinIdEmpresa NUMBER,
                          pinTipoPoder NUMBER,
                          pstEscritura VARCHAR2,
                          pstGrupo     VARCHAR2)
  RETURN VARCHAR2
  AS
    lstCredito VARCHAR2(3000);
  BEGIN
    --lstCredito := '<UL type= disk>';
    lstCredito := '<br>';--NAVA
    FOR i IN (SELECT * FROM(SELECT APO.DES_GRUPO,
                     (SELECT VAL_CAT_VAL
                      FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB
                      WHERE  ID_CATALOGO_VALOR = APO.ID_CATALOGO_VALOR) AS CREDITO
              FROM  DERCORP_APODERADOS_TAB APO
              WHERE APO.ID_EMPRESA      = pinIdEmpresa
              AND   APO.ID_CATALOGO     = 35
              AND   APO.NUM_TIPO_PODER  = pinTipoPoder
              AND   APO.DES_ESCRITURA   = pstEscritura
              AND   APO.DES_GRUPO       = pstGrupo)TAB
              ORDER BY TAB.CREDITO)
   LOOP
     lstCredito := lstCredito||'</br><LI>'||i.CREDITO;
   END LOOP;
   --lstCredito := lstCredito||'</UL>';
   lstCredito := lstCredito||'<br>';--NAVA
   return lstCredito;
  END;
  FUNCTION GET_PLEITO    (pinIdEmpresa NUMBER,
                          pinTipoPoder NUMBER,
                          pstEscritura VARCHAR2,
                          pstGrupo     VARCHAR2)
  RETURN VARCHAR2
  AS
    lstPleito VARCHAR2(3000);
  BEGIN
    --lstPleito := '<UL type= disk>';
    lstPleito := '<br>'; --NAVA
    FOR i IN (SELECT * FROM (SELECT APO.DES_GRUPO,
                     (SELECT VAL_CAT_VAL
                      FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB
                      WHERE  ID_CATALOGO_VALOR = APO.ID_CATALOGO_VALOR) AS PLEITO
              FROM  DERCORP_APODERADOS_TAB APO
              WHERE APO.ID_EMPRESA      = pinIdEmpresa
              AND   APO.ID_CATALOGO     = 36
              AND   APO.NUM_TIPO_PODER  = pinTipoPoder
              AND   APO.DES_ESCRITURA   = pstEscritura
              AND   APO.DES_GRUPO       = pstGrupo)TAB
              ORDER BY TAB.PLEITO)
   LOOP
     lstPleito := lstPleito||'</br><LI>'||i.PLEITO;
   END LOOP;
   --lstPleito := lstPleito||'</UL>';
   lstPleito := lstPleito||'<br>'; --NAVA
   return lstPleito;
  END;
  FUNCTION GET_ESPECIAL   (pinIdEmpresa NUMBER,
                          pinTipoPoder NUMBER,
                          pstEscritura VARCHAR2,
                          pstGrupo     VARCHAR2)
  RETURN VARCHAR2
  AS
    lstEspecial VARCHAR2(3000);
  BEGIN
    --lstEspecial := '<UL type= disk>';
    lstEspecial := '<br>';--NAVA
    FOR i IN (SELECT * FROM(SELECT APO.DES_GRUPO,
                     (SELECT VAL_CAT_VAL
                      FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB
                      WHERE  ID_CATALOGO_VALOR = APO.ID_CATALOGO_VALOR) AS APODERADO
              FROM  DERCORP_APODERADOS_TAB APO
              WHERE APO.ID_EMPRESA      = pinIdEmpresa
              AND   APO.ID_CATALOGO     = 37
              AND   APO.NUM_TIPO_PODER  = pinTipoPoder
              AND   APO.DES_ESCRITURA   = pstEscritura
              AND   APO.DES_GRUPO       = pstGrupo)TAB
              ORDER BY TAB.APODERADO)
   LOOP
     lstEspecial := lstEspecial||'</br><LI>'||i.APODERADO;
   END LOOP;
   --lstEspecial := lstEspecial||'</UL>';
   lstEspecial := lstEspecial||'<br>'; --NAVA
   return lstEspecial;
  END;
  FUNCTION GET_GRUPO_UNION   (pinIdEmpresa NUMBER,
                              pinTipoPoder NUMBER,
                              pstEscritura VARCHAR2,
                              pstGrupo     VARCHAR2)
  RETURN VARCHAR2 IS
    CURSOR CUR_GRUPO IS
      SELECT DISTINCT APO.ID_EMPRESA,
      APO.DES_ESCRITURA,
      APO.NUM_TIPO_PODER,
      --APO.DES_GRUPO,
      APO.ATRIBUTO3,
      DERCORP_APODERADOS_PKG.GET_DOMINIO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS ACTOS_DOMINIO,
      DERCORP_APODERADOS_PKG.GET_ADMINISTRACION(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS ACTOS_ADMINISTRACION,
      DERCORP_APODERADOS_PKG.GET_CREDITO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS TITULOS_CREDITO,
      DERCORP_APODERADOS_PKG.GET_PLEITO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS PLEITOS_COBRANZAS,
      DERCORP_APODERADOS_PKG.GET_ESPECIAL(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS PODERES_ESPECIALES
      FROM            DERCORP_APODERADOS_TAB APO
      WHERE	1=1
      AND	APO.ID_EMPRESA      = pinIdEmpresa
      AND    APO.NUM_TIPO_PODER  = pinTipoPoder
      AND    APO.DES_ESCRITURA = pstEscritura
      AND    APO.DES_GRUPO =  pstGrupo;
    lstEspecial VARCHAR2(3000):= '<br>';
    lstTemp     VARCHAR2(3000);
  BEGIN
    FOR i IN CUR_GRUPO
      LOOP
        FOR j IN (SELECT * FROM (
                    SELECT DISTINCT APO.ID_EMPRESA,
                    APO.DES_ESCRITURA,
                    APO.NUM_TIPO_PODER,
                    APO.DES_GRUPO,
                    DERCORP_APODERADOS_PKG.GET_APODERADOS(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO,APO.ATRIBUTO3) AS APODERADOS,
                    DERCORP_APODERADOS_PKG.GET_DOMINIO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS ACTOS_DOMINIO,
                    DERCORP_APODERADOS_PKG.GET_ADMINISTRACION(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS ACTOS_ADMINISTRACION,
                    DERCORP_APODERADOS_PKG.GET_CREDITO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS TITULOS_CREDITO,
                    DERCORP_APODERADOS_PKG.GET_PLEITO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS PLEITOS_COBRANZAS,
                    DERCORP_APODERADOS_PKG.GET_ESPECIAL(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS PODERES_ESPECIALES
                    FROM            DERCORP_APODERADOS_TAB APO
                    WHERE	1=1
                    AND	APO.ID_EMPRESA         = pinIdEmpresa
                    AND    APO.NUM_TIPO_PODER  = pinTipoPoder
                    AND    APO.DES_ESCRITURA   = pstEscritura) TAB
                    WHERE TAB.ACTOS_DOMINIO    = i.ACTOS_DOMINIO
                    AND   TAB.ACTOS_ADMINISTRACION = i.ACTOS_ADMINISTRACION
                    AND   TAB.TITULOS_CREDITO     = i.TITULOS_CREDITO
                    AND   TAB.PLEITOS_COBRANZAS  =  i.PLEITOS_COBRANZAS
                    AND   TAB.PODERES_ESPECIALES = i.PODERES_ESPECIALES
                    ORDER BY TAB.APODERADOS )
            LOOP
             lstEspecial:= lstEspecial||'</br>'||j.APODERADOS;
            END LOOP;
      END LOOP;
    RETURN  lstEspecial;
  END;
  --JJAQ
   FUNCTION GET_GRUPO_UNION_REVOCADO (pinIdEmpresa NUMBER,
                                      pinTipoPoder NUMBER,
                                      pstEscritura VARCHAR2,
                                      pstGrupo     VARCHAR2)
  RETURN VARCHAR2 IS
    CURSOR CUR_GRUPO IS
      SELECT DISTINCT APO.ID_EMPRESA,
      APO.DES_ESCRITURA,
      APO.NUM_TIPO_PODER,
      APO.DES_GRUPO,
      DERCORP_APODERADOS_PKG.GET_DOMINIO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS ACTOS_DOMINIO,
      DERCORP_APODERADOS_PKG.GET_ADMINISTRACION(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS ACTOS_ADMINISTRACION,
      DERCORP_APODERADOS_PKG.GET_CREDITO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS TITULOS_CREDITO,
      DERCORP_APODERADOS_PKG.GET_PLEITO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS PLEITOS_COBRANZAS,
      DERCORP_APODERADOS_PKG.GET_ESPECIAL(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS PODERES_ESPECIALES
      FROM            DERCORP_APODERADOS_TAB APO
      WHERE	1=1
      AND	APO.ID_EMPRESA      = pinIdEmpresa
      AND    APO.NUM_TIPO_PODER  = pinTipoPoder
      AND    APO.DES_ESCRITURA = pstEscritura
      AND    APO.DES_GRUPO =  pstGrupo;
    lstEspecial VARCHAR2(3000):= '<br>';
    lstTemp     VARCHAR2(3000);
  BEGIN
    FOR i IN CUR_GRUPO
      LOOP
        FOR j IN (SELECT * FROM (
                    SELECT DISTINCT APO.ID_EMPRESA,
                    APO.DES_ESCRITURA,
                    APO.NUM_TIPO_PODER,
                    APO.DES_GRUPO,
                    DERCORP_APODERADOS_PKG.GET_APODERADOS_REVOCADOS(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO,APO.ATRIBUTO3) AS APODERADOS,
                    DERCORP_APODERADOS_PKG.GET_DOMINIO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS ACTOS_DOMINIO,
                    DERCORP_APODERADOS_PKG.GET_ADMINISTRACION(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS ACTOS_ADMINISTRACION,
                    DERCORP_APODERADOS_PKG.GET_CREDITO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS TITULOS_CREDITO,
                    DERCORP_APODERADOS_PKG.GET_PLEITO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS PLEITOS_COBRANZAS,
                    DERCORP_APODERADOS_PKG.GET_ESPECIAL(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS PODERES_ESPECIALES
                    FROM            DERCORP_APODERADOS_TAB APO
                    WHERE	1=1
                    AND	APO.ID_EMPRESA         = pinIdEmpresa
                    AND    APO.NUM_TIPO_PODER  = pinTipoPoder
                    AND    APO.DES_ESCRITURA   = pstEscritura) TAB
                    WHERE TAB.ACTOS_DOMINIO    = i.ACTOS_DOMINIO
                    AND   TAB.ACTOS_ADMINISTRACION = i.ACTOS_ADMINISTRACION
                    AND   TAB.TITULOS_CREDITO     = i.TITULOS_CREDITO
                    AND   TAB.PLEITOS_COBRANZAS  =  i.PLEITOS_COBRANZAS
                    AND   TAB.PODERES_ESPECIALES = i.PODERES_ESPECIALES
                    ORDER BY TAB.APODERADOS )
            LOOP
             lstEspecial:= lstEspecial||'</br>'||j.APODERADOS;
            END LOOP;
      END LOOP;
    RETURN  lstEspecial;
  END;
  PROCEDURE COPY_ESTRUCTURA_PR(pstEscrituraFrom       VARCHAR2,
                               pstEscrituraTo         VARCHAR2,
                               pinIdEmpresaHasta      NUMBER,
                               pinIdEmpresaDesde      NUMBER)
  IS
  BEGIN
    --DELETE FROM DERCORP_APODERADOS_TAB
    DELETE FROM DERCORP_APODERADOS_WK_TAB
    WHERE  ID_EMPRESA     = pinIdEmpresaHasta
    AND    DES_ESCRITURA  = pstEscrituraTo
    ;
    FOR i IN (SELECT APO.* FROM DERCORP_APODERADOS_TAB APO
    --FOR i IN (SELECT APO.* FROM DERCORP_APODERADOS_WK_TAB APO
              WHERE 1=1
              AND   APO.DES_ESCRITURA = pstEscrituraFrom
              AND   APO.ID_EMPRESA    = pinIdEmpresaDesde
              )
    LOOP
       --ECM 06 MAYO 2016 Captura - Consulta - Cambiar tabla final por tabla de trabajo
       --INSERT INTO DERCORP_APODERADOS_TAB APO ( ID_EMPRESA,
       INSERT INTO DERCORP_APODERADOS_WK_TAB APO (  ID_EMPRESA,
                                                    ID_CATALOGO,
                                                    ID_CATALOGO_VALOR,
                                                    DES_TIPO_ELEMENTO,
                                                    NUM_TIPO_PODER,
                                                    DES_GRUPO,
                                                    DES_ESCRITURA,
                                                    FEC_FECHA_BAJA,
                                                    DES_TIPO_BAJA,
                                                    DES_DOCUMENTO,
                                                    ATRIBUTO1,
                                                    ATRIBUTO2,
                                                    ATRIBUTO3,
                                                    ATRIBUTO15,
                                                    FEC_CREATION_DATE
                                                  )
       VALUES(pinIdEmpresaHasta,
              i.ID_CATALOGO,
              i.ID_CATALOGO_VALOR,
              i.DES_TIPO_ELEMENTO,
              i.NUM_TIPO_PODER,
              i.DES_GRUPO,
              pstEscrituraTo,
              --i.DES_ESCRITURA,
              i.FEC_FECHA_BAJA,
              i.DES_TIPO_BAJA,
              i.DES_DOCUMENTO,
              i.ATRIBUTO1,
              i.ATRIBUTO2,
              i.ATRIBUTO3,
              i.ATRIBUTO15,
              i.FEC_CREATION_DATE
              );
    END LOOP;
    COMMIT;
  END;
  PROCEDURE COPY_ESTRUCTURA_WK_TBL_PR(pinIdEmpresa  NUMBER)
  IS
  BEGIN
    DELETE FROM DERCORP_APODERADOS_WK_TAB
    WHERE  ID_EMPRESA     = pinIdEmpresa;
    FOR i IN (SELECT APO.* FROM DERCORP_APODERADOS_TAB APO
              WHERE APO.ID_EMPRESA = pinIdEmpresa)
    LOOP
       INSERT INTO DERCORP_APODERADOS_WK_TAB APO ( ID_EMPRESA,
                                                ID_CATALOGO,
                                                ID_CATALOGO_VALOR,
                                                DES_TIPO_ELEMENTO,
                                                NUM_TIPO_PODER,
                                                DES_GRUPO,
                                                DES_ESCRITURA,
                                                FEC_FECHA_BAJA,
                                                DES_TIPO_BAJA,
                                                DES_DOCUMENTO,
                                                COD_REVOCADO,
                                                DES_PROTO_MED_ESC,
                                                FEC_PROTO_MED_ESC,
                                                DES_REVOCADO_MEDIANTE,
                                                FEC_REVOCADO_MEDIANTE,
                                                ID_REVOCACION,
                                                ATRIBUTO1,
                                                ATRIBUTO2,
                                                ATRIBUTO3,
                                                ATRIBUTO15,
                                                FEC_CREATION_DATE
                                               )
       VALUES(pinIdEmpresa,
              i.ID_CATALOGO,
              i.ID_CATALOGO_VALOR,
              i.DES_TIPO_ELEMENTO,
              i.NUM_TIPO_PODER,
              i.DES_GRUPO,
              i.DES_ESCRITURA,
              i.FEC_FECHA_BAJA,
              i.DES_TIPO_BAJA,
              i.DES_DOCUMENTO,
              i.COD_REVOCADO,
              i.DES_PROTO_MED_ESC,
              i.FEC_PROTO_MED_ESC,
              i.DES_REVOCADO_MEDIANTE,
              i.FEC_REVOCADO_MEDIANTE,
              i.ID_REVOCACION,
              i.ATRIBUTO1,
              i.ATRIBUTO2,
              i.ATRIBUTO3,
              i.ATRIBUTO15,
              i.FEC_CREATION_DATE
              );
    END LOOP;
    COMMIT;
  END;
  PROCEDURE COPY_ESTRUCTURA_FINAL_PR(pinIdEmpresa  NUMBER,
                                     pstEscritura VARCHAR2,
                                     pstTipoPoder VARCHAR2,
                                     pstgrupoApod VARCHAR2,
                                     pstNumOrden  VARCHAR2)
  IS
    lstNumOrden   VARCHAR2(150);
  BEGIN
     DELETE FROM DERCORP_APODERADOS_TAB
     WHERE  ID_EMPRESA     = pinIdEmpresa
     AND    DES_ESCRITURA  = pstEscritura;
    /*FOR i IN (SELECT apowk.*
              FROM dercorp_apoderados_wk_tab apowk
              WHERE apowk.id_empresa = pinIdEmpresa
              AND NOT EXISTS (SELECT apo.*
                              FROM dercorp_apoderados_tab apo
                              WHERE apo.id_empresa = apowk.id_empresa
                              AND   apo.id_catalogo = apowk.id_catalogo
                              AND   apo.id_catalogo_valor = apowk.id_catalogo_valor
                              AND   trim(apo.des_grupo)= trim(apowk.des_grupo)
                              AND   trim(apo.des_escritura) = trim(apowk.des_escritura)))*/
    --JJAQ Proceso para la agrupacion de apoderados de acuerdo al numero capturado por el ususario
    UPDATE dercorp_apoderados_wk_tab
            SET atributo2 =  pstNumOrden
            WHERE 1 = 1
            AND	id_empresa      = pinIdEmpresa
    				AND num_tipo_poder  = pstTipoPoder
    				AND des_escritura   = pstEscritura
            AND TRIM(atributo3) = pstgrupoApod;
    /*
    SELECT atributo2 INTO lstNumOrden
            FROM dercorp_apoderados_wk_tab apo
            WHERE 1 = 1
            AND	apo.id_empresa      = pinIdEmpresa
    				AND apo.num_tipo_poder  = pstTipoPoder
    				AND apo.des_escritura   = pstEscritura
            AND apo.des_grupo       = pstgrupoApod
            AND ROWNUM              = 1;*/
    UPDATE dercorp_apoderados_wk_tab
            SET des_grupo =  pstNumOrden ||' '||pstgrupoApod
            WHERE 1 = 1
            AND	id_empresa      = pinIdEmpresa
    				AND num_tipo_poder  = pstTipoPoder
    				AND des_escritura   = pstEscritura
            AND TRIM(atributo3)       = pstgrupoApod;
    FOR i IN (SELECT APO.* FROM DERCORP_APODERADOS_WK_TAB APO
              WHERE APO.ID_EMPRESA = pinIdEmpresa
              AND    DES_ESCRITURA  = pstEscritura)
    LOOP
       INSERT INTO DERCORP_APODERADOS_TAB APO ( ID_EMPRESA,
                                                ID_CATALOGO,
                                                ID_CATALOGO_VALOR,
                                                DES_TIPO_ELEMENTO,
                                                NUM_TIPO_PODER,
                                                DES_GRUPO,
                                                DES_ESCRITURA,
                                                FEC_FECHA_BAJA,
                                                DES_TIPO_BAJA,
                                                DES_DOCUMENTO,
                                                COD_REVOCADO,
                                                DES_PROTO_MED_ESC,
                                                FEC_PROTO_MED_ESC,
                                                DES_REVOCADO_MEDIANTE,
                                                FEC_REVOCADO_MEDIANTE,
                                                ID_REVOCACION,
                                                ATRIBUTO1,
                                                ATRIBUTO2,
                                                ATRIBUTO3,
                                                ATRIBUTO15,
                                                FEC_CREATION_DATE
                                               )
       VALUES(pinIdEmpresa,
              i.ID_CATALOGO,
              i.ID_CATALOGO_VALOR,
              i.DES_TIPO_ELEMENTO,
              i.NUM_TIPO_PODER,
              i.DES_GRUPO,
              i.DES_ESCRITURA,
              i.FEC_FECHA_BAJA,
              i.DES_TIPO_BAJA,
              i.DES_DOCUMENTO,
              i.COD_REVOCADO,
              i.DES_PROTO_MED_ESC,
              i.FEC_PROTO_MED_ESC,
              i.DES_REVOCADO_MEDIANTE,
              i.FEC_REVOCADO_MEDIANTE,
              i.ID_REVOCACION,
              i.ATRIBUTO1,
              i.ATRIBUTO2,
              i.ATRIBUTO3,
              i.ATRIBUTO15,
              i.FEC_CREATION_DATE
              );
    END LOOP;
    COMMIT;
  END;
  --JJAQ
   FUNCTION GET_GRUPO_UNION_REVOCADO_SNUM ( pinIdEmpresa NUMBER,
                                            pinTipoPoder NUMBER,
                                            pstEscritura VARCHAR2,
                                            pstGrupo     VARCHAR2)
  RETURN VARCHAR2 IS
    CURSOR CUR_GRUPO IS
      SELECT DISTINCT APO.ID_EMPRESA,
      APO.DES_ESCRITURA,
      APO.NUM_TIPO_PODER,
      APO.ATRIBUTO3,
      DERCORP_APODERADOS_PKG.GET_DOMINIO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS ACTOS_DOMINIO,
      DERCORP_APODERADOS_PKG.GET_ADMINISTRACION(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS ACTOS_ADMINISTRACION,
      DERCORP_APODERADOS_PKG.GET_CREDITO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS TITULOS_CREDITO,
      DERCORP_APODERADOS_PKG.GET_PLEITO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS PLEITOS_COBRANZAS,
      DERCORP_APODERADOS_PKG.GET_ESPECIAL(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS PODERES_ESPECIALES
      FROM            DERCORP_APODERADOS_TAB APO
      WHERE	1=1
      AND	   APO.ID_EMPRESA      = pinIdEmpresa
      AND    APO.NUM_TIPO_PODER  = pinTipoPoder
      AND    APO.DES_ESCRITURA = pstEscritura
      AND    APO.DES_GRUPO =  pstGrupo;
    lstEspecial VARCHAR2(3000):= '<br>';
    --lstEspecial CLOB:= '<br>';
    lstTemp     VARCHAR2(3000);
  BEGIN
    FOR i IN CUR_GRUPO
      LOOP
        FOR j IN (SELECT * FROM (
                    SELECT DISTINCT APO.ID_EMPRESA,
                    APO.DES_ESCRITURA,
                    APO.NUM_TIPO_PODER,
                    APO.ATRIBUTO3,
                    --DBMS_LOB.substr(DERCORP_WK_APODERADOS_PKG.GET_APODERADOS_REVOCADOS(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO)) AS APODERADOS,
                    DERCORP_APODERADOS_PKG.GET_APODERADOS_REVOCADOS(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO,APO.ATRIBUTO3) AS APODERADOS,
                    DERCORP_APODERADOS_PKG.GET_DOMINIO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS ACTOS_DOMINIO,
                    DERCORP_APODERADOS_PKG.GET_ADMINISTRACION(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS ACTOS_ADMINISTRACION,
                    DERCORP_APODERADOS_PKG.GET_CREDITO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS TITULOS_CREDITO,
                    DERCORP_APODERADOS_PKG.GET_PLEITO(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS PLEITOS_COBRANZAS,
                    DERCORP_APODERADOS_PKG.GET_ESPECIAL(APO.ID_EMPRESA,APO.NUM_TIPO_PODER,APO.DES_ESCRITURA,APO.DES_GRUPO) AS PODERES_ESPECIALES
                    FROM            DERCORP_APODERADOS_TAB APO
                    WHERE	1=1
                    AND	APO.ID_EMPRESA              = pinIdEmpresa
                    AND    APO.NUM_TIPO_PODER       = pinTipoPoder
                    AND    APO.DES_ESCRITURA        = pstEscritura) TAB
                    WHERE TAB.ACTOS_DOMINIO         = i.ACTOS_DOMINIO
                    AND   TAB.ACTOS_ADMINISTRACION  = i.ACTOS_ADMINISTRACION
                    AND   TAB.TITULOS_CREDITO       = i.TITULOS_CREDITO
                    AND   TAB.PLEITOS_COBRANZAS     =  i.PLEITOS_COBRANZAS
                    AND   TAB.PODERES_ESPECIALES    = i.PODERES_ESPECIALES
                    ORDER BY TAB.APODERADOS )
            LOOP
             lstEspecial:= lstEspecial||'</br>'||j.APODERADOS;
            END LOOP;
      END LOOP;
    RETURN  lstEspecial;
  END;
END DERCORP_APODERADOS_PKG;
/;
