-- dmap_object_gen_tag : type : table name : emjoinst
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emjoinst"  (
joi_keyjoi numeric(10) not null,
joi_keyta1 numeric(10) not null,
joi_keyta2 numeric(10) not null,
joi_joins1 varchar(255),
joi_joins2 varchar(255)
) ;
-- dmap_object_gen_tag : type : alter table name : emjoinst
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emjoinst add constraint pk_emjoinst primary key (joi_keyjoi);
-- dmap_object_gen_tag : type : alter table name : emjoinst
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emjoinst alter column joi_keyjoi set not null;
-- dmap_object_gen_tag : type : alter table name : emjoinst
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emjoinst alter column joi_keyta1 set not null;
-- dmap_object_gen_tag : type : alter table name : emjoinst
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emjoinst alter column joi_keyta2 set not null;
