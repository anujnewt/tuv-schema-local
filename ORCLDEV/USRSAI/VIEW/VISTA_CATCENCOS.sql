-- dmap_object_gen_tag : type : view name : vista_catcencos
set search_path = usrsai,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "vista_catcencos"  ("cdc_keydep", "cdc_desdep", "cdc_tipprog", "cdc_desprog", "cdc_nomresp", "cdc_duracion", "cdc_idioma") as select distinct x0.dep_keydep , x0.dep_desdep , x1.ald_keytpr
, x3.pam_nompar , x4.emp_nomemp , x1.ald_pertra , x1.ald_idioma
from usrsiho.nmcodeps x0 ,usrsiho.nmloalde x1 ,usrsiho.holodear x2 ,
usrsiho.glcopams x3 ,usrsiho.nmcoempl x4 where
((((x1.ald_keydep = x0.dep_keydep  and x1.ald_keydep
= x2.dea_keydep  and x1.ald_keytpr = x3.pam_cvesec ) and (x4.emp_keyemp = x1.ald_keyemp ) ) and (x3.pam_keypar
= 'H1' ) ) and (x1.ald_keypro = 138 ) );/* dmap converted statement end */
-- estimed cost of view [ vista_catcencos ]: 1.00;
