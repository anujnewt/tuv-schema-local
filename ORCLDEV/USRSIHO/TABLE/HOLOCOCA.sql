-- dmap_object_gen_tag : type : table name : holococa
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holococa"  (
coc_keyplz numeric(10) not null,
coc_keycap numeric(5) not null,
coc_numsec numeric(6) not null,
coc_stspag varchar(1) not null,
coc_keyrph numeric(10),
coc_keygdp numeric(10),
coc_hjatra numeric(10),
coc_reghja numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : holococa
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holococa alter column coc_keyplz set not null;
-- dmap_object_gen_tag : type : alter table name : holococa
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holococa alter column coc_keycap set not null;
-- dmap_object_gen_tag : type : alter table name : holococa
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holococa alter column coc_numsec set not null;
-- dmap_object_gen_tag : type : alter table name : holococa
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holococa alter column coc_stspag set not null;
