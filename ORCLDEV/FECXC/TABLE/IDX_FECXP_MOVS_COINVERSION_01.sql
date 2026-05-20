-- dmap_object_gen_tag : type : index name : idx_fecxp_movs_coinversion_01
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_fecxp_movs_coinversion_01 on fecxp_movs_coinversion (folio_set, id_status_mov);
