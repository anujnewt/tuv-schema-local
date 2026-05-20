-- dmap_object_gen_tag : type : view name : sim_holococa
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "sim_holococa"  ("coc_keycap", "coc_keyplz") as select coc_keycap, coc_keyplz  from holococa;/* dmap converted statement end */
-- estimed cost of view [ sim_holococa ]: 1.00;
