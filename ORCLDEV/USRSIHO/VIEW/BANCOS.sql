-- dmap_object_gen_tag : type : view name : bancos
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "bancos"  ("ban_keyban", "ban_desban") as select distinct(ban_keyban), ban_desban   from nmlobanc
order by  ban_keyban asc;/* dmap converted statement end */
-- estimed cost of view [ bancos ]: 1.00;
