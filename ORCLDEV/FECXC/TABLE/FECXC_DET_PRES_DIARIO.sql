-- dmap_object_gen_tag : type : table name : fecxc_det_pres_diario
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_det_pres_diario"  (
sec_presup numeric(38) not null,
sec_pres_dia numeric(38) not null,
diario timestamp(0) not null,
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
importe decimal(20, 2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_pres_diario
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_pres_diario add constraint pk_fecxc_det_pres_diario primary key (sec_presup,sec_pres_dia);
-- dmap_object_gen_tag : type : alter table name : fecxc_det_pres_diario
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_pres_diario alter column sec_presup set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_pres_diario
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_pres_diario alter column sec_pres_dia set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_pres_diario
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_pres_diario alter column diario set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_pres_diario
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_pres_diario alter column importe set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_pres_diario
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_pres_diario add constraint fk_det_pres_det_p foreign key (sec_presup) references fecxc_enc_de_presu(sec_presup) on delete no action not deferrable initially immediate;
