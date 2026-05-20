-- dmap_object_gen_tag : type : table name : det_compara
set search_path = labppto,oracle,dmap_extension,public;
create table "det_compara"  (
id_comp numeric(38) not null,
cve_cuenta varchar(20),
importe decimal(14, 2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : det_compara
set search_path = labppto,oracle,dmap_extension,public;
alter table det_compara alter column id_comp set not null;
-- dmap_object_gen_tag : type : alter table name : det_compara
set search_path = labppto,oracle,dmap_extension,public;
alter table det_compara alter column importe set not null;
