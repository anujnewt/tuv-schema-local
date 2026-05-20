CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECXC_CARGA_CONCILIAR_P" 
 (
 p_ANIO        IN NUMBER,
 p_MES     IN NUMBER,
 p_DNI     IN NUMBER DEFAULT 0,
 p_OTROS     IN NUMBER DEFAULT 0,
 p_FORMATO    IN NUMBER DEFAULT 1,
 p_USUARIO    IN VARCHAR2
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 COUNTREG   NUMBER;
 MONEDALOC  VARCHAR2(40 BYTE);
BEGIN
 BEGIN
  select DESMONEDA into MONEDALOC from FECXC_Monedas  Where ES_MONEDA_LOCCAL = 1;
  DBMS_OUTPUT.PUT_LINE(MONEDALOC);
 END;
/****************************************************************************
 LIMPIA TODOS LOS DATOS CREADOS CON EL USUARIO QUE INVOCO EL PROC
 ****************************************************************************/
 DELETE FECXC_CONCILIACION_REP WHERE  USUARIO = p_USUARIO;
/****************************************************************************
 carga cobranza nominal (depositos)
 ****************************************************************************/
 INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   1 AS SECUENCIA ,
   'Cobranza Nominal' AS TITULO ,
   null ,
   NVL (SUM (b.importe), 0),
   null ,
   NVL (SUM (b.importe), 0),
      case c.mes_cobranza
      when 1  then 'Enero'
   when 2  then 'Febrero'
   when 3  then 'Marzo'
   when 4  then 'Abril'
   when 5  then 'Mayo'
   when 6  then 'Junio'
   when 7  then 'Julio'
   when 8  then 'Agosto'
   when 9  then 'Septiembre'
   when 10 then 'Octubre'
   when 11 then 'Noviembre'
   when 12 then 'Diciembre'
   end as MES,
   c.anio_cobranza,
   m.desmoneda,
   ''
 FROM fecxc_enc_clasificados a,
  fecxc_det_clasificados b,
  fecxc_calendario_cob c,
  fecxc_monedas m,
  fecxc_det_clasfecxc i
 WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
  AND a.e_codigo = b.e_codigo
  AND b.cod_sec_det = i.cod_sec_det
  AND b.cod_sec_catclas = i.cod_sec_catclas
  AND a.f_deposito >= c.fecha_inicio
  AND a.f_deposito <= c.fecha_fin
  AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza = p_ANIO
  AND i.EXCLUIR_ENREPORTES = 'NO'
  AND b.SEGMENTO1 is not null
 GROUP BY c.mes_cobranza, c.anio_cobranza,m.desmoneda;
/****************************************************************************
 carga IVA
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   2 AS SECUENCIA,
   'IVA' AS TITULOCXC,
   NVL (SUM (b.importe), 0) AS TITULO,
      null,
   NVL (SUM (b.importe), 0) AS TOTALIZQFE,
      null,
      case c.mes_cobranza
      when 1  then 'Enero'
   when 2  then 'Febrero'
   when 3  then 'Marzo'
   when 4  then 'Abril'
   when 5  then 'Mayo'
   when 6  then 'Junio'
   when 7  then 'Julio'
   when 8  then 'Agosto'
   when 9  then 'Septiembre'
   when 10 then 'Octubre'
   when 11 then 'Noviembre'
   when 12 then 'Diciembre'
   end as MES,
   c.anio_cobranza,
   m.desmoneda,
   ''
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo = b.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND tipo_linea = 'IMPUESTO'
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza = p_ANIO
GROUP BY c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
 carga IVA  (inserta en cero todos los valores para las monedas
    que no se incluyeron en el proceso de IVA
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   2 AS SECUENCIA,
   'IVA' AS TITULO,
   null,
   null,
   null,
         null,
   a.MES_REP,
   a.ANNO_REP,
   a.MONEDA,
   ''
  FROM FECXC_CONCILIACION_REP a
  where a.MONEDA NOT in (
   SELECT  x.MONEDA
    FROM FECXC_CONCILIACION_REP x
    where x.USUARIO = p_USUARIO
    AND x.ANNO_REP = p_ANIO
    and x.SECUENCIA = 2
    )
  GROUP BY a.MES_REP, a.ANNO_REP,a.MONEDA;
/****************************************************************************
 carga traspasos
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
SELECT   p_USUARIO,
   3 AS SECUENCIA,
   'Traspasos' AS TITULO,
   NVL (SUM (b.importe), 0) ,
   null ,
   NVL (SUM (b.importe), 0) ,
   null ,
      case c.mes_cobranza
      when 1  then 'Enero'
   when 2  then 'Febrero'
   when 3  then 'Marzo'
   when 4  then 'Abril'
   when 5  then 'Mayo'
   when 6  then 'Junio'
   when 7  then 'Julio'
   when 8  then 'Agosto'
   when 9  then 'Septiembre'
   when 10 then 'Octubre'
   when 11 then 'Noviembre'
   when 12 then 'Diciembre'
   end as MES,
   c.anio_cobranza,
   m.desmoneda,
   ''
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo = b.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND i.nopara_flujo = 1
     AND tipo_linea = 'TRASPASOS'
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza = p_ANIO
GROUP BY c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
 carga Traspasos  (inserta en cero todos los valores para las monedas
    que no se incluyeron en el proceso de Traspasos
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   3 AS SECUENCIA,
   'Traspasos' AS TITULO,
   null,
   null,
   null,
         null,
   a.MES_REP,
   a.ANNO_REP,
   a.MONEDA,
   ''
  FROM FECXC_CONCILIACION_REP a
  where a.MONEDA NOT in (
   SELECT  x.MONEDA
    FROM FECXC_CONCILIACION_REP x
    where x.USUARIO = p_USUARIO
    AND x.ANNO_REP = p_ANIO
    and x.SECUENCIA = 10
    )
  GROUP BY a.MES_REP, a.ANNO_REP,a.MONEDA;
/****************************************************************************
 carga Reclasificaciones
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
SELECT   p_USUARIO,
   4 AS SECUENCIA,
   'Reclasificaciones' AS TITULO,
   NVL (SUM (b.importe), 0),
   null,
   NVL (SUM (b.importe), 0),
   null,
      case c.mes_cobranza
      when 1  then 'Enero'
   when 2  then 'Febrero'
   when 3  then 'Marzo'
   when 4  then 'Abril'
   when 5  then 'Mayo'
   when 6  then 'Junio'
   when 7  then 'Julio'
   when 8  then 'Agosto'
   when 9  then 'Septiembre'
   when 10 then 'Octubre'
   when 11 then 'Noviembre'
   when 12 then 'Diciembre'
   end as MES,
   c.anio_cobranza,
   m.desmoneda,
   ''
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo = b.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND i.nopara_flujo = 1
     AND tipo_linea = 'RECLASIFICACIONES'
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza = p_ANIO
GROUP BY c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
 carga Reclasificaciones  (inserta en cero todos los valores para las monedas
    que no se incluyeron en el proceso de Reclasificaciones
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   4 AS SECUENCIA,
   'Reclasificaciones' AS TITULO,
   null,
   null,
   null,
         null,
   a.MES_REP,
   a.ANNO_REP,
   a.MONEDA,
   ''
  FROM FECXC_CONCILIACION_REP a
  where a.MONEDA NOT in (
   SELECT  x.MONEDA
    FROM FECXC_CONCILIACION_REP x
    where x.USUARIO = p_USUARIO
    AND x.ANNO_REP = p_ANIO
    and x.SECUENCIA = 5
    )
  GROUP BY a.MES_REP, a.ANNO_REP,a.MONEDA;
/****************************************************************************
 carga Movimientos extraordinarios
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
SELECT   p_USUARIO,
   5 AS SECUENCIA,
   'Movimientos extraordinarios' AS TITULO,
   NVL (SUM (b.importe), 0),
         null,
   NVL (SUM (b.importe), 0),
   null,
   case c.mes_cobranza
      when 1  then 'Enero'
   when 2  then 'Febrero'
   when 3  then 'Marzo'
   when 4  then 'Abril'
   when 5  then 'Mayo'
   when 6  then 'Junio'
   when 7  then 'Julio'
   when 8  then 'Agosto'
   when 9  then 'Septiembre'
   when 10 then 'Octubre'
   when 11 then 'Noviembre'
   when 12 then 'Diciembre'
   end as MES,
   c.anio_cobranza,
   m.desmoneda,
   ''
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
         fecxc_calendario_cob d,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.f_deposito != a.f_real_dep
     AND a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo = b.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND i.nopara_flujo = 1
     AND tipo_linea = 'BASE'
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND a.f_real_dep >= d.fecha_inicio
     AND a.f_real_dep <= d.fecha_fin
     AND c.mes_cobranza != d.mes_cobranza
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza = p_ANIO
GROUP BY c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
 carga Movimientos extraordinarios  (inserta en cero todos los valores para las monedas
    que no se incluyeron en el proceso de Movimientos extraordinarios
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   5 AS SECUENCIA,
   'Movimientos extraordinarios' AS TITULO,
   null,
   null,
   null,
         null,
   a.MES_REP,
   a.ANNO_REP,
   a.MONEDA,
   ''
  FROM FECXC_CONCILIACION_REP a
  where a.MONEDA NOT in (
   SELECT  x.MONEDA
    FROM FECXC_CONCILIACION_REP x
    where x.USUARIO = p_USUARIO
     AND x.ANNO_REP = p_ANIO
    and x.SECUENCIA = 6
    )
  GROUP BY a.MES_REP, a.ANNO_REP,a.MONEDA;
/****************************************************************************
 Totales
 ****************************************************************************/
 INSERT INTO FECXC_CONCILIACION_REP(
    USUARIO,
    SECUENCIA,
    TITULO,
    TOTALIZQCXC,
    TOTALDERCXC,
    TOTALIZQFE,
    TOTALDERFE,
    MES_REP,
    ANNO_REP,
    MONEDA,
      SEGRESTAR
  )
 SELECT
   p_USUARIO,
   6 AS SECUENCIA,
   'SUBTOTAL' AS TITULO,
   null,
   NVL (TOTALDERCXC,0),
   null,
   NVL (TOTALDERFE,0) ,
   a.MES_REP,
   a.ANNO_REP,
   a.MONEDA,
   ''
  FROM FECXC_CONCILIACION_REP a
  where USUARIO = p_USUARIO
  AND a.ANNO_REP = p_ANIO
  and SECUENCIA = 1;
/****************************************************************************
 espacio en blaco
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   7 AS SECUENCIA,
   '-' AS TITULO,
   null,
   null,
   null,
         null,
   a.MES_REP,
   a.ANNO_REP,
   a.MONEDA,
   ''
  FROM FECXC_CONCILIACION_REP a
  where a.MONEDA NOT in (
   SELECT  x.MONEDA
    FROM FECXC_CONCILIACION_REP x
    where x.USUARIO = p_USUARIO
    AND x.ANNO_REP = p_ANIO
    and x.SECUENCIA = 7
    )
  GROUP BY a.MES_REP, a.ANNO_REP,a.MONEDA;
 /****************************************************************************
 (-) Empresas no gestionadas
 ****************************************************************************/
 INSERT INTO FECXC_CONCILIACION_REP(
    USUARIO,
    SECUENCIA,
    TITULO,
    TOTALIZQCXC,
    TOTALDERCXC,
    TOTALIZQFE,
    TOTALDERFE,
    MES_REP,
    ANNO_REP,
    MONEDA,
      SEGRESTAR
  )
 SELECT
   p_USUARIO,
   8 AS SECUENCIA ,
   '(-) Empresa no gestionada' AS TITULO ,
   null,
   null,
   null,
   -1 * NVL (SUM (b.importe), 0),
      case c.mes_cobranza
      when 1  then 'Enero'
   when 2  then 'Febrero'
   when 3  then 'Marzo'
   when 4  then 'Abril'
   when 5  then 'Mayo'
   when 6  then 'Junio'
   when 7  then 'Julio'
   when 8  then 'Agosto'
   when 9  then 'Septiembre'
   when 10 then 'Octubre'
   when 11 then 'Noviembre'
   when 12 then 'Diciembre'
   end as MES,
   c.anio_cobranza,
   m.desmoneda,
   k.DESC_VALOR
 FROM fecxc_enc_clasificados a,
  fecxc_det_clasificados b,
  fecxc_calendario_cob c,
  fecxc_monedas m,
  fecxc_det_clasfecxc i,
  FECXC_RESTA_SEGMENTOS j,
  fecxc_det_catalogos k
 WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
  AND a.e_codigo = b.e_codigo
  AND b.cod_sec_det = i.cod_sec_det
  AND b.cod_sec_catclas = i.cod_sec_catclas
  AND a.f_deposito >= c.fecha_inicio
  AND a.f_deposito <= c.fecha_fin
  AND tipo_linea = 'BASE'
  AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza = p_ANIO
  and j.COD_SEC_LIN = b.SEGMENTO1
  and j.COD_SEC_TIPCAT = 1
  and b.SEGMENTO1 = k.COD_SEC_LIN
  and k.tipo_cat = 'SEGMENTO'
 GROUP BY c.mes_cobranza, c.anio_cobranza,m.desmoneda,k.DESC_VALOR;
/****************************************************************************
  verifica si el insert anterior genero regisros para insertar o no una linea
 ****************************************************************************/
 COUNTREG := 0;
  BEGIN
  select COUNT (SECUENCIA) into COUNTREG
  From FECXC_CONCILIACION_REP
   where   SECUENCIA = 8
   AND USUARIO = p_USUARIO;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    COUNTREG := 0;
 END;
 DBMS_OUTPUT.PUT_LINE(COUNTREG);
 IF COUNTREG > 0 THEN
  /****************************************************************************
  Totales Empresas no gestionadas
  ****************************************************************************/
  INSERT INTO FECXC_CONCILIACION_REP(
     USUARIO,
     SECUENCIA,
     TITULO,
     TOTALIZQCXC,
     TOTALDERCXC,
     TOTALIZQFE,
     TOTALDERFE,
     MES_REP,
     ANNO_REP,
     MONEDA,
       SEGRESTAR
   )
  SELECT
    p_USUARIO,
    9 AS SECUENCIA,
    '-' AS TITULO,
    null,
    null,
    null,
    NVL (SUM (TOTALDERFE),0) ,
    a.MES_REP,
    a.ANNO_REP,
    a.MONEDA,
    ''
   FROM FECXC_CONCILIACION_REP a
   where USUARIO = p_USUARIO
   AND a.ANNO_REP = p_ANIO
   and SECUENCIA = 8
   GROUP BY a.MES_REP, a.ANNO_REP,a.MONEDA;
  /****************************************************************************
  espacio en blaco
  ****************************************************************************/
 INSERT INTO FECXC_CONCILIACION_REP(
    USUARIO,
    SECUENCIA,
    TITULO,
    TOTALIZQCXC,
    TOTALDERCXC,
    TOTALIZQFE,
    TOTALDERFE,
    MES_REP,
    ANNO_REP,
    MONEDA,
    SEGRESTAR
  )
  SELECT
    p_USUARIO,
    10 AS SECUENCIA,
    '*' AS TITULO,
    null,
    null,
    null,
          null,
    a.MES_REP,
    a.ANNO_REP,
    a.MONEDA,
    ''
   FROM FECXC_CONCILIACION_REP a
   where a.MONEDA NOT in (
    SELECT  x.MONEDA
     FROM FECXC_CONCILIACION_REP x
     where x.USUARIO = p_USUARIO
     AND x.ANNO_REP = p_ANIO
     and x.SECUENCIA = 10
     )
   GROUP BY a.MES_REP, a.ANNO_REP,a.MONEDA;
 END IF;
/****************************************************************************
 carga cobranza virtual
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   11 AS SECUENCIA,
   'Cobranza Virtual' AS TITULO,
   NVL (SUM (b.importe), 0) ,
   null,
   null,
   -1 * NVL (SUM (b.importe), 0),
      case c.mes_cobranza
      when 1  then 'Enero'
   when 2  then 'Febrero'
   when 3  then 'Marzo'
   when 4  then 'Abril'
   when 5  then 'Mayo'
   when 6  then 'Junio'
   when 7  then 'Julio'
   when 8  then 'Agosto'
   when 9  then 'Septiembre'
   when 10 then 'Octubre'
   when 11 then 'Noviembre'
   when 12 then 'Diciembre'
   end as MES,
   c.anio_cobranza,
   m.desmoneda,
   ''
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo = b.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND i.nopara_flujo = 1
     AND tipo_linea = 'COBVIRTUAL'
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza = p_ANIO
GROUP BY c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
 carga Cobranza Virtual  (inserta en cero todos los valores para las monedas
    que no se incluyeron en el proceso de Cobranza Virtual
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   11 AS SECUENCIA,
   'Cobranza Virtual' AS TITULO,
   null,
   null,
   null,
         null,
   a.MES_REP,
   a.ANNO_REP,
   a.MONEDA,
   ''
  FROM FECXC_CONCILIACION_REP a
  where a.MONEDA NOT in (
   SELECT  x.MONEDA
    FROM FECXC_CONCILIACION_REP x
    where x.USUARIO = p_USUARIO
    AND x.ANNO_REP = p_ANIO
    and x.SECUENCIA = 11
    )
  GROUP BY a.MES_REP, a.ANNO_REP,a.MONEDA;
/****************************************************************************
 carga Otros ingresos
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   12 AS SECUENCIA,
   'Otros conceptos' AS TITULO,
   null,
   null,
   null,
         case when m.ES_MONEDA_LOCCAL = 1 then
   (NVL (SUM (b.importe), 0) + p_OTROS ) else NVL (SUM (b.importe), 0)  end AS TOTALDERFE,
      case c.mes_cobranza
      when 1  then 'Enero'
   when 2  then 'Febrero'
   when 3  then 'Marzo'
   when 4  then 'Abril'
   when 5  then 'Mayo'
   when 6  then 'Junio'
   when 7  then 'Julio'
   when 8  then 'Agosto'
   when 9  then 'Septiembre'
   when 10 then 'Octubre'
   when 11 then 'Noviembre'
   when 12 then 'Diciembre'
   end as MES,
   c.anio_cobranza,
   m.desmoneda,
   ''
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo = b.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND i.nopara_flujo = 2
     AND tipo_linea = 'OTROS'
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza = p_ANIO
GROUP BY m.ES_MONEDA_LOCCAL,c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
 carga intereses  (inserta en cero todos los valores para las monedas
    que no se incluyeron en el proceso de intereses
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   12 AS SECUENCIA,
   'Otros conceptos' AS TITULO,
   null,
   null,
   null,
   case when a.MONEDA = 'MONEDA NACIONAL' then
   p_OTROS  else null end ,
   a.MES_REP,
   a.ANNO_REP,
   a.MONEDA,
   ''
  FROM FECXC_CONCILIACION_REP a
  where a.MONEDA NOT in (
   SELECT  x.MONEDA
    FROM FECXC_CONCILIACION_REP x
    where x.USUARIO = p_USUARIO
     AND x.ANNO_REP = p_ANIO
    and x.SECUENCIA = 12
    )
  GROUP BY a.MES_REP, a.ANNO_REP,a.MONEDA;
/****************************************************************************
 carga Intercambios
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   13 AS SECUENCIA,
   'Intercambios' AS TITULO,
   null,
   null,
   null,
   NVL (SUM (b.importe), 0) AS TOTALDERFE,
   case c.mes_cobranza
   when 1  then 'Enero'
   when 2  then 'Febrero'
   when 3  then 'Marzo'
   when 4  then 'Abril'
   when 5  then 'Mayo'
   when 6  then 'Junio'
   when 7  then 'Julio'
   when 8  then 'Agosto'
   when 9  then 'Septiembre'
   when 10 then 'Octubre'
   when 11 then 'Noviembre'
   when 12 then 'Diciembre'
   end as MES,
   c.anio_cobranza,
   m.desmoneda,
   ''
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo = b.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND i.nopara_flujo = 2
     AND tipo_linea = 'INTERCAMBIOS'
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza = p_ANIO
GROUP BY c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
 carga Intercambios  (inserta en cero todos los valores para las monedas
    que no se incluyeron en el proceso de Intercambios
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   13 AS SECUENCIA,
   'Intercambios' AS TITULO,
   null,
   null,
   null,
   null,
   a.MES_REP,
   a.ANNO_REP,
   a.MONEDA,
   ''
  FROM FECXC_CONCILIACION_REP a
  where a.MONEDA NOT in (
   SELECT  x.MONEDA
    FROM FECXC_CONCILIACION_REP x
    where x.USUARIO = p_USUARIO
    AND x.ANNO_REP = p_ANIO
    and x.SECUENCIA = 13
    )
  GROUP BY a.MES_REP, a.ANNO_REP,a.MONEDA;
/****************************************************************************
 carga Intereses
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   14 AS SECUENCIA,
   'Intereses' AS TITULO,
   null,
   null,
   null,
   NVL (SUM (b.importe), 0) AS TOTALDERFE,
   case c.mes_cobranza
   when 1  then 'Enero'
   when 2  then 'Febrero'
   when 3  then 'Marzo'
   when 4  then 'Abril'
   when 5  then 'Mayo'
   when 6  then 'Junio'
   when 7  then 'Julio'
   when 8  then 'Agosto'
   when 9  then 'Septiembre'
   when 10 then 'Octubre'
   when 11 then 'Noviembre'
   when 12 then 'Diciembre'
   end as MES,
   c.anio_cobranza,
   m.desmoneda,
   ''
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo = b.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND i.nopara_flujo = 2
     AND tipo_linea = 'INTERESES'
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza = p_ANIO
GROUP BY c.mes_cobranza, c.anio_cobranza, m.desmoneda;
/****************************************************************************
 carga intereses  (inserta en cero todos los valores para las monedas
    que no se incluyeron en el proceso de intereses
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   14 AS SECUENCIA,
   'Intereses' AS TITULO,
   null,
   null,
   null,
         null,
   a.MES_REP,
   a.ANNO_REP,
   a.MONEDA,
   ''
  FROM FECXC_CONCILIACION_REP a
  where a.MONEDA NOT in (
   SELECT  x.MONEDA
    FROM FECXC_CONCILIACION_REP x
    where x.USUARIO = p_USUARIO
    AND x.ANNO_REP = p_ANIO
    and x.SECUENCIA = 14
    )
  GROUP BY a.MES_REP, a.ANNO_REP,a.MONEDA;
/****************************************************************************
 carga DNI
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   15 AS SECUENCIA,
   'DNI' AS TITULO,
   null,
   null,
   null,
         case when m.ES_MONEDA_LOCCAL = 1 then
   (NVL (SUM (b.importe), 0) + p_DNI ) else NVL (SUM (b.importe), 0)  end AS TOTALDERFE,
      case c.mes_cobranza
      when 1  then 'Enero'
   when 2  then 'Febrero'
   when 3  then 'Marzo'
   when 4  then 'Abril'
   when 5  then 'Mayo'
   when 6  then 'Junio'
   when 7  then 'Julio'
   when 8  then 'Agosto'
   when 9  then 'Septiembre'
   when 10 then 'Octubre'
   when 11 then 'Noviembre'
   when 12 then 'Diciembre'
   end as MES,
   c.anio_cobranza,
   m.desmoneda,
   ''
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo = b.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND i.nopara_flujo = 2
     AND tipo_linea = 'DNI'
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza = p_ANIO
GROUP BY m.ES_MONEDA_LOCCAL,c.mes_cobranza, c.anio_cobranza,  m.desmoneda;
/****************************************************************************
 carga DNI  (inserta en cero todos los valores para las monedas
    que no se incluyeron en el proceso de DNI
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   15 AS SECUENCIA,
   'DNI' AS TITULO,
   null,
   null,
   null,
   case when a.MONEDA = 'MONEDA NACIONAL' then
   p_DNI  else null end ,
   a.MES_REP,
   a.ANNO_REP,
   a.MONEDA,
   ''
  FROM FECXC_CONCILIACION_REP a
  where a.MONEDA NOT in (
   SELECT  x.MONEDA
    FROM FECXC_CONCILIACION_REP x
    where x.USUARIO = p_USUARIO
    AND x.ANNO_REP = p_ANIO
    and x.SECUENCIA = 15
    )
  GROUP BY a.MES_REP, a.ANNO_REP,a.MONEDA;
/****************************************************************************
 Totales
 ****************************************************************************/
 INSERT INTO FECXC_CONCILIACION_REP(
    USUARIO,
    SECUENCIA,
    TITULO,
    TOTALIZQCXC,
    TOTALDERCXC,
    TOTALIZQFE,
    TOTALDERFE,
    MES_REP,
    ANNO_REP,
    MONEDA,
      SEGRESTAR
  )
 SELECT
   p_USUARIO,
   16 AS SECUENCIA,
   'TOTAL' AS TITULO,
   null,
   NVL (SUM (TOTALDERCXC),0) ,
   null,
   NVL (SUM (TOTALDERFE),0) ,
   a.MES_REP,
   a.ANNO_REP,
   a.MONEDA,
   ''
  FROM FECXC_CONCILIACION_REP a
  where USUARIO = p_USUARIO
  AND a.ANNO_REP = p_ANIO
  and SECUENCIA in (6,9,11,12,13,14,15)
  GROUP BY a.MES_REP, a.ANNO_REP,a.MONEDA;
/****************************************************************************
 espacio en blaco
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_REP(
   USUARIO,
   SECUENCIA,
   TITULO,
   TOTALIZQCXC,
   TOTALDERCXC,
   TOTALIZQFE,
   TOTALDERFE,
   MES_REP,
   ANNO_REP,
   MONEDA,
   SEGRESTAR
 )
 SELECT
   p_USUARIO,
   17 AS SECUENCIA,
   '#' AS TITULO,
   null,
   null,
   null,
   null,
   a.MES_REP,
   a.ANNO_REP,
   a.MONEDA,
   ''
  FROM FECXC_CONCILIACION_REP a
  where a.MONEDA NOT in (
   SELECT  x.MONEDA
    FROM FECXC_CONCILIACION_REP x
    where x.USUARIO = p_USUARIO
    AND x.ANNO_REP = p_ANIO
    and x.SECUENCIA = 17
    )
  GROUP BY a.MES_REP, a.ANNO_REP,a.MONEDA;
/****************************************************************************
 Diferencia
 ****************************************************************************/
 INSERT INTO FECXC_CONCILIACION_REP(
    USUARIO,
    SECUENCIA,
    TITULO,
    TOTALIZQCXC,
    TOTALDERCXC,
    TOTALIZQFE,
    TOTALDERFE,
    MES_REP,
    ANNO_REP,
    MONEDA,
      SEGRESTAR
  )
 SELECT
   p_USUARIO,
   18 AS SECUENCIA,
   'Diferencia' AS TITULO,
   null,
   NVL (TOTALDERCXC-TOTALDERFE,0),
   null,
   null,
   a.MES_REP,
   a.ANNO_REP,
   a.MONEDA,
   ''
  FROM FECXC_CONCILIACION_REP a
  where USUARIO = p_USUARIO
  AND a.ANNO_REP = p_ANIO
  and SECUENCIA = 16;
/****************************************************************************
 Comprobacion
 ****************************************************************************/
 INSERT INTO FECXC_CONCILIACION_REP(
    USUARIO,
    SECUENCIA,
    TITULO,
    TOTALIZQCXC,
    TOTALDERCXC,
    TOTALIZQFE,
    TOTALDERFE,
    MES_REP,
    ANNO_REP,
    MONEDA,
      SEGRESTAR
  )
 SELECT
   p_USUARIO,
   19 AS SECUENCIA,
   'Comprobacion' AS TITULO,
   null,
   NVL (SUM (TOTALDERCXC)+SUM (TOTALDERFE),0) ,
   null,
   null,
   a.MES_REP,
   a.ANNO_REP,
   a.MONEDA,
   ''
  FROM FECXC_CONCILIACION_REP a
  where USUARIO = p_USUARIO
  AND a.ANNO_REP = p_ANIO
  and SECUENCIA in (9,11,12,13,14,15,18)
  GROUP BY a.MES_REP, a.ANNO_REP,a.MONEDA;
/****************************   SIN ORDERNAR   ******************************/
/****************************************************************************
 aplica formato
 ****************************************************************************/
 update  FECXC_CONCILIACION_REP set
   TOTALIZQCXC = TOTALIZQCXC / p_FORMATO,
      TOTALDERCXC = TOTALDERCXC / p_FORMATO,
      TOTALIZQFE  = TOTALIZQFE / p_FORMATO,
      TOTALDERFE  = TOTALDERFE /p_FORMATO
 where USUARIO = p_USUARIO
 AND ANNO_REP = p_ANIO;
 /****************************************************************************
 fin
 ****************************************************************************/
 END FECXC_CARGA_CONCILIAR_P;
/
