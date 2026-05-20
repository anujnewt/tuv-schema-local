-- dmap_object_gen_tag : type : index name : idx_fecxp_cod_sub_bit01
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_fecxp_cod_sub_bit01 on fecxp_cod_sub_bitacora (ins_no_empresa, ins_id_codigo, ins_id_subcodigo);
