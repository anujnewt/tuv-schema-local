-- dmap_object_gen_tag : type : table name : bmb1_parteb2
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb1_parteb2"  (
idpregunta numeric(38) not null,
par1 varchar(50),
par2 varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : bmb1_parteb2
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_parteb2 alter column idpregunta set not null;
