-- dmap_object_gen_tag : type : table name : grupoentidadrelacion360
set search_path = pppt,oracle,dmap_extension,public;
create table "grupoentidadrelacion360"  (
idgrupoentidadeval numeric(38) not null,
idgrupoentidadpar numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : grupoentidadrelacion360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupoentidadrelacion360 alter column idgrupoentidadeval set not null;
-- dmap_object_gen_tag : type : alter table name : grupoentidadrelacion360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupoentidadrelacion360 alter column idgrupoentidadpar set not null;
