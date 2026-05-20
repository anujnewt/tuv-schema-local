-- dmap_object_gen_tag : type : table name : emtabulador
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emtabulador"  (
tab_keytab numeric(10) not null,
tab_keypue varchar(16) not null,
tab_monto decimal(18, 2) not null,
tab_fecini timestamp(0),
tab_fecfin timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : emtabulador
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emtabulador alter column tab_keytab set not null;
-- dmap_object_gen_tag : type : alter table name : emtabulador
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emtabulador alter column tab_keypue set not null;
-- dmap_object_gen_tag : type : alter table name : emtabulador
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emtabulador alter column tab_monto set not null;
