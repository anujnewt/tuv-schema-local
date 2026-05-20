-- dmap_object_gen_tag : type : view name : xxlb_cfdixpoliza_v
set search_path = labconf,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxlb_cfdixpoliza_v"  ("keyfac", "origen", "mes", "anio", "uuid", "orgid", "rfc_emisor", "rfc_receptor", "importe", "fecha_emision") as select keyfac,
origen,
mes,
anio,
uuid,
orgid,
rfc_emisor,
rfc_receptor,
importe,
fecha_emision
from labconf.cfdixpoliza;/* dmap converted statement end */
-- estimed cost of view [ xxlb_cfdixpoliza_v ]: 1.00;
