-- dmap_object_gen_tag : type : table name : nmloccol
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmloccol"  (
cco_keyrco varchar(8),
cco_numsec numeric(5),
cco_secope numeric(5),
cco_operan varchar(10),
cco_operad varchar(1),
cco_tipope varchar(1),
cco_uniimp varchar(1),
cco_peracu varchar(15)
) ;
