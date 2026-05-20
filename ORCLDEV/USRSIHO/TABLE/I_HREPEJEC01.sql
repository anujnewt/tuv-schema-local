-- dmap_object_gen_tag : type : index name : i_hrepejec01
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hrepejec01 on hrepejec01 (eje_keynom, eje_keyapr, eje_nummes, eje_keyemp, eje_keydep, eje_numemi, eje_keypue);
