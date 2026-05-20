-- dmap_object_gen_tag : type : table name : isnentidades
set search_path = labprod,oracle,dmap_extension,public;
create table "isnentidades"  (
id numeric(10) not null,
ent_keyent varchar(2),
ent_desent varchar(70),
ent_porcen decimal(8, 2),
ent_poradi decimal(8, 2),
ent_keytab varchar(3),
ent_limeda numeric(4),
ent_anio numeric(4)
) ;
-- dmap_object_gen_tag : type : alter table name : isnentidades
set search_path = labprod,oracle,dmap_extension,public;
alter table isnentidades alter column id set not null;
