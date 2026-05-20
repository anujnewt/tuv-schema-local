-- dmap_object_gen_tag : type : table name : holoenctra
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holoenctra"  (
enc_num_id numeric(10) not null,
enc_keydep varchar(16) not null,
enc_fecgra timestamp(0),
enc_fecpag timestamp(0),
enc_keytpr varchar(6),
enc_nomprd varchar(60),
enc_feccap timestamp(0) not null,
enc_horcom varchar(20),
enc_keypro numeric(5),
enc_usuori varchar(15),
enc_stsrep varchar(1),
enc_feclib timestamp(0),
enc_horlib varchar(5),
enc_gcxxii varchar(1),
enc_entcom varchar(5),
enc_salcom varchar(5),
enc_auxnu1 numeric(10),
enc_auxca1 varchar(20),
enc_desscc varchar(60),
enc_numlla numeric(10),
enc_conlla varchar(1),
enc_descap varchar(60)
) ;
-- dmap_object_gen_tag : type : alter table name : holoenctra
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoenctra alter column enc_num_id set not null;
-- dmap_object_gen_tag : type : alter table name : holoenctra
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoenctra alter column enc_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : holoenctra
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoenctra alter column enc_feccap set not null;
