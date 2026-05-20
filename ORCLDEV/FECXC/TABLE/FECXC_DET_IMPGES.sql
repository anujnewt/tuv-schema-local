-- dmap_object_gen_tag : type : table name : fecxc_det_impges
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_det_impges"  (
e_codigo numeric(38) not null,
cod_sec_importa numeric(38) not null,
n_linea numeric(38) not null,
cod_sec_catclas numeric(38),
cod_sec_det numeric(38),
importe decimal(20, 2) not null,
f_ingreso timestamp(0) not null,
reference_1 varchar(10),
reference_2 varchar(10),
reference_3 varchar(30),
reference_4 varchar(150),
segmento1 numeric(38),
segmento2 numeric(38),
segmento3 numeric(38),
segmento4 numeric(38),
segmento5 numeric(38),
segmento6 numeric(38),
segmento7 numeric(38),
segmento8 numeric(38),
segmento9 numeric(38),
segmento10 numeric(38),
codcps varchar(30)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_impges add constraint pk_fecxc_det_impges primary key (e_codigo,cod_sec_importa,n_linea);
-- dmap_object_gen_tag : type : alter table name : fecxc_det_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_impges alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_impges alter column cod_sec_importa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_impges alter column n_linea set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_impges alter column importe set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_impges alter column f_ingreso set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_impges add constraint fk_fecxc foreign key (cod_sec_catclas,cod_sec_det) references fecxc_det_clasfecxc(cod_sec_catclas,cod_sec_det) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_impges add constraint fk_fecxc_de_enc foreign key (e_codigo,cod_sec_importa) references fecxc_enc_impges(e_codigo,cod_sec_importa) on delete cascade not deferrable initially immediate;
