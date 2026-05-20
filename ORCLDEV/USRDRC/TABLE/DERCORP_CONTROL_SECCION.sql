-- dmap_object_gen_tag : type : table name : dercorp_control_seccion
set search_path = usrdrc,oracle,dmap_extension,public;
create table "dercorp_control_seccion"  (
id_user numeric(38) not null default 0,
id_empresa numeric(38) not null default 0,
id_seccion numeric(38) not null default 0,
status numeric(38) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : dercorp_control_seccion
set search_path = usrdrc,oracle,dmap_extension,public;
alter table dercorp_control_seccion add primary key (id_user);
-- dmap_object_gen_tag : type : alter table name : dercorp_control_seccion
set search_path = usrdrc,oracle,dmap_extension,public;
alter table dercorp_control_seccion alter column id_user set not null;
-- dmap_object_gen_tag : type : alter table name : dercorp_control_seccion
set search_path = usrdrc,oracle,dmap_extension,public;
alter table dercorp_control_seccion alter column id_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : dercorp_control_seccion
set search_path = usrdrc,oracle,dmap_extension,public;
alter table dercorp_control_seccion alter column id_seccion set not null;
-- dmap_object_gen_tag : type : alter table name : dercorp_control_seccion
set search_path = usrdrc,oracle,dmap_extension,public;
alter table dercorp_control_seccion alter column status set not null;
