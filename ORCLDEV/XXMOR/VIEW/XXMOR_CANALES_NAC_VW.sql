-- dmap_object_gen_tag : type : view name : xxmor_canales_nac_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxmor_"canal"es_nac_vw"  (canal) as select '2CAN' as canal
union
select '4CAN'
union
select '5CAN'
union
select '9CAN'
;/* dmap converted statement end */
-- estimed cost of view [ xxmor_canales_nac_vw ]: 1.00;
