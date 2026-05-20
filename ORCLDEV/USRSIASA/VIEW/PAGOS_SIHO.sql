CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIASA"."PAGOS_SIHO" ("CVE_PROCESO", "DES_PROCESO", "CVE_NOMINA", "DES_NOMINA", "EMISION", "CVE_AREA", "DESC_AREA", "MES", "CODIGO_EMPLEADO", "NOMBRE", "CVE_TIPO_PROG", "DESC_TPOPROG", "CVE_CENCOS", "DESC_CENCOS", "CVE_PUESTO", "DESC_PUESTO", "CVE_CONCEPTO", "DESC_CONCEPTO", "SSSCTA", "CVE_STS", "ESTATUS", "FECHA_PAGO", "FECHA_PROCESO", "IMP_TOTAL") AS 
  SELECT x1.per_keypro,
         x9.pro_despro,
         x1.per_keynom,
         x10.nom_destip,
         x1.per_nu4aux,
         x1.per_nu3aux,
         x7.pam_nompar,
         x1.per_nummes,
         x0.his_keyemp,
         x4.emp_nomemp,
         x3.ald_keytpr,
         x6.pam_nompar,
         x0.his_keydep,
         x2.dep_desdep,
         x0.his_keypue,
         x5.pue_despue,
         x0.his_keycon,
         x11.con_descon,
         substr(x0.his_ca2aux,7,3),
         x8.pam_cvesec,
         x8.pam_nompar,
         CASE  substr(x0.his_ca1aux,4,1)  WHEN '0'  THEN ''  ELSE TO_CHAR (x0.his_fecmov,'dd/mm/yyyy') END,
         TO_CHAR(x1.per_fecpag,'dd/mm/yyyy'),
         sum(x0.his_import * 1)
    FROM nmlohism x0 ,
         nmloperi x1 ,
         nmcodeps x2 ,
         nmloalde x3 ,
         nmcoempl x4 ,
         nmcopues x5 ,
         glcopams x6 ,
         glcopams x7 ,
         glcopams x8 ,
         nmloproc x9 ,
         nmlonomi x10 ,
         nmloconc x11
    WHERE TO_CHAR(x1.per_fecpag,'YYYY') >= 2009
     --WHERE x0.his_keypro=138 AND x0.his_keyper='1108151' --Solo para probar
     AND x1.per_keypro = x0.his_keypro
     AND x1.per_keyper = x0.his_keyper
     AND x0.his_keypue!= 'H01'
     AND trim(x0.his_keydep) = x2.dep_keydep
     AND x0.his_keyemp = x4.emp_keyemp
     AND x0.his_keypue = x5.pue_keypue
     AND trim(x0.his_keydep) = x3.ald_keydep
     AND trim(x6.pam_keypar) = 'H1'
     AND trim(x6.pam_cvesec) = x3.ald_keytpr
     AND trim(x7.pam_keypar) = 'H2'
     AND trim(x7.pam_cvesec) = x1.per_nu3aux
     AND trim(x8.pam_keypar) = 'H27'
     AND trim(x8.pam_cvesec) = substr(x0.his_ca1aux,4,1)
     AND x0.his_keypro = x9.pro_keypro
     AND x0.his_keynom = x10.nom_keynom
     AND x0.his_keycon = x11.con_keycon
   GROUP BY x1.per_keypro,
            x9.pro_despro,
            x1.per_keynom,
            x10.nom_destip,
            x1.per_nu4aux,
            x1.per_nu3aux,
            x7.pam_nompar,
            x1.per_nummes,
            x0.his_keyemp,
            x4.emp_nomemp,
            x3.ald_keytpr,
            x6.pam_nompar,
            x0.his_keydep,
            x2.dep_desdep,
            x0.his_keypue,
            x5.pue_despue,
            x0.his_keycon,
            x11.con_descon,
            substr(x0.his_ca2aux,7,3),
            x8.pam_cvesec,
            x8.pam_nompar,
            CASE  substr(x0.his_ca1aux,4,1)  WHEN '0'  THEN ''  ELSE TO_CHAR (x0.his_fecmov,'dd/mm/yyyy') END,
            TO_CHAR(x1.per_fecpag,'dd/mm/yyyy');
