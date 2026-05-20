-- dmap_object_gen_tag : type : table name : eoloreor
set search_path = usrsiho,oracle,dmap_extension,public;
create table "eoloreor"  (
reo_keyorg varchar(3),
reo_keyplz numeric(10),
reo_keydep varchar(16),
reo_padplz numeric(10),
reo_paddep varchar(16),
reo_codniv varchar(80),
reo_pesesp numeric(5),
reo_numniv numeric(5),
reo_tipplz varchar(1),
reo_keypue varchar(16),
reo_ctrdir numeric(5),
reo_ctrind numeric(5)
) ;
