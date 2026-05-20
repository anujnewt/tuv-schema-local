-- dmap_object_gen_tag : type : view name : view_ap_sipros
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "view_ap_sipros"  ("soi_keyemp", "soi_keycon", "soi_refere", "soi_tipope", "soi_import", "soi_fecope", "soi_tipmon", "soi_tipcam", "soi_tipreg", "soi_keypre", "soi_keypro", "soi_status", "soi_feccar", "soi_stacar", "soi_refamo", "soi_vennum", "soi_vencod") as (select
soi_keyemp,
soi_keycon,
soi_refere,
soi_tipope,
soi_import,
soi_fecope,
soi_tipmon,
soi_tipcam,
soi_tipreg,
soi_keypre,
soi_keypro,
soi_status,
soi_feccar,
soi_stacar,
soi_refamo,
soi_vennum,
soi_vencod from labprod.ap_sipros);/* dmap converted statement end */
-- estimed cost of view [ view_ap_sipros ]: 1.00;
