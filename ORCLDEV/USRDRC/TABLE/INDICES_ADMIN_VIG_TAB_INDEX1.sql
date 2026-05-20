-- dmap_object_gen_tag : type : index name : indices_admin_vig_tab_index1
set search_path = usrdrc,oracle,dmap_extension,public;
create index indices_admin_vig_tab_index1 on pendium_indices_admin_vig_tab (id_empresa, id_flex_tbl, val_c8);
