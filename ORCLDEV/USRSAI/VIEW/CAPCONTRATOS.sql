-- dmap_object_gen_tag : type : view name : capcontratos
set search_path = usrsai,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "capcontratos"  ("cac_keyplz", "cac_keycap", "cac_stspag", "coc_keyrph") as select x0.coc_keyplz , x0.coc_keycap , x0.coc_stspag , x0.coc_keyrph
from usrsiho.holococa x0 ,usrsiho.holocont x1 ,
usrsiho.nmcoempl x2 where (x0.coc_keyplz
= x1.con_keyplz  and x1.con_keyemp = x2.emp_keyemp  and x2.emp_keypro = 138 );/* dmap converted statement end */
-- estimed cost of view [ capcontratos ]: 1.00;
