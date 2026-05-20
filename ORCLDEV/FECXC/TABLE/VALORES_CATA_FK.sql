-- dmap_object_gen_tag : type : index name : valores_cata_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index valores_cata_fk on fecxc_valores_nivxemp (cod_sec_tipcat, cod_sec_lin);
