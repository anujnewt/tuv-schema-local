-- dmap_object_gen_tag : type : table name : glcousua
set search_path = usrsiho,oracle,dmap_extension,public;
create table "glcousua"  (
usu_keyusu numeric(10),
usu_nomusu varchar(40),
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
