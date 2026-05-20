-- dmap_object_gen_tag : type : table name : bmb1_resvendedor
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb1_resvendedor"  (
idpersonal numeric(38) not null,
fecha timestamp(0) not null,
partea varchar(90),
parteb varchar(113),
status numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : bmb1_resvendedor
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_resvendedor alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : bmb1_resvendedor
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_resvendedor alter column fecha set not null;
