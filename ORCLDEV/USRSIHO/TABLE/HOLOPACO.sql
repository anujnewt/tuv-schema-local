-- dmap_object_gen_tag : type : table name : holopaco
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holopaco"  (
pac_keytco varchar(6) not null,
pac_keyvar numeric(5) not null,
pac_desvar varchar(40),
pac_select varchar(250) not null,
pac_varwor varchar(20) not null,
pac_tipdat varchar(1) not null,
pac_nalias varchar(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : holopaco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopaco add constraint pk_hpaco primary key (pac_keytco,pac_keyvar);
-- dmap_object_gen_tag : type : alter table name : holopaco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopaco alter column pac_select set not null;
-- dmap_object_gen_tag : type : alter table name : holopaco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopaco alter column pac_varwor set not null;
-- dmap_object_gen_tag : type : alter table name : holopaco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopaco alter column pac_tipdat set not null;
-- dmap_object_gen_tag : type : alter table name : holopaco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopaco alter column pac_nalias set not null;
