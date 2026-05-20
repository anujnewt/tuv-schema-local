-- dmap_object_gen_tag : type : view name : llamados_siho
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "llamados_siho"  ("centro_costos", "des_cencos", "tipo_programa", "des_programa", "cve_actividad", "des_actividad", "codigo_hon", "nombre_artistico", "personaje", "nombre_productor", "cve_proceso", "des_proceso", "folio_contrato", "cve_tipocontrato", "des_tipocontrato", "llamado", "fecha_llamado", "hra_llamado", "foro_locacion", "fecha_capllam", "hoja_trabajo", "status_hojatrab", "sindicato", "fecha_grabacion", "fecha_caphoja", "horaent", "horasal", "capitulos", "tabulador", "hrs_trabajadas", "hrs_extras", "tpo_incidencia", "des_tpoincidencia", "costo_unitario", "des_sincencos") as select x1.enc_keydep ,
x6.dep_desdep ,
x1.enc_keytpr ,
oracle.substr(trim(both x4.pam_nompar), 1, 25) ,
x0.det_keypue ,
x7.pue_despue ,
x0.det_keyemp ,
x0.det_nomcor ,
x0.det_person ,
(select x10.emp_nomemp  from usrsiho.nmcoempl x10 where (x10.emp_keyemp = x8.ald_keyemp)) ,
x1.enc_keypro ,
x9.pro_despro ,
x0.det_keyfol ,
x3.con_keytco ,
oracle.substr(trim(both x5.pam_nompar),1,25) ,
x1.enc_numlla ,
(select x11.enc_feclla from usrsiho.holoenclla x11 where (x11.enc_num_id = x1.enc_numlla)) ,
x0.det_hralla ,
x0.det_noforo ,
(select x12.enc_feccap from usrsiho.holoenclla x12 where (x12.enc_num_id = x1.enc_numlla)) ,
x0.det_num_id ,
case
when(x1.enc_stsrep = '0' )  then 'PENDIENTE'
when(x1.enc_stsrep = '1' )  then 'LIBERADA'
when(x1.enc_stsrep = '2' )  then 'AUTORIZADA'
when(x1.enc_stsrep = '3' )  then 'EN CALCULO'
when(x1.enc_stsrep = '4' )  then 'PAGADA'
when(x1.enc_stsrep = '5' )  then 'RECHAZADA'
when(x1.enc_stsrep = '6' )  then 'ELIMINADA'
end ,
x0.det_sindkto ,
x1.enc_fecgra ,
x1.enc_feccap ,
x0.det_hraent ,
x0.det_hrasal ,
x0.det_capgra ,
(select x13.tab_import
from usrsiho.holotabs x13
where x13.tab_keypro= x2.emp_keypro::NUMERIC
and x13.tab_keypue = x3.con_keypue::VARCHAR
and x13.tab_pertra = x3.con_pertra::VARCHAR
and x13.tab_idioma = x3.con_idioma::VARCHAR
and x13.tab_keynac = x3.con_keynac::VARCHAR
and x13.tab_keytab = (x3.con_keytco - 1 )
and x13.tab_fecini<= x0.det_fecgra
and x13.tab_fecfin >= x0.det_fecgra
and x3.con_keyfol::NUMERIC = x0.det_keyfol::NUMERIC ) ,
fn_diftiempo(((coalesce(oracle.substr(x0.det_hraent,1,2),0)* 60) + coalesce(oracle.substr(x0.det_hraent,4,2),0)) ,((coalesce(oracle.substr(x0.det_hrasal,1,2),0)* 60) + coalesce(oracle.substr(x0.det_hrasal,4,2),0))),
case
when ((nullif(x0.det_keyemp::text, '') is null ) or (nullif(x0.det_keyfol::text, '') is null ) )  then 0
when(nullif(x0.det_keyemp::text, '') is not null )  then fn_hocalctiextsias(((coalesce(oracle.substr(x0.det_hraent,1,2) ,0 )* 60) + coalesce(oracle.substr(x0.det_hraent,4,2) ,0 )) ,((coalesce(oracle.substr(x0.det_hrasal,1,2),0 )* 60) + coalesce(oracle.substr(x0.det_hrasal,4,2) ,0 )) ,60 ,coalesce(x0.det_capini ,0 ),coalesce(x0.det_capfin ,0 ),x0.det_keydep,x0.det_keyfol ,coalesce(x3.con_keypue ,'X' ),coalesce(x3.con_cosuni,0 ),x0.det_keytco ,x0.det_keyemp )
end ,
x0.det_tipinc ,
case
when trim(both ' ' from x0.det_tipinc ) = 'N'    then 'NORMAL'
when trim(both ' ' from x0.det_tipinc ) = 'LI'   then 'LIQUIDACION'
when trim(both ' ' from x0.det_tipinc ) = 'JE'   then 'JOR. VIAJE'
when trim(both ' ' from x0.det_tipinc ) = 'JV'   then 'JOR. ESTANCIA'
when trim(both ' ' from x0.det_tipinc ) = 'CM'   then 'COMIDA'
when trim(both ' ' from x0.det_tipinc ) = 'CN'   then 'CENA'
when trim(both ' ' from x0.det_tipinc ) = 'DE'   then 'DESAYUNO'
when trim(both ' ' from x0.det_tipinc ) = 'ED'   then 'EDICION'
when trim(both ' ' from x0.det_tipinc ) = 'PA'   then 'PASAJES'
when trim(both ' ' from x0.det_tipinc ) = 'TA'   then 'AJUSTE TPO. AIRE'
when trim(both ' ' from x0.det_tipinc ) = 'TE'   then 'AJUSTE TPO. EXTRA'
when trim(both ' ' from x0.det_tipinc ) = 'VL'   then 'VIATICOS LOC.'
end ,
case
when trim(both ' ' from x0.det_tipinc ) = 'N'   then (select x14.tab_import
from usrsiho.holotabs x14
where x14.tab_keypro = x2.emp_keypro::NUMERIC
and x14.tab_keypue = x3.con_keypue::VARCHAR
and x14.tab_pertra = x3.con_pertra::VARCHAR
and x14.tab_idioma = x3.con_idioma::VARCHAR
and x14.tab_keynac = x3.con_keynac::VARCHAR
and x14.tab_keytab = (x3.con_keytco - 1 )
and x14.tab_fecini <= x0.det_fecgra
and x14.tab_fecfin >= x0.det_fecgra
and x3.con_keyfol::NUMERIC = x0.det_keyfol::NUMERIC)
when trim(both ' ' from x0.det_tipinc ) <> 'N'  then  x0.det_cosuni
end ,
x1.enc_desscc
from usrsiho.nmloproc x9, usrsiho.nmloalde x8, usrsiho.nmcopues x7, usrsiho.nmcodeps x6, usrsiho.glcopams x5, usrsiho.glcopams x4, usrsiho.nmcoempl x2, usrsiho.holoenctra x1, usrsiho.holocont x3
left outer join usrsiho.holodettra x0 on (x3.con_keyemp = x0.det_keyemp and x3.con_keydep::VARCHAR = x0.det_keydep::VARCHAR and x3.con_keyfol::NUMERIC = x0.det_keyfol::NUMERIC)
where x0.det_num_id = x1.enc_num_id::NUMERIC and x2.emp_keyemp = x0.det_keyemp::NUMERIC    and x1.enc_keydep = x6.dep_keydep::VARCHAR and x0.det_keypue = x7.pue_keypue::VARCHAR and x1.enc_keydep = x8.ald_keydep::VARCHAR and x1.enc_keypro = x9.pro_keypro::NUMERIC and trim(both x4.pam_keypar) = 'H1' and x1.enc_keytpr = trim(both::VARCHAR x4.pam_cvesec) and trim(both x5.pam_keypar) = 'H3' and x0.det_keytco = cast(trim(both::NUMERIC x5.pam_cvesec) as integer) and x0.det_stsreg = 'V' and x0.det_inanda = 'N';/* dmap converted statement end */
-- estimed cost of view [ llamados_siho ]: 1.00;
