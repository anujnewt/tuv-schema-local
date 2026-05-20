-- dmap_object_gen_tag : type : table name : nmpasinc
set search_path = labconf,oracle,dmap_extension,public;
create table "nmpasinc"  (
inc_keyusu numeric(38),
inc_feccap timestamp(0),
inc_keyemp numeric(38),
inc_keycon varchar(3),
inc_keycen varchar(16),
inc_keypue varchar(16),
inc_keycco varchar(16),
inc_cantid decimal(6, 2),
inc_import decimal(14, 4),
inc_keypro numeric(38),
inc_keyper varchar(7),
inc_costo decimal(14, 4),
inc_semana numeric(38),
inc_sempro varchar(50)
) ;
