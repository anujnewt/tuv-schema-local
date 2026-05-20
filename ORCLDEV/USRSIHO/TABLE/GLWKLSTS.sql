-- dmap_object_gen_tag : type : table name : glwklsts
set search_path = usrsiho,oracle,dmap_extension,public;
create table "glwklsts"  (
lst_keycno varchar(8),
lst_idepcc varchar(15),
lst_keyusu numeric(10),
lst_detall varchar(155),
lst_encabe varchar(155),
lst_corte1 varchar(80),
lst_corte2 varchar(80),
lst_corte3 varchar(80),
lst_total1 varchar(155),
lst_total2 varchar(155),
lst_total3 varchar(155),
lst_numsec numeric(10),
lst_impdet numeric(5)
) ;
