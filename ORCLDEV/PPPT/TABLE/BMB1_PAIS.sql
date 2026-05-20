-- dmap_object_gen_tag : type : table name : bmb1_pais
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb1_pais"  (
idpais numeric(38) not null default 0,
pais varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : bmb1_pais
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_pais alter column idpais set not null;
