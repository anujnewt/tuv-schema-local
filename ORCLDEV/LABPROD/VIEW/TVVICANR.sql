-- dmap_object_gen_tag : type : view name : tvvicanr
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "tvvicanr"  ("can_keyemp", "emp_nomemp", "can_percan", "pro_keycia", "cia_descia", "can_keypro", "pro_despro", "can_perori", "serie", "folio", "per_anioa1", "per_nummes") as select can_keyemp, emp_nomemp, can_percan, pro_keycia, cia_descia, can_keypro, pro_despro, can_perori, emp.serie, emp.folio, per_anioa1, per_nummes
from labprod.nmlocanr
inner join labprod.nmloperi on can_keypro = per_keypro and can_percan = per_keyper
inner join labprod.cfdi2comprobantepro pro on can_keypro = pro.com_keypro and can_perori = pro.com_keyper
inner join labprod.cfdi2comprobanteemp emp on pro.idcomprobantepro = emp.idcomprobantepro and emp.com_keyemp = can_keyemp
left join labprod.nmloproc on can_keypro = pro_keypro
left join labprod.nmlocias on pro_keycia = cia_keycia
left join labprod.nmcoempl on can_keyemp = emp_keyemp;/* dmap converted statement end */
-- estimed cost of view [ tvvicanr ]: 1.00;
