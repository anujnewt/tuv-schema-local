-- dmap_object_gen_tag : type : index name : enc_det_importa_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index enc_det_importa_fk on fecxc_det_impges (e_codigo, cod_sec_importa);
