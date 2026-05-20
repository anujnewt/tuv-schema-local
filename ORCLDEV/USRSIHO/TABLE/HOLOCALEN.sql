-- dmap_object_gen_tag : type : table name : holocalen
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holocalen"  (
ale_fecpag timestamp(0) not null,
ale_consec varchar(3) not null,
ale_status varchar(1),
ale_forpag varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : holocalen
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocalen alter column ale_fecpag set not null;
-- dmap_object_gen_tag : type : alter table name : holocalen
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocalen alter column ale_consec set not null;
