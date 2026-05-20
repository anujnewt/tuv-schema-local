-- dmap_object_gen_tag : type : table name : xxcofidi_bitacora_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_bitacora_tab"  (
id_bitacora_pk numeric(38) not null,
fec_evento timestamp,
evento varchar(20),
id_usuario_fk numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_bitacora_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_bitacora_tab add constraint xxcofidi_bitacora_pk_idx01 primary key (id_bitacora_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_bitacora_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_bitacora_tab alter column id_bitacora_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_bitacora_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_bitacora_tab add constraint xxcofidi_bitacora_usu_fk_idx01 foreign key (id_usuario_fk) references xxcofidi_usuario_tab(id_usuario_pk) on delete no action not deferrable initially immediate;
