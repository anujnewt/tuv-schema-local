CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."XXTV_TEN_CASC_PKG" AS
  PROCEDURE GET_TREE_DATA_RECORDS(resultSet OUT SYS_REFCURSOR, paramEmpresa VARCHAR2, paramFecha VARCHAR2,
                                                                              paramConsolida VARCHAR2,
                                                                              paramSegmento VARCHAR2,
                                                                              paramClasificacion VARCHAR2,
                                                                              paramPais VARCHAR2,
                                                                              paranNumOracle VARCHAR2,
                                                                              paramGiro VARCHAR2,
                                                                              paramPorcentaje VARCHAR2,
                                                                              paramPorcentajeOpt VARCHAR2,
                                                                              paramPorcentajeCual VARCHAR2
                                                                              );
  PROCEDURE GET_TREE_DATA(resultSet OUT SYS_REFCURSOR, paramEmpresa VARCHAR2, paramFecha VARCHAR2,
                                                                              paramConsolida VARCHAR2,
                                                                              paramSegmento VARCHAR2,
                                                                              paramClasificacion VARCHAR2,
                                                                              paramPais VARCHAR2,
                                                                              paranNumOracle VARCHAR2,
                                                                              paramGiro VARCHAR2,
                                                                              paramPorcentaje VARCHAR2,
                                                                              paramPorcentajeOpt VARCHAR2,
                                                                              paramPorcentajeCual VARCHAR2,
                                                                              paramPorcentajeVisualizar VARCHAR2
                                                                              );
  PROCEDURE GET_TREE_DATA1(resultSet OUT SYS_REFCURSOR, paramEmpresa VARCHAR2, paramFecha VARCHAR2,
                                                                              paramConsolida VARCHAR2,
                                                                              paramSegmento VARCHAR2,
                                                                              paramClasificacion VARCHAR2,
                                                                              paramPais VARCHAR2,
                                                                              paranNumOracle VARCHAR2,
                                                                              paramGiro VARCHAR2,
                                                                              paramPorcentaje VARCHAR2,
                                                                              paramPorcentajeOpt VARCHAR2,
                                                                              paramPorcentajeCual VARCHAR2,
                                                                              paramPorcentajeVisualizar VARCHAR2,
                                                                              paramDivision VARCHAR2
                                                                              );
  PROCEDURE GET_TREE_DATA2(resultSet OUT SYS_REFCURSOR, paramEmpresa VARCHAR2, paramFecha VARCHAR2,
                                                                              paramConsolida VARCHAR2,
                                                                              paramSegmento VARCHAR2,
                                                                              paramClasificacion VARCHAR2,
                                                                              paramPais VARCHAR2,
                                                                              paranNumOracle VARCHAR2,
                                                                              paramGiro VARCHAR2,
                                                                              paramPorcentaje VARCHAR2,
                                                                              paramPorcentajeOpt VARCHAR2,
                                                                              paramPorcentajeCual VARCHAR2);
  PROCEDURE GET_TREE_DATA3(resultSet OUT SYS_REFCURSOR, paramEmpresa VARCHAR2, paramFecha VARCHAR2,
                                                                              paramConsolida VARCHAR2,
                                                                              paramSegmento VARCHAR2,
                                                                              paramClasificacion VARCHAR2,
                                                                              paramPais VARCHAR2,
                                                                              paranNumOracle VARCHAR2,
                                                                              paramGiro VARCHAR2,
                                                                              paramPorcentaje VARCHAR2,
                                                                              paramPorcentajeOpt VARCHAR2,
                                                                              paramPorcentajeCual VARCHAR2);
  PROCEDURE GET_TREE_DATA4(resultSet OUT SYS_REFCURSOR, paramEmpresa VARCHAR2, paramFecha VARCHAR2,
                                                                              paramConsolida VARCHAR2,
                                                                              paramSegmento VARCHAR2,
                                                                              paramClasificacion VARCHAR2,
                                                                              paramPais VARCHAR2,
                                                                              paranNumOracle VARCHAR2,
                                                                              paramGiro VARCHAR2,
                                                                              paramPorcentaje VARCHAR2,
                                                                              paramPorcentajeOpt VARCHAR2,
                                                                              paramPorcentajeCual VARCHAR2,
                                                                              paramPorcentajeVisualizar VARCHAR2);
  PROCEDURE dump_clob (clob IN OUT NOCOPY CLOB,action number);
  PROCEDURE APPEND_LOG(text VARCHAR2,action number);
  --ECM 12 Agosto 2016 - Quitar numeros de los nodos padre que no cumplen con el filtro.
  PROCEDURE NEW_TENC_CASC_PR;
  --JJAQ y ULR 29/03/2017 Quitar padre e hijos cuando no se cumpla con el porcentaje directo o indirecto
  PROCEDURE QUITAR_PADRE_HIJOS_PR;
