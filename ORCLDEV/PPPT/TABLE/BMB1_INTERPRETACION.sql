-- dmap_object_gen_tag : type : table name : bmb1_interpretacion
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb1_interpretacion"  (
idfactor numeric(38) not null,
nivel numeric(38) not null,
interpretacion varchar(255)
) ;
-- dmap_object_gen_tag : type : alter table name : bmb1_interpretacion
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_interpretacion alter column idfactor set not null;
-- dmap_object_gen_tag : type : alter table name : bmb1_interpretacion
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_interpretacion alter column nivel set not null;
