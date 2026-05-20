-- dmap_object_gen_tag : type : table name : com_sips_orac_bita
set search_path = labconf,oracle,dmap_extension,public;
create table "com_sips_orac_bita"  (
bit_regist varchar(50),
bit_valant varchar(50),
bit_valnue varchar(50),
bit_keyemp numeric(38),
bit_fecmov timestamp(0),
bit_menerr varchar(200),
bit_noctvo numeric(10) not null,
bit_status varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : com_sips_orac_bita
set search_path = labconf,oracle,dmap_extension,public;
alter table com_sips_orac_bita alter column bit_noctvo set not null;
