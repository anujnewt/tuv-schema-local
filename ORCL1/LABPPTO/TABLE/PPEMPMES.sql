-- dmap_object_gen_tag : type : table name : ppempmes
set search_path = labppto,oracle,dmap_extension,public;
create table "ppempmes"  (
emm_keycia varchar(4) not null,
emm_keyver numeric(38) not null,
emm_mes numeric(38) not null,
emm_keyemp numeric(38) not null,
emm_nomemp varchar(75) not null,
emm_keycen varchar(16) not null,
emm_keypue varchar(16) not null,
emm_fecing timestamp(0) not null,
emm_tipemp varchar(6) not null,
emm_keypro numeric(38) not null,
emm_cvezon numeric(38),
emm_keyloc varchar(16),
emm_status numeric(38),
emm_keyplz numeric(38) not null,
emm_mesbaj numeric(38),
emm_ciaorg varchar(4),
emm_salmes decimal(12, 2),
emm_cccont varchar(20),
emm_iest varchar(6)
) ;
-- dmap_object_gen_tag : type : alter table name : ppempmes
set search_path = labppto,oracle,dmap_extension,public;
alter table ppempmes alter column emm_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : ppempmes
set search_path = labppto,oracle,dmap_extension,public;
alter table ppempmes alter column emm_keyver set not null;
-- dmap_object_gen_tag : type : alter table name : ppempmes
set search_path = labppto,oracle,dmap_extension,public;
alter table ppempmes alter column emm_mes set not null;
-- dmap_object_gen_tag : type : alter table name : ppempmes
set search_path = labppto,oracle,dmap_extension,public;
alter table ppempmes alter column emm_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : ppempmes
set search_path = labppto,oracle,dmap_extension,public;
alter table ppempmes alter column emm_nomemp set not null;
-- dmap_object_gen_tag : type : alter table name : ppempmes
set search_path = labppto,oracle,dmap_extension,public;
alter table ppempmes alter column emm_keycen set not null;
-- dmap_object_gen_tag : type : alter table name : ppempmes
set search_path = labppto,oracle,dmap_extension,public;
alter table ppempmes alter column emm_keypue set not null;
-- dmap_object_gen_tag : type : alter table name : ppempmes
set search_path = labppto,oracle,dmap_extension,public;
alter table ppempmes alter column emm_fecing set not null;
-- dmap_object_gen_tag : type : alter table name : ppempmes
set search_path = labppto,oracle,dmap_extension,public;
alter table ppempmes alter column emm_tipemp set not null;
-- dmap_object_gen_tag : type : alter table name : ppempmes
set search_path = labppto,oracle,dmap_extension,public;
alter table ppempmes alter column emm_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : ppempmes
set search_path = labppto,oracle,dmap_extension,public;
alter table ppempmes alter column emm_keyplz set not null;
