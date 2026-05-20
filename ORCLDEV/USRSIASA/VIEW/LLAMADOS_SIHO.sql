CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIASA"."LLAMADOS_SIHO" ("CENTRO_COSTOS", "DES_CENCOS", "TIPO_PROGRAMA", "DES_PROGRAMA", "CVE_ACTIVIDAD", "DES_ACTIVIDAD", "CODIGO_HON", "NOMBRE_ARTISTICO", "PERSONAJE", "NOMBRE_PRODUCTOR", "CVE_PROCESO", "DES_PROCESO", "FOLIO_CONTRATO", "CVE_TIPOCONTRATO", "DES_TIPOCONTRATO", "LLAMADO", "FECHA_LLAMADO", "HRA_LLAMADO", "FORO_LOCACION", "FECHA_CAPLLAM", "HOJA_TRABAJO", "STATUS_HOJATRAB", "SINDICATO", "FECHA_GRABACION", "FECHA_CAPHOJA", "HORAENT", "HORASAL", "CAPITULOS", "TABULADOR", "HRS_TRABAJADAS", "HRS_EXTRAS", "TPO_INCIDENCIA", "DES_TPOINCIDENCIA", "COSTO_UNITARIO", "DES_SINCENCOS") AS 
  SELECT x1.enc_keydep ,
       x6.dep_desdep ,
       x1.enc_keytpr ,
       substr(trim(x4.pam_nompar),1,25) ,
       x0.det_keypue ,
       x7.pue_despue ,
       x0.det_keyemp ,
       x0.det_nomcor ,
       x0.det_person ,
       (select x10.emp_nomemp from nmcoempl x10 where (x10.emp_keyemp=x8.ald_keyemp)) ,
       x1.enc_keypro ,
       x9.pro_despro ,
       x0.det_keyfol ,
       x3.con_keytco ,
       substr(trim(x5.pam_nompar),1,25) ,
       x1.enc_numlla ,
       (select x11.enc_feclla from holoenclla x11 where (x11.enc_num_id = x1.enc_numlla)) ,
       x0.det_hralla ,
       x0.det_noforo ,
       (select x12.enc_feccap from holoenclla x12 where (x12.enc_num_id = x1.enc_numlla)) ,
       x0.det_num_id ,
       CASE
            WHEN (x1.enc_stsrep = '0' )  THEN 'PENDIENTE'
            WHEN (x1.enc_stsrep = '1' )  THEN 'LIBERADA'
            WHEN (x1.enc_stsrep = '2' )  THEN 'AUTORIZADA'
            WHEN (x1.enc_stsrep = '3' )  THEN 'EN CALCULO'
            WHEN (x1.enc_stsrep = '4' )  THEN 'PAGADA'
            WHEN (x1.enc_stsrep = '5' )  THEN 'RECHAZADA'
            WHEN (x1.enc_stsrep = '6' )  THEN 'ELIMINADA'
       END ,
       x0.det_sindkto ,
       x1.enc_fecgra ,
       x1.enc_feccap ,
       x0.det_hraent ,
       x0.det_hrasal ,
       x0.det_capgra ,
       (select x13.tab_import
          from holotabs x13
         where x13.tab_keypro= x2.emp_keypro
           AND x13.tab_keypue = x3.con_keypue
           AND x13.tab_pertra = x3.con_pertra
           AND x13.tab_idioma = x3.con_idioma
           AND x13.tab_keynac = x3.con_keynac
           AND x13.tab_keytab = (x3.con_keytco - 1 )
           AND x13.tab_fecini<= x0.det_fecgra
           AND x13.tab_fecfin >= x0.det_fecgra
           AND x3.con_keyfol = x0.det_keyfol ) ,
       usrsiho.fn_diftiempo(((NVL(substr(x0.det_hraent,1,2),0)* 60) + NVL (substr(x0.det_hraent,4,2),0)) ,((NVL (substr(x0.det_hrasal,1,2),0)* 60) + NVL (substr(x0.det_hrasal,4,2),0))),
       CASE
          WHEN ((x0.det_keyemp IS NULL ) OR (x0.det_keyfol IS NULL ) )  THEN 0
          WHEN (x0.det_keyemp IS NOT NULL )  THEN usrsiho.fn_hocalctiextsias(((NVL (substr(x0.det_hraent,1,2) ,0 )* 60) + NVL (substr(x0.det_hraent,4,2) ,0 )) ,((NVL(substr(x0.det_hrasal,1,2),0 )* 60) + NVL (substr(x0.det_hrasal,4,2) ,0 )) ,60 ,NVL(x0.det_capini ,0 ),NVL (x0.det_capfin ,0 ),x0.det_keydep,x0.det_keyfol ,NVL(x3.con_keypue ,'X' ),NVL (x3.con_cosuni,0 ),x0.det_keytco ,x0.det_keyemp )
       END ,
       x0.det_tipinc ,
       CASE
          WHEN TRIM ( BOTH ' ' FROM x0.det_tipinc ) = 'N'    THEN 'NORMAL'
          WHEN TRIM ( BOTH ' ' FROM x0.det_tipinc ) = 'LI'   THEN 'LIQUIDACION'
          WHEN TRIM ( BOTH ' ' FROM x0.det_tipinc ) = 'JE'   THEN 'JOR. VIAJE'
          WHEN TRIM ( BOTH ' ' FROM x0.det_tipinc ) = 'JV'   THEN 'JOR. ESTANCIA'
          WHEN TRIM ( BOTH ' ' FROM x0.det_tipinc ) = 'CM'   THEN 'COMIDA'
          WHEN TRIM ( BOTH ' ' FROM x0.det_tipinc ) = 'CN'   THEN 'CENA'
          WHEN TRIM ( BOTH ' ' FROM x0.det_tipinc ) = 'DE'   THEN 'DESAYUNO'
          WHEN TRIM ( BOTH ' ' FROM x0.det_tipinc ) = 'ED'   THEN 'EDICION'
          WHEN TRIM ( BOTH ' ' FROM x0.det_tipinc ) = 'PA'   THEN 'PASAJES'
          WHEN TRIM ( BOTH ' ' FROM x0.det_tipinc ) = 'TA'   THEN 'AJUSTE TPO. AIRE'
          WHEN TRIM ( BOTH ' ' FROM x0.det_tipinc ) = 'TE'   THEN 'AJUSTE TPO. EXTRA'
          WHEN TRIM ( BOTH ' ' FROM x0.det_tipinc ) = 'VL'   THEN 'VIATICOS LOC.'
          END ,
       CASE
          WHEN TRIM ( BOTH ' ' FROM x0.det_tipinc ) = 'N'   THEN (select x14.tab_import
                                                                    from holotabs x14
                                                                       where x14.tab_keypro = x2.emp_keypro
                                                                         AND x14.tab_keypue = x3.con_keypue
                                                                         AND x14.tab_pertra = x3.con_pertra
                                                                         AND x14.tab_idioma = x3.con_idioma
                                                                         AND x14.tab_keynac = x3.con_keynac
                                                                         AND x14.tab_keytab = (x3.con_keytco - 1 )
                                                                         AND x14.tab_fecini <= x0.det_fecgra
                                                                         AND x14.tab_fecfin >= x0.det_fecgra
                                                                         AND x3.con_keyfol = x0.det_keyfol)
            WHEN TRIM ( BOTH ' ' FROM x0.det_tipinc ) <> 'N'  THEN  x0.det_cosuni
       END ,
       x1.enc_desscc
  FROM holodettra x0 ,
       holoenctra x1 ,
	     nmcoempl x2 ,
	     holocont x3 ,
       glcopams x4 ,
       glcopams x5 ,
       nmcodeps x6 ,
       nmcopues x7 ,
       nmloalde x8 ,
       nmloproc x9
 WHERE x0.det_num_id = x1.enc_num_id
   AND x2.emp_keyemp = x0.det_keyemp
   AND x3.con_keyemp = x0.det_keyemp (+)
   AND x3.con_keydep = x0.det_keydep (+)
   AND x3.con_keyfol = x0.det_keyfol (+)
   AND x1.enc_keydep = x6.dep_keydep
   AND x0.det_keypue = x7.pue_keypue
   AND x1.enc_keydep = x8.ald_keydep
   AND x1.enc_keypro = x9.pro_keypro
   AND trim(x4.pam_keypar) = 'H1'
   AND x1.enc_keytpr = trim(x4.pam_cvesec)
   AND trim(x5.pam_keypar) = 'H3'
   AND x0.det_keytco = cast(trim(x5.pam_cvesec) as integer)
   AND x0.det_stsreg = 'V'
   AND x0.det_inanda = 'N';
