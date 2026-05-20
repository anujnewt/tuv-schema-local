-- dmap_object_gen_tag : type : table name : grupoentidad360
set search_path = pppt,oracle,dmap_extension,public;
create table "grupoentidad360"  (
idgrupoentidad numeric(38) not null default 0,
idgrupo numeric(38),
identidad numeric(38),
peso numeric(38),
tipoentidad numeric(38),
status numeric(38),
idrelacion numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : grupoentidad360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupoentidad360 alter column idgrupoentidad set not null;
