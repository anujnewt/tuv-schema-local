-- dmap_object_gen_tag : type : table name : accesocc
set search_path = usrsiho,oracle,dmap_extension,public;
create table "accesocc"  (
acc_usuario varchar(20),
acc_nomusuario varchar(60),
acc_cencos varchar(16),
acc_ressol varchar(1),
acc_ussiho numeric(10),
acc_correo varchar(200),
acc_ccopia varchar(200),
acc_status varchar(1)
) ;
