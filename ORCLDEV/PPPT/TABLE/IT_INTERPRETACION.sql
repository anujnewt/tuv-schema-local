-- dmap_object_gen_tag : type : table name : it_interpretacion
set search_path = pppt,oracle,dmap_extension,public;
create table "it_interpretacion"  (
ci numeric(38) not null,
interpretacion varchar(100),
interpretacionppp varchar(50),
interpretacioncorta varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : it_interpretacion
set search_path = pppt,oracle,dmap_extension,public;
alter table it_interpretacion alter column ci set not null;
