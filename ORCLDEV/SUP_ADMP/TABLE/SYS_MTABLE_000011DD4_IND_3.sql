-- dmap_object_gen_tag : type : index name : sys_mtable_000011dd4_ind_3
set search_path = sup_admp,oracle,dmap_extension,public;
create index sys_mtable_000011dd4_ind_3 on "imp_sd_46-13_02_36" (
object_schema,
object_name,
object_type,
partition_name,
subpartition_name
);
