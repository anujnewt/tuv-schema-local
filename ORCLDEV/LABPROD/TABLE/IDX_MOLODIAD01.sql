-- dmap_object_gen_tag : type : index name : idx_molodiad01
set search_path = labprod,oracle,dmap_extension,public;
create index idx_molodiad01 on molodiad (dia_keyemp, dia_keycon, dia_fecini);
