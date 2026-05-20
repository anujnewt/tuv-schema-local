-- dmap_object_gen_tag : type : table name : dercorp_rep_cap_social_tab
set search_path = usrdrc,oracle,dmap_extension,public;
create table "dercorp_rep_cap_social_tab"  (
id_empresa_sup numeric,
cve_empresa_sup varchar(240),
id_cat_valor_sup numeric,
id_empresa_inf numeric,
cve_empresa_inf varchar(240),
id_cat_valor_inf numeric,
id_catalogo numeric,
id_flex numeric,
id_nivel numeric
) ;
