-- dmap_object_gen_tag : type : table name : emdetbit
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emdetbit"  (
det_keybit numeric(10) not null,
det_tabla varchar(20) not null,
det_campo varchar(20) not null,
det_valact varchar(100),
det_valant varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : emdetbit
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emdetbit alter column det_keybit set not null;
-- dmap_object_gen_tag : type : alter table name : emdetbit
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emdetbit alter column det_tabla set not null;
-- dmap_object_gen_tag : type : alter table name : emdetbit
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emdetbit alter column det_campo set not null;
