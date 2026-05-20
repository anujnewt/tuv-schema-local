-- dmap_object_gen_tag : type : table name : nmwkmovt
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmwkmovt"  (
mov_keyemp numeric(10),
mov_keycon varchar(3),
mov_keynom numeric(5),
mov_keydep varchar(16),
mov_keypue varchar(16),
mov_cantid decimal(16, 2),
mov_import decimal(16, 2),
mov_fecmov timestamp(0),
mov_keyper varchar(7),
mov_keypro numeric(5),
mov_keyfor varchar(4),
mov_codimp varchar(2),
mov_codacu varchar(2),
mov_rowide decimal(16, 6),
mov_ca1aux varchar(16),
mov_ca2aux varchar(16),
mov_uniope numeric(5),
mov_keyplz numeric(5),
mov_tipplz varchar(2)
) ;
