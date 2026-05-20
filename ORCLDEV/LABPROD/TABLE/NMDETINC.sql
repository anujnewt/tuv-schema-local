-- dmap_object_gen_tag : type : table name : nmdetinc
set search_path = labprod,oracle,dmap_extension,public;
create table "nmdetinc"  (
inc_cvedia varchar(2),
inc_keyusu numeric(38),
inc_keyemp numeric(38),
inc_keysem numeric(38),
inc_ccosto varchar(16),
inc_horent varchar(5),
inc_horsal varchar(5),
inc_concep varchar(3),
inc_fecha timestamp(0),
inc_horas decimal(5, 2),
inc_impor decimal(14, 2),
inc_cveinc varchar(2),
inc_keypro numeric(38),
inc_keyper varchar(7)
) ;
