-- dmap_object_gen_tag : type : table name : grupoentidadpregunta360
set search_path = pppt,oracle,dmap_extension,public;
create table "grupoentidadpregunta360"  (
idgrupoentidad numeric(38) not null,
idevaluado numeric(38) not null,
idpregunta numeric(38) not null,
respuesta varchar(4000) not null
) ;
-- dmap_object_gen_tag : type : alter table name : grupoentidadpregunta360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupoentidadpregunta360 alter column idgrupoentidad set not null;
-- dmap_object_gen_tag : type : alter table name : grupoentidadpregunta360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupoentidadpregunta360 alter column idevaluado set not null;
-- dmap_object_gen_tag : type : alter table name : grupoentidadpregunta360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupoentidadpregunta360 alter column idpregunta set not null;
-- dmap_object_gen_tag : type : alter table name : grupoentidadpregunta360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupoentidadpregunta360 alter column respuesta set not null;
