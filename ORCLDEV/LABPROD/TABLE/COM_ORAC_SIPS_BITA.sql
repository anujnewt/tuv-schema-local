-- dmap_object_gen_tag : type : table name : com_orac_sips_bita
set search_path = labprod,oracle,dmap_extension,public;
create table "com_orac_sips_bita"  (
eme_noctvo numeric(38) not null,
eme_status char(1) not null,
eme_object char(18) not null,
eme_menerr varchar(200) not null,
eme_fecmov timestamp(0) not null
) ;
-- dmap_object_gen_tag : type : alter table name : com_orac_sips_bita
set search_path = labprod,oracle,dmap_extension,public;
alter table com_orac_sips_bita alter column eme_noctvo set not null;
-- dmap_object_gen_tag : type : alter table name : com_orac_sips_bita
set search_path = labprod,oracle,dmap_extension,public;
alter table com_orac_sips_bita alter column eme_status set not null;
-- dmap_object_gen_tag : type : alter table name : com_orac_sips_bita
set search_path = labprod,oracle,dmap_extension,public;
alter table com_orac_sips_bita alter column eme_object set not null;
-- dmap_object_gen_tag : type : alter table name : com_orac_sips_bita
set search_path = labprod,oracle,dmap_extension,public;
alter table com_orac_sips_bita alter column eme_menerr set not null;
-- dmap_object_gen_tag : type : alter table name : com_orac_sips_bita
set search_path = labprod,oracle,dmap_extension,public;
alter table com_orac_sips_bita alter column eme_fecmov set not null;
