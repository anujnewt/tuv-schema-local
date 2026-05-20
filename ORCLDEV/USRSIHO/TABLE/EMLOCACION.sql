-- dmap_object_gen_tag : type : table name : emlocacion
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emlocacion"  (
loc_keyloc numeric(10) not null,
loc_keydep varchar(16) not null,
loc_fecha timestamp(0) not null,
loc_descri varchar(100) not null,
loc_import decimal(18, 2) not null,
loc_iva decimal(15, 2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : emlocacion
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emlocacion alter column loc_keyloc set not null;
-- dmap_object_gen_tag : type : alter table name : emlocacion
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emlocacion alter column loc_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : emlocacion
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emlocacion alter column loc_fecha set not null;
-- dmap_object_gen_tag : type : alter table name : emlocacion
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emlocacion alter column loc_descri set not null;
-- dmap_object_gen_tag : type : alter table name : emlocacion
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emlocacion alter column loc_import set not null;
-- dmap_object_gen_tag : type : alter table name : emlocacion
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emlocacion alter column loc_iva set not null;
