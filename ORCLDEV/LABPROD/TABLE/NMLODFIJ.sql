-- dmap_object_gen_tag : type : table name : nmlodfij
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlodfij"  (
dfi_keyemp numeric(10),
dfi_keycon varchar(3),
dfi_keypro numeric(5),
dfi_perini varchar(7),
dfi_perfin varchar(7),
dfi_keydep varchar(16),
dfi_keypue varchar(16),
dfi_fecmov timestamp(0),
dfi_cantid decimal(12, 2),
dfi_import decimal(12, 2),
dfi_ca1aux varchar(10),
dfi_ca2aux varchar(10)
) ;
