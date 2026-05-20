-- dmap_object_gen_tag : type : table name : tvincsaf
set search_path = labprod,oracle,dmap_extension,public;
create table "tvincsaf"  (
inc_keyemp numeric(10),
inc_cveref varchar(16),
inc_totsol decimal(16, 2),
inc_impdes decimal(16, 2),
inc_fecini varchar(16),
inc_impsal decimal(16, 2),
inc_unipre decimal(16, 2),
inc_unides decimal(16, 2),
inc_unisal decimal(16, 2),
inc_keycon varchar(4),
inc_persaf varchar(7),
inc_respue numeric(3),
inc_perlab varchar(7),
inc_keypro numeric(3),
inc_tipope numeric(3),
inc_fecmov timestamp(0)
) ;
