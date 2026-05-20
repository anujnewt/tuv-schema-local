-- dmap_object_gen_tag : type : table name : emdetenvios
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emdetenvios"  (
det_keyenv numeric(10) not null,
det_keyemp numeric(10) not null,
det_keysta numeric(10) not null,
det_feccan timestamp(0),
det_usucan numeric(10),
det_fecreq timestamp(0) not null
) ;
-- dmap_object_gen_tag : type : alter table name : emdetenvios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emdetenvios add constraint pk_emdetenvios primary key (det_keyenv,det_keyemp);
-- dmap_object_gen_tag : type : alter table name : emdetenvios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emdetenvios alter column det_keyenv set not null;
-- dmap_object_gen_tag : type : alter table name : emdetenvios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emdetenvios alter column det_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : emdetenvios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emdetenvios alter column det_keysta set not null;
-- dmap_object_gen_tag : type : alter table name : emdetenvios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emdetenvios alter column det_fecreq set not null;
