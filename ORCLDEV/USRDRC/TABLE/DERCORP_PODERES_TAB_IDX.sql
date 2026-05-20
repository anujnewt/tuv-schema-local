-- dmap_object_gen_tag : type : index name : dercorp_poderes_tab_idx
set search_path = usrdrc,oracle,dmap_extension,public;
create index dercorp_poderes_tab_idx on dercorp_poderes_tab (id_empresa);
