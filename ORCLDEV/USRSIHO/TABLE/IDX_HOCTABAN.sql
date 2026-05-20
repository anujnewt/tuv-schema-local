-- dmap_object_gen_tag : type : index name : idx_hoctaban
set search_path = usrsiho,oracle,dmap_extension,public;
create index idx_hoctaban on hoctaban (cta_keypro, cta_keyban);
