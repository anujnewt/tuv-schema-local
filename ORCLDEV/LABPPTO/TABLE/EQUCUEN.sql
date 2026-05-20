-- dmap_object_gen_tag : type : table name : equcuen
set search_path = labppto,oracle,dmap_extension,public;
create table "equcuen"  (
equ_cnomina varchar(3) not null,
equ_cdeptal varchar(6) not null,
equ_cdescri varchar(60) not null
) ;
-- dmap_object_gen_tag : type : alter table name : equcuen
set search_path = labppto,oracle,dmap_extension,public;
alter table equcuen alter column equ_cnomina set not null;
-- dmap_object_gen_tag : type : alter table name : equcuen
set search_path = labppto,oracle,dmap_extension,public;
alter table equcuen alter column equ_cdeptal set not null;
-- dmap_object_gen_tag : type : alter table name : equcuen
set search_path = labppto,oracle,dmap_extension,public;
alter table equcuen alter column equ_cdescri set not null;
