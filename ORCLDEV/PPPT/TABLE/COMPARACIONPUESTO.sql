-- dmap_object_gen_tag : type : table name : comparacionpuesto
set search_path = pppt,oracle,dmap_extension,public;
create table "comparacionpuesto"  (
idcomparacion numeric(38) not null,
idpuesto numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : comparacionpuesto
set search_path = pppt,oracle,dmap_extension,public;
alter table comparacionpuesto alter column idcomparacion set not null;
-- dmap_object_gen_tag : type : alter table name : comparacionpuesto
set search_path = pppt,oracle,dmap_extension,public;
alter table comparacionpuesto alter column idpuesto set not null;
