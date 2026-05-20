-- dmap_object_gen_tag : type : table name : glcousua
set search_path = labconf,oracle,dmap_extension,public;
create table "glcousua"  (
usu_keyusu numeric(10) not null,
usu_nomusu varchar(40) not null,
usu_keyest varchar(3),
usu_keydep varchar(16),
usu_fecalt timestamp(0),
usu_horalt varchar(5),
usu_cveusu varchar(64),
usu_keymen varchar(4),
usu_masopc varchar(10),
usu_status varchar(1),
usu_acceso timestamp(0),
usu_passwd timestamp(0),
usu_fecdur numeric(10),
usu_tipusu varchar(1),
usu_permen varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : glcousua
set search_path = labconf,oracle,dmap_extension,public;
alter table glcousua add constraint glusua01 unique (usu_keyusu);
-- dmap_object_gen_tag : type : alter table name : glcousua
set search_path = labconf,oracle,dmap_extension,public;
alter table glcousua alter column usu_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : glcousua
set search_path = labconf,oracle,dmap_extension,public;
alter table glcousua alter column usu_nomusu set not null;
