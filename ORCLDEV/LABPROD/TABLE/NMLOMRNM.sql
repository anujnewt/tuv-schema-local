-- dmap_object_gen_tag : type : table name : nmlomrnm
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlomrnm"  (
mrn_keynom numeric(38),
mrn_keyper varchar(7),
mrn_ordgen numeric(38),
mrn_idecam varchar(6),
mrn_valkey varchar(16),
mrn_mensaj varchar(60),
mrn_imprim varchar(1),
mrn_operad varchar(2),
mrn_estruc varchar(1)
) ;
