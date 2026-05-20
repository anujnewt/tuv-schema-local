-- dmap_object_gen_tag : type : table name : bmb1_personaldatos
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb1_personaldatos"  (
idpersonal numeric(38) not null,
idpais numeric(38) not null,
idregion numeric(38),
agencia varchar(100),
ubicacion varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : bmb1_personaldatos
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_personaldatos alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : bmb1_personaldatos
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_personaldatos alter column idpais set not null;
