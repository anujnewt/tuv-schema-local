-- dmap_object_gen_tag : type : table name : fecxc_inpc
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_inpc"  (
sec_inpc numeric(38) not null,
ano_inpc numeric(38) not null,
mes_inpc numeric(38) not null,
inpc_estimado decimal(20, 11) not null,
inpc_actual decimal(20, 11) not null,
inpc_factorac decimal(20, 11) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_inpc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_inpc add constraint pk_fecxc_inpc primary key (sec_inpc);
-- dmap_object_gen_tag : type : alter table name : fecxc_inpc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_inpc alter column sec_inpc set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_inpc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_inpc alter column ano_inpc set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_inpc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_inpc alter column mes_inpc set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_inpc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_inpc alter column inpc_estimado set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_inpc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_inpc alter column inpc_actual set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_inpc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_inpc alter column inpc_factorac set not null;
