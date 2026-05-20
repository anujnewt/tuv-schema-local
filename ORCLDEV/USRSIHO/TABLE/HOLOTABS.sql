-- dmap_object_gen_tag : type : table name : holotabs
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holotabs"  (
tab_keypro numeric(5) not null,
tab_keytab varchar(6) not null,
tab_keypue varchar(16) not null,
tab_pertra varchar(6) not null,
tab_idioma varchar(6) not null,
tab_keynac varchar(6) not null,
tab_import decimal(16, 2) not null,
tab_fecini timestamp(0) not null,
tab_fecfin timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : holotabs
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holotabs add constraint pk_htabs primary key (tab_keypro,tab_keytab,tab_keypue,tab_pertra,tab_idioma,tab_keynac,tab_fecini);
-- dmap_object_gen_tag : type : alter table name : holotabs
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holotabs alter column tab_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : holotabs
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holotabs alter column tab_keytab set not null;
-- dmap_object_gen_tag : type : alter table name : holotabs
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holotabs alter column tab_keypue set not null;
-- dmap_object_gen_tag : type : alter table name : holotabs
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holotabs alter column tab_pertra set not null;
-- dmap_object_gen_tag : type : alter table name : holotabs
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holotabs alter column tab_idioma set not null;
-- dmap_object_gen_tag : type : alter table name : holotabs
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holotabs alter column tab_keynac set not null;
-- dmap_object_gen_tag : type : alter table name : holotabs
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holotabs alter column tab_import set not null;
