-- dmap_object_gen_tag : type : table name : fecxc_valores_nivxemp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_valores_nivxemp"  (
e_codigo numeric(38) not null,
cod_nivel numeric(38) not null,
cod_sec_tipcat numeric(38) not null,
cod_sec_lin numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_valores_nivxemp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_valores_nivxemp add constraint pk_fecxc_valores_nivxemp primary key (cod_sec_tipcat,e_codigo,cod_nivel,cod_sec_lin);
-- dmap_object_gen_tag : type : alter table name : fecxc_valores_nivxemp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_valores_nivxemp alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_valores_nivxemp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_valores_nivxemp alter column cod_nivel set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_valores_nivxemp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_valores_nivxemp alter column cod_sec_tipcat set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_valores_nivxemp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_valores_nivxemp alter column cod_sec_lin set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_valores_nivxemp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_valores_nivxemp add constraint fk_fecxc_va_valores_c_fecxc_de foreign key (cod_sec_tipcat,cod_sec_lin) references fecxc_det_catalogos(cod_sec_tipcat,cod_sec_lin) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : fecxc_valores_nivxemp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_valores_nivxemp add constraint fk_fecxc_va_valores_n_fecxc_ca foreign key (e_codigo,cod_nivel) references fecxc_cat_xempresa(e_codigo,cod_nivel) on delete no action not deferrable initially immediate;
