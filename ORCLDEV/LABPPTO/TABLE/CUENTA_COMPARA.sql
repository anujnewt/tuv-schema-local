-- dmap_object_gen_tag : type : table name : cuenta_compara
set search_path = labppto,oracle,dmap_extension,public;
create table "cuenta_compara"  (
cve_cuenta numeric(38) not null,
des_cta varchar(60)
) ;
-- dmap_object_gen_tag : type : alter table name : cuenta_compara
set search_path = labppto,oracle,dmap_extension,public;
alter table cuenta_compara alter column cve_cuenta set not null;
