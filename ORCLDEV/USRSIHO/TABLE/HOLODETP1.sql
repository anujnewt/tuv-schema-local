-- dmap_object_gen_tag : type : table name : holodetp1
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holodetp1"  (
det_keypol numeric(10) not null,
det_keyfol numeric(6) not null,
det_cuenta varchar(40) not null,
det_cargos decimal(16, 6),
det_abonos decimal(16, 6),
det_sec_sindical varchar(50) not null
) ;
-- dmap_object_gen_tag : type : alter table name : holodetp1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodetp1 add constraint pk_hdetp1 primary key (det_keypol,det_keyfol,det_cuenta,det_sec_sindical);
-- dmap_object_gen_tag : type : alter table name : holodetp1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodetp1 alter column det_keypol set not null;
-- dmap_object_gen_tag : type : alter table name : holodetp1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodetp1 alter column det_cuenta set not null;
