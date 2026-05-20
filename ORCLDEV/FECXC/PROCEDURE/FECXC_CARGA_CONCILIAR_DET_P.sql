CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECXC_CARGA_CONCILIAR_DET_P" 
 (
 p_ANIO        IN NUMBER,
 p_MES     IN NUMBER,
 p_DNI     IN NUMBER DEFAULT 0,
 p_OTROS     IN NUMBER DEFAULT 0,
 p_USUARIO    IN VARCHAR2
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 COUNTREG   NUMBER;
 MONEDALOC  VARCHAR2(40 BYTE);
 EMPRESALOC VARCHAR2(60 BYTE);
BEGIN
 BEGIN
  select DESMONEDA into MONEDALOC from FECXC_Monedas  Where ES_MONEDA_LOCCAL = 1;
  DBMS_OUTPUT.PUT_LINE(MONEDALOC);
 END;
 BEGIN
  select DES_EMPRESA into EMPRESALOC from fecxc_empresas  Where E_CODIGO = 552;
  DBMS_OUTPUT.PUT_LINE(EMPRESALOC);
 END;
/****************************************************************************
 LIMPIA TODOS LOS DATOS CREADOS CON EL USUARIO QUE INVOCO EL PROC
 ****************************************************************************/
 DELETE FECXC_CONCILIACION_DET_REP WHERE  USUARIO = p_USUARIO;
/****************************************************************************
 carga traspasos
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_DET_REP(
    USUARIO,
    EMPRESA,
    MONEDA,
    REFERENCIA,
    IMPORTE,
    FOLIO,
    TIPO,
    MES_REP,
    ANNO_REP
 )
  SELECT p_USUARIO,
  d.des_empresa,
  m.desmoneda,
  a.refecliente,
  sum(b.importe) as importe,
  a.codfolio,
  'Traspasos' as Tipo,
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
  c.anio_cobranza
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
   fecxc_empresas d,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo =d.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
  AND a.e_codigo =b.e_codigo
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND i.nopara_flujo = 1
     AND tipo_linea = 'TRASPASOS'
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza =p_ANIO
  group by m.desmoneda,d.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
/****************************************************************************
 carga Reclasificaciones
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_DET_REP(
    USUARIO,
    EMPRESA,
    MONEDA,
    REFERENCIA,
    IMPORTE,
    FOLIO,
    TIPO,
    MES_REP,
    ANNO_REP
 )
  SELECT p_USUARIO,
  d.des_empresa,
  m.desmoneda,
  a.refecliente,
  sum(b.importe) as importe,
  a.codfolio,
  'Reclasificaciones' as Tipo,
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
  c.anio_cobranza
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
   fecxc_empresas d,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo =d.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
  AND a.e_codigo =b.e_codigo
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND i.nopara_flujo = 1
     AND tipo_linea = 'RECLASIFICACIONES'
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza =p_ANIO
  group by m.desmoneda,d.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
/****************************************************************************
 carga Movimientos extraordinarios
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_DET_REP(
    USUARIO,
    EMPRESA,
    MONEDA,
    REFERENCIA,
    IMPORTE,
    FOLIO,
    TIPO,
    MES_REP,
    ANNO_REP
 )
 SELECT  p_USUARIO,
  x.des_empresa,
  m.desmoneda,
  a.refecliente,
  sum(b.importe) as importe,
  a.codfolio,
  'Movimientos extraordinarios' as Tipo,
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
  c.anio_cobranza
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
         fecxc_calendario_cob d,
         fecxc_monedas m,
         fecxc_det_clasfecxc i,
   fecxc_empresas x
   WHERE a.f_deposito != a.f_real_dep
     AND a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo = b.e_codigo
  AND a.e_codigo =x.e_codigo
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
   group by m.desmoneda,x.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
 /****************************************************************************
 carga cobranza virtual
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_DET_REP(
    USUARIO,
    EMPRESA,
    MONEDA,
    REFERENCIA,
    IMPORTE,
    FOLIO,
    TIPO,
    MES_REP,
    ANNO_REP
 )
  SELECT p_USUARIO,
  d.des_empresa,
  m.desmoneda,
  a.refecliente,
  sum(b.importe) as importe,
  a.codfolio,
  'Cobranza Virtual' as Tipo,
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
  c.anio_cobranza
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
   fecxc_empresas d,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo =d.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
  AND a.e_codigo =b.e_codigo
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND i.nopara_flujo = 1
     AND tipo_linea = 'COBVIRTUAL'
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza =p_ANIO
  group by m.desmoneda,d.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
/****************************************************************************
 carga Otros ingresos
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_DET_REP(
    USUARIO,
    EMPRESA,
    MONEDA,
    REFERENCIA,
    IMPORTE,
    FOLIO,
    TIPO,
    MES_REP,
    ANNO_REP
 )
 SELECT p_USUARIO,
     d.des_empresa,
   m.desmoneda,
   nvl(a.refecliente,''),
   NVL(SUM (b.importe), 0) AS TOTALDERFE,
   nvl(a.codfolio,0),
   'Otros conceptos' as Tipo,
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
  c.anio_cobranza
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
   fecxc_empresas d,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo = b.e_codigo
  AND a.e_codigo = d.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND i.nopara_flujo = 2
     AND tipo_linea = 'OTROS'
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza =p_ANIO
GROUP BY m.desmoneda,d.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
IF p_OTROS != 0 THEN
    DBMS_OUTPUT.PUT_LINE(p_OTROS);
 INSERT INTO FECXC_CONCILIACION_DET_REP(
    USUARIO,
    EMPRESA,
    MONEDA,
    REFERENCIA,
    IMPORTE,
    FOLIO,
    TIPO,
    MES_REP,
    ANNO_REP
 )
 values (
    p_USUARIO,
    EMPRESALOC,
    MONEDALOC,
    '',
    p_OTROS,
    '',
    'Otros conceptos',
    case p_MES
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
     end,
    p_ANIO
 );
END IF;
/****************************************************************************
 carga Intercambios
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_DET_REP(
    USUARIO,
    EMPRESA,
    MONEDA,
    REFERENCIA,
    IMPORTE,
    FOLIO,
    TIPO,
    MES_REP,
    ANNO_REP
 )
 SELECT p_USUARIO,
     d.des_empresa,
   m.desmoneda,
   nvl(a.refecliente,''),
   NVL(SUM (b.importe), 0) AS TOTALDERFE,
   nvl(a.codfolio,0),
   'Intercambios' as Tipo,
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
  c.anio_cobranza
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
   fecxc_empresas d,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo = b.e_codigo
  AND a.e_codigo = d.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND i.nopara_flujo = 2
     AND tipo_linea = 'INTERCAMBIOS'
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza =p_ANIO
GROUP BY m.desmoneda,d.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
/****************************************************************************
 carga Intereses
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_DET_REP(
    USUARIO,
    EMPRESA,
    MONEDA,
    REFERENCIA,
    IMPORTE,
    FOLIO,
    TIPO,
    MES_REP,
    ANNO_REP
 )
  SELECT p_USUARIO,
  d.des_empresa,
  m.desmoneda,
  a.refecliente,
  sum(b.importe) as importe,
  a.codfolio,
  'Intereses' as Tipo,
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
  c.anio_cobranza
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
   fecxc_empresas d,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo =d.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
  AND a.e_codigo =b.e_codigo
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND i.nopara_flujo = 2
     AND tipo_linea = 'INTERESES'
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza =p_ANIO
  group by m.desmoneda,d.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
/****************************************************************************
 carga DNI
 ****************************************************************************/
INSERT INTO FECXC_CONCILIACION_DET_REP(
    USUARIO,
    EMPRESA,
    MONEDA,
    REFERENCIA,
    IMPORTE,
    FOLIO,
    TIPO,
    MES_REP,
    ANNO_REP
 )
  SELECT p_USUARIO,
  d.des_empresa,
  m.desmoneda,
  a.refecliente,
  sum(b.importe) as importe,
  a.codfolio,
  'DNI' as Tipo,
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
  c.anio_cobranza
    FROM fecxc_enc_clasificados a,
         fecxc_det_clasificados b,
         fecxc_calendario_cob c,
   fecxc_empresas d,
         fecxc_monedas m,
         fecxc_det_clasfecxc i
   WHERE a.cod_sec_clasifica = b.cod_sec_clasifica
     AND a.e_codigo =d.e_codigo
     AND b.cod_sec_det = i.cod_sec_det
  AND a.e_codigo =b.e_codigo
     AND b.cod_sec_catclas = i.cod_sec_catclas
     AND a.f_deposito >= c.fecha_inicio
     AND a.f_deposito <= c.fecha_fin
     AND i.nopara_flujo = 2
     AND tipo_linea = 'DNI'
     AND a.secmoneda = m.secmoneda
  AND c.mes_cobranza = p_MES
  AND c.anio_cobranza =p_ANIO
  group by m.desmoneda,d.des_empresa,a.refecliente,a.codfolio,c.mes_cobranza,c.anio_cobranza;
  IF p_DNI != 0 THEN
   DBMS_OUTPUT.PUT_LINE(p_DNI);
  INSERT INTO FECXC_CONCILIACION_DET_REP(
     USUARIO,
     EMPRESA,
     MONEDA,
     REFERENCIA,
     IMPORTE,
     FOLIO,
     TIPO,
     MES_REP,
     ANNO_REP
  )
  values (
     p_USUARIO,
     EMPRESALOC,
     MONEDALOC,
     '',
     p_DNI,
     '',
     'DNI',
     case p_MES
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
     end,
     p_ANIO
  );
  END IF;
/****************************************************************************
 aplica formato
 ***************************************************************************
 update  FECXC_CONCILIACION_DET_REP set
   IMPORTE = IMPORTE / p_FORMATO
 where USUARIO = p_USUARIO
 AND ANNO_REP = p_ANIO;*/
 /****************************************************************************
 fin
 ****************************************************************************/
 END FECXC_CARGA_CONCILIAR_DET_P;
/
