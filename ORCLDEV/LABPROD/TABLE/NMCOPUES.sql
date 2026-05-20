-- dmap_object_gen_tag : type : table name : nmcopues
set search_path = labprod,oracle,dmap_extension,public;
create table "nmcopues"  (
pue_keypue varchar(16) not null,
pue_despue varchar(60) not null,
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
-- dmap_object_gen_tag : type : alter table name : nmcopues
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcopues add constraint nmpues01 unique (pue_keypue);
-- dmap_object_gen_tag : type : alter table name : nmcopues
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcopues alter column pue_keypue set not null;
-- dmap_object_gen_tag : type : alter table name : nmcopues
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcopues alter column pue_despue set not null;
