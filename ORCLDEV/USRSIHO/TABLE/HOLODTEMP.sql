-- dmap_object_gen_tag : type : table name : holodtemp
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holodtemp"  (
det_keypol numeric(10),
det_keyfol numeric(6),
det_cuenta varchar(40),
det_cargos decimal(16, 6),
det_abonos decimal(16, 6)
) ;
