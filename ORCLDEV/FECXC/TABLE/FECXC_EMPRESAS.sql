-- dmap_object_gen_tag : type : table name : fecxc_empresas
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_empresas"  (
e_codigo numeric(38) not null,
des_empresa varchar(100) not null,
tipoempresa varchar(2) not null,
permite_captura varchar(1),
tipopresup varchar(1),
cual_erp varchar(1),
e_codigo_soin varchar(5)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_empresas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_empresas add constraint pk_fecxc_empresas primary key (e_codigo);
-- dmap_object_gen_tag : type : alter table name : fecxc_empresas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_empresas add constraint ckc_cual_erp_fecxc_em check (cual_erp is null or ( cual_erp in ('O','S') ));
-- dmap_object_gen_tag : type : alter table name : fecxc_empresas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_empresas add constraint ckc_permite_captura_fecxc_em check (permite_captura is null or ( permite_captura in ('S','N') ));
-- dmap_object_gen_tag : type : alter table name : fecxc_empresas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_empresas add constraint ckc_tipoempresa_fecxc_em check (tipoempresa in ('GE','NG'));
-- dmap_object_gen_tag : type : alter table name : fecxc_empresas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_empresas add constraint ckc_tipopresup_fecxc_em check (tipopresup is null or ( tipopresup in ('M','D') ));
-- dmap_object_gen_tag : type : alter table name : fecxc_empresas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_empresas alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_empresas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_empresas alter column des_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_empresas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_empresas alter column tipoempresa set not null;
