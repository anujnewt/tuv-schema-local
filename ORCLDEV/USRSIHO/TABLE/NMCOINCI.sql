-- dmap_object_gen_tag : type : table name : nmcoinci
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmcoinci"  (
inc_keyemp numeric(10),
inc_keycon varchar(3),
inc_keypro numeric(5),
inc_keyper varchar(7),
inc_keydep varchar(16),
inc_keypue varchar(16),
inc_fecmov timestamp(0),
inc_cantid decimal(16, 6),
inc_import decimal(12, 2),
inc_diauno decimal(12, 2),
inc_diados decimal(12, 2),
inc_diatre decimal(12, 2),
inc_diacua decimal(12, 2),
inc_diacin decimal(12, 2),
inc_diasei decimal(12, 2),
inc_diasie decimal(12, 2),
inc_keyinc decimal(16, 6),
inc_numfol numeric(10)
) ;
