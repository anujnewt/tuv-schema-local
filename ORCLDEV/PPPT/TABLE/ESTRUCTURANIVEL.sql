-- dmap_object_gen_tag : type : table name : estructuranivel
set search_path = pppt,oracle,dmap_extension,public;
create table "estructuranivel"  (
idestructuranivel numeric(38) not null,
estructuranivel varchar(50) not null,
nivel numeric(38) not null default 0,
usaclave numeric(38) not null default 0,
idempresa numeric(38) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : estructuranivel
set search_path = pppt,oracle,dmap_extension,public;
alter table estructuranivel alter column idestructuranivel set not null;
-- dmap_object_gen_tag : type : alter table name : estructuranivel
set search_path = pppt,oracle,dmap_extension,public;
alter table estructuranivel alter column estructuranivel set not null;
-- dmap_object_gen_tag : type : alter table name : estructuranivel
set search_path = pppt,oracle,dmap_extension,public;
alter table estructuranivel alter column nivel set not null;
-- dmap_object_gen_tag : type : alter table name : estructuranivel
set search_path = pppt,oracle,dmap_extension,public;
alter table estructuranivel alter column usaclave set not null;
-- dmap_object_gen_tag : type : alter table name : estructuranivel
set search_path = pppt,oracle,dmap_extension,public;
alter table estructuranivel alter column idempresa set not null;
