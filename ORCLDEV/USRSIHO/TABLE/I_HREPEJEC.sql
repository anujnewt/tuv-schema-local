-- dmap_object_gen_tag : type : index name : i_hrepejec
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hrepejec on hrepejec (eje_keynom, eje_keyapr, eje_nummes, eje_keyemp, eje_keydep, eje_numemi, eje_keypue);
