-- dmap_object_gen_tag : type : table name : nmlohism_cons
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmlohism_cons"  (
his_keyemp numeric(10),
his_keycon varchar(3),
his_keypro numeric(5),
his_keydep varchar(16),
his_keypue varchar(16),
his_cantid decimal(16, 2),
his_import decimal(16, 2),
his_fecmov timestamp(0),
his_keyper varchar(7),
his_keynom numeric(5),
his_codimp varchar(2),
his_codacu varchar(2),
his_ca1aux varchar(16),
his_ca2aux varchar(16),
his_rowide decimal(16, 6),
his_uniope numeric(5),
his_keyplz numeric(5),
his_tipplz varchar(2)
) ;
