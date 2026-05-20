-- dmap_object_gen_tag : type : table name : fecxc_cob_canal_deldia
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_cob_canal_deldia"  (
e_codigo numeric(38),
segmento numeric(38),
codmoneda varchar(3),
mes numeric(38),
cobranza_dia decimal(20, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_cob_canal_deldia
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_cob_canal_deldia add constraint fk_fecxc_co_cn_cobdia_fecxc_em foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
