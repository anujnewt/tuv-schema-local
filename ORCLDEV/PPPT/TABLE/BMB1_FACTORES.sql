-- dmap_object_gen_tag : type : table name : bmb1_factores
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb1_factores"  (
idresultado numeric(38) not null,
resultado varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : bmb1_factores
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_factores alter column idresultado set not null;
