-- dmap_object_gen_tag : type : table name : glcofrmr
set search_path = usrsiho,oracle,dmap_extension,public;
create table "glcofrmr"  (
frm_keycno varchar(8),
frm_numsec numeric(5),
frm_keytab varchar(18),
frm_keycam varchar(18),
frm_format varchar(19),
frm_ubicac varchar(1),
frm_ctotal varchar(1),
frm_corte1 numeric(5),
frm_idepcc varchar(15),
frm_nomcam varchar(40)
) ;
