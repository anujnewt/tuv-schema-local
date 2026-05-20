-- dmap_object_gen_tag : type : table name : holodetp2
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holodetp2"  (
det_keypol numeric(10) not null,
det_keyfol numeric(6),
det_cuenta varchar(40) not null,
det_cargos decimal(16, 6),
det_abonos decimal(16, 6),
det_keypue varchar(16),
det_caietu numeric(10),
det_sec_sindical varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : holodetp2
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodetp2 alter column det_keypol set not null;
-- dmap_object_gen_tag : type : alter table name : holodetp2
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodetp2 alter column det_cuenta set not null;
