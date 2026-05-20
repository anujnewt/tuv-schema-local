-- dmap_object_gen_tag : type : table name : campos
set search_path = fecxc,oracle,dmap_extension,public;
create table "campos"  (
entidad varchar(30) not null,
campo varchar(30) not null,
nombre varchar(50) not null,
tipo char(1) not null,
longitud numeric(38) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : campos
set search_path = fecxc,oracle,dmap_extension,public;
alter table campos alter column entidad set not null;
-- dmap_object_gen_tag : type : alter table name : campos
set search_path = fecxc,oracle,dmap_extension,public;
alter table campos alter column campo set not null;
-- dmap_object_gen_tag : type : alter table name : campos
set search_path = fecxc,oracle,dmap_extension,public;
alter table campos alter column nombre set not null;
-- dmap_object_gen_tag : type : alter table name : campos
set search_path = fecxc,oracle,dmap_extension,public;
alter table campos alter column tipo set not null;
-- dmap_object_gen_tag : type : alter table name : campos
set search_path = fecxc,oracle,dmap_extension,public;
alter table campos alter column longitud set not null;
