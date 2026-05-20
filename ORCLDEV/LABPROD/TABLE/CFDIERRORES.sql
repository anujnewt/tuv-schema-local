-- dmap_object_gen_tag : type : table name : cfdierrores
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdierrores"  (
iderror numeric(38) not null,
idcomprobanteemp numeric(38) not null,
com_tiperr numeric(38) not null,
com_keyerr varchar(10),
com_descrip varchar(250)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdierrores
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdierrores add constraint cfdierrores_pk primary key (iderror);
-- dmap_object_gen_tag : type : alter table name : cfdierrores
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdierrores alter column iderror set not null;
-- dmap_object_gen_tag : type : alter table name : cfdierrores
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdierrores alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdierrores
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdierrores alter column com_tiperr set not null;
