-- dmap_object_gen_tag : type : table name : muconcen
set search_path = labprod,oracle,dmap_extension,public;
create table "muconcen"  (
emp_keycen char(16),
emp_ca2aux char(10),
con_ctaref char(20),
his_keycon char(3),
con_descon char(30),
his_import decimal(10, 2)
) ;
