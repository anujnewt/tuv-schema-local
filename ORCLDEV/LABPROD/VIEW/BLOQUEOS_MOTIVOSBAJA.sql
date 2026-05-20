-- dmap_object_gen_tag : type : view name : bloqueos_motivosbaja
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "bloqueos_motivosbaja"  ("motivobaja", "descripcion") as select pam_cvesec motivobaja,
pam_nompar descripcion
from labprod.glcopams
where pam_keypar = 'BA';/* dmap converted statement end */
-- estimed cost of view [ bloqueos_motivosbaja ]: 1.00;
