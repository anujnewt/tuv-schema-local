-- dmap_object_gen_tag : type : view name : videsper
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "videsper"  ("per_keyper", "per_desper", "per_keypro", "per_fecpag", "id", "per_keynom") as select per_keyper, per_keyper||' DE '||to_char(per_fecini, 'dd/mm/yyyy')||' A '||to_char(per_fecfin, 'dd/mm/yyyy')||' Proceso: '||per_keypro  as per_desper,  per_keypro, per_fecpag,
per_keyper||'-'||per_keypro id, per_keynom
from labprod.nmloperi;/* dmap converted statement end */
-- estimed cost of view [ videsper ]: 1.80;
