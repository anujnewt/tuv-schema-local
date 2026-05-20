-- dmap_object_gen_tag : type : table name : emmenace
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emmenace"  (
alm_klogin numeric(10) not null,
alm_knuobj numeric(10) not null,
alm_tipmov varchar(4) not null,
alm_tipacc varchar(1),
alm_valor varchar(1),
alm_padre numeric(5) not null,
alm_orden numeric(5) not null,
alm_tipmen varchar(1) not null,
alm_tipobj varchar(4) not null,
alm_descor varchar(20) not null
) ;
-- dmap_object_gen_tag : type : alter table name : emmenace
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmenace alter column alm_klogin set not null;
-- dmap_object_gen_tag : type : alter table name : emmenace
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmenace alter column alm_knuobj set not null;
-- dmap_object_gen_tag : type : alter table name : emmenace
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmenace alter column alm_tipmov set not null;
-- dmap_object_gen_tag : type : alter table name : emmenace
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmenace alter column alm_padre set not null;
-- dmap_object_gen_tag : type : alter table name : emmenace
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmenace alter column alm_orden set not null;
-- dmap_object_gen_tag : type : alter table name : emmenace
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmenace alter column alm_tipmen set not null;
-- dmap_object_gen_tag : type : alter table name : emmenace
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmenace alter column alm_tipobj set not null;
-- dmap_object_gen_tag : type : alter table name : emmenace
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmenace alter column alm_descor set not null;
