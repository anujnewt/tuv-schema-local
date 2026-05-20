-- dmap_object_gen_tag : type : index name : segespeciales_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index segespeciales_fk on fecxc_segmultimon (cod_sec_tipcat, cod_sec_lin);
