-- dmap_object_gen_tag : type : table name : fecxc_det_catalogos
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_det_catalogos"  (
cod_sec_tipcat numeric(38) not null,
cod_sec_lin numeric(38) not null,
tipo_cat varchar(10) not null,
cod_valor varchar(10) not null,
desc_valor varchar(100) not null,
rep_edit_ext numeric(2)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_catalogos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_catalogos add constraint pk_fecxc_det_catalogos primary key (cod_sec_tipcat,cod_sec_lin);
-- dmap_object_gen_tag : type : alter table name : fecxc_det_catalogos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_catalogos alter column cod_sec_tipcat set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_catalogos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_catalogos alter column cod_sec_lin set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_catalogos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_catalogos alter column tipo_cat set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_catalogos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_catalogos alter column cod_valor set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_catalogos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_catalogos alter column desc_valor set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_catalogos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_catalogos add constraint fk_fecxc_de_cat_enc_d_fecxc_en foreign key (cod_sec_tipcat) references fecxc_enc_catalogos(cod_sec_tipcat) on delete no action not deferrable initially immediate;
