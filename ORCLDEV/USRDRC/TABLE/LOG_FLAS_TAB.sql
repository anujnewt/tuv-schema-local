-- dmap_object_gen_tag : type : table name : log_flas_tab
set search_path = usrdrc,oracle,dmap_extension,public;
create table "log_flas_tab"  (
valor_anterior varchar(20),
valor_actual varchar(20),
creation_date timestamp(0),
nom_denominacion_actual varchar(300),
nom_denominacion_anterior varchar(300),
nom_modifico varchar(150)
) ;
