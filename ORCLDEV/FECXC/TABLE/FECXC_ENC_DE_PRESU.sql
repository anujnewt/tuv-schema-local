-- dmap_object_gen_tag : type : table name : fecxc_enc_de_presu
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_enc_de_presu"  (
sec_presup numeric(38) not null,
secmoneda numeric(38),
codanno numeric(38) not null,
fecha timestamp(0) not null,
usu_pres varchar(30) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_de_presu
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_de_presu add constraint pk_fecxc_enc_de_presu primary key (sec_presup);
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_de_presu
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_de_presu alter column sec_presup set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_de_presu
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_de_presu alter column codanno set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_de_presu
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_de_presu alter column fecha set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_de_presu
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_de_presu alter column usu_pres set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_de_presu
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_de_presu add constraint fk_fecxc_en_pre_moned_fecxc_mo foreign key (secmoneda) references fecxc_monedas(secmoneda) on delete no action not deferrable initially immediate;
