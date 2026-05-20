-- dmap_object_gen_tag : type : index name : sys_mtable_000011dd4_ind_5
set search_path = sup_admp,oracle,dmap_extension,public;
create index sys_mtable_000011dd4_ind_5 on "imp_sd_46-13_02_36" (
original_object_schema,
original_object_name,
partition_name
);
