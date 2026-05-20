-- dmap_object_gen_tag : type : table name : xxcofidi_paginacion_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_paginacion_ct_tab"  (
id_paginacion_pk numeric(38) not null,
pagina numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_paginacion_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_paginacion_ct_tab add constraint xxcofidi_paginacion_pk_idx01 primary key (id_paginacion_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_paginacion_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_paginacion_ct_tab alter column id_paginacion_pk set not null;
