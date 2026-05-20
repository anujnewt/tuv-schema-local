CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSAI"."VISTA_CATCENCOS" ("CDC_KEYDEP", "CDC_DESDEP", "CDC_TIPPROG", "CDC_DESPROG", "CDC_NOMRESP", "CDC_DURACION", "CDC_IDIOMA") AS 
  select distinct x0.dep_keydep ,x0.dep_desdep ,x1.ald_keytpr
    ,x3.pam_nompar ,x4.emp_nomemp ,x1.ald_pertra ,x1.ald_idioma
    from usrsiho.nmcodeps x0 ,usrsiho.nmloalde x1 ,usrsiho.holodear x2 ,
    usrsiho.glcopams x3 ,usrsiho.nmcoempl x4 where
    ((((((x1.ald_keydep = x0.dep_keydep ) AND (x1.ald_keydep
    = x2.dea_keydep ) ) AND (x1.ald_keytpr = x3.pam_cvesec )
    ) AND (x4.emp_keyemp = x1.ald_keyemp ) ) AND (x3.pam_keypar
    = 'H1' ) ) AND (x1.ald_keypro = 138 ) ) ;
