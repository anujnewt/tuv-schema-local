-- dmap_object_gen_tag : type : index name : idx_c_cong
set search_path = labprod,oracle,dmap_extension,public;
create index idx_c_cong on congelada_rh2000 (mes_keyemp, mes_keymes, mes_keyper, mes_keypro);
