-- dmap_object_gen_tag : type : table name : xxchk_bit_errores
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_bit_errores"  (
codigo_error varchar(3),
desc_error varchar(30),
id_cheque numeric(38),
code_combination varchar(50),
compania numeric(38),
status_cheque varchar(30)
) ;
