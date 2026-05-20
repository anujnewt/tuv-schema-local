-- dmap_object_gen_tag : type : index name : ix_holotabs_kaz01
set search_path = usrsiho,oracle,dmap_extension,public;
create index ix_holotabs_kaz01 on holotabs (tab_keypue, tab_fecini, tab_fecfin);
