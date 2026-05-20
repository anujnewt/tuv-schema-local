-- dmap_object_gen_tag : type : table name : fecxp_param_ext_mc
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_param_ext_mc"  (
diaeje numeric(38) not null default 1,
meseje numeric(38) not null default 0,
diaini numeric(38) not null default 1,
mesini numeric(38) not null default 0,
diafin numeric(38) not null default 1,
mesfin numeric(38) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_param_ext_mc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_param_ext_mc alter column diaeje set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_param_ext_mc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_param_ext_mc alter column meseje set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_param_ext_mc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_param_ext_mc alter column diaini set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_param_ext_mc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_param_ext_mc alter column mesini set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_param_ext_mc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_param_ext_mc alter column diafin set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_param_ext_mc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_param_ext_mc alter column mesfin set not null;
