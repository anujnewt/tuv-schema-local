-- dmap_object_gen_tag : type : table name : holoenclla
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holoenclla"  (
enc_num_id numeric(10) not null,
enc_keydep varchar(16),
enc_feclla timestamp(0),
enc_keytpr varchar(6),
enc_nomprd varchar(60),
enc_feccap timestamp(0) not null,
enc_keypro numeric(5),
enc_usuori varchar(15),
enc_auxnu1 numeric(10),
enc_auxca1 varchar(60),
enc_solscc numeric(10),
enc_stslla numeric(10),
enc_hjatra numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : holoenclla
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoenclla alter column enc_num_id set not null;
-- dmap_object_gen_tag : type : alter table name : holoenclla
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoenclla alter column enc_feccap set not null;
