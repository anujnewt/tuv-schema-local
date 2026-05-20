-- dmap_object_gen_tag : type : table name : fecxc_cat_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_cat_xempresa"  (
e_codigo numeric(38) not null,
cod_nivel numeric(38) not null,
cod_sec_tipcat numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_cat_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_cat_xempresa add constraint pk_fecxc_cat_xempresa primary key (e_codigo,cod_nivel);
-- dmap_object_gen_tag : type : alter table name : fecxc_cat_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_cat_xempresa alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_cat_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_cat_xempresa alter column cod_nivel set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_cat_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_cat_xempresa add constraint fk_fecxc_ca_cat_det_c_fecxc_en foreign key (cod_sec_tipcat) references fecxc_enc_catalogos(cod_sec_tipcat) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : fecxc_cat_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_cat_xempresa add constraint fk_fecxc_ca_emp_cat_c_fecxc_em foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
