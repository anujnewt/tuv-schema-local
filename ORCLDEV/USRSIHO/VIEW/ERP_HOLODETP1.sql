-- dmap_object_gen_tag : type : view name : erp_holodetp1
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "erp_holodetp1"  ("det_keypol", "det_keyfol", "det_cuenta", "det_cargos", "det_abonos", "det_sec_sindical") as select
det_keypol, det_keyfol, det_cuenta, det_cargos, det_abonos, det_sec_sindical
from  holodetp1;/* dmap converted statement end */
-- estimed cost of view [ erp_holodetp1 ]: 1.00;
