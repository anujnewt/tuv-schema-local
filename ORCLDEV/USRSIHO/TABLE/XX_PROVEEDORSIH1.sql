-- dmap_object_gen_tag : type : index name : xx_proveedorsih1
set search_path = usrsiho,oracle,dmap_extension,public;
create index xx_proveedorsih1 on xx_proveedorsiho (rfc, tipomov, status, fecha);
