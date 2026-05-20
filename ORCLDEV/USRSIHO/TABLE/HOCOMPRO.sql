-- dmap_object_gen_tag : type : table name : hocompro
set search_path = usrsiho,oracle,dmap_extension,public;
create table "hocompro"  (
cpr_keydep varchar(30),
cpr_desdep varchar(60),
cpr_presupuesto decimal(20, 2),
cpr_comprometido decimal(20, 2),
cpr_ejercido decimal(20, 2),
cpr_disponible decimal(20, 2),
cpr_llasincon decimal(20, 2),
cpr_keypue varchar(20)
) ;
