-- dmap_object_gen_tag : type : table name : eolosolc
set search_path = labconf,oracle,dmap_extension,public;
create table "eolosolc"  (
sol_keysol numeric(10) not null,
sol_keyest varchar(3) not null,
sol_keydep varchar(16) not null,
sol_keypue varchar(16),
sol_keypro numeric(5),
sol_keyusu numeric(10),
sol_tipplz varchar(3) not null,
sol_tipcon varchar(1) not null,
sol_contra varchar(3) not null,
sol_canpla numeric(5),
sol_cansol numeric(5),
sol_canaut numeric(5),
sol_fecini timestamp(0),
sol_fecfin timestamp(0),
sol_fecpla timestamp(0),
sol_fecsol timestamp(0),
sol_fecaut timestamp(0),
sol_status varchar(1),
sol_keysue varchar(4),
sol_tiptab varchar(2),
sol_sueniv numeric(10),
sol_subniv numeric(10),
sol_cobert varchar(2),
sol_unimed varchar(1),
sol_canmed decimal(14, 2),
sol_estman varchar(1),
sol_ca1aux varchar(10),
sol_ca2aux varchar(10),
sol_ca3aux varchar(10),
sol_ca4aux varchar(10),
sol_ca5aux varchar(10),
sol_ca6aux varchar(10),
sol_ca7aux varchar(10),
sol_ca8aux varchar(10),
sol_cantid numeric(5)
) ;
-- dmap_object_gen_tag : type : alter table name : eolosolc
set search_path = labconf,oracle,dmap_extension,public;
alter table eolosolc alter column sol_keysol set not null;
-- dmap_object_gen_tag : type : alter table name : eolosolc
set search_path = labconf,oracle,dmap_extension,public;
alter table eolosolc alter column sol_keyest set not null;
-- dmap_object_gen_tag : type : alter table name : eolosolc
set search_path = labconf,oracle,dmap_extension,public;
alter table eolosolc alter column sol_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : eolosolc
set search_path = labconf,oracle,dmap_extension,public;
alter table eolosolc alter column sol_tipplz set not null;
-- dmap_object_gen_tag : type : alter table name : eolosolc
set search_path = labconf,oracle,dmap_extension,public;
alter table eolosolc alter column sol_tipcon set not null;
-- dmap_object_gen_tag : type : alter table name : eolosolc
set search_path = labconf,oracle,dmap_extension,public;
alter table eolosolc alter column sol_contra set not null;
