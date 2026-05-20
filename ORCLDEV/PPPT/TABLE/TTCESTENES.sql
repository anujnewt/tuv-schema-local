-- dmap_object_gen_tag : type : table name : ttcestenes
set search_path = pppt,oracle,dmap_extension,public;
create table "ttcestenes"  (
idprueba numeric(38) not null,
calificacion numeric(38) not null,
minpuntos numeric(38) not null,
maxpuntos numeric(38) not null,
idcompetencia numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : ttcestenes
set search_path = pppt,oracle,dmap_extension,public;
alter table ttcestenes alter column idprueba set not null;
-- dmap_object_gen_tag : type : alter table name : ttcestenes
set search_path = pppt,oracle,dmap_extension,public;
alter table ttcestenes alter column calificacion set not null;
-- dmap_object_gen_tag : type : alter table name : ttcestenes
set search_path = pppt,oracle,dmap_extension,public;
alter table ttcestenes alter column minpuntos set not null;
-- dmap_object_gen_tag : type : alter table name : ttcestenes
set search_path = pppt,oracle,dmap_extension,public;
alter table ttcestenes alter column maxpuntos set not null;
-- dmap_object_gen_tag : type : alter table name : ttcestenes
set search_path = pppt,oracle,dmap_extension,public;
alter table ttcestenes alter column idcompetencia set not null;
