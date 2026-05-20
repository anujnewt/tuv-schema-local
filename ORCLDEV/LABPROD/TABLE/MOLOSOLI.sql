-- dmap_object_gen_tag : type : table name : molosoli
set search_path = labprod,oracle,dmap_extension,public;
create table "molosoli"  (
sol_keyemp numeric(10) not null,
sol_keycon varchar(3) not null,
sol_fecini timestamp(0),
sol_horini varchar(8),
sol_fecfin timestamp(0),
sol_horfin varchar(8),
sol_numdia decimal(10, 2),
sol_status numeric(38),
sol_empaut numeric(38),
sol_depaut varchar(16),
sol_pueaut varchar(16),
sol_keyusu numeric(38),
sol_keymot varchar(3),
sol_fecper timestamp(0),
sol_observ varchar(250),
sol_keyhor varchar(16),
sol_keyrol numeric(10),
sol_fecmod timestamp(0),
sol_hormod varchar(8),
sol_keysol decimal(16, 6),
sol_trpaus decimal(16, 6),
sol_pernom varchar(7),
sol_conori varchar(3),
sol_numani numeric(10),
sol_keypro numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : molosoli
set search_path = labprod,oracle,dmap_extension,public;
alter table molosoli alter column sol_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : molosoli
set search_path = labprod,oracle,dmap_extension,public;
alter table molosoli alter column sol_keycon set not null;
