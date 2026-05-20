-- dmap_object_gen_tag : type : table name : nmlodcem
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlodcem"  (
dce_keyemp numeric(38) not null,
dce_keycia varchar(5) not null,
dce_keyper varchar(7) not null,
dce_keydep varchar(16),
dce_keyloc varchar(16),
dce_mesini numeric(38) not null,
dce_mesfin numeric(38) not null,
dce_regrfc varchar(13) not null,
dce_recurp varchar(18),
dce_apepat varchar(30) not null,
dce_apemat varchar(30),
dce_nombre varchar(30) not null,
dce_aregeo varchar(2) not null,
dce_calanu varchar(2) not null,
dce_sindic varchar(2) not null,
dce_asimil varchar(2) not null,
dce_fedent varchar(2) not null,
dce_rfc001 varchar(13),
dce_rfc002 varchar(13),
dce_rfc003 varchar(13),
dce_apovol decimal(16, 2),
dce_apoapl varchar(1),
dce_apoded decimal(16, 2),
dce_apopat decimal(16, 2),
dce_percep decimal(16, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : nmlodcem
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodcem alter column dce_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcem
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodcem alter column dce_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcem
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodcem alter column dce_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcem
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodcem alter column dce_mesini set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcem
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodcem alter column dce_mesfin set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcem
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodcem alter column dce_regrfc set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcem
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodcem alter column dce_apepat set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcem
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodcem alter column dce_nombre set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcem
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodcem alter column dce_aregeo set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcem
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodcem alter column dce_calanu set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcem
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodcem alter column dce_sindic set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcem
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodcem alter column dce_asimil set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcem
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodcem alter column dce_fedent set not null;
