CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXMOR_TIPO_SERVICIO_VW" ("TIPO_SERVICIO") AS 
  SELECT   inclusion || '-' || sptchr ||':'|| usrchr AS tipo_servicio
       FROM   XXMOR_CONF_TIPO_SRV_TAB
   GROUP BY   inclusion, sptchr, usrchr
   ORDER BY   inclusion, sptchr, usrchr
 ;
