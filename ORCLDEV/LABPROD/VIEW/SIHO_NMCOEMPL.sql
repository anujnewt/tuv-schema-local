-- dmap_object_gen_tag : type : view name : siho_nmcoempl
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "siho_nmcoempl"  ("emp_keyemp", "emp_nomemp", "emp_keydep", "dep_desdep", "emp_keypue", "pue_despue", "emp_keycen", "cen_descen", "emp_status") as select emp_keyemp,
emp_nomemp,
emp_keydep,
dep_desdep,
emp_keypue,
pue_despue,
emp_keycen,
cen_descen,
emp_status
from labprod.nmcoempl
left join labprod.nmcodeps on dep_keydep::VARCHAR=emp_keydep::VARCHAR
left join labprod.nmcopues on pue_keypue::VARCHAR=emp_keypue::VARCHAR
left join labprod.nmlocenc on cen_keycen::VARCHAR=emp_keycen::VARCHAR
where 1=1
and   emp_keypro in (select pam_cvesec from labprod.glcopams where pam_keypar='CTCO'::VARCHAR::NUMERIC);/* dmap converted statement end */
-- estimed cost of view [ siho_nmcoempl ]: 1.00;
