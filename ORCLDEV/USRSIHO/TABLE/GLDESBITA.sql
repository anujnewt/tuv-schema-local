-- dmap_object_gen_tag : type : table name : gldesbita
set search_path = usrsiho,oracle,dmap_extension,public;
create table "gldesbita"  (
sbi_numrec numeric(10) not null,
sbi_keyusu numeric(10),
sbi_keynom numeric(10),
sbi_numemi numeric(10),
sbi_keypro numeric(10) not null,
sbi_keyapr varchar(6),
sbi_keyemp numeric(10),
sbi_ejerci numeric(10) not null,
sbi_fecdes varchar(10),
sbi_hordes varchar(5),
sbi_numrem numeric(10),
sbi_cvepol numeric(10),
sbi_feccob varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : gldesbita
set search_path = usrsiho,oracle,dmap_extension,public;
alter table gldesbita alter column sbi_numrec set not null;
-- dmap_object_gen_tag : type : alter table name : gldesbita
set search_path = usrsiho,oracle,dmap_extension,public;
alter table gldesbita alter column sbi_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : gldesbita
set search_path = usrsiho,oracle,dmap_extension,public;
alter table gldesbita alter column sbi_ejerci set not null;
