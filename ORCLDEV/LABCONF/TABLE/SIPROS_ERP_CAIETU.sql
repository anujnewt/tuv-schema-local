-- dmap_object_gen_tag : type : table name : sipros_erp_caietu
set search_path = labconf,oracle,dmap_extension,public;
create table "sipros_erp_caietu"  (
ape_keypol varchar(30),
ape_fecpol timestamp(0),
ape_despro varchar(40),
ape_tipfac varchar(8),
ape_tipmon varchar(3),
ape_tipcam numeric(38),
ape_terpag varchar(10),
ape_rfcban varchar(20),
ape_sucban varchar(20),
ape_totreg numeric(38),
ape_import decimal(16, 2),
ape_source varchar(10),
ape_status varchar(1),
ape_keyemp numeric(38),
ape_keylot varchar(20),
ape_fecmod timestamp(0),
ape_auxnu1 numeric(38),
ape_auxca1 varchar(100),
ape_caietu numeric(38)
) ;
