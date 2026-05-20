-- dmap_object_gen_tag : type : table name : sccocoma
set search_path = labconf,oracle,dmap_extension,public;
create table "sccocoma"  (
com_keyplz numeric(5),
com_keyemp numeric(5),
com_fecmov timestamp(0),
com_tipmov varchar(2),
com_keyusu numeric(5),
com_feccap timestamp(0),
com_status varchar(2),
com_salcon decimal(12, 6),
com_keyims varchar(5)
) ;
