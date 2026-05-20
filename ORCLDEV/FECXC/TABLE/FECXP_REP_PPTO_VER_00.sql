-- dmap_object_gen_tag : type : index name : fecxp_rep_ppto_ver_00
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_rep_ppto_ver_00 on fecxp_rep_ppto_ver (linea_id, version_fe);
