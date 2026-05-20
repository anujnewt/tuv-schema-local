-- dmap_object_gen_tag : type : table name : holocoac
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holocoac"  (
coa_keyplz numeric(10) not null,
coa_keypue varchar(16) not null,
coa_cosuni decimal(13, 2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : holocoac
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocoac add constraint pk_hcoac primary key (coa_keyplz,coa_keypue);
-- dmap_object_gen_tag : type : alter table name : holocoac
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocoac alter column coa_keyplz set not null;
-- dmap_object_gen_tag : type : alter table name : holocoac
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocoac alter column coa_keypue set not null;
-- dmap_object_gen_tag : type : alter table name : holocoac
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocoac alter column coa_cosuni set not null;
