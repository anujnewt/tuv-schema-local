CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXMOR_PARA_ORD_DB2_VW" ("ID_SOLICITUD", "LINEA", "TIPO", "ROTID", "CALL_PROCEDURE") AS 
  SELECT ID_SOLICITUD,
          '0' AS LINEA,
          'ENCABEZADO' AS TIPO,
          NULL ROTID,
             'CALL MOR.XXMOR_GuardaEncabezado_PR('
          || NVL (TO_CHAR (P_ORDID || ','), 'null,')
          || NVL2 (P_ADVID, '''' || P_ADVID || ''',', 'NULL,')
          || NVL2 (P_ACCTHDRID, '''' || P_ACCTHDRID || ''',', 'NULL,')
          || NVL2 (P_STNID, '''' || P_STNID || ''',', 'NULL,')
          || NVL (TO_CHAR ('' || P_ORDTYP || ','), 'null,')
          || NVL2 (P_STRDT, '''' || P_STRDT || ''',', 'NULL,')
          || NVL2 (P_EDT, '''' || P_EDT || ''',', 'NULL,')
          || NVL2 (P_MCONTID, '''' || P_MCONTID || ''',', 'NULL,')
          || NVL2 (P_AGYESTNUM, '''' || P_AGYESTNUM || ''',', 'NULL,')
          || NVL2 (P_PRDID1, '''' || P_PRDID1 || ''',', 'NULL,')
          || NVL2 (P_RTCRD, '''' || P_RTCRD || ''',', 'NULL,')
          || NVL2 (P_USRFLD1, '''' || P_USRFLD1 || ''',', 'NULL,')
          || NVL (TO_CHAR ('' || P_USRFL10 || ','), 'null,')
          || DECODE (TRIM (P_TOTSPTORD),
                     '', 'NULL,',
                     NULL, 'NULL,',
                     P_TOTSPTORD || ',')
          || NVL2 (P_CMT, '''' || P_CMT || ''',', 'NULL,')
          || NVL2 (P_ROTID, '''' || P_ROTID || ''',', 'NULL,')
          || NVL (TO_CHAR ('' || P_COPY_X_ORDEN || ','), 'null,')
          || NVL (TO_CHAR ('' || P_SPTLEN || ','), 'null')
          || NVL2 (P_MATLOC, '''' || P_MATLOC || ''',', 'NULL,')
          || NVL2 (P_VERSION, '''' || P_VERSION || ''',', 'NULL,')
          || NVL (TO_CHAR ('' || P_CUT_IN || ','), 'null,')
          || NVL2 (P_AUX1, '''' || P_AUX1 || ''',', 'NULL,')
          || NVL2 (P_AUX2, '''' || P_AUX2 || ''',', 'NULL,')
          || NVL2 (P_AUX3, '''' || P_AUX3 || ''',', 'NULL,')
          || NVL2 (P_AUX4, '''' || P_AUX4 || ''',', 'NULL,')
          || NVL2 (P_AUX5, '''' || P_AUX5 || ''')', 'NULL, ?)')
             AS CALL_PROCEDURE
     FROM XXMOR_PARA_ENC_VW
   --WHERE ID_SOLICITUD = 9462
   UNION
   SELECT ID_SOLICITUD,
          LINEA,
          'LINEA' AS TIPO,
          NULL ROTID,
          'CALL MOR.MOR.XXMOR_GuardaLinea_PR('
          || DECODE (TRIM (ORDID),
                     '', 'NULL,',
                     NULL, 'NULL,',
                     ORDID || ',')
          || NVL2 (STNID, '''' || STNID || ''',', 'NULL,')
          || NVL (TO_CHAR ('' || SPOT_CHR || ','), 'NULL,')
          || NVL2 (USR_CHR, '''' || USR_CHR || ''',', 'NULL,')
          || NVL (TO_CHAR ('' || SECNUM || ','), 'NULL,')
          || NVL2 (STRDT, '''' || STRDT || ''',', 'NULL,')
          || NVL2 (EDT, '''' || EDT || ''',', 'NULL,')
          || NVL2 (BUYUNTID, '''' || BUYUNTID || ''',', 'NULL,')
          || NVL (TO_CHAR ('' || STRTIM || ','), 'NULL,')
          || NVL (TO_CHAR ('' || ETIM || ','), 'NULL,')
          || NVL (TO_CHAR ('' || SPTLEN || ','), 'NULL,')
          || NVL2 (SPTPAT, '''' || SPTPAT || ''',', 'NULL,')
          || NVL (TO_CHAR ('' || RT || ','), 'NULL,')
          || NVL2 (BKDT, '''' || BKDT || ''',', 'NULL,')
          || NVL (TO_CHAR ('' || REVSTS || ','), 'NULL,')
          || NVL (TO_CHAR ('' || USRFL11 || ','), 'NULL,')
          || NVL (TO_CHAR ('' || LNSPTORD || ','), 'NULL,')
          || NVL (TO_CHAR ('' || LNVALORD || ','), 'NULL,')
          || NVL2 (PRDID1, '''' || PRDID1 || ''',', 'NULL,')
          || NVL2 (BRND, '''' || BRND || ''',', 'NULL,')
          || NVL2 (CMT, '''' || CMT || ''',', 'NULL,')
          || NVL2 (P_ROTID, '''' || P_ROTID || ''',', 'NULL,')
          || NVL2 (ADVID, '''' || ADVID || ''',', 'NULL,')
          || NVL2 (VERSION, '''' || VERSION || ''',', 'NULL,')
          || NVL (TO_CHAR ('' || P_COPY_X_LINEA || ','), 'NULL,')
          || NVL (TO_CHAR ('' || CUT_IN || ','), 'NULL,')
          || NVL2 (MATLOC, '''' || MATLOC || ''',', 'NULL,')
          || NVL2 (P_AUX1, '''' || P_AUX1 || ''',', 'NULL,')
          || NVL2 (P_AUX2, '''' || P_AUX2 || ''',', 'NULL,')
          || NVL2 (P_AUX3, '''' || P_AUX3 || ''',', 'NULL,')
          || NVL2 (P_AUX4, '''' || P_AUX4 || ''',', 'NULL,')
          || NVL2 (P_AUX5, '''' || P_AUX5 || ''',?),', 'NULL,?)')
             AS CALL_PROCEDURE
     FROM XXMOR_PARA_LIN_VW
   --WHERE ID_SOLICITUD = 9462
   UNION
   SELECT ID_SOLICITUD,
          LINEA,
          'COPY' AS TIPO,
          ROTID,
             'CALL mor.XXMOR_GuardaCopys_Pr('
          || NVL2 (ROTID, '''' || ROTID || ''',', 'NULL,')
          || NVL (TO_CHAR ('' || ID_FORANEO_ORDEN || ','), 'NULL,')
          || NVL (TO_CHAR ('' || ID_FORANEO_LINEA || ','), 'NULL,')
          || NVL2 (ADVID, '''' || ADVID || ''',', 'NULL,')
          || NVL (TO_CHAR ('' || DURACION || ','), 'NULL,')
          || NVL2 (FECHA_INICIO, '''' || FECHA_INICIO || ''',', 'NULL,')
          || NVL2 (MATLOC, '''' || MATLOC || ''',', 'NULL,')
          || NVL2 (VERSION, '''' || VERSION || ''',', 'NULL,')
          || NVL (TO_CHAR ('' || CUT_IN || ','), 'NULL,')
          || NVL2 (STNID, '''' || STNID || ''',', 'NULL,')
          || NVL2 (PLATAFORMA_CANAL,
                   '''' || PLATAFORMA_CANAL || ''',',
                   'NULL,')
          || NVL2 (FECHA_FIN, '''' || FECHA_FIN || ''',', 'NULL,')
          || NVL2 (MARCA, '''' || MARCA || ''',', 'NULL,')
          || NVL2 (COPYS_X_FECHA || COPYS_X_ORDEN,
                   '''' || COPYS_X_FECHA || COPYS_X_ORDEN || ''',',
                   'NULL,')
          || NVL2 (MATLOC_NULL, '''' || MATLOC_NULL || ''',?)', 'NULL,?)')
             AS CALL_PROCEDURE
     FROM XXMOR_PARA_COPY_VW
 ;
