-- dmap_object_gen_tag : type : table name : it_puntajes
set search_path = pppt,oracle,dmap_extension,public;
create table "it_puntajes"  (
puntaje numeric(38) not null,
ci numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : it_puntajes
set search_path = pppt,oracle,dmap_extension,public;
alter table it_puntajes alter column puntaje set not null;
