-- dmap_object_gen_tag : type : table name : fecxc_cobranza_anterior
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_cobranza_anterior"  (
e_codigo numeric(38),
segmento numeric(38),
codmoneda varchar(3),
cobranza_anterior decimal(20, 4),
cobranzareal_anterior decimal(20, 4)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_cobranza_anterior
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_cobranza_anterior add constraint fk_fecxc_co_tv_cobant_fecxc_em foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
