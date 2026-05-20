-- dmap_object_gen_tag : type : table name : fecxc_det_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_det_clasfecxc"  (
cod_sec_catclas numeric(38) not null,
cod_sec_det numeric(38) not null,
tipo_linea varchar(30),
codclasif varchar(10) not null,
cod_subclasif varchar(10) not null,
sub_descrip varchar(40) not null,
nopara_flujo numeric(38) not null,
excluir_enreportes varchar(2) default 'NO'
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_clasfecxc add constraint pk_fecxc_det_clasfecxc primary key (cod_sec_catclas,cod_sec_det);
-- dmap_object_gen_tag : type : alter table name : fecxc_det_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_clasfecxc add constraint ckc_excluir_enreporte_fecxc_de check (excluir_enreportes is null or ( excluir_enreportes in ('SI','NO') ));
-- dmap_object_gen_tag : type : alter table name : fecxc_det_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_clasfecxc add constraint ckc_nopara_flujo_fecxc_de check (nopara_flujo in (0,1,2));
-- dmap_object_gen_tag : type : alter table name : fecxc_det_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_clasfecxc add constraint ckc_tiplin check (tipo_linea is null or ( tipo_linea in ('IMPUESTO','BASE','OTROS','DNI','INTERCAMBIOS','COBVIRTUAL','RECLASIFICACIONES','TRASPASOS','OTROS_INGRESOS','INTERESES','FILLER_UNO','FILLER_DOS') ));
-- dmap_object_gen_tag : type : alter table name : fecxc_det_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_clasfecxc alter column cod_sec_catclas set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_clasfecxc alter column cod_sec_det set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_clasfecxc alter column codclasif set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_clasfecxc alter column cod_subclasif set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_clasfecxc alter column sub_descrip set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_clasfecxc alter column nopara_flujo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_clasfecxc add constraint fk_fecxc_de_enc_det_c_fecxc_en foreign key (cod_sec_catclas) references fecxc_enc_clasfecxc(cod_sec_catclas) on delete no action not deferrable initially immediate;
