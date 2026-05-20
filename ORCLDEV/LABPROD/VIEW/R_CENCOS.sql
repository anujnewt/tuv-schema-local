-- dmap_object_gen_tag : type : view name : r_cencos
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "r_cencos"  ("rcc_keydep", "rcc_keycen", "rcc_refcon", "rcc_oracle") as select dep_keydep rcc_keydep,
dep_keycen rcc_keycen,
dep_refcon rcc_refcon,
oracle.substr(dep_refcon, 15, 8) as "rcc_oracle"
from labprod.nmcodeps;/* dmap converted statement end */
-- estimed cost of view [ r_cencos ]: 1.00;
