-- dmap_object_gen_tag : type : table name : fecxc_caninter_xmes_cob_act
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_caninter_xmes_cob_act"  (
e_codigo numeric(38),
segmento numeric(38),
canal numeric(38),
codmoneda varchar(3),
mes numeric(38),
cobranza_mes decimal(20, 4)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_caninter_xmes_cob_act
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_caninter_xmes_cob_act add constraint fk_fecxc_ca_it_cobact_fecxc_em foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
