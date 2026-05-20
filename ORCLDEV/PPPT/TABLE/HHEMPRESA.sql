-- dmap_object_gen_tag : type : table name : hhempresa
set search_path = pppt,oracle,dmap_extension,public;
create table "hhempresa"  (
idempresa numeric(38) not null default 0,
empresa varchar(255) not null,
contacto varchar(255),
emailcontacto varchar(50),
tel varchar(50),
notas varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : hhempresa
set search_path = pppt,oracle,dmap_extension,public;
alter table hhempresa alter column idempresa set not null;
-- dmap_object_gen_tag : type : alter table name : hhempresa
set search_path = pppt,oracle,dmap_extension,public;
alter table hhempresa alter column empresa set not null;
