-- dmap_object_gen_tag : type : table name : moloconc
set search_path = labconf,oracle,dmap_extension,public;
create table "moloconc"  (
con_dborig numeric(5),
con_dboper numeric(5),
con_keycon varchar(3),
con_descon varchar(50),
con_eqinom varchar(3),
con_tipcon varchar(1),
con_cardir varchar(20),
con_abodir varchar(20),
con_carind varchar(20),
con_aboind varchar(20),
con_proced varchar(10),
con_tipdia varchar(1),
con_frmenv varchar(1),
con_progra varchar(1),
con_valder varchar(1),
con_indmed varchar(1),
con_facpun varchar(1),
con_facasi varchar(1),
con_ca1aux varchar(10),
con_ca2aux varchar(10),
con_ca3aux varchar(10),
con_ca4aux varchar(10),
con_letkar varchar(1),
con_colkar varchar(12)
) ;
