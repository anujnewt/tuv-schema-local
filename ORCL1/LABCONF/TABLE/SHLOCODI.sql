-- dmap_object_gen_tag : type : table name : shlocodi
set search_path = labconf,oracle,dmap_extension,public;
create table "shlocodi"  (
cod_keyemp numeric,
cod_regrfc varchar(13),
cod_keydep varchar(16),
cod_keypue varchar(16),
cod_edaemp numeric(38),
cod_cvetur numeric(38),
cod_diainc numeric(38),
cod_feccon timestamp(0),
cod_diagno varchar(6),
cod_tratam varchar(6),
cod_tratex varchar(200)
) ;
