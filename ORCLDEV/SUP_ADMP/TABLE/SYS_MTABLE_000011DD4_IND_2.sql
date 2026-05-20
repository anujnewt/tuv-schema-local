-- dmap_object_gen_tag : type : index name : sys_mtable_000011dd4_ind_2
set search_path = sup_admp,oracle,dmap_extension,public;
create index sys_mtable_000011dd4_ind_2 on "imp_sd_46-13_02_36" (
object_schema,
original_object_name,
object_type
);
