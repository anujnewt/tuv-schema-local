-- dmap_object_gen_tag : type : table name : fecxc_enc_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_enc_clasfecxc"  (
cod_sec_catclas numeric(38) not null,
codclasif varchar(10) not null,
sub_descrip varchar(40) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasfecxc add constraint pk_fecxc_enc_clasfecxc primary key (cod_sec_catclas);
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasfecxc alter column cod_sec_catclas set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasfecxc alter column codclasif set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasfecxc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasfecxc alter column sub_descrip set not null;
