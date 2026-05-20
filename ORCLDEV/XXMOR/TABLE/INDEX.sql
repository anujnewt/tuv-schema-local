-- dmap_object_gen_tag : type : unique name : index
set search_path = xxmor,oracle,dmap_extension,public;
create unique index xxmor_fzas_ventas_tab_idx02 on xxmor_fzas_vtas_tab (ident_fza_ventas);
