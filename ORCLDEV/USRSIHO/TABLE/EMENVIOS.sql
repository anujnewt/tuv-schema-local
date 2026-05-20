-- dmap_object_gen_tag : type : table name : emenvios
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emenvios"  (
env_keyenv numeric(10) not null,
env_keydep varchar(16) not null,
env_feclla timestamp(0) not null,
env_fecreq timestamp(0) not null,
env_horlla varchar(5) not null,
env_keysta numeric(10) not null,
env_keyfor varchar(6) not null,
env_keyusu numeric(10) not null,
env_feccan timestamp(0),
env_usucan numeric(10),
env_notas varchar(200)
) ;
-- dmap_object_gen_tag : type : alter table name : emenvios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emenvios alter column env_keyenv set not null;
-- dmap_object_gen_tag : type : alter table name : emenvios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emenvios alter column env_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : emenvios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emenvios alter column env_feclla set not null;
-- dmap_object_gen_tag : type : alter table name : emenvios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emenvios alter column env_fecreq set not null;
-- dmap_object_gen_tag : type : alter table name : emenvios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emenvios alter column env_horlla set not null;
-- dmap_object_gen_tag : type : alter table name : emenvios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emenvios alter column env_keysta set not null;
-- dmap_object_gen_tag : type : alter table name : emenvios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emenvios alter column env_keyfor set not null;
-- dmap_object_gen_tag : type : alter table name : emenvios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emenvios alter column env_keyusu set not null;
