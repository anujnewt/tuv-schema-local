-- dmap_object_gen_tag : type : table name : fecxc_dep_especiales_d
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_dep_especiales_d"  (
secuencia_det_dep_esp numeric(38) not null,
secuencia_dep_especiales numeric(38) not null,
code_combination numeric(38),
importe_linea decimal(20, 4),
ora_soin_segmento1 varchar(25),
ora_soin_segmento2 varchar(25),
ora_soin_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_dep_especiales_d
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_dep_especiales_d alter column secuencia_det_dep_esp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_dep_especiales_d
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_dep_especiales_d alter column secuencia_dep_especiales set not null;
