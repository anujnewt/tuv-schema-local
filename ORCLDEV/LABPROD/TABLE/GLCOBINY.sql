-- dmap_object_gen_tag : type : table name : glcobiny
set search_path = labprod,oracle,dmap_extension,public;
create table "glcobiny"  (
bin_keybin varchar(8) not null,
bin_desbin varchar(35),
bin_idefun varchar(30),
bin_idever varchar(15),
bin_perfil varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : glcobiny
set search_path = labprod,oracle,dmap_extension,public;
alter table glcobiny alter column bin_keybin set not null;
