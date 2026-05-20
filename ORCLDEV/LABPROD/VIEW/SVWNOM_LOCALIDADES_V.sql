-- dmap_object_gen_tag : type : view name : svwnom_localidades_v
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "svwnom_localidades_v"  ("loc_keyloc", "loc_desloc", "loc_domloc", "loc_colloc", "loc_ciuloc", "loc_estloc", "loc_codpos", "loc_cvezon") as select  loc_keyloc
, loc_desloc
, loc_domloc
, loc_colloc
,   (select pam_nompar
from labprod.glcopams
where pam_keypar ='MU'
and pam_cvesec=loc_ciuloc) loc_ciuloc
,(select pam_nompar
from labprod.glcopams
where pam_keypar ='EF'
and pam_cvesec=loc_estloc) loc_estloc
,loc_codpos
,loc_cvezon
from labprod.nmlolocp cp
,labprod.nmcoempl emp
where cp.loc_keyloc =emp.emp_keyloc
and emp.emp_status =1
group by cp.loc_keyloc
,cp.loc_desloc
,cp.loc_domloc
,cp.loc_domloc
,cp.loc_colloc
,cp.loc_colloc
,cp.loc_ciuloc
,cp.loc_estloc
,cp.loc_codpos
,cp.loc_cvezon;/* dmap converted statement end */
-- estimed cost of view [ svwnom_localidades_v ]: 1.00;
