-- dmap_object_gen_tag : type : table name : pllohjpn
set search_path = labconf,oracle,dmap_extension,public;
create table "pllohjpn"  (
pnl_keymin varchar(5),
pnl_keypnl varchar(5),
pnl_keyhoj varchar(5),
pnl_deshoj varchar(25),
pnl_sensib numeric(10),
pnl_coment varchar(250),
pnl_autorc varchar(30),
pnl_fechac timestamp(0),
pnl_precol varchar(3),
pnl_precon varchar(2),
pnl_hojinf varchar(5),
pnl_tiphoj varchar(1),
pnl_stadel varchar(1)
) ;
