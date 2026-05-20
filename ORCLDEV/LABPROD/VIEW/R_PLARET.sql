-- dmap_object_gen_tag : type : view name : r_plaret
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "r_plaret"  ("ret_keyemp", "ret_nomemp", "ret_keydep", "ret_desdep", "ret_keypue", "ret_despue", "ret_keycen", "ret_descen", "ret_keycia", "ret_descia", "ret_keypro", "ret_despro", "ret_tipemp", "ret_status", "ret_keyloc", "ret_desloc", "ret_fecaux", "ret_fecbaj", "ret_cvebaj", "ret_nompar", "ret_keypar", "ret_valpar") as select
emp_keyemp ret_keyemp,
emp_nomemp ret_nomemp,
emp_keydep ret_keydep,
dep_desdep ret_desdep,
emp_keypue ret_keypue,
pue_despue ret_despue,
dep_keycen ret_keycen,
cen_descen ret_descen,
cia_keycia ret_keycia,
cia_descia ret_descia,
emp_keypro ret_keypro,
pro_despro ret_despro,
emp_tipemp ret_tipemp,
emp_status ret_status,
emp_keyloc ret_keyloc,
loc_desloc ret_desloc,
emp_fecaux ret_fecaux,
emp_fecbaj ret_fecbaj,
emp_cvebaj ret_cvebaj,
pam_nompar ret_nompar,
dat_keypar ret_keypar,
dat_valpar ret_valpar
from labprod.nmcoempl
inner join labprod.nmlodata on dat_keyemp::NUMERIC=emp_keyemp::NUMERIC and dat_keypar::VARCHAR='54'::VARCHAR and not(nullif(dat_valpar::text, '') is null)
left join labprod.glcopams on pam_keypar::VARCHAR='BA'::VARCHAR and pam_cvesec::VARCHAR=emp_cvebaj::VARCHAR
left join labprod.nmcodeps on dep_keydep::VARCHAR=emp_keydep::VARCHAR
left join labprod.nmcopues on pue_keypue::VARCHAR=emp_keypue::VARCHAR
left join labprod.nmlocenc on cen_keycen::VARCHAR=emp_keycen::VARCHAR
left join labprod.nmloproc on pro_keypro::NUMERIC=emp_keypro::NUMERIC
left join labprod.nmlocias on cia_keycia::VARCHAR=pro_keycia::VARCHAR
left join labprod.nmlolocp on loc_keyloc::VARCHAR=emp_keyloc::VARCHAR
where 1=1
and exists (select pam_cvesec from labprod.glcopams where pam_keypar='CTCO'::VARCHAR and pam_cvesec=emp_keypro::VARCHAR);/* dmap converted statement end */
-- estimed cost of view [ r_plaret ]: 1.00;
