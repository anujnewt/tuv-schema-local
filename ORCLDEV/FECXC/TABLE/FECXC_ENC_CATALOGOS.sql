-- dmap_object_gen_tag : type : table name : fecxc_enc_catalogos
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_enc_catalogos"  (
cod_sec_tipcat numeric(38) not null,
tipo_cat varchar(10) not null,
tipo_des varchar(15) not null,
es_nivel char(2)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_catalogos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_catalogos add constraint pk_fecxc_enc_catalogos primary key (cod_sec_tipcat);
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_catalogos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_catalogos add constraint ckc_es_nivel_fecxc_en check (es_nivel is null or ( es_nivel in ('SI','NO') ));
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_catalogos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_catalogos alter column cod_sec_tipcat set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_catalogos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_catalogos alter column tipo_cat set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_catalogos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_catalogos alter column tipo_des set not null;
