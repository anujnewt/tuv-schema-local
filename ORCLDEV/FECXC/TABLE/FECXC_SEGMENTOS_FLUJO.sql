-- dmap_object_gen_tag : type : table name : fecxc_segmentos_flujo
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_segmentos_flujo"  (
id_segmento numeric(38) not null,
des_segmento varchar(80)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_segmentos_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_segmentos_flujo add constraint pk_fecxc_segmentos_flujo primary key (id_segmento);
-- dmap_object_gen_tag : type : alter table name : fecxc_segmentos_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_segmentos_flujo alter column id_segmento set not null;
