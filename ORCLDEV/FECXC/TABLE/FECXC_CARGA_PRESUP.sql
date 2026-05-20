-- dmap_object_gen_tag : type : table name : fecxc_carga_presup
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_carga_presup"  (
moneda varchar(25),
fecha timestamp(0),
segmento varchar(25),
concepto varchar(25),
importe numeric,
anio numeric(38),
division varchar(25),
estatus_origen varchar(25) default 'EN ESPERA'
) ;
