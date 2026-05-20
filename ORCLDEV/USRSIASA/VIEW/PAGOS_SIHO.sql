-- dmap_object_gen_tag : type : view name : pagos_siho
set search_path = usrsiasa,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pagos_siho"  ("cve_proceso", "des_proceso", "cve_nomina", "des_nomina", "emision", "cve_area", "desc_area", "mes", "codigo_empleado", "nombre", "cve_tipo_prog", "desc_tpoprog", "cve_cencos", "desc_cencos", "cve_puesto", "desc_puesto", "cve_concepto", "desc_concepto", "ssscta", "cve_sts", "estatus", "fecha_pago", "fecha_proceso", "imp_total") as select x1.per_keypro,
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
oracle.substr(x0.his_ca2aux, 7, 3),
x8.pam_cvesec,
x8.pam_nompar,
case  oracle.substr(x0.his_ca1aux, 4, 1)  when '0'  then ''  else to_char(x0.his_fecmov, 'dd/mm/yyyy') end,
to_char(x1.per_fecpag, 'dd/mm/yyyy'),
sum(x0.his_import * 1)
from nmlohism x0 ,
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
where to_char(x1.per_fecpag,'YYYY') >= 2009
--where x0.his_keypro=138 and x0.his_keyper='1108151' --solo para probar
and x1.per_keypro = x0.his_keypro
and x1.per_keyper = x0.his_keyper
and x0.his_keypue!= 'H01'
and trim(both x0.his_keydep) = x2.dep_keydep
and x0.his_keyemp = x4.emp_keyemp
and x0.his_keypue = x5.pue_keypue
and trim(both x0.his_keydep) = x3.ald_keydep
and trim(both x6.pam_keypar) = 'H1'
and trim(both x6.pam_cvesec) = x3.ald_keytpr
and trim(both x7.pam_keypar) = 'H2'
and trim(both x7.pam_cvesec) = x1.per_nu3aux
and trim(both x8.pam_keypar) = 'H27'
and trim(both x8.pam_cvesec) = oracle.substr(x0.his_ca1aux,4,1)
and x0.his_keypro = x9.pro_keypro
and x0.his_keynom = x10.nom_keynom
and x0.his_keycon = x11.con_keycon
group by x1.per_keypro,
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
oracle.substr(x0.his_ca2aux,7,3),
x8.pam_cvesec,
x8.pam_nompar,
case  oracle.substr(x0.his_ca1aux,4,1)  when '0'  then ''  else to_char(x0.his_fecmov,'dd/mm/yyyy') end,
to_char(x1.per_fecpag,'dd/mm/yyyy');/* dmap converted statement end */
-- estimed cost of view [ pagos_siho ]: 1.00;
