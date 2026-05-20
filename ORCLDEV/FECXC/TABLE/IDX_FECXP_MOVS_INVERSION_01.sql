-- dmap_object_gen_tag : type : index name : idx_fecxp_movs_inversion_01
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_fecxp_movs_inversion_01 on fecxp_movs_inversion (folio_set, id_status_mov, id_tipo_movto);
