-- dmap_object_gen_tag : type : table name : inloevem
set search_path = labconf,oracle,dmap_extension,public;
create table "inloevem"  (
vem_keyemp numeric(5),
vem_rfcemp varchar(14),
vem_keygpo numeric(5),
vem_keycur varchar(8),
vem_cvesec varchar(6),
vem_valeva decimal(5, 2),
vem_feceva timestamp(0),
vem_tipeva varchar(1),
vem_status varchar(2),
vem_fecsta timestamp(0)
) ;
