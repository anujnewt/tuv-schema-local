-- dmap_object_gen_tag : type : table name : comparacionpersonal
set search_path = pppt,oracle,dmap_extension,public;
create table "comparacionpersonal"  (
idcomparacion numeric(38) not null,
idpersonal numeric(38) not null,
idpuesto0 numeric,
idpuesto1 numeric,
idpuesto2 numeric,
idpuesto3 numeric,
idpuesto4 numeric,
idpuesto5 numeric,
idpuesto6 numeric,
idpuesto7 numeric,
idpuesto8 numeric,
idpuesto9 numeric
) ;
-- dmap_object_gen_tag : type : alter table name : comparacionpersonal
set search_path = pppt,oracle,dmap_extension,public;
alter table comparacionpersonal alter column idcomparacion set not null;
-- dmap_object_gen_tag : type : alter table name : comparacionpersonal
set search_path = pppt,oracle,dmap_extension,public;
alter table comparacionpersonal alter column idpersonal set not null;
