-- dmap_object_gen_tag : type : table name : inlogpos
set search_path = labprod,oracle,dmap_extension,public;
create table "inlogpos"  (
gpo_keygpo numeric(5),
gpo_keycur varchar(8),
gpo_fecini timestamp(0),
gpo_fecfin timestamp(0),
gpo_tipfte varchar(1),
gpo_rfcfte varchar(14),
gpo_nomfte varchar(40),
gpo_keyemp numeric(5),
gpo_cupcur numeric(5),
gpo_obs001 varchar(50),
gpo_obs002 varchar(50),
gpo_obs003 varchar(50),
gpo_cos001 decimal(10, 2),
gpo_cos002 decimal(10, 2),
gpo_cos003 decimal(10, 2),
gpo_status varchar(2),
gpo_fecsta timestamp(0),
gpo_keypgr numeric(5),
gpo_cveemp varchar(2),
gpo_numpla numeric(5),
gpo_numeta numeric(5),
gpo_rfcins varchar(13)
) ;
