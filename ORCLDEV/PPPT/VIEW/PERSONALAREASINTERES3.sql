-- dmap_object_gen_tag : type : view name : personalareasinteres3
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "personalareasinteres3"  ("idpersonal", "idareainteres", "areainteres") as select personalareainteres.idpersonal,  personalareainteres.idareainteres,  catexpfuncional.expfuncional as areainteres  from personalareainteres inner join catexpfuncional on personalareainteres.idareainteres = catexpfuncional.idexpfuncional;/* dmap converted statement end */
-- estimed cost of view [ personalareasinteres3 ]: 1.00;
