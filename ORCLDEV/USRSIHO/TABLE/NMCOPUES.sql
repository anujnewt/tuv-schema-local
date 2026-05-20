-- dmap_object_gen_tag : type : table name : nmcopues
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmcopues"  (
pue_keypue varchar(16),
pue_despue varchar(40),
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
pue_sueniv numeric(10),
pue_subniv numeric(10),
pue_keysue varchar(4),
pue_cobert varchar(2),
pue_arepue varchar(6),
pue_subare varchar(6),
pue_nivpue numeric(10),
pue_grppue varchar(16),
pue_subgrp varchar(16),
pue_tippue varchar(2)
) ;