END XXTV_TEN_CASC_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."XXTV_TEN_CASC_PKG" AS
  PROCEDURE GET_TREE_DATA_RECORDS(resultSet OUT SYS_REFCURSOR, paramEmpresa VARCHAR2, paramFecha VARCHAR2,
                                                                              paramConsolida VARCHAR2,
                                                                              paramSegmento VARCHAR2,
                                                                              paramClasificacion VARCHAR2,
                                                                              paramPais VARCHAR2,
                                                                              paranNumOracle VARCHAR2,
                                                                              paramGiro VARCHAR2,
                                                                              paramPorcentaje VARCHAR2,
                                                                              paramPorcentajeOpt VARCHAR2,
                                                                              paramPorcentajeCual VARCHAR2
                                                                              ) AS
      v_stringbuilder CLOB;
      v_lastlevel NUMBER;
      postArrTenCasc SYS_REFCURSOR;
      pistOutType    VARCHAR2(20):='DBMS';
  BEGIN
    --DELETE FROM APP_TEMP_LOG;
    ----DELETE FROM DERCORP_REPORTE_TENCASC_FIS; Solo se usa para debug
    --DELETE FROM DERCORP_REPORTE_TENCASC_TMP;
    --DERCORP_REPORT_TENCASC_PKG.DO_REPORT_PR(postArrTenCasc, pistOutType, paramEmpresa);
    OPEN resultSet FOR
            --SELECT * FROM PENDIUM_TEN_CASC_PASO_TMP ORDER BY id_row;
            SELECT super_query_rownum,
                    id_row,
                    id_parent,
                    des_dato1,
                    des_dato2,
                    --nom_empresa,
                    LPAD(EXT.des_dato3,LENGTH(EXT.des_dato3) + LEVEL * 5 - 5,' ') AS NOM_EMPRESA,
                    --pad,
                    LPAD(' ',5 + LEVEL * 5 - 5,' ') AS PAD,
                    des_dato4,
                    directo,
                    indirecto,
                    des_dato7,
                    --ten_casc_level,
                    LEVEL TEN_CASC_LEVEL,
                    cant_hijos,
                    consolida,
                    segmento,
                    clasificacion,
                    pais,
                    no_emp_oracle,
                    giro,
                    consolida_all,
                    segmento_all,
                    clasificacion_all,
                    pais_all,
                    no_emp_oracle_all,
                    giro_all,
                    division_all,
                    division
        FROM PENDIUM_TEN_CASC_PASO_TMP ext
        START WITH EXT.DES_DATO4 = paramEmpresa
        CONNECT BY PRIOR EXT.id_row = EXT.id_parent
        ORDER SIBLINGS BY EXT.des_dato3;
  END GET_TREE_DATA_RECORDS;
  PROCEDURE GET_TREE_DATA(resultSet OUT SYS_REFCURSOR, paramEmpresa VARCHAR2, paramFecha VARCHAR2,
                                                                              paramConsolida VARCHAR2,
                                                                              paramSegmento VARCHAR2,
                                                                              paramClasificacion VARCHAR2,
                                                                              paramPais VARCHAR2,
                                                                              paranNumOracle VARCHAR2,
                                                                              paramGiro VARCHAR2,
                                                                              paramPorcentaje VARCHAR2,
                                                                              paramPorcentajeOpt VARCHAR2,
                                                                              paramPorcentajeCual VARCHAR2,
                                                                              paramPorcentajeVisualizar VARCHAR2
                                                                              ) AS
      v_stringbuilder CLOB;
      v_lastlevel NUMBER;
      postArrTenCasc SYS_REFCURSOR;
      pistOutType    VARCHAR2(20):='DBMS';
  BEGIN
    DELETE FROM APP_TEMP_LOG;
    --DELETE FROM DERCORP_REPORTE_TENCASC_FIS;
    DELETE FROM DERCORP_REPORTE_TENCASC_TMP;
    DERCORP_REPORT_TENCASC_PKG.DO_REPORT_PR(postArrTenCasc, pistOutType, paramEmpresa);
    v_lastlevel := 0;
    v_stringbuilder := '';
    FOR XX_ROW IN (
            /*
            SELECT
              *
            FROM
              DERCORP_REPORTE_TENCASC2_TMP
             WHERE
              CONSOLIDA_ALL LIKE '%' || paramConsolida || '%'
              AND
              SEGMENTO_ALL LIKE '%' || paramSegmento || '%'
              AND
              CLASIFICACION_ALL LIKE '%' || paramClasificacion || '%'
              AND
              PAIS_ALL LIKE '%' || paramPais || '%'
              AND
              NO_EMP_ORACLE_ALL LIKE '%' || paranNumOracle || '%'
              AND
              GIRO_ALL LIKE '%' || paramGiro || '%'
            --ORDER BY
              --DES_DATO1
            START WITH DES_DATO4 = paramEmpresa
            CONNECT BY PRIOR DES_DATO1 = DES_DATO4
              */
            SELECT EXT.DES_DATO1,
                 EXT.DES_DATO2,
                 LPAD(EXT.DES_DATO3,LENGTH(EXT.DES_DATO3) + LEVEL * 5 - 5,' ') AS NOM_EMPRESA,
                 LPAD(' ',5 + LEVEL * 5 - 5,' ') AS PAD,
                 EXT.DES_DATO4,
                 EXT.DES_DATO5 DIRECTO,
                 EXT.DES_DATO6 INDIRECTO,
                 EXT.DES_DATO7,
                 LEVEL TEN_CASC_LEVEL,
                 (SELECT
                      count(*)
                  FROM
                      --DERCORP_REPORTE_TENCASC_FIS
                      DERCORP_REPORTE_TENCASC_TMP
                  WHERE
                    DES_DATO4 = EXT.DES_DATO1) CANT_HIJOS,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(516,EXT.DES_DATO1) AS CONSOLIDA,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(506,EXT.DES_DATO1) AS SEGMENTO,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(507,EXT.DES_DATO1) AS CLASIFICACION,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(509,EXT.DES_DATO1) AS PAIS,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(502,EXT.DES_DATO1) AS NO_EMP_ORACLE,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(504,EXT.DES_DATO1) AS GIRO,
                  '' AS CONSOLIDA_ALL,
                  '' AS SEGMENTO_ALL,
                  '' AS CLASIFICACION_ALL,
                  '' AS PAIS_ALL,
                  '' AS NO_EMP_ORACLE_ALL,
                  '' AS GIRO_ALL
          FROM
            --DERCORP_REPORTE_TENCASC_FIS EXT
            DERCORP_REPORTE_TENCASC_TMP EXT
          --WHERE
          --  EXT.DES_DATO2 LIKE '%XEZZ%'
          WHERE
          /*
            (
            APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1) LIKE '%' || paramConsolida || '%'
                OR
                (
                  APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1) IS NULL
                  AND
                  LENGTH(paramConsolida) = 0
                )
               )*/
              (APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1) LIKE '%' || paramConsolida || '%'
                 OR APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1) IS NULL)
              AND
              (APP_COMMON_PKG.GET_FIELD_VALUE(506,EXT.DES_DATO1) LIKE '%' || paramSegmento || '%'
                 OR APP_COMMON_PKG.GET_FIELD_VALUE(506,EXT.DES_DATO1) IS NULL)
              AND
              (APP_COMMON_PKG.GET_FIELD_VALUE(507,EXT.DES_DATO1) LIKE '%' || paramClasificacion || '%'
                 OR APP_COMMON_PKG.GET_FIELD_VALUE(507,EXT.DES_DATO1) IS NULL)
              AND
              (APP_COMMON_PKG.GET_FIELD_VALUE(509,EXT.DES_DATO1) LIKE '%' || paramPais || '%'
                 OR APP_COMMON_PKG.GET_FIELD_VALUE(509,EXT.DES_DATO1) IS NULL)
              AND
              (APP_COMMON_PKG.GET_FIELD_VALUE(502,EXT.DES_DATO1) LIKE '%' || paranNumOracle || '%'
                 OR APP_COMMON_PKG.GET_FIELD_VALUE(502,EXT.DES_DATO1) IS NULL)
              AND
              (APP_COMMON_PKG.GET_FIELD_VALUE(504,EXT.DES_DATO1) LIKE '%' || paramGiro || '%'
                 OR APP_COMMON_PKG.GET_FIELD_VALUE(504,EXT.DES_DATO1) IS NULL)
              --AND
              --( EXT.DES_DATO5 LIKE '%' || paramPorcentaje || '%'
                 --OR EXT.DES_DATO6 LIKE '%' || paramPorcentaje || '%')
               AND
                      (
                          (
                            APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1) ||
                            APP_COMMON_PKG.GET_FIELD_VALUE(506,EXT.DES_DATO1) ||
                            APP_COMMON_PKG.GET_FIELD_VALUE(507,EXT.DES_DATO1) ||
                            APP_COMMON_PKG.GET_FIELD_VALUE(509,EXT.DES_DATO1) ||
                            APP_COMMON_PKG.GET_FIELD_VALUE(502,EXT.DES_DATO1) ||
                            APP_COMMON_PKG.GET_FIELD_VALUE(504,EXT.DES_DATO1)
                           )
                                  LIKE
                                        '%' ||
                                        paramConsolida ||
                                        paramSegmento ||
                                        paramClasificacion ||
                                        paramPais ||
                                        paranNumOracle ||
                                        paramGiro ||
                                        '%'
                        )
              AND
                (
                    (
                      paramPorcentajeCual = 'Directo'
                      AND
                      (
                          (paramPorcentajeOpt = '1' AND TO_NUMBER(EXT.DES_DATO5) = TO_NUMBER(paramPorcentaje))
                          OR
                          (paramPorcentajeOpt = '2' AND TO_NUMBER(EXT.DES_DATO5) > TO_NUMBER(paramPorcentaje))
                          OR
                          (paramPorcentajeOpt = '3' AND TO_NUMBER(EXT.DES_DATO5) < TO_NUMBER(paramPorcentaje))
                      )
                    )
                    OR
                    (
                      paramPorcentajeCual = 'Indirecto'
                      AND
                      (
                          (paramPorcentajeOpt = '1' AND TO_NUMBER(EXT.DES_DATO6) = TO_NUMBER(paramPorcentaje))
                          OR
                          (paramPorcentajeOpt = '2' AND TO_NUMBER(EXT.DES_DATO6) > TO_NUMBER(paramPorcentaje))
                          OR
                          (paramPorcentajeOpt = '3' AND TO_NUMBER(EXT.DES_DATO6) < TO_NUMBER(paramPorcentaje))
                      )
                    )
                )
         /*   */
          START WITH EXT.DES_DATO4 = paramEmpresa
          CONNECT BY PRIOR EXT.DES_DATO1 = EXT.DES_DATO4
              )
      LOOP
          --IF v_lastlevel < XX_ROW.LEVEL THEN
            --  DBMS_OUTPUT.PUT_LINE('"data":[');
          --END IF;
          -- Cerrar el nivel Anterior
          IF v_lastlevel > XX_ROW.TEN_CASC_LEVEL THEN
              v_stringbuilder := substr(v_stringbuilder, 1, length(v_stringbuilder)-2);
              v_stringbuilder := v_stringbuilder || chr(10);
              v_stringbuilder := v_stringbuilder || XX_ROW.PAD || ']},';
              v_stringbuilder := v_stringbuilder || chr(10);
              --DBMS_OUTPUT.PUT_LINE(XX_ROW.PAD || ']},');
          END IF;
          IF v_lastlevel > (XX_ROW.TEN_CASC_LEVEL + 1) THEN
              v_stringbuilder := v_stringbuilder || XX_ROW.PAD || ']},';
              v_stringbuilder := v_stringbuilder || chr(10);
              --DBMS_OUTPUT.PUT_LINE(XX_ROW.PAD || ']},');
          END IF;
          /*
          IF XX_ROW.LEVEL = 1 THEN
              v_stringbuilder := v_stringbuilder || XX_ROW.PAD || '},';
              v_stringbuilder := v_stringbuilder || chr(10);
              --DBMS_OUTPUT.PUT_LINE(XX_ROW.PAD || ']},');
          END IF;
      */
        --DBMS_OUTPUT.PUT_LINE(
        v_stringbuilder := v_stringbuilder ||
                                XX_ROW.PAD || '{ "nombre":"' || XX_ROW.NOM_EMPRESA ||
                                (CASE
                                  WHEN UPPER(paramPorcentajeVisualizar) IN('DIRECTO','AMBOS')
                                  THEN
                                    '", "directo":"' || XX_ROW.DIRECTO
                                  ELSE
                                    '' END
                                  ) ||
                                --'", "directo":"' || XX_ROW.DIRECTO ||
                                (CASE
                                  WHEN UPPER(paramPorcentajeVisualizar) IN('INDIRECTO','AMBOS')
                                  THEN
                                    '", "indirecto":"' || XX_ROW.INDIRECTO
                                  ELSE
                                    '' END
                                  ) ||
                                --'", "indirecto":"' || XX_ROW.INDIRECTO ||
                                '", "consolida":"' || XX_ROW.CONSOLIDA ||
                                '", "segmento":"' || XX_ROW.SEGMENTO ||
                                '", "clasificacion":"' || XX_ROW.CLASIFICACION ||
                                '", "pais":"' || XX_ROW.PAIS ||
                                '", "no_emp_oracle":"' || XX_ROW.NO_EMP_ORACLE ||
                                '", "giro":"' || XX_ROW.GIRO || '"';
        v_stringbuilder := v_stringbuilder || chr(10);
        IF XX_ROW.CANT_HIJOS > 0 THEN
          --DBMS_OUTPUT.PUT_LINE(XX_ROW.PAD || ', "data":[');
          v_stringbuilder := v_stringbuilder || XX_ROW.PAD || ', "data":[';
          v_stringbuilder := v_stringbuilder || chr(10);
        ELSE
          v_stringbuilder := v_stringbuilder || XX_ROW.PAD || '},';
          v_stringbuilder := v_stringbuilder || chr(10);
        END IF;
        v_lastlevel := XX_ROW.TEN_CASC_LEVEL;
      END LOOP;
      v_stringbuilder := substr(v_stringbuilder, 1, length(v_stringbuilder)-2);
      v_stringbuilder := v_stringbuilder || chr(10);
      --DBMS_OUTPUT.PUT_LINE('A');
      --DBMS_OUTPUT.PUT_LINE(v_stringbuilder);
      --DBMS_OUTPUT.PUT_LINE('B');
      --retStrData := v_stringbuilder;
        dump_clob(v_stringbuilder,0);
        COMMIT;
        OPEN resultSet FOR
            SELECT
              TEXT
            FROM
              APP_TEMP_LOG
            ORDER BY
              LOG_ID;
  END GET_TREE_DATA;
  --
  -- Nuevo TreeTable jquery
  --
  PROCEDURE GET_TREE_DATA1(resultSet OUT SYS_REFCURSOR, paramEmpresa VARCHAR2, paramFecha VARCHAR2,
                                                                              paramConsolida VARCHAR2,
                                                                              paramSegmento VARCHAR2,
                                                                              paramClasificacion VARCHAR2,
                                                                              paramPais VARCHAR2,
                                                                              paranNumOracle VARCHAR2,
                                                                              paramGiro VARCHAR2,
                                                                              paramPorcentaje VARCHAR2,
                                                                              paramPorcentajeOpt VARCHAR2,
                                                                              paramPorcentajeCual VARCHAR2,
                                                                              paramPorcentajeVisualizar VARCHAR2,
                                                                              paramDivision VARCHAR2
                                                                              ) AS
      postArrTenCasc SYS_REFCURSOR;
      pistOutType       VARCHAR2(20):='DBMS';
      pistCout          NUMBER;
      pistCout2         NUMBER;
      pistCountIdParent NUMBER;
      rowNumberUpdate   NUMBER := 1;
      v_cadena          VARCHAR2(5000);
      TYPE tipo_cursor IS REF CURSOR;
      rr tipo_cursor;
      CURSOR QUERY_ID_PARENT_CUR
        IS
          SELECT distinct id_parent FROM PENDIUM_TEN_CASC_PASO_TMP WHERE id_parent <> 1 order by id_parent;
      CURSOR TEN_CASC_CUR
        IS
           SELECT
                ROWNUM AS SUPER_QUERY_ROWNUM,
                EXT.ID_ROW,
                (CASE NVL(EXT.DES_DATO4,'null')
                    WHEN 'null' THEN 'null'
                    ELSE
                      (SELECT
                          '' || MAX(INTER.ID_ROW)
                        FROM
                          DERCORP_REPORTE_TENCASC_ID_TMP INTER
                          --DERCORP_REPORTE_TC_ID_TMP INTER
                        WHERE
                          INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null')
                        AND
                          INTER.ID_ROW < EXT.ID_ROW
                      )
                    END
                  ) ID_PARENT,
                 EXT.DES_DATO1,
                 EXT.DES_DATO2,
                -- LPAD(EXT.DES_DATO3,LENGTH(EXT.DES_DATO3) + LEVEL * 5 - 5,' ') AS NOM_EMPRESA,
                 --LPAD(' ',5 + LEVEL * 5 - 5,' ') AS PAD,
                 EXT.DES_DATO3,
                 EXT.DES_DATO4,
                 EXT.DES_DATO5 DIRECTO,
                 EXT.DES_DATO6 INDIRECTO,
                 EXT.DES_DATO7,
                 --LEVEL TEN_CASC_LEVEL,
                 (SELECT
                      count(*)
                  FROM
                      DERCORP_REPORTE_TENCASC_ID_TMP
                  WHERE
                    DES_DATO4 = EXT.DES_DATO1) CANT_HIJOS,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(516,EXT.DES_DATO1) AS CONSOLIDA,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(506,EXT.DES_DATO1) AS SEGMENTO,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(507,EXT.DES_DATO1) AS CLASIFICACION,
                 APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(509,EXT.DES_DATO1) AS PAIS,
                APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(502,EXT.DES_DATO1) AS NO_EMP_ORACLE,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(504,EXT.DES_DATO1) AS GIRO,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(505,EXT.DES_DATO1) AS DIVISION,--division JAMS 26/07/2017
                  '' AS CONSOLIDA_ALL,
                  '' AS SEGMENTO_ALL,
                  '' AS CLASIFICACION_ALL,
                  '' AS PAIS_ALL,
                  '' AS NO_EMP_ORACLE_ALL,
                  '' AS GIRO_ALL,
                  '' AS DIVISION_ALL
          FROM
            DERCORP_REPORTE_TENCASC_ID_TMP EXT
          WHERE
                APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(507,EXT.DES_DATO1)  <> 'Fusionada'
				AND (APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1)  = NVL(paramConsolida, APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1)) OR APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1) IS NULL)
				AND (APP_COMMON_PKG.GET_FIELD_VALUE(506,EXT.DES_DATO1)  = NVL(paramSegmento, APP_COMMON_PKG.GET_FIELD_VALUE(506,EXT.DES_DATO1)) OR APP_COMMON_PKG.GET_FIELD_VALUE(506,EXT.DES_DATO1) IS NULL)
				AND (APP_COMMON_PKG.GET_FIELD_VALUE(507,EXT.DES_DATO1)  = NVL(paramClasificacion, APP_COMMON_PKG.GET_FIELD_VALUE(507,EXT.DES_DATO1)) OR APP_COMMON_PKG.GET_FIELD_VALUE(507,EXT.DES_DATO1) IS NULL )
				AND (APP_COMMON_PKG.GET_FIELD_VALUE(509,EXT.DES_DATO1)  = NVL(paramPais, APP_COMMON_PKG.GET_FIELD_VALUE(509,EXT.DES_DATO1)) OR APP_COMMON_PKG.GET_FIELD_VALUE(509,EXT.DES_DATO1) IS NULL)
				AND (APP_COMMON_PKG.GET_FIELD_VALUE(502,EXT.DES_DATO1)  = NVL(paranNumOracle, APP_COMMON_PKG.GET_FIELD_VALUE(502,EXT.DES_DATO1)) OR APP_COMMON_PKG.GET_FIELD_VALUE(502,EXT.DES_DATO1) IS NULL)
				AND (APP_COMMON_PKG.GET_FIELD_VALUE(504,EXT.DES_DATO1)  = NVL(paramGiro, APP_COMMON_PKG.GET_FIELD_VALUE(504,EXT.DES_DATO1)) OR APP_COMMON_PKG.GET_FIELD_VALUE(504,EXT.DES_DATO1) IS NULL)
                AND (APP_COMMON_PKG.GET_FIELD_VALUE(505,EXT.DES_DATO1)  = NVL(paramDivision, APP_COMMON_PKG.GET_FIELD_VALUE(505,EXT.DES_DATO1)) OR APP_COMMON_PKG.GET_FIELD_VALUE(505,EXT.DES_DATO1) IS NULL)--division JAMS 26/07/2017
              AND
                (
                    (
                      paramPorcentajeCual = 'Directo'
                      AND
                      (
                          (paramPorcentajeOpt = '1' AND TO_NUMBER(EXT.DES_DATO5) = TO_NUMBER(paramPorcentaje))
                          OR
                          (paramPorcentajeOpt = '2' AND TO_NUMBER(EXT.DES_DATO5) > TO_NUMBER(paramPorcentaje))
                          OR
                          (paramPorcentajeOpt = '3' AND TO_NUMBER(EXT.DES_DATO5) < TO_NUMBER(paramPorcentaje))
                      )
                    )
                    OR
                    (
                      paramPorcentajeCual = 'Indirecto'
                      AND
                      (
                          (paramPorcentajeOpt = '1' AND TO_NUMBER(EXT.DES_DATO6) = TO_NUMBER(paramPorcentaje))
                          OR
                          (paramPorcentajeOpt = '2' AND TO_NUMBER(EXT.DES_DATO6) > TO_NUMBER(paramPorcentaje))
                          OR
                          (paramPorcentajeOpt = '3' AND TO_NUMBER(EXT.DES_DATO6) < TO_NUMBER(paramPorcentaje))
                      )
                    )
                )
            ;
  BEGIN
       v_cadena:= '
            SELECT
                ROWNUM AS SUPER_QUERY_ROWNUM,
                EXT.ID_ROW,
                (CASE NVL(EXT.DES_DATO4,''null'')
                    WHEN ''null'' THEN ''null''
                    ELSE
                      (SELECT
                          '' || MAX(INTER.ID_ROW)
                        FROM
                          DERCORP_REPORTE_TENCASC_ID_TMP INTER
                          --DERCORP_REPORTE_TC_ID_TMP INTER
                        WHERE
                          INTER.DES_DATO1 = NVL(EXT.DES_DATO4,''null'')
                        AND
                          INTER.ID_ROW < EXT.ID_ROW
                      )
                    END
                  ) ID_PARENT,
                 EXT.DES_DATO1,
                 EXT.DES_DATO2,
                 EXT.DES_DATO3,
                 EXT.DES_DATO4,
                 EXT.DES_DATO5 DIRECTO,
                 EXT.DES_DATO6 INDIRECTO,
                 EXT.DES_DATO7,
                 (SELECT
                      count(*)
                  FROM
                      DERCORP_REPORTE_TENCASC_ID_TMP
                  WHERE
                    DES_DATO4 = EXT.DES_DATO1) CANT_HIJOS,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(516,EXT.DES_DATO1) AS CONSOLIDA,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(506,EXT.DES_DATO1) AS SEGMENTO,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(507,EXT.DES_DATO1) AS CLASIFICACION,
                 APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(509,EXT.DES_DATO1) AS PAIS,
                APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(502,EXT.DES_DATO1) AS NO_EMP_ORACLE,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(504,EXT.DES_DATO1) AS GIRO,
                  APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(505,EXT.DES_DATO1) AS DIVISION,--division JAMS 26/07/2017
                  '' AS CONSOLIDA_ALL,
                  '' AS SEGMENTO_ALL,
                  '' AS CLASIFICACION_ALL,
                  '' AS PAIS_ALL,
                  '' AS NO_EMP_ORACLE_ALL,
                  '' AS GIRO_ALL,
                  '' AS DIVISION_ALL
          FROM
            DERCORP_REPORTE_TENCASC_ID_TMP EXT
          WHERE
                APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(507,EXT.DES_DATO1)  <> ''Fusionada''
        ';
        IF paramConsolida != NULL
        THEN
            v_cadena:= v_cadena || ' AND APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1)  = paramConsolida';
        END IF;
		IF paramSegmento != NULL
        THEN
            v_cadena:= v_cadena || ' AND APP_COMMON_PKG.GET_FIELD_VALUE(506,EXT.DES_DATO1)  = paramSegmento';
        END IF;
        IF paramClasificacion != NULL
        THEN
            v_cadena:= v_cadena || ' AND APP_COMMON_PKG.GET_FIELD_VALUE(507,EXT.DES_DATO1)  = paramClasificacion';
        END IF;
		IF paramPais != NULL
        THEN
            v_cadena:= v_cadena || ' AND APP_COMMON_PKG.GET_FIELD_VALUE(509,EXT.DES_DATO1)  = paramPais';
        END IF;
		IF paranNumOracle != NULL
        THEN
            v_cadena:= v_cadena || ' AND APP_COMMON_PKG.GET_FIELD_VALUE(502,EXT.DES_DATO1)  = paranNumOracle';
        END IF;
		IF paramGiro != NULL
        THEN
            v_cadena:= v_cadena || ' AND APP_COMMON_PKG.GET_FIELD_VALUE(504,EXT.DES_DATO1)  = paramGiro';
        END IF;
		IF paramDivision != NULL
        THEN
            v_cadena:= v_cadena || ' AND APP_COMMON_PKG.GET_FIELD_VALUE(505,EXT.DES_DATO1)  = paramDivision';
        END IF;
		v_cadena:= v_cadena ||
             '
              AND
                (
                    (
                      paramPorcentajeCual = ''Directo''
                      AND
                      (
                          (paramPorcentajeOpt = ''1'' AND TO_NUMBER(EXT.DES_DATO5) = TO_NUMBER(paramPorcentaje))
                          OR
                          (paramPorcentajeOpt = ''2'' AND TO_NUMBER(EXT.DES_DATO5) > TO_NUMBER(paramPorcentaje))
                          OR
                          (paramPorcentajeOpt = ''3'' AND TO_NUMBER(EXT.DES_DATO5) < TO_NUMBER(paramPorcentaje))
                      )
                    )
                    OR
                    (
                      paramPorcentajeCual = ''Indirecto''
                      AND
                      (
                          (paramPorcentajeOpt = ''1'' AND TO_NUMBER(EXT.DES_DATO6) = TO_NUMBER(paramPorcentaje))
                          OR
                          (paramPorcentajeOpt = ''2'' AND TO_NUMBER(EXT.DES_DATO6) > TO_NUMBER(paramPorcentaje))
                          OR
                          (paramPorcentajeOpt = ''3'' AND TO_NUMBER(EXT.DES_DATO6) < TO_NUMBER(paramPorcentaje))
                      )
                    )
                )
                ';
    DELETE FROM DERCORP_REPORTE_TENCASC_TMP;
    DERCORP_REPORT_TENCASC_PKG.DO_REPORT_PR(postArrTenCasc, pistOutType, paramEmpresa);
    DELETE FROM DERCORP_REPORTE_TENCASC_ID_TMP;
    DELETE FROM DERCORP_REPORTE_TENCASC_G_TMP;
    INSERT INTO
      DERCORP_REPORTE_TENCASC_G_TMP
    SELECT
      EXT.DES_DATO1,
      EXT.DES_DATO2,
      EXT.DES_DATO3,
      EXT.DES_DATO4,
      SUM(EXT.DES_DATO5),
      SUM(EXT.DES_DATO6),
      EXT.DES_DATO7,
      EXT.DES_DATO8,
      EXT.DES_DATO9,
      EXT.DES_DATO10
    FROM
      DERCORP_REPORTE_TENCASC_TMP EXT
    GROUP BY
      EXT.DES_DATO1,
      EXT.DES_DATO2,
      EXT.DES_DATO3,
      EXT.DES_DATO4,
      EXT.DES_DATO7,
      EXT.DES_DATO8,
      EXT.DES_DATO9,
      EXT.DES_DATO10;
    INSERT INTO
        DERCORP_REPORTE_TENCASC_ID_TMP
    SELECT
      1,
      EXT.DES_DATO1,
      EXT.DES_DATO2,
      EXT.DES_DATO3,
      EXT.DES_DATO4,
      EXT.DES_DATO5,
      EXT.DES_DATO6,
      EXT.DES_DATO7,
      EXT.DES_DATO8,
      EXT.DES_DATO9,
      EXT.DES_DATO10
    FROM
      --DERCORP_REPORTE_TENCASC_TMP EXT
      DERCORP_REPORTE_TENCASC_G_TMP EXT
    WHERE
      EXT.DES_DATO4 IS NULL
    UNION
    SELECT
      --DISTINCT
      rownum + 1,
      EXT.DES_DATO1,
      EXT.DES_DATO2,
      EXT.DES_DATO3,
      EXT.DES_DATO4,
      EXT.DES_DATO5,
      EXT.DES_DATO6,
      EXT.DES_DATO7,
      EXT.DES_DATO8,
      EXT.DES_DATO9,
      EXT.DES_DATO10
    FROM
      --DERCORP_REPORTE_TENCASC_TMP EXT
      DERCORP_REPORTE_TENCASC_G_TMP EXT
    START WITH EXT.DES_DATO4 = paramEmpresa
    CONNECT BY PRIOR EXT.DES_DATO1 = EXT.DES_DATO4;
    /*
    SELECT
      --DISTINCT
      rownum + 1,
      EXT.DES_DATO1,
      EXT.DES_DATO2,
      EXT.DES_DATO3,
      EXT.DES_DATO4,
      EXT.DES_DATO5,
      EXT.DES_DATO6,
      EXT.DES_DATO7,
      EXT.DES_DATO8,
      EXT.DES_DATO9,
      EXT.DES_DATO10
    FROM
      --DERCORP_REPORTE_TENCASC_TMP EXT
      (SELECT DISTINCT * FROM DERCORP_REPORTE_TENCASC_G_TMP) EXT
    START WITH EXT.DES_DATO4 = paramEmpresa
    CONNECT BY PRIOR EXT.DES_DATO1 = EXT.DES_DATO4;
    */
    --DELETE FROM DERCORP_REPORTE_TC_ID_TMP;
    /*
    INSERT INTO
    DERCORP_REPORTE_TC_ID_TMP
    SELECT
    ID_ROW,
        (CASE NVL(EXT.DES_DATO4,'null')
                          WHEN 'null' THEN 'null'
                          ELSE
                            --'ok'
                            (SELECT
                                '' || MAX(INTER.ID_ROW)
                              FROM
                                DERCORP_REPORTE_TENCASC_ID_TMP INTER
                              WHERE
                                INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null')
                              AND
                                INTER.ID_ROW < EXT.ID_ROW
                            )
                            --(SELECT INTER.ID_ROW || '' FROM DERCORP_REPORTE_TENCASC_ID_TMP INTER WHERE INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null'))
                          END
                        ) ID_PARENT,
      DES_DATO1,
      DES_DATO2,
      DES_DATO3,
      DES_DATO4,
      DES_DATO5,
      DES_DATO6,
      DES_DATO7,
      DES_DATO8,
      DES_DATO9,
      DES_DATO10
    FROM
      DERCORP_REPORTE_TENCASC_ID_TMP EXT;
      */
    COMMIT;
    DELETE FROM USRDRC.PENDIUM_TEN_CASC_PASO_TMP;
    FOR i IN TEN_CASC_CUR
    --OPEN rr for v_cadena;
    LOOP
       /* SELECT COUNT(*) INTO pistCout
        FROM PENDIUM_TEN_CASC_PASO_TMP te
        --WHERE id_row = i.id_row and id_parent = i.id_parent;
        WHERE te.des_dato1=i.des_dato1 and te.ten_casc_level=i.ten_casc_level;
        SELECT COUNT(*) INTO pistCout2
        FROM PENDIUM_TEN_CASC_PASO_TMP te
        WHERE des_dato1 = i.des_dato1 and id_parent = i.id_parent;
        */
       -- IF pistCout = 0 and pistCout2=0
       -- THEN
      -- exit when rr%notfound;
          INSERT
                INTO USRDRC.PENDIUM_TEN_CASC_PASO_TMP
                 (
                  SUPER_QUERY_ROWNUM,
                  ID_ROW,
                  ID_PARENT,
                  DES_DATO1,
                  --NOM_EMPRESA,
                  DES_DATO3,
                  DES_DATO2,
                  --PAD,
                  DES_DATO4,
                  DIRECTO,
                  INDIRECTO,
                  DES_DATO7,
                  --TEN_CASC_LEVEL,
                  CANT_HIJOS,
                  CONSOLIDA,
                  SEGMENTO,
                  CLASIFICACION,
                  PAIS,
                  NO_EMP_ORACLE,
                  GIRO,
                  DIVISION,
                  CONSOLIDA_ALL,
                  SEGMENTO_ALL,
                  CLASIFICACION_ALL,
                  PAIS_ALL,
                  NO_EMP_ORACLE_ALL,
                  GIRO_ALL,
                  DIVISION_ALL
                 )VALUES(
                          i.SUPER_QUERY_ROWNUM,
                          i.ID_ROW,
                          i.ID_PARENT,
                          i.DES_DATO1,
                          --i.NOM_EMPRESA,
                          i.DES_DATO3,
                          i.DES_DATO2,
                          --i.PAD,
                          i.DES_DATO4,
                          i.DIRECTO,
                          i.INDIRECTO,
                          i.DES_DATO7,
                          --i.TEN_CASC_LEVEL,
                          i.CANT_HIJOS,
                          i.CONSOLIDA,
                          i.SEGMENTO,
                          i.CLASIFICACION,
                          i.PAIS,
                          i.NO_EMP_ORACLE,
                          i.GIRO,
                          i.DIVISION,
                          i.CONSOLIDA_ALL,
                          i.SEGMENTO_ALL,
                          i.CLASIFICACION_ALL,
                          i.PAIS_ALL,
                          i.NO_EMP_ORACLE_ALL,
                          i.GIRO_ALL,
                          i.DIVISION_ALL
                 );
        --END IF;
    END LOOP;
   -- close rr;
    --JJAQ 29/03/2017 CURSOR PARA ELIMINAR PADRE E HIJOS SI NO CUPLE CON EL PORCENTAJE
    /*JAMS 27/07/2017 se comenta porque al parecer ya no es necesario
    FOR i IN QUERY_ID_PARENT_CUR
    LOOP
        SELECT count(*) INTO pistCountIdParent
        FROM PENDIUM_TEN_CASC_PASO_TMP
        WHERE id_row = i.id_parent;
        IF pistCountIdParent = 0
        THEN
            DELETE FROM PENDIUM_TEN_CASC_PASO_TMP WHERE id_parent = i.id_parent;
            COMMIT;
        END IF;
    END LOOP;
    */
    OPEN resultSet FOR
           --SELECT * FROM PENDIUM_TEN_CASC_PASO_TAB WHERE ID_PARENT IN (SELECT ID_ROW FROM PENDIUM_TEN_CASC_PASO_TAB) OR TEN_CASC_LEVEL =1 ORDER BY ID_ROW;
          -- SELECT * FROM PENDIUM_TEN_CASC_PASO_TMP ORDER BY id_row;
            --SELECT * FROM PENDIUM_TEN_CASC_PASO_TMP ORDER BY SUPER_QUERY_ROWNUM;
            SELECT super_query_rownum,
                    id_row,
                    id_parent,
                    des_dato1,
                    des_dato2,
                    --nom_empresa,
                    LPAD(EXT.des_dato3,LENGTH(EXT.des_dato3) + LEVEL * 5 - 5,' ') AS NOM_EMPRESA,
                    --pad,
                    LPAD(' ',5 + LEVEL * 5 - 5,' ') AS PAD,
                    des_dato4,
                    directo,
                    indirecto,
                    des_dato7,
                    --ten_casc_level,
                    LEVEL TEN_CASC_LEVEL,
                    cant_hijos,
                    consolida,
                    segmento,
                    clasificacion,
                    pais,
                    no_emp_oracle,
                    giro,
                    consolida_all,
                    segmento_all,
                    clasificacion_all,
                    pais_all,
                    no_emp_oracle_all,
                    giro_all,
                    division_all,
                    division
        FROM PENDIUM_TEN_CASC_PASO_TMP ext
        START WITH EXT.DES_DATO4 = paramEmpresa
        CONNECT BY PRIOR EXT.id_row = EXT.id_parent
        ORDER SIBLINGS BY EXT.des_dato3;
          --  SELECT * FROM PENDIUM_TEN_CASC_PASO_TMP;
  END GET_TREE_DATA1;
  PROCEDURE GET_TREE_DATA2(resultSet OUT SYS_REFCURSOR, paramEmpresa VARCHAR2, paramFecha VARCHAR2,
                                                                              paramConsolida VARCHAR2,
                                                                              paramSegmento VARCHAR2,
                                                                              paramClasificacion VARCHAR2,
                                                                              paramPais VARCHAR2,
                                                                              paranNumOracle VARCHAR2,
                                                                              paramGiro VARCHAR2,
                                                                              paramPorcentaje VARCHAR2,
                                                                              paramPorcentajeOpt VARCHAR2,
                                                                              paramPorcentajeCual VARCHAR2) AS
      v_stringbuilder CLOB;
      v_lastlevel NUMBER;
      postArrTenCasc SYS_REFCURSOR;
      pistOutType    VARCHAR2(20):='DBMS';
      listEmpresaName    VARCHAR2(200);
  BEGIN
    DELETE FROM APP_TEMP_LOG;
    DELETE FROM DERCORP_REPORTE_TENCASC_TMP;
    DERCORP_REPORT_TENCASC_PKG.DO_REPORT_PR(postArrTenCasc, pistOutType, paramEmpresa);
    v_lastlevel := 0;
    v_stringbuilder := '';
    BEGIN
        SELECT
          DES_DATO2 INTO listEmpresaName
        FROM
          DERCORP_REPORTE_TENCASC_TMP
        WHERE
          DES_DATO1 = paramEmpresa;
    EXCEPTION
      WHEN OTHERS THEN
          NULL;
    END;
    v_stringbuilder := v_stringbuilder || '{' || chr(10);
    v_stringbuilder := v_stringbuilder || '   "name": "' || listEmpresaName || '",' || chr(10);
    v_stringbuilder := v_stringbuilder || '   "children": [' || chr(10);
    FOR XX_ROW IN (
      SELECT EXT.DES_DATO1,
             EXT.DES_DATO2,
             LPAD(EXT.DES_DATO3,LENGTH(EXT.DES_DATO3) + LEVEL * 5 - 5,' ') AS NOM_EMPRESA,
             LPAD(' ',5 + LEVEL * 5 - 5,' ') AS PAD,
             EXT.DES_DATO3,
             EXT.DES_DATO4,
             EXT.DES_DATO5 DIRECTO,
             EXT.DES_DATO6 INDIRECTO,
             EXT.DES_DATO7,
             LEVEL,
             (SELECT
                  count(*)
              FROM
                  DERCORP_REPORTE_TENCASC_TMP
              WHERE
                DES_DATO4 = EXT.DES_DATO1) CANT_HIJOS
      FROM
        DERCORP_REPORTE_TENCASC_TMP EXT
      --WHERE
        --    EXT.DES_DATO2 LIKE '%XEZZ%'
        /*
      WHERE
            (APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1) LIKE '%' || paramConsolida || '%'
               OR APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1) IS NULL)
            AND
            (APP_COMMON_PKG.GET_FIELD_VALUE(506,EXT.DES_DATO1) LIKE '%' || paramSegmento || '%'
               OR APP_COMMON_PKG.GET_FIELD_VALUE(506,EXT.DES_DATO1) IS NULL)
            AND
            (APP_COMMON_PKG.GET_FIELD_VALUE(507,EXT.DES_DATO1) LIKE '%' || paramClasificacion || '%'
               OR APP_COMMON_PKG.GET_FIELD_VALUE(507,EXT.DES_DATO1) IS NULL)
            AND
            (APP_COMMON_PKG.GET_FIELD_VALUE(509,EXT.DES_DATO1) LIKE '%' || paramPais || '%'
               OR APP_COMMON_PKG.GET_FIELD_VALUE(509,EXT.DES_DATO1) IS NULL)
            AND
            (APP_COMMON_PKG.GET_FIELD_VALUE(502,EXT.DES_DATO1) LIKE '%' || paranNumOracle || '%'
               OR APP_COMMON_PKG.GET_FIELD_VALUE(502,EXT.DES_DATO1) IS NULL)
            AND
            (APP_COMMON_PKG.GET_FIELD_VALUE(504,EXT.DES_DATO1) LIKE '%' || paramGiro || '%'
               OR APP_COMMON_PKG.GET_FIELD_VALUE(504,EXT.DES_DATO1) IS NULL)
               */
      START WITH EXT.DES_DATO4 = paramEmpresa
      CONNECT BY PRIOR EXT.DES_DATO1 = EXT.DES_DATO4
              )
      LOOP
          --IF v_lastlevel < XX_ROW.LEVEL THEN
          --    DBMS_OUTPUT.PUT_LINE('"data":[');
          --END IF;
          -- Cerrar el nivel Anterior
          IF v_lastlevel = (XX_ROW.LEVEL + 1) THEN
              v_stringbuilder := substr(v_stringbuilder, 1, length(v_stringbuilder)-2);
              v_stringbuilder := v_stringbuilder || chr(10);
              --v_stringbuilder := v_stringbuilder || XX_ROW.PAD || ']},';
              v_stringbuilder := v_stringbuilder || XX_ROW.PAD ||'     ]     ' || chr(10);--AAA,,
              --v_stringbuilder := v_stringbuilder || XX_ROW.PAD || '},  ' || chr(10);
              v_stringbuilder := v_stringbuilder || XX_ROW.PAD || '},    ' || chr(10);  --CCC ---BBB,,
              v_stringbuilder := v_stringbuilder || chr(10);
              --DBMS_OUTPUT.PUT_LINE(XX_ROW.PAD || ']},');
          END IF;
          IF v_lastlevel = (XX_ROW.LEVEL + 2) THEN
              v_stringbuilder := substr(v_stringbuilder, 1, length(v_stringbuilder)-2);
              v_stringbuilder := v_stringbuilder || chr(10);
              v_stringbuilder := v_stringbuilder || XX_ROW.PAD ||'     ]}]     ' || chr(10); --ACAC,,
              v_stringbuilder := v_stringbuilder || XX_ROW.PAD || '}, '; --AAA --CCC,,
              v_stringbuilder := v_stringbuilder || chr(10);
              --DBMS_OUTPUT.PUT_LINE(XX_ROW.PAD || ']},');
          END IF;
          IF v_lastlevel = (XX_ROW.LEVEL + 3) THEN
              v_stringbuilder := substr(v_stringbuilder, 1, length(v_stringbuilder)-2);
              v_stringbuilder := v_stringbuilder || chr(10);
              v_stringbuilder := v_stringbuilder || XX_ROW.PAD ||'     ]}     ' || chr(10); --ACAC,,
              v_stringbuilder := v_stringbuilder || XX_ROW.PAD || '}, '; --AAA --CCC,,
              v_stringbuilder := v_stringbuilder || chr(10);
              --DBMS_OUTPUT.PUT_LINE(XX_ROW.PAD || ']},');
          END IF;
          /*
          IF v_lastlevel > (XX_ROW.LEVEL + 2) THEN
              --v_stringbuilder := substr(v_stringbuilder, 1, length(v_stringbuilder)-2);
              --v_stringbuilder := v_stringbuilder || chr(10);
              v_stringbuilder := v_stringbuilder || XX_ROW.PAD || '}, ';--BBB
              v_stringbuilder := v_stringbuilder || chr(10);
              --DBMS_OUTPUT.PUT_LINE(XX_ROW.PAD || ']},');
          END IF;
          */
          --IF XX_ROW.LEVEL = 1 THEN
          --    v_stringbuilder := v_stringbuilder || XX_ROW.PAD || '},';
          --    v_stringbuilder := v_stringbuilder || chr(10);
          --    --DBMS_OUTPUT.PUT_LINE(XX_ROW.PAD || ']},');
          --END IF;
        --DBMS_OUTPUT.PUT_LINE(
        v_stringbuilder := v_stringbuilder ||
                                XX_ROW.PAD || '{ "name":"' || XX_ROW.NOM_EMPRESA ||
                                ' (' || XX_ROW.INDIRECTO || '%)"';
                                --' (' || XX_ROW.DIRECTO || '% ... ' || XX_ROW.INDIRECTO || '%)"';
        v_stringbuilder := v_stringbuilder || chr(10);-- || '<br>';
        IF XX_ROW.CANT_HIJOS > 0 THEN
          --DBMS_OUTPUT.PUT_LINE(XX_ROW.PAD || ', "data":[');
          v_stringbuilder := v_stringbuilder || XX_ROW.PAD  || '   , "children": [' || chr(10);
          v_stringbuilder := v_stringbuilder || chr(10);
        ELSE
          v_stringbuilder := v_stringbuilder || XX_ROW.PAD || '},';
          v_stringbuilder := v_stringbuilder || chr(10);
        END IF;
        v_lastlevel := XX_ROW.LEVEL;
      END LOOP;
      v_stringbuilder := substr(v_stringbuilder, 1, length(v_stringbuilder)-2);
      v_stringbuilder := v_stringbuilder || '     ]' || chr(10);
      v_stringbuilder := v_stringbuilder || '}' || chr(10);
      --v_stringbuilder := v_stringbuilder || chr(10);
      --DBMS_OUTPUT.PUT_LINE('A');
      --DBMS_OUTPUT.PUT_LINE(v_stringbuilder);
      --DBMS_OUTPUT.PUT_LINE('B');
      --retStrData := v_stringbuilder;
        dump_clob(v_stringbuilder,2);
        COMMIT;
        OPEN resultSet FOR
            SELECT
              APP_COMMON_PKG.GET_TXT_HTML_FN(TEXT) AS TEXT
            FROM
              APP_TEMP_LOG
            WHERE
              TEXT IS NOT NULL
              AND
              TEXT <> 'null'
            ORDER BY
              LOG_ID;
  END GET_TREE_DATA2;
  --
  -- ORGANIGRAMA
  --
  PROCEDURE GET_TREE_DATA3(resultSet OUT SYS_REFCURSOR, paramEmpresa VARCHAR2, paramFecha VARCHAR2,
                                                                              paramConsolida VARCHAR2,
                                                                              paramSegmento VARCHAR2,
                                                                              paramClasificacion VARCHAR2,
                                                                              paramPais VARCHAR2,
                                                                              paranNumOracle VARCHAR2,
                                                                              paramGiro VARCHAR2,
                                                                              paramPorcentaje VARCHAR2,
                                                                              paramPorcentajeOpt VARCHAR2,
                                                                              paramPorcentajeCual VARCHAR2
                                                                              ) AS
      v_stringbuilder CLOB;
      --v_lastlevel NUMBER;
      v_cadena          VARCHAR2(5000);
      postArrTenCasc SYS_REFCURSOR;
      pistOutType    VARCHAR2(20):='DBMS';
      --listEmpresaName    VARCHAR2(200);
  BEGIN
    DELETE FROM APP_TEMP_LOG;
    DELETE FROM DERCORP_REPORTE_TENCASC_TMP;
    DERCORP_REPORT_TENCASC_PKG.DO_REPORT_PR(postArrTenCasc, pistOutType, paramEmpresa);
    DELETE FROM DERCORP_REPORTE_TENCASC_ID_TMP;
    DELETE FROM DERCORP_REPORTE_TENCASC_G_TMP;
    INSERT INTO
      DERCORP_REPORTE_TENCASC_G_TMP
    SELECT
      EXT.DES_DATO1,
      EXT.DES_DATO2,
      EXT.DES_DATO3,
      EXT.DES_DATO4,
      SUM(EXT.DES_DATO5),
      SUM(EXT.DES_DATO6),
      EXT.DES_DATO7,
      EXT.DES_DATO8,
      EXT.DES_DATO9,
      EXT.DES_DATO10
    FROM
      DERCORP_REPORTE_TENCASC_TMP EXT
    GROUP BY
      EXT.DES_DATO1,
      EXT.DES_DATO2,
      EXT.DES_DATO3,
      EXT.DES_DATO4,
      EXT.DES_DATO7,
      EXT.DES_DATO8,
      EXT.DES_DATO9,
      EXT.DES_DATO10;
    INSERT INTO
        DERCORP_REPORTE_TENCASC_ID_TMP
    SELECT
      1,
      EXT.DES_DATO1,
      EXT.DES_DATO2,
      EXT.DES_DATO3,
      EXT.DES_DATO4,
      EXT.DES_DATO5,
      EXT.DES_DATO6,
      EXT.DES_DATO7,
      EXT.DES_DATO8,
      EXT.DES_DATO9,
      EXT.DES_DATO10
    FROM
      --DERCORP_REPORTE_TENCASC_TMP EXT
      DERCORP_REPORTE_TENCASC_G_TMP EXT
    WHERE
      EXT.DES_DATO4 IS NULL
    UNION
    SELECT
      rownum + 1,
      EXT.DES_DATO1,
      EXT.DES_DATO2,
      EXT.DES_DATO3,
      EXT.DES_DATO4,
      EXT.DES_DATO5,
      EXT.DES_DATO6,
      EXT.DES_DATO7,
      EXT.DES_DATO8,
      EXT.DES_DATO9,
      EXT.DES_DATO10
    FROM
      --DERCORP_REPORTE_TENCASC_TMP EXT
      DERCORP_REPORTE_TENCASC_G_TMP EXT
    START WITH EXT.DES_DATO4 = paramEmpresa
    CONNECT BY PRIOR EXT.DES_DATO1 = EXT.DES_DATO4;
      /**/
    --v_lastlevel := 0;
    v_stringbuilder := 'var data = [' || chr(10);
    FOR XX_ROW IN (
                  SELECT
      '{ id: '
                            --||  EXT.DES_DATO1 ||
                            || EXT.ID_ROW || --'-' ||
                    ', parent:  ' ||
                            --NVL(EXT.DES_DATO4,'null') ||  '-' ||
                            --(SELECT INTER.ID_ROW FROM DERCORP_REPORTE_TENCASC_ID_TMP INTER WHERE INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null')) ||
                            (CASE NVL(EXT.DES_DATO4,'null')
                              WHEN 'null' THEN 'null'
                              ELSE
                                --'ok'
                                (SELECT
                                    '' || MAX(INTER.ID_ROW)
                                  FROM
                                    DERCORP_REPORTE_TENCASC_ID_TMP INTER
                                  WHERE
                                    INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null')
                                  AND
                                    INTER.ID_ROW < EXT.ID_ROW
                                )
                                --(SELECT INTER.ID_ROW || '' FROM DERCORP_REPORTE_TENCASC_ID_TMP INTER WHERE INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null'))
                              END
                            ) ||
                            --NVL((SELECT INTER.ID_ROW FROM DERCORP_REPORTE_TENCASC_ID_TMP INTER WHERE INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null')),'null') ||
                            /*NVL(
                             (SELECT
                                '' || MAX(INTER.ID_ROW)
                              FROM
                                DERCORP_REPORTE_TENCASC_ID_TMP INTER
                              WHERE
                                INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null')
                              AND
                                INTER.ID_ROW < EXT.ID_ROW
                            )
                            ,'null')
                            ||*/
                    ', empresa : "' || EXT.DES_DATO3 || --LPAD('-',rownum,'-') ||
                    '", directo: "' || EXT.DES_DATO5 ||
                    '", indirecto: "' || EXT.DES_DATO6 ||
                    '" },' AS ROW_DATA
    FROM
      --DERCORP_REPORTE_TENCASC_TMP EXT
      DERCORP_REPORTE_TENCASC_ID_TMP EXT
    WHERE
      EXT.DES_DATO4 IS NULL
    UNION
                  SELECT
                    '{ id: '
                            --||  EXT.DES_DATO1 ||
                            || EXT.ID_ROW || --'-' ||
                    ', parent:  ' ||
                            --NVL(EXT.DES_DATO4,'null') ||  '-' ||
                            --(SELECT INTER.ID_ROW FROM DERCORP_REPORTE_TENCASC_ID_TMP INTER WHERE INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null')) ||
                            (CASE NVL(EXT.DES_DATO4,'null')
                              WHEN 'null' THEN 'null'
                              ELSE
                                --'ok'
                                (SELECT
                                    '' || MAX(INTER.ID_ROW)
                                  FROM
                                    DERCORP_REPORTE_TENCASC_ID_TMP INTER
                                  WHERE
                                    INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null')
                                  AND
                                    INTER.ID_ROW < EXT.ID_ROW
                                )
                                --(SELECT INTER.ID_ROW || '' FROM DERCORP_REPORTE_TENCASC_ID_TMP INTER WHERE INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null'))
                              END
                            ) ||
                            --NVL((SELECT INTER.ID_ROW FROM DERCORP_REPORTE_TENCASC_ID_TMP INTER WHERE INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null')),'null') ||
                            /*NVL(
                             (SELECT
                                '' || MAX(INTER.ID_ROW)
                              FROM
                                DERCORP_REPORTE_TENCASC_ID_TMP INTER
                              WHERE
                                INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null')
                              AND
                                INTER.ID_ROW < EXT.ID_ROW
                            )
                            ,'null')
                            ||*/
                    ', empresa : "' || EXT.DES_DATO3 || --LPAD('-',rownum,'-') ||
                    '", directo: "' || EXT.DES_DATO5 ||
                    '", indirecto: "' || EXT.DES_DATO6 ||
                    '" },' AS ROW_DATA
                  FROM
                    --DERCORP_REPORTE_TENCASC_TMP EXT
                    DERCORP_REPORTE_TENCASC_ID_TMP EXT
                  WHERE
                    (
                    NVL(TRIM(APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1)),'NULL') LIKE '%' || paramConsolida || '%'
                      /*OR
                      (
                        APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1) IS NULL
                        AND
                        LENGTH(paramConsolida) = 0
                      )*/
                     )
                    AND
                    (
                      NVL(TRIM(APP_COMMON_PKG.GET_FIELD_VALUE(506,EXT.DES_DATO1)),'NULL') LIKE '%' || paramSegmento || '%'
                       --OR APP_COMMON_PKG.GET_FIELD_VALUE(506,EXT.DES_DATO1) IS NULL
                       )
                    AND
                    (
                      NVL(TRIM(APP_COMMON_PKG.GET_FIELD_VALUE(507,EXT.DES_DATO1)),'NULL') LIKE '%' || paramClasificacion || '%'
                       --OR APP_COMMON_PKG.GET_FIELD_VALUE(507,EXT.DES_DATO1) IS NULL
                       )
                    AND
                    (
                      NVL(TRIM(APP_COMMON_PKG.GET_FIELD_VALUE(509,EXT.DES_DATO1)),'NULL') LIKE '%' || paramPais || '%'
                       --OR APP_COMMON_PKG.GET_FIELD_VALUE(509,EXT.DES_DATO1) IS NULL
                       )
                    AND
                   (
                      NVL(TRIM(APP_COMMON_PKG.GET_FIELD_VALUE(502,EXT.DES_DATO1)),'NULL') LIKE '%' || paranNumOracle || '%'
                      /*OR
                      (
                        APP_COMMON_PKG.GET_FIELD_VALUE(502,EXT.DES_DATO1) IS NULL
                        AND
                        LENGTH(paramConsolida) = 0
                      )*/
                     )
                    AND
                    (
                      NVL(TRIM(APP_COMMON_PKG.GET_FIELD_VALUE(504,EXT.DES_DATO1)),'NULL') LIKE '%' || paramGiro || '%'
                       --OR APP_COMMON_PKG.GET_FIELD_VALUE(504,EXT.DES_DATO1) IS NULL
                       )
                       /*
                    AND
                    (
                      EXT.DES_DATO1 = paramEmpresa
                      OR
                      LENGTH(paramPorcentaje) = 0
                      OR
                      EXT.DES_DATO5 LIKE '%' || NVL(paramPorcentaje,'') || '%'
                      OR
                      EXT.DES_DATO6 LIKE '%' || NVL(paramPorcentaje,'') || '%'
                       --OR APP_COMMON_PKG.GET_FIELD_VALUE(504,EXT.DES_DATO1) IS NULL
                       )*/
                      AND
                      (
                          (
                            EXT.DES_DATO5 IS NULL
                            OR
                            EXT.DES_DATO6 IS NULL
                          )
                          OR
                          (
                            (
                              paramPorcentajeCual = 'Directo'
                              AND
                              (
                                  (paramPorcentajeOpt = '1' AND TO_NUMBER(EXT.DES_DATO5) = TO_NUMBER(paramPorcentaje))
                                  OR
                                  (paramPorcentajeOpt = '2' AND TO_NUMBER(EXT.DES_DATO5) > TO_NUMBER(paramPorcentaje))
                                  OR
                                  (paramPorcentajeOpt = '3' AND TO_NUMBER(EXT.DES_DATO5) < TO_NUMBER(paramPorcentaje))
                              )
                            )
                            OR
                            (
                              paramPorcentajeCual = 'Indirecto'
                              AND
                              (
                                  (paramPorcentajeOpt = '1' AND TO_NUMBER(EXT.DES_DATO6) = TO_NUMBER(paramPorcentaje))
                                  OR
                                  (paramPorcentajeOpt = '2' AND TO_NUMBER(EXT.DES_DATO6) > TO_NUMBER(paramPorcentaje))
                                  OR
                                  (paramPorcentajeOpt = '3' AND TO_NUMBER(EXT.DES_DATO6) < TO_NUMBER(paramPorcentaje))
                              )
                            )
                          )
                      )
                   AND APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(507,EXT.DES_DATO1)  <> 'Fusionada'
                  -- AND EXT.DES_DATO4 IS NOT NULL --JAMS 27-03-2018
                  --WHERE
                  --  TAB.DES_DATO3 LIKE '%S.A.%'
              )
      LOOP
          v_stringbuilder := v_stringbuilder || XX_ROW.ROW_DATA || chr(10); -- || '<br>';    ---- LINE JUMP
      END LOOP;
      v_stringbuilder := substr(v_stringbuilder, 1, length(v_stringbuilder)-2);
      v_stringbuilder := v_stringbuilder || '];' || chr(10);
      dump_clob(v_stringbuilder,3);
      COMMIT;
      --JJAQ 29/03/2017
      QUITAR_PADRE_HIJOS_PR;
      OPEN resultSet FOR
          SELECT
            APP_COMMON_PKG.GET_TXT_HTML_FN(TEXT) AS TEXT
          FROM
            APP_TEMP_LOG
          WHERE
            TEXT IS NOT NULL
            AND
            TEXT <> 'null'
          ORDER BY
            LOG_ID;
  END GET_TREE_DATA3;
  --
  -- ORGANIGRAMA GOOGLE ORGCHART
  --
  PROCEDURE GET_TREE_DATA4(resultSet OUT SYS_REFCURSOR, paramEmpresa VARCHAR2, paramFecha VARCHAR2,
                                                                              paramConsolida VARCHAR2,
                                                                              paramSegmento VARCHAR2,
                                                                              paramClasificacion VARCHAR2,
                                                                              paramPais VARCHAR2,
                                                                              paranNumOracle VARCHAR2,
                                                                              paramGiro VARCHAR2,
                                                                              paramPorcentaje VARCHAR2,
                                                                              paramPorcentajeOpt VARCHAR2,
                                                                              paramPorcentajeCual VARCHAR2,
                                                                              paramPorcentajeVisualizar VARCHAR2) AS
      v_stringbuilder CLOB;
      --v_lastlevel NUMBER;
      postArrTenCasc SYS_REFCURSOR;
      pistOutType    VARCHAR2(20):='DBMS';
      --listEmpresaName    VARCHAR2(200);
      countColors INT;
  BEGIN
    DELETE FROM APP_TEMP_LOG;
    DELETE FROM DERCORP_REPORTE_TENCASC_TMP;
    delete from DERCORP_REPOR_TENCASC_ID_TMP_2;
    delete from DERCORP_REPORTE_TENCASC_G_TMP;
    DERCORP_REPORT_TENCASC_PKG.DO_REPORT_PR(postArrTenCasc, pistOutType, paramEmpresa);
    --DELETE FROM DERCORP_REPORTE_TENCASC_ID_TMP;
    --DELETE DERCORP_REPOR_TENCASC_ID_TMP_2;
    DELETE FROM DERCORP_REPORTE_TENCASC_G_TMP;
    INSERT INTO
      DERCORP_REPORTE_TENCASC_G_TMP
    SELECT
      EXT.DES_DATO1,
      EXT.DES_DATO2,
      EXT.DES_DATO3,
      EXT.DES_DATO4,
      SUM(EXT.DES_DATO5),
      SUM(EXT.DES_DATO6),
      EXT.DES_DATO7,
      EXT.DES_DATO8,
      EXT.DES_DATO9,
      EXT.DES_DATO10
    FROM
      DERCORP_REPORTE_TENCASC_TMP EXT
    GROUP BY
      EXT.DES_DATO1,
      EXT.DES_DATO2,
      EXT.DES_DATO3,
      EXT.DES_DATO4,
      EXT.DES_DATO7,
      EXT.DES_DATO8,
      EXT.DES_DATO9,
      EXT.DES_DATO10;
    INSERT INTO
        --DERCORP_REPORTE_TENCASC_ID_TMP
        DERCORP_REPOR_TENCASC_ID_TMP_2
    SELECT
      1,
      EXT.DES_DATO1,
      EXT.DES_DATO2,
      EXT.DES_DATO3,
      EXT.DES_DATO4,
      EXT.DES_DATO5,
      EXT.DES_DATO6,
      EXT.DES_DATO7,
      EXT.DES_DATO8,
      EXT.DES_DATO9,
      EXT.DES_DATO10,
      '',
      '#29A01C'
    FROM
      --DERCORP_REPORTE_TENCASC_TMP EXT
      DERCORP_REPORTE_TENCASC_G_TMP EXT
    WHERE
      EXT.DES_DATO4 IS NULL
    UNION
    SELECT
      rownum + 1,
      EXT.DES_DATO1,
      EXT.DES_DATO2,
      EXT.DES_DATO3,
      EXT.DES_DATO4,
      EXT.DES_DATO5,
      EXT.DES_DATO6,
      EXT.DES_DATO7,
      EXT.DES_DATO8,
      EXT.DES_DATO9,
      EXT.DES_DATO10,
      '',
      '#29A01C'
    FROM
      --DERCORP_REPORTE_TENCASC_TMP EXT
      DERCORP_REPORTE_TENCASC_G_TMP EXT
    START WITH EXT.DES_DATO4 = paramEmpresa
    CONNECT BY PRIOR EXT.DES_DATO1 = EXT.DES_DATO4;
      /**/
            --
      -- SCRIPTS FINALES
      --
      -- HIJOS DE RAIZ
      UPDATE DERCORP_REPOR_TENCASC_ID_TMP_2 SET
        RAMA = ROWNUM
      WHERE
        DES_DATO4 = 248;
      FOR XX_RAMA IN (SELECT DISTINCT RAMA FROM DERCORP_REPOR_TENCASC_ID_TMP_2 WHERE RAMA IS NOT NULL)
      LOOP
            FOR i IN 1..10 LOOP
                  UPDATE DERCORP_REPOR_TENCASC_ID_TMP_2 SET
                    RAMA = XX_RAMA.RAMA
                  WHERE
                    DES_DATO4 IN (SELECT
                                    DES_DATO1
                                  FROM
                                    DERCORP_REPOR_TENCASC_ID_TMP_2
                                  WHERE
                                    RAMA = XX_RAMA.RAMA)
                  ;
          END LOOP;
      END LOOP;
      /*
      SELECT COUNT(*) INTO countColors
      FROM
      DERCORP_REPOR_TENCASC_COLORS
      ;
      */
      UPDATE DERCORP_REPOR_TENCASC_ID_TMP_2 SET
        COLOR = (SELECT COLOR FROM DERCORP_REPOR_TENCASC_COLORS
                WHERE
                    --MOD(countColors,RAMA) =  ID
                    ID = RAMA
                    )
      ;
    --v_lastlevel := 0;
    v_stringbuilder := 'data.addRows([' || chr(10);
    FOR XX_ROW IN (
SELECT
                    '[{v:' || CHR(39) ||  EXT.ID_ROW || CHR(39) ||
                    ', f:' || CHR(39) ||  EXT.DES_DATO3 || '<div style="background-color:'||EXT.COLOR||'">'||
                    --'<div style="color:red; font-style:italic">directo: "'||EXT.DES_DATO5||'"</div>'||
                    (CASE
                        WHEN UPPER(paramPorcentajeVisualizar) IN('DIRECTO','AMBOS')
                        THEN
                          '<div style="color:red; font-style:italic">directo: "'||EXT.DES_DATO5||'"</div>'
                        ELSE
                          '' END
                        ) ||
                    --'<div style="color:blue; font-style:italic">indirecto: "'||EXT.DES_DATO6||'"</div>'||CHR(39)||'}'||
                    (CASE
                        WHEN UPPER(paramPorcentajeVisualizar) IN('INDIRECTO','AMBOS')
                        THEN
                          '<div style="color:blue; font-style:italic">indirecto: "'||EXT.DES_DATO6||'"</div>'
                        ELSE
                          '' END
                        ) || '</div>' ||
                        CHR(39)|| '}' ||
                    ','||CHR(39)||
                            (CASE NVL(EXT.DES_DATO4,'')
                              WHEN '' THEN ''
                              ELSE
                                --'ok'
                                (SELECT
                                    '' || MAX(INTER.ID_ROW)
                                  FROM
                                    DERCORP_REPORTE_TENCASC_ID_TMP INTER
                                  WHERE
                                    INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'')
                                  AND
                                    INTER.ID_ROW < EXT.ID_ROW
                                )
                              END
                            ) ||CHR(39) ||
                            --NVL((SELECT INTER.ID_ROW FROM DERCORP_REPORTE_TENCASC_ID_TMP INTER WHERE INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null')),'null') ||
                            /*NVL(
                             (SELECT
                                '' || MAX(INTER.ID_ROW)
                              FROM
                                DERCORP_REPORTE_TENCASC_ID_TMP INTER
                              WHERE
                                INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null')
                              AND
                                INTER.ID_ROW < EXT.ID_ROW
                            )
                            ,'null')
                            ||*/
                    ','||CHR(39)||CHR(39)||'],' AS ROW_DATA
                  FROM
                    --DERCORP_REPORTE_TENCASC_TMP EXT
                    --DERCORP_REPORTE_TENCASC_ID_TMP EXT
                    DERCORP_REPOR_TENCASC_ID_TMP_2 EXT
                  WHERE
                  EXT.DES_DATO4 IS NULL
                  UNION
                  SELECT
                    '[{v:' || CHR(39) ||  EXT.ID_ROW || CHR(39) ||
                    ', f:' || CHR(39) ||  EXT.DES_DATO3 || '<div style="background-color:'||EXT.COLOR||'">'||
                    --'<div style="color:red; font-style:italic">directo: "'||EXT.DES_DATO5||'"</div>'||
                    (CASE
                        WHEN UPPER(paramPorcentajeVisualizar) IN('DIRECTO','AMBOS')
                        THEN
                          '<div style="color:red; font-style:italic">directo: "'||EXT.DES_DATO5||'"</div>'
                        ELSE
                          '' END
                        ) ||
                    --'<div style="color:blue; font-style:italic">indirecto: "'||EXT.DES_DATO6||'"</div>'||CHR(39)||'}'||
                    (CASE
                        WHEN UPPER(paramPorcentajeVisualizar) IN('INDIRECTO','AMBOS')
                        THEN
                          '<div style="color:blue; font-style:italic">indirecto: "'||EXT.DES_DATO6||'"</div>'
                        ELSE
                          '' END
                        ) || '</div>' ||
                        CHR(39)|| '}' ||
                    ','||CHR(39)||
                            (CASE NVL(EXT.DES_DATO4,'')
                              WHEN '' THEN ''
                              ELSE
                                --'ok'
                                (SELECT
                                    '' || MAX(INTER.ID_ROW)
                                  FROM
                                    DERCORP_REPORTE_TENCASC_ID_TMP INTER
                                  WHERE
                                    INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'')
                                  AND
                                    INTER.ID_ROW < EXT.ID_ROW
                                )
                              END
                            ) ||CHR(39) ||
                            --NVL((SELECT INTER.ID_ROW FROM DERCORP_REPORTE_TENCASC_ID_TMP INTER WHERE INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null')),'null') ||
                            /*NVL(
                             (SELECT
                                '' || MAX(INTER.ID_ROW)
                              FROM
                                DERCORP_REPORTE_TENCASC_ID_TMP INTER
                              WHERE
                                INTER.DES_DATO1 = NVL(EXT.DES_DATO4,'null')
                              AND
                                INTER.ID_ROW < EXT.ID_ROW
                            )
                            ,'null')
                            ||*/
                    ','||CHR(39)||CHR(39)||'],' AS ROW_DATA
                  FROM
                    --DERCORP_REPORTE_TENCASC_TMP EXT
                    --DERCORP_REPORTE_TENCASC_ID_TMP EXT
                    DERCORP_REPOR_TENCASC_ID_TMP_2 EXT
                  WHERE
                        APP_COMMON_PKG.GET_FIELD_TEXT_VALUE(507,EXT.DES_DATO1)  <> 'Fusionada'
                        AND (APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1)  = NVL(paramConsolida, APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1)) OR APP_COMMON_PKG.GET_FIELD_VALUE(516,EXT.DES_DATO1) IS NULL)
                        AND (APP_COMMON_PKG.GET_FIELD_VALUE(506,EXT.DES_DATO1)  = NVL(paramSegmento, APP_COMMON_PKG.GET_FIELD_VALUE(506,EXT.DES_DATO1)) OR APP_COMMON_PKG.GET_FIELD_VALUE(506,EXT.DES_DATO1) IS NULL)
                        AND (APP_COMMON_PKG.GET_FIELD_VALUE(507,EXT.DES_DATO1)  = NVL(paramClasificacion, APP_COMMON_PKG.GET_FIELD_VALUE(507,EXT.DES_DATO1)) OR APP_COMMON_PKG.GET_FIELD_VALUE(507,EXT.DES_DATO1) IS NULL )
                        AND (APP_COMMON_PKG.GET_FIELD_VALUE(509,EXT.DES_DATO1)  = NVL(paramPais, APP_COMMON_PKG.GET_FIELD_VALUE(509,EXT.DES_DATO1)) OR APP_COMMON_PKG.GET_FIELD_VALUE(509,EXT.DES_DATO1) IS NULL)
                        AND (APP_COMMON_PKG.GET_FIELD_VALUE(502,EXT.DES_DATO1)  = NVL(paranNumOracle, APP_COMMON_PKG.GET_FIELD_VALUE(502,EXT.DES_DATO1)) OR APP_COMMON_PKG.GET_FIELD_VALUE(502,EXT.DES_DATO1) IS NULL)
                        AND (APP_COMMON_PKG.GET_FIELD_VALUE(504,EXT.DES_DATO1)  = NVL(paramGiro, APP_COMMON_PKG.GET_FIELD_VALUE(504,EXT.DES_DATO1)) OR APP_COMMON_PKG.GET_FIELD_VALUE(504,EXT.DES_DATO1) IS NULL)
                     --   AND (APP_COMMON_PKG.GET_FIELD_VALUE(505,EXT.DES_DATO1)  = NVL(paramDivision, APP_COMMON_PKG.GET_FIELD_VALUE(505,EXT.DES_DATO1)) OR APP_COMMON_PKG.GET_FIELD_VALUE(505,EXT.DES_DATO1) IS NULL)--division JAMS 26/07/2017
                        AND
                      (
                          (
                            EXT.DES_DATO5 IS NULL
                            OR
                            EXT.DES_DATO6 IS NULL
                          )
                          OR
                          (
                            (
                              paramPorcentajeCual = 'Directo'
                              AND
                              (
                                  (paramPorcentajeOpt = '1' AND TO_NUMBER(EXT.DES_DATO5) = TO_NUMBER(paramPorcentaje))
                                  OR
                                  (paramPorcentajeOpt = '2' AND TO_NUMBER(EXT.DES_DATO5) > TO_NUMBER(paramPorcentaje))
                                  OR
                                  (paramPorcentajeOpt = '3' AND TO_NUMBER(EXT.DES_DATO5) < TO_NUMBER(paramPorcentaje))
                              )
                            )
                            OR
                            (
                              paramPorcentajeCual = 'Indirecto'
                              AND
                              (
                                  (paramPorcentajeOpt = '1' AND TO_NUMBER(EXT.DES_DATO6) = TO_NUMBER(paramPorcentaje))
                                  OR
                                  (paramPorcentajeOpt = '2' AND TO_NUMBER(EXT.DES_DATO6) > TO_NUMBER(paramPorcentaje))
                                  OR
                                  (paramPorcentajeOpt = '3' AND TO_NUMBER(EXT.DES_DATO6) < TO_NUMBER(paramPorcentaje))
                              )
                            )
                          )
                      )
                  --WHERE
                  --  TAB.DES_DATO3 LIKE '%S.A.%'
              )
      LOOP
          v_stringbuilder := v_stringbuilder || XX_ROW.ROW_DATA || chr(10);-- || '<br>';    ---- LINE JUMP
      END LOOP;
      v_stringbuilder := substr(v_stringbuilder, 1, length(v_stringbuilder)-2);
      v_stringbuilder := v_stringbuilder || ']);' || chr(10);
      dump_clob(v_stringbuilder,4);
      COMMIT;
      --ECM 12 Agosto 2016 - Quitar numeros de los nodos padre que no cumplen con el filtro.
      --NEW_TENC_CASC_PR; JJAQ Se comenta para que no borre el idParent
      QUITAR_PADRE_HIJOS_PR;
      OPEN resultSet FOR
          SELECT
            APP_COMMON_PKG.GET_TXT_HTML_FN(TEXT) AS TEXT
          FROM
            APP_TEMP_LOG
          WHERE
            TEXT IS NOT NULL
            AND
            TEXT <> 'null'
          ORDER BY
            LOG_ID;
  END GET_TREE_DATA4;
  PROCEDURE dump_clob (clob IN OUT NOCOPY CLOB,action number) IS
    offset NUMBER := 1;
    amount NUMBER;
    len    NUMBER := DBMS_LOB.getLength(clob);
    buf    VARCHAR2(32767);
  BEGIN
    WHILE offset < len LOOP
      -- this is slowwwwww...
      amount := LEAST(DBMS_LOB.instr(clob, chr(10), offset)
                      - offset, 32767);
      IF amount > 0 THEN
        -- this is slow...
        DBMS_LOB.read(clob, amount, offset, buf);
        offset := offset + amount + 1;
      ELSE
        buf := NULL;
        offset := offset + 1;
      END IF;
      --DBMS_OUTPUT.put_line('*' || buf);
      APPEND_LOG(buf,action);
    END LOOP;
  END dump_clob;
  --
  --
  --
  PROCEDURE APPEND_LOG(text VARCHAR2,action number)
  AS
    liinCount NUMBER;
  BEGIN
    SELECT
      COUNT(*) INTO liinCount
    FROM
      APP_TEMP_LOG;
    liinCount := liinCount + 1;
    IF action = 3 --PRIMER ORGANIGRAMA
    THEN
        INSERT INTO APP_TEMP_LOG (LOG_ID,TEXT,ID_ROW,ID_PARENT)
        VALUES (liinCount
            ,text
            ,SUBSTR (TEXT,INSTR(TEXT,'id:')+4,TO_NUMBER(INSTR(TEXT,',',1))-TO_NUMBER(INSTR(TEXT,'id:')+4))
            ,REPLACE(REPLACE(SUBSTR(TEXT, TO_NUMBER(INSTR(TEXT, 't:  ',1, 1)+4),  TO_NUMBER(INSTR(TEXT, ', e',1, 1))-19),',',''),'null','')
            );
    ELSE IF action = 4
    THEN
        INSERT INTO APP_TEMP_LOG (LOG_ID,TEXT,ID_ROW,ID_PARENT)
        VALUES (liinCount
            ,text
            ,SUBSTR(TEXT, TO_NUMBER(INSTR(TEXT, '''', 1, 1)+1),TO_NUMBER(INSTR(TEXT, '''',1, 2)-6))
            ,SUBSTR(TEXT, TO_NUMBER(INSTR(TEXT, '''',-1, 4))+1 ,  TO_NUMBER(INSTR(TEXT, '''',-1, 3)) - TO_NUMBER(INSTR(TEXT, '''',-1, 4)) -1));
    ELSE
          INSERT INTO APP_TEMP_LOG (LOG_ID,TEXT,ID_ROW,ID_PARENT)
        VALUES (liinCount
            ,text
            ,NULL
            ,NULL);
    END IF;
    END IF;
    DBMS_OUTPUT.PUT_LINE('LINE');
    DBMS_OUTPUT.PUT_LINE(text);
  END APPEND_LOG;
  --ECM 12 Agosto 2016 - Quitar numeros de los nodos padre que no cumplen con el filtro.
  PROCEDURE NEW_TENC_CASC_PR
  IS
  lstIdPadre VARCHAR2(32767);
  linBandera NUMBER := 0;
  CURSOR   ID_PADRE_CUR
  IS
  SELECT   LOG_ID
          ,SUBSTR(TEXT, TO_NUMBER(INSTR(TEXT, '''',-1, 4))+1 ,  TO_NUMBER(INSTR(TEXT, '''',-1, 3)) - TO_NUMBER(INSTR(TEXT, '''',-1, 4)) -1) AS ID_PADRE
          ,TEXT
  FROM     APP_TEMP_LOG
  WHERE    1=1
  AND      TEXT IS NOT NULL
  AND      TEXT <> 'null'
  ORDER BY LOG_ID
  ;
  CURSOR   ID_HIJO_CUR
  IS
  SELECT   SUBSTR(TEXT, TO_NUMBER(INSTR(TEXT, '''',1, 1))+1,  TO_NUMBER(INSTR(TEXT, '''',1, 2)) - TO_NUMBER(INSTR(TEXT, '''',1, 1))-1 ) AS ID_HIJO
  FROM     APP_TEMP_LOG
  WHERE    1=1
  AND      TEXT IS NOT NULL
  AND      TEXT <> 'null'
  ORDER BY LOG_ID
  ;
  BEGIN
    FOR i IN ID_PADRE_CUR
    LOOP
        FOR j IN ID_HIJO_CUR
        LOOP
          IF i.ID_PADRE = j.ID_HIJO THEN
              linBandera := linBandera + 1;
          END IF;
        END LOOP;
        IF i.LOG_ID > 1 THEN
            IF linBandera = 0 THEN
                DBMS_OUTPUT.PUT_LINE(i.LOG_ID||' '||linBandera||' '||i.TEXT||' '||
                  SUBSTR(i.TEXT, TO_NUMBER(INSTR(i.TEXT, '''',-1, 4))+1 ,  TO_NUMBER(INSTR(i.TEXT, '''',-1, 3)) - TO_NUMBER(INSTR(i.TEXT, '''',-1, 4)) -1) ||' '||
                  REPLACE(i.TEXT, ''||SUBSTR(i.TEXT, TO_NUMBER(INSTR(i.TEXT, '''',-1, 4))+1 ,  TO_NUMBER(INSTR(i.TEXT, '''',-1, 3)) - TO_NUMBER(INSTR(i.TEXT, '''',-1, 4)) -1)||'','')
                );
                lstIdPadre := REPLACE(i.TEXT, ''||SUBSTR(i.TEXT, TO_NUMBER(INSTR(i.TEXT, '''',-1, 4))+1 ,  TO_NUMBER(INSTR(i.TEXT, '''',-1, 3)) - TO_NUMBER(INSTR(i.TEXT, '''',-1, 4)) -1)||'','');
                UPDATE APP_TEMP_LOG SET TEXT = lstIdPadre
                WHERE 1=1
                AND LOG_ID = i.LOG_ID
                ;
            END IF;
        END IF;
        linBandera := 0;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END NEW_TENC_CASC_PR;
  --JJAQ y ULR 29/03/2017 Quitar padre e hijos cuando no se cumpla con el porcentaje directo o indirecto
  PROCEDURE QUITAR_PADRE_HIJOS_PR
  IS
    pistCountIdParent NUMBER;
    CURSOR id_parent_cur
    IS
        SELECT DISTINCT id_parent
        FROM APP_TEMP_LOG
        WHERE id_parent IS NOT NULL
        ORDER BY id_parent;
  BEGIN
          FOR i IN id_parent_cur
          LOOP
              SELECT count(*) INTO pistCountIdParent
              FROM APP_TEMP_LOG
              WHERE id_row = i.id_parent;
        IF pistCountIdParent = 0
        THEN
            DELETE FROM APP_TEMP_LOG tmp WHERE tmp.id_parent = i.id_parent;
            COMMIT;
        END IF;
          END LOOP;
  END QUITAR_PADRE_HIJOS_PR;
END XXTV_TEN_CASC_PKG;
/;
