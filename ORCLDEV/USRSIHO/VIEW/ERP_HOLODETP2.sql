-- dmap_object_gen_tag : type : view name : erp_holodetp2
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "erp_holodetp2"  ("det_keypol", "det_keyfol", "det_cuenta", "det_cargos", "det_abonos", "det_keypue", "det_caietu", "det_sec_sindical") as select
det_keypol, det_keyfol, det_cuenta, det_cargos, det_abonos, det_keypue, det_caietu, det_sec_sindical
from  holodetp2;/* dmap converted statement end */
-- estimed cost of view [ erp_holodetp2 ]: 1.00;
