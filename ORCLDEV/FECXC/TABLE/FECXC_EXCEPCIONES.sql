-- dmap_object_gen_tag : type : table name : fecxc_excepciones
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_excepciones"  (
e_codigo numeric(38) not null,
fecha_excepcion timestamp(0) not null,
dia_excepcion numeric(38),
hora_excepcion varchar(5)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_excepciones
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_excepciones add constraint pk_fecxc_excepciones primary key (e_codigo,fecha_excepcion);
-- dmap_object_gen_tag : type : alter table name : fecxc_excepciones
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_excepciones alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_excepciones
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_excepciones alter column fecha_excepcion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_excepciones
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_excepciones add constraint fk_fecxc_ex_excepxemp_fecxc_em foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
