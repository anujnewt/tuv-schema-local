-- dmap_object_gen_tag : type : index name : segmento_xemp_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index segmento_xemp_fk on fecxc_emp_x_segmento (id_segmento);
