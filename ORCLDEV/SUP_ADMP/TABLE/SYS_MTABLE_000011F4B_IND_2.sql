-- dmap_object_gen_tag : type : index name : sys_mtable_000011f4b_ind_2
set search_path = sup_admp,oracle,dmap_extension,public;
create index sys_mtable_000011f4b_ind_2 on "imp_sd_204-11_36_29" (
object_schema,
original_object_name,
object_type
);
