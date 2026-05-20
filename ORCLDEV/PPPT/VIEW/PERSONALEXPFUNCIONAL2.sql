-- dmap_object_gen_tag : type : view name : personalexpfuncional2
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "personalexpfuncional2"  ("idpersonal", "idexpfuncional", "expfuncional") as select personalexpfuncional.idpersonal,  personalexpfuncional.idexpfuncional,  catexpfuncional.expfuncional  from personalexpfuncional inner join catexpfuncional on personalexpfuncional.idexpfuncional = catexpfuncional.idexpfuncional;/* dmap converted statement end */
-- estimed cost of view [ personalexpfuncional2 ]: 1.00;
