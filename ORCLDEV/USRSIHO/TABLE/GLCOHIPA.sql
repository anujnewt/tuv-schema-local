-- dmap_object_gen_tag : type : table name : glcohipa
set search_path = usrsiho,oracle,dmap_extension,public;
create table "glcohipa"  (
hip_keyusu numeric(10) not null,
hip_numsec numeric(10),
hip_fecpas timestamp(0),
hip_cveusu varchar(65)
) ;
-- dmap_object_gen_tag : type : alter table name : glcohipa
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcohipa alter column hip_keyusu set not null;
