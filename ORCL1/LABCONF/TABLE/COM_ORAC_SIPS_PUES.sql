-- dmap_object_gen_tag : type : table name : com_orac_sips_pues
set search_path = labconf,oracle,dmap_extension,public;
create table "com_orac_sips_pues"  (
ora_noctvo numeric(38) not null,
pue_keypue varchar(16),
pue_despue varchar(60),
pue_refcon varchar(20),
pue_nu1aux varchar(10),
pue_nu2aux varchar(10),
pue_nu3aux varchar(10),
pue_nu4aux varchar(10),
pue_nu5aux varchar(10),
pue_ca1aux varchar(10),
pue_ca2aux varchar(10),
pue_ca3aux varchar(10),
pue_ca4aux varchar(10),
pue_ca5aux varchar(10),
pue_sueniv numeric(38),
pue_subniv numeric(38),
pue_keysue varchar(4),
pue_cobert varchar(2),
pue_arepue varchar(6),
pue_subare varchar(6),
pue_nivpue numeric(38),
pue_grppue varchar(16),
pue_subgrp varchar(16),
pue_tippue varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : com_orac_sips_pues
set search_path = labconf,oracle,dmap_extension,public;
alter table com_orac_sips_pues alter column ora_noctvo set not null;
