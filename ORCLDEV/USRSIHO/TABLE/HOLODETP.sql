-- dmap_object_gen_tag : type : table name : holodetp
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holodetp"  (
det_keypol numeric(10) not null,
det_cuenta varchar(40) not null,
det_cargos decimal(16, 2),
det_abonos decimal(16, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : holodetp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodetp add constraint pk_hdetp primary key (det_keypol,det_cuenta);
-- dmap_object_gen_tag : type : alter table name : holodetp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodetp alter column det_keypol set not null;
