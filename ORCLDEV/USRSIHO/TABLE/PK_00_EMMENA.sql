-- dmap_object_gen_tag : type : index name : pk_00_emmena
set search_path = usrsiho,oracle,dmap_extension,public;
create index pk_00_emmena on emmenace (alm_klogin, alm_knuobj, alm_tipmov, alm_tipacc);
