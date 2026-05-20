-- dmap_object_gen_tag : type : index name : contsdw2_03
set search_path = usrsiho,oracle,dmap_extension,public;
create index contsdw2_03 on holocont_sdw2 (con_fecini, con_keytco, con_keypue);
