-- dmap_object_gen_tag : type : table name : detalleparametros
set search_path = labppto,oracle,dmap_extension,public;
create table "detalleparametros"  (
iddetalle numeric(10) not null,
enq_keyrep varchar(16) not null,
orden numeric(10) not null,
descripcionparametro varchar(50) not null
) ;
-- dmap_object_gen_tag : type : alter table name : detalleparametros
set search_path = labppto,oracle,dmap_extension,public;
alter table detalleparametros add constraint pk_detalleparametros primary key (iddetalle);
-- dmap_object_gen_tag : type : alter table name : detalleparametros
set search_path = labppto,oracle,dmap_extension,public;
alter table detalleparametros alter column iddetalle set not null;
-- dmap_object_gen_tag : type : alter table name : detalleparametros
set search_path = labppto,oracle,dmap_extension,public;
alter table detalleparametros alter column enq_keyrep set not null;
-- dmap_object_gen_tag : type : alter table name : detalleparametros
set search_path = labppto,oracle,dmap_extension,public;
alter table detalleparametros alter column orden set not null;
-- dmap_object_gen_tag : type : alter table name : detalleparametros
set search_path = labppto,oracle,dmap_extension,public;
alter table detalleparametros alter column descripcionparametro set not null;
