-- dmap_object_gen_tag : type : table name : hoimpcon
set search_path = usrsiho,oracle,dmap_extension,public;
create table "hoimpcon"  (
con_ejerci numeric(5),
con_numreg numeric(10),
con_keypro numeric(10),
con_keyare varchar(6),
con_keyemp numeric(10),
con_mesini varchar(2),
con_mesfin varchar(2),
con_rfcemp varchar(16),
con_recurp varchar(18),
con_apepat varchar(30),
con_apemat varchar(30),
con_nombre varchar(30),
con_aregeo varchar(2),
con_calanu varchar(1),
con_siasim varchar(1),
con_entfed varchar(2),
con_ingasim numeric(10),
con_israsim numeric(10),
con_stsimp varchar(1)
) ;
