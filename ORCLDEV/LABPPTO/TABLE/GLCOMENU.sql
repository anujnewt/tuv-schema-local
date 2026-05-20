-- dmap_object_gen_tag : type : table name : glcomenu
set search_path = labppto,oracle,dmap_extension,public;
create table "glcomenu"  (
men_keymen varchar(4) not null,
men_ideniv numeric(5),
men_numsec numeric(5),
men_gpomen varchar(4),
men_tipmen varchar(1),
men_permis numeric(5),
men_mengpo varchar(4),
men_keybin varchar(8),
men_perfil varchar(40),
men_descri varchar(35),
men_modulo varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : glcomenu
set search_path = labppto,oracle,dmap_extension,public;
alter table glcomenu alter column men_keymen set not null;
