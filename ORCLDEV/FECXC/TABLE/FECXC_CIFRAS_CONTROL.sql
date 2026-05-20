-- dmap_object_gen_tag : type : table name : fecxc_cifras_control
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_cifras_control"  (
mes numeric,
periodo numeric,
segmento varchar(25),
importe_seg numeric,
concepto varchar(25),
importe_con numeric,
division varchar(25),
importe_div numeric,
canal varchar(25),
importe_can numeric,
region varchar(25),
importe_reg numeric
) ;
