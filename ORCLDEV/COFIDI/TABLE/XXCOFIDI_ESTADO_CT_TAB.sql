-- dmap_object_gen_tag : type : table name : xxcofidi_estado_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_estado_ct_tab"  (
id_estado_pk numeric(38) not null,
estado varchar(50) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_estado_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_estado_ct_tab add constraint xxcofidi_estado_pk_idx01 primary key (id_estado_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_estado_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_estado_ct_tab alter column id_estado_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_estado_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_estado_ct_tab alter column estado set not null;
