-- dmap_object_gen_tag : type : table name : xxchk_cat_edo_cheque
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_cat_edo_cheque"  (
e_codigo numeric(38) not null,
id_estado_cheque numeric(38) not null,
c_cargo_erp numeric(38),
c_abono_erp numeric(38),
c_cargo_soin varchar(4),
sc_cargo_soin varchar(4),
ssc_cargo_soin varchar(4),
cr_cargo_soin varchar(3),
cr_cargo_soin2 varchar(4),
c_abono_soin varchar(4),
sc_abono_soin varchar(4),
ssc_abono_soin varchar(4),
cr_abono_soin varchar(3),
cr_abono_soin2 varchar(4),
contabiliza numeric(1),
envia_correo numeric(1)
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_cat_edo_cheque
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cat_edo_cheque add constraint pk_xxchk_cat_edo_cheque primary key (e_codigo,id_estado_cheque);
-- dmap_object_gen_tag : type : alter table name : xxchk_cat_edo_cheque
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cat_edo_cheque alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cat_edo_cheque
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cat_edo_cheque alter column id_estado_cheque set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cat_edo_cheque
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cat_edo_cheque add constraint fk_xxchk_ca_fk_contab_xxchk_ca foreign key (id_estado_cheque) references xxchk_cat_edos(id_estado_cheque) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxchk_cat_edo_cheque
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cat_edo_cheque add constraint fk_xxchk_stachek_toemp foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
