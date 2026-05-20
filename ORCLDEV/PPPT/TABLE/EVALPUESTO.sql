-- dmap_object_gen_tag : type : table name : evalpuesto
set search_path = pppt,oracle,dmap_extension,public;
create table "evalpuesto"  (
idpuesto numeric(38) not null,
idevaluacion numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : evalpuesto
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpuesto alter column idpuesto set not null;
-- dmap_object_gen_tag : type : alter table name : evalpuesto
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpuesto alter column idevaluacion set not null;
