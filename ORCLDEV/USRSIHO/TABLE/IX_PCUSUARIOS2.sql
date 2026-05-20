-- dmap_object_gen_tag : type : index name : ix_pcusuarios2
set search_path = usrsiho,oracle,dmap_extension,public;
create index ix_pcusuarios2 on pcusuarios (usupassword, usulogin);
