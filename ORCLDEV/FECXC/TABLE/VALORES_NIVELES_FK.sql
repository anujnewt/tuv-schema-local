-- dmap_object_gen_tag : type : index name : valores_niveles_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index valores_niveles_fk on fecxc_valores_nivxemp (e_codigo, cod_nivel);
