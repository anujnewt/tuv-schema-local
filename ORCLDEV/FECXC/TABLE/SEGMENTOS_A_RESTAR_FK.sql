-- dmap_object_gen_tag : type : index name : segmentos_a_restar_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index segmentos_a_restar_fk on fecxc_resta_segmentos (cod_sec_tipcat, cod_sec_lin);
