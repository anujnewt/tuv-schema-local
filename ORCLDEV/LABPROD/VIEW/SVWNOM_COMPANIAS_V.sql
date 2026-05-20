-- dmap_object_gen_tag : type : view name : svwnom_companias_v
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "svwnom_companias_v"  ("cia_keycia", "cia_descia", "cia_dircia", "cia_colcia", "cia_pobcia", "cia_codpos", "cia_cidcia", "cia_telcia") as select cia_keycia
, cia_descia
, cia_dircia
, cia_colcia
, cia_pobcia
, cia_codpos
, cia_cidcia
, cia_telcia
from labprod.nmlocias;/* dmap converted statement end */
-- estimed cost of view [ svwnom_companias_v ]: 1.00;
